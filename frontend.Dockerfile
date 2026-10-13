FROM node:24-bookworm-slim
WORKDIR /app
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY artifacts/vernacular-ai/package.json artifacts/vernacular-ai/package.json
COPY lib/api-client-react/package.json lib/api-client-react/package.json
RUN corepack enable && pnpm install --frozen-lockfile
COPY . .
CMD ["pnpm", "--filter", "@workspace/vernacular-ai", "run", "dev"]