FROM node:10.7.0-alpine

LABEL maintainer="Luca Perret <perret.luca@gmail.com>" \
      org.label-schema.vendor="Strapi" \
      org.label-schema.name="Strapi Docker image" \
      org.label-schema.description="Strapi containerized" \
      org.label-schema.url="https://strapi.io" \
      org.label-schema.vcs-url="https://github.com/strapi/strapi-docker" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="1.0"

WORKDIR /usr/src/api

RUN npm install -g strapi@3.0.0-alpha.13.0.1

COPY strapi.sh ./
RUN chmod +x ./strapi.sh

EXPOSE 1337

COPY healthcheck.js ./
HEALTHCHECK --interval=15s --timeout=60s --start-period=60s \
      CMD node /usr/src/api/healthcheck.js

CMD ["./strapi.sh"]
