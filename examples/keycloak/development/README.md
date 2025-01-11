# growi-docker-compose with Keycloak Example

This is an example of Docker Compose to run GROWI with Keycloak as the OIDC and SAML provider for development purpose.

## Install and Start

### Clone repos and copy compose.override.dev.yml

```bash
git clone https://github.com/weseek/growi-docker-compose.git growi
cd growi
cp examples/keycloak/development/compose.override.yml ./
```

### Start

```bash
docker compose up
```

Then, for the first time only, do following:

1. Access to http://localho.st:3000 and install GROWI
1. Move to http://localho.st:3000/admin/security
1. Enable SAML if you want to use
    1. Show SAML tab and set these variables:
        - SAML
            - [x] Enable SAML
        - Attribute Mapping Options
            - [x] Automatically bind external accounts newly logged in to local accounts when `username` match (*1)
    1. Click Update button
1. Enable OIDC if you want to use
    1. Show OIDC tab and set these variables:
        - OpenID Connect
            - [x] Enable OIDC
        - Configuration
            - Provider Name: `keycloak`
            - Issuer Host: `http://localho.st:8080/realms/growi-dev`
            - Client ID: `growi-oidc-client`
            - Client Secret: `8yl2dujVmjr7maftgadNth18Eg4oiTLj`
        - Attribute Mapping (Optional)
            - Identifier: `sub`
            - username: `preferred_username`
            - Name: `name`
            - Email: `email`
            - [x] Automatically bind external accounts newly logged in to local accounts when `username` match (*1)
    1. Click Update button

(*1) Treat users as identical whether logged in via SAML or OIDC

## Login

You can login with your Keycloak account.

### Initial keycloak users

| Username | Password |
|----------|----------|
| keycloak-user | `password` |

### How to add keycloak users

You can add users from the admin panel by clicking "Users" in the sidebar and then selecting "Add User". You will need to provide a username, password, and other required details.
After adding a user, they can log in using their Keycloak credentials.
