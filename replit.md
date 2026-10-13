# VernacularAI

An education-specific AI layer that turns Hindi curriculum questions into grounded, age-appropriate learning in a student's mother tongue.

## Run & Operate

- `pnpm --filter @workspace/api-server run dev` — run the API server (port 5000)
- `pnpm --filter @workspace/vernacular-ai run dev` — run the web app
- `pnpm run typecheck` — full typecheck across all packages
- `pnpm run build` — typecheck + build all packages
- `pnpm --filter @workspace/api-spec run codegen` — regenerate API hooks and Zod schemas from the OpenAPI spec
- `pnpm --filter @workspace/db run push` — push DB schema changes (dev only)
- Required env: `DATABASE_URL` — Postgres connection string

## Stack

- pnpm workspaces, Node.js 24, TypeScript 5.9
- API: Express 5
- DB: PostgreSQL + Drizzle ORM
- Validation: Zod (`zod/v4`), `drizzle-zod`
- API codegen: Orval (from OpenAPI spec)
- Build: esbuild (CJS bundle)

## Where things live

- `artifacts/vernacular-ai/` — React/Vite web app with teacher, student, curriculum, and dashboard routes
- `artifacts/api-server/src/routes/learning.ts` — learning and curriculum endpoints
- `artifacts/api-server/src/services/vernacular.ts` — local retrieval and pedagogical/translation providers
- `lib/api-spec/openapi.yaml` — API source of truth
- `lib/db/src/schema/vernacular.ts` — PostgreSQL/Drizzle schema
- `data/curriculum/` — original curriculum-aligned demo passages
- `DEMO_CHECKLIST.md` — presentation runbook

## Architecture decisions

- The MVP uses deterministic local providers so the complete demo remains usable without large model downloads or external API keys.
- Retrieval runs before pedagogy and returns source chunks in every grounded response; no positive match means no invented answer.
- Santali output is explicitly labeled as an offline translation fallback, not as IndicTrans2 quality.
- Browser voice features are progressive enhancements; text mode remains the reliable core path.

## Product

VernacularAI supports a three-minute teacher-to-learner demo: select Grade 1 Mathematics and Santali, ask a Hindi question, inspect the retrieved curriculum chunks, read a simple explanation and example, try a quiz, and play browser speech when available.

## User preferences

No durable preferences recorded.

## Gotchas

- Run API codegen after changing `lib/api-spec/openapi.yaml`.
- Keep curriculum demo passages clearly labeled as original curriculum-aligned samples, not copied NCERT text.
- Never claim a model provider is active unless its status is ready.

## Pointers

- See the `pnpm-workspace` skill for workspace structure, TypeScript setup, and package details
