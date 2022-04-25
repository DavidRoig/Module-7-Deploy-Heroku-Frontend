FROM node:14-alpine AS base
RUN mkdir -p /usr/app
WORKDIR /usr/app

FROM base AS build-frontend
COPY ./ ./
RUN npm cache clean --force
RUN npm ci
RUN npm run build

FROM base AS build-backend
COPY --from=build-frontend /usr/app/dist ./public
COPY ./server/package.json ./
COPY ./server/index.js ./
RUN npm install --only=production

ENV STATIC_FILES_PATH=./public
ENV PORT=8083
EXPOSE 8083

ENTRYPOINT [ "node", "index" ]
