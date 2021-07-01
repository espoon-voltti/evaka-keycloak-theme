FROM node:14.15 AS builder-theme

WORKDIR /work

COPY package*.json /work/
RUN npm install
COPY ./evaka/ /work/evaka/
COPY ./sass/ /work/sass/
COPY ./scripts/ /work/scripts/
RUN npm run build
