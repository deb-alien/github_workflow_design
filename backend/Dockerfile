FROM node:lts-alpine3.23 AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

FROM base AS build

RUN apk add --no-cache curl
RUN mkdir -p certs && curl -sS https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -o certs/global-bundle.pem

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm run build
RUN pnpm prune --prod

FROM node:lts-alpine3.23 AS production

WORKDIR /app

COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./
COPY --from=build /app/certs ./certs

USER node

EXPOSE 3000

CMD ["node", "dist/main.js"]
