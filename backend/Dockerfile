##############################
#* Stage 1 - Base
##############################
FROM node:lts-alpine AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

##############################
#* Stage 2 - Dependencies
##############################
FROM base AS dependencies

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

RUN --mount=type=cache,target=/pnpm/store \
    pnpm install --frozen-lockfile

##############################
#* Stage 3 - Build
##############################
FROM dependencies AS build

RUN apk add --no-cache curl && \
    mkdir -p certs && \
    curl -sS https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -o certs/global-bundle.pem

COPY . .
RUN pnpm run build

##############################
#* Stage 4 - Production Dependencies
##############################
FROM base AS production

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

RUN --mount=type=cache,target=/pnpm/store \
    pnpm install --frozen-lockfile --prod

##############################
#* Stage 5 - Runtime
##############################
FROM node:lts-alpine AS runtime

WORKDIR /app

ENV NODE_ENV=production

RUN apk add --no-cache curl && \
    addgroup -g 1001 -S nodejs && \
    adduser -S nestjs -u 1001 -G nodejs

COPY --from=production /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./
COPY --from=build /app/certs ./certs

# Apply secure directory ownership permissions
RUN chown -R nestjs:nodejs /app

USER nestjs

EXPOSE 3000

HEALTHCHECK --interval=30s \
    --timeout=5s \
    --start-period=20s \
    --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

CMD ["node", "dist/main"]
