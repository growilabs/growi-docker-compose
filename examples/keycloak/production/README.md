# growi-docker-compose with Keycloak Example

This is an example of Docker Compose to run GROWI with Keycloak as the OIDC and SAML provider for production purpose.

## Install and Start

### Clone repos and copy compose.override.prod.yml

```bash
git clone https://github.com/weseek/growi-docker-compose.git growi
cd growi
cp examples/keycloak/compose.override.prod.yml compose.override.yml
cp examples/keycloak/.prod.env .env
```

### Start

Change some environment variables in `.env`:

- `GROWI_DOMAIN`: GROWI domain name (e.g., `example.com`)
- `KEYCLOAK_DOMAIN`: Keycloak domain name (e.g., `kc.example.com`)
- `KC_DB_ROOT_PASSWORD`: password of `root` user on MariaDB
- `KC_DB_KEYCLOAK_PASSWORD`: password of `keycloak` user on MariaDB

```bash
docker compose up
```

Then, for the first time only, do following:

1. Access to https://kc.example.com/ and login as `temp-admin` user
1. Create a realm with name `growi`
1. Create a client with these variables:
    - Client type: SAML
    - Client ID: `growi-saml`
    - Root URL: `https://example.com`
    - Home URL: `https://example.com`
    - Valid redirect URLs: `https://example.com/passport/saml/callback`
1. Create mappers
    1. Open client `growi`
    1. Show `Keys` tab and turn off "Signing keys config"
    1. Show `Client scopes` tab and open `growi-dedicated` scope
    1. Create these mappers from `Configure a new mapper` or `Add mapper`
        - Create mapper like these for `id`, `username`, `email`, `firstName`, `lastName`
            - Mapper type: `User Property`
            - Name: `firstName`
            - Friendly Name: `firstName`
            - SAML Attribute Name: `firstName`
1. Create user from `Users` or set identity providers as you like

1. Access to https://example.com/ and install GROWI
1. Move to https://example.com/admin/security
1. Enable SAML
    1. Show SAML tab and set these variables:
        - SAML
            - [x] Enable SAML
        - Entry point: `https://kc.example.com/realms/growi/protocol/saml`
        - Issuer: `growi`
        - Certificate: Copy certificate from Keycloak (realm `growi` -> Realm settings -> `Keys` -> `Certificate` for algorithm `RS256`) and sandwich "-----BEGIN CERTIFICATE-----" and "-----END CERTIFICATE-----"
        - Attribute Mapping
            - ID: `id`
            - Username: `username`
            - Mail address: `email`
            - [x] Automatically bind external accounts newly logged in to local accounts when `username` match (*1)
    1. Click Update button
1. Enable OIDC
    1. Show OIDC tab and set these variables:
        * OpenID Connect
            - [x] Enable OIDC
        * Configuration
            - Provider Name: `keycloak`
            - Issuer Host: `https://kc.example.com/realms/growi`
            - Client ID: `growi-oidc-client`
            - Client Secret: `8yl2dujVmjr7maftgadNth18Eg4oiTLj`
        * Attribute Mapping (Optional)
            - Identifier: `sub`
            - username: `preferred_username`
            - Name: `name`
            - Email: `email`
            - [x] Automatically bind external accounts newly logged in to local accounts when `username` match (*1)
    1. Click Update button

(*1) Treat users as identical whether logged in via SAML or OIDC

## Login

You can login with your Keycloak account.

### How to add keycloak users

You can add users from the admin panel by clicking "Users" in the sidebar and then selecting "Add User". You will need to provide a username, password, and other required details.
After adding a user, they can log in using their Keycloak credentials.
