# growi-docker-compose with LDAP Example

This is an example of Docker Compose to run GROWI with LDAP for development purposes.


## Install and Start

### Clone repos and copy compose.override.yml

```bash
git clone https://github.com/weseek/growi-docker-compose.git growi
cd growi
cp examples/ldap/compose.override.yml ./
cp examples/ldap/.env ./
```

### Start

```bash
docker compose up
```

Then, for the first time only, do following:

1. Access to http://localhost:3000 and install GROWI
1. Move to http://localhost:3000/admin/security
1. Enable LDAP
    1. Show LDAP tab and set these variables:
        - LDAP
            - [x] Enable LDAP
        - Configuration
            - Server URL: `ldaps://example.org/ou=users,dc=example,dc=org`
            - Binding Mode: `Manager Bind`
            - Bind DN: `cn=admin,dc=example,dc=org`
            - Bind Password: `adminpassword`
    1. Click `Update` button
    1. Click `Test Saved Configuration` button
        - username: `user1`
        - Password: `password`

## Update certificates

Pre requirements:

- Install and Start

And, run the following command on Linux:

```bash
docker run --rm --interactive --tty --entrypoint /scripts/issue-certificate.sh \
  --volume $(pwd)/examples/ldap/scripts:/scripts \
  --volume $(pwd)/examples/ldap/certs:/root \
  --env-file .env \
  --env ARTIFACTS_OWNER_ID=$(id -u) --env ARTIFACTS_GROUP_ID=$(id -g) \
  --workdir /root \
  alpine/openssl
# UNDESIRABLE FOR SECURITY REASONS
# Key access privileges should be restricted in the production environment.
chmod 644 $(pwd)/examples/ldap/certs/*key.pem
```

If you are using Windows, you need to change your Linux commands appropriately.
