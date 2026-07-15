##############################
#* Stage 1 - Base
##############################
FROM node:lts-alpine AS base

#| Core Package Manager Setup
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

##############################
#* Stage 2 - Dependencies
##############################
FROM base AS dependencies

#| Copy manifests for dependency caching dependency layer resolution
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

#| Native pnpm store cache injection
RUN --mount=type=cache,target=/pnpm/store \
    pnpm install --frozen-lockfile

##############################
#* Stage 3 - Build
##############################
FROM dependencies AS build

#| Pull AWS global root certificate authority bundle for secure RDS handshakes
RUN apk add --no-cache curl && \
    mkdir -p certs && \
    curl -sS https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -o certs/global-bundle.pem

#| Compile down source artifacts
COPY . .
RUN pnpm run build

##############################
#* Stage 4 - Production Dependencies
##############################
FROM base AS production

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

#| Exclude devDependencies to minimize image size footprints
RUN --mount=type=cache,target=/pnpm/store \
    pnpm install --frozen-lockfile --prod

##############################
#* Stage 5 - Runtime
##############################
FROM node:lts-alpine AS runtime

WORKDIR /app

#| Capture the build argument passed from CLI or CI/CD pipelines
ARG NODE_ENV=production

#| Persist the build argument into the active runtime environment
ENV NODE_ENV=${NODE_ENV}

#| Runtime System Packages & Least-Privilege Execution Accounts
RUN apk add --no-cache curl && \
    addgroup -g 1001 -S nodejs && \
    adduser -S nestjs -u 1001 -G nodejs

#| Layer compilation mappings from preceding caching stages
COPY --from=production /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./
COPY --from=build /app/certs ./certs

#| Enforce user application scope file security boundaries
RUN chown -R nestjs:nodejs /app

USER nestjs

EXPOSE 3000

#| Process status monitoring probe
HEALTHCHECK --interval=30s \
    --timeout=5s \
    --start-period=20s \
    --retries=3 \
    CMD curl -f http://localhost:3000/api/health || exit 1

CMD ["node", "dist/main"]
