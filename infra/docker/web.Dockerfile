FROM node:20-alpine AS deps
WORKDIR /app

# Copy workspace manifests so pnpm knows about your monorepo
COPY package.json pnpm-workspace.yaml ./
COPY apps/web/package.json apps/web/
COPY packages/shared/package.json packages/shared/

# Prepare pnpm and fetch dependencies metadata
RUN corepack enable && pnpm fetch


FROM node:20-alpine AS builder
WORKDIR /app

# Bring in everything from deps stage
COPY --from=deps /app /app

# Copy the full repo (source code)
COPY . .

# Install dependencies and build the Next.js app
RUN corepack enable && pnpm i --frozen-lockfile
RUN pnpm -C apps/web build


FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production \
    PORT=3000

# Copy the built Next.js app and node_modules for runtime
COPY --from=builder /app/apps/web/.next /app/apps/web/.next
COPY --from=builder /app/apps/web/package.json /app/apps/web/
COPY --from=builder /app/node_modules /app/node_modules

EXPOSE 3000

CMD ["node", "apps/web/node_modules/.bin/next", "start", "-p", "3000"]
