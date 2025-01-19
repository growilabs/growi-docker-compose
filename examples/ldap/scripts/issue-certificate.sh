#!/bin/sh
#
# This script create certificates and private keys for an LDAP server using TLS.
# - cacert.crt (CA certificate)
# - privkey.pem (CA private key)
# - ldaps_cert.crt (LDAP server certificate)
# - ldaps_key.pem (LDAP server private key)
#
# Set LDAPS_DOMAIN environment variable to specify the domain name for your LDAP server.
if [ -z "$LDAPS_DOMAIN" -o -z "$ARTIFACTS_OWNER_ID" -o -z "ARTIFACTS_GROUP_ID" ]; then
  echo "Please set LDAPS_DOMAIN, ARTIFACTS_OWNER_ID, and ARTIFACTS_GROUP_ID environment variable."
  exit 1
fi

# Generate a self-signed CA certificate:
# - Creates a new 4096-bit RSA key pair
# - Generates an X.509 certificate valid for 100 years (36500 days)
# - No password protection (-nodes)
# - Certificate subject details: Country=Japan, State=Example, Location=Example, Organization=Example
# - Outputs the certificate as 'cacert.crt'
openssl req -new -x509 -nodes -newkey rsa:4096 -out cacert.crt -days 36500 -subj '/C=JP/ST=Example/L=Example/O=Example'

echo "Generated CA certificate..."
openssl x509 -in cacert.crt -text

# Step 1: Generate a Certificate Signing Request (CSR):
# - Creates a new private key (ldaps_key.pem)
# - No password protection (-nodes)
# - Creates a CSR (ldaps_csr.pem)
# - Sets certificate subject with Country=Japan, State=Example, Location=Example, Organization=Example
# - Uses the specified LDAPS domain as Common Name (CN)
openssl req -new -nodes -keyout ldaps_key.pem -out ldaps_csr.pem -subj "/C=JP/ST=Example/L=Example/O=Example/CN=${LDAPS_DOMAIN}"
# Step 2: Sign the CSR with the CA certificate:
# - Takes the CSR (ldaps_csr.pem) as input
# - Uses the CA private key (privkey.pem) and CA certificate (cacert.crt) for signing
# - Creates a signed certificate (ldaps_cert.crt)
# - Sets validity period to 100 years (36500 days)
openssl x509 -req -in ldaps_csr.pem -out ldaps_cert.crt -CAkey privkey.pem -CA cacert.crt -days 36500

echo "Issued CA certificate..."
openssl x509 -in ldaps_cert.crt -text

echo "Change the owner of cacert.crt, privkey.pem, ldaps_csr.pem, ldaps_key.pem, ldaps_cert.crt to ${ARTIFACTS_OWNER_ID}:${ARTIFACTS_GROUP_ID} (to match the ldap container user)"
chown ${ARTIFACTS_OWNER_ID}:${ARTIFACTS_GROUP_ID} cacert.crt privkey.pem ldaps_csr.pem ldaps_key.pem ldaps_cert.crt
