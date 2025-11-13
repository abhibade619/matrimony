# Matrim Monorepo

## Structure
- **apps/web** – Next.js 16 (TypeScript)
- **apps/api** – FastAPI (Python 3.11)
- **packages/shared** – Shared TypeScript utilities
- **infra/docker** – Dockerfiles + Docker Compose
- **.github/workflows** – CI configuration

## Local dev (without Docker)

### Install JS deps
```bash
pnpm install
