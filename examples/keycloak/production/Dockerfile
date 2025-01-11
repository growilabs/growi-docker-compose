# ref. https://www.keycloak.org/server/containers
FROM quay.io/keycloak/keycloak:26.0.7

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=false

# Configure a database vendor
ENV KC_DB=mariadb

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build
