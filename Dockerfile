FROM node:14.15 AS builder-theme

WORKDIR /work

COPY package*.json /work/
RUN npm install
COPY ./evaka/ /work/evaka/
COPY ./sass/ /work/sass/
COPY ./scripts/ /work/scripts/
RUN npm run build

FROM quay.io/keycloak/keycloak:12.0.4

USER root

RUN microdnf update -y \
 && microdnf upgrade -y \
 && microdnf install -y jq \
 && microdnf clean all

USER 1000

RUN mkdir -p /opt/jboss/keycloak/standalone/data/password-blacklists/ \
 && curl -sSf "https://raw.githubusercontent.com/danielmiessler/SecLists/2021.1/Passwords/xato-net-10-million-passwords-1000000.txt" \
      -o /opt/jboss/keycloak/standalone/data/password-blacklists/default.txt \
 && echo "424a3e03a17df0a2bc2b3ca749d81b04e79d59cb7aeec8876a5a3f308d0caf51  /opt/jboss/keycloak/standalone/data/password-blacklists/default.txt" | sha256sum -c -

COPY --from=builder-theme /work/evaka /opt/jboss/keycloak/themes/evaka

CMD ["--server-config=standalone.xml", "-b", "0.0.0.0"]
