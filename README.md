# VernacularAI

VernacularAI is an education-specific AI layer for mother-tongue-based primary education. It combines curriculum-grounded retrieval, pedagogical generation, Indic-language translation, and voice-ready interaction into one teacher-to-learner workflow.

This prototype addresses Smart India Hackathon problem statement **SIH26042** for Smart Education. Its primary demo is a Grade 3 Environmental Studies flow for “Why do plants need sunlight?” from teacher input to a grounded explanation with Santali output. A smaller Grade 1 Mathematics sample remains available for regression checks.

## What is real in this MVP

- Curated curriculum passages are loaded from `data/curriculum/` and split into indexed chunks.
- Retrieval uses token vectors and cosine similarity, with top-k results and chapter filtering.
- Responses are generated only when matching curriculum context is found.
- Pedagogical output is age-appropriate, structured, and tied to the retrieved chapter.
- Hindi-to-Santali is behind a provider boundary. The included offline provider is a labeled phrasebook fallback for the demo; it does not claim IndicTrans2 quality.
- Voice input and text-to-speech use browser capabilities when available, and visibly degrade to text when unavailable.
- Actual pipeline timings are measured on every response.
- Feedback, curriculum, questions, responses, and document/chunk tables are defined in Drizzle, with feedback persistence exercised by the API.

The current provider boundary is intentionally ready for IndicTrans2, IndicLID, IndicConformer, IndicF5, and an API/local LLM without making any of those large model downloads a startup requirement.

## Architecture

```text
Teacher / student text or browser voice
              |
              v
      API learning workflow
      | language detection
      | translation provider
      | curriculum retrieval (top-k cosine)
      | pedagogical provider
      | voice-ready output metadata
              |
              v
     Grounded bilingual learning response
```

See [docs/architecture.md](docs/architecture.md) for provider boundaries, offline behavior, and the model upgrade path.

## Stack

- React + Vite + TypeScript
- Express 5 API server
- OpenAPI-first contracts with Orval-generated React Query and Zod helpers
- PostgreSQL + Drizzle ORM schema
- Browser SpeechRecognition and speechSynthesis when supported
- Lightweight local retrieval for the CPU-friendly demo

## Run locally

Prerequisites: Node 24, pnpm, and a PostgreSQL database exposed as `DATABASE_URL`.

```bash
pnpm install
pnpm --filter @workspace/api-spec run codegen
pnpm --filter @workspace/db run push
pnpm --filter @workspace/api-server run dev
```

In another terminal:

```bash
pnpm --filter @workspace/vernacular-ai run dev
```

The workspace workflows are the preferred way to run the API and frontend in Replit. The app uses `/api` for backend requests and `/` for the web experience.

## Environment variables

Copy `.env.example` to `.env` for local work. Never commit credentials.

- `DATABASE_URL`: PostgreSQL connection string.
- `LLM_PROVIDER`: reserved provider selector; the default `offline` keeps the MVP deterministic.
- `LLM_MODEL`: optional future model name.
- `HF_TOKEN`: optional model-download token; never required for the basic demo.
- `CORS_ORIGINS`: allowed frontend origins.

## Curriculum and indexing

The demo passages are original, curriculum-aligned content rather than copied NCERT pages. This avoids representing unlicensed text as official NCERT content. Add reviewed text under `data/curriculum/grade_1/mathematics/`; the API indexes the available files at startup and exposes chunks through `/api/curriculum`.

## API

See [docs/api.md](docs/api.md) and `lib/api-spec/openapi.yaml`.

Key endpoints:

- `GET /api/healthz` and `GET /api/health`
- `GET /api/curriculum`
- `GET /api/curriculum/:chapterId`
- `GET /api/sources`
- `POST /api/ask`
- `POST /api/translate`
- `POST /api/quiz`
- `POST /api/lesson/generate`
- `POST /api/generate-lesson`
- `POST /api/asr`
- `POST /api/tts`
- `GET /api/system-status`
- `GET /api/metrics`
- `POST /api/feedback`

## Docker

`docker-compose.yml` documents the three-service shape (frontend, API, Postgres). The Replit workflow is recommended for the hosted workspace; Docker is for local parity and later deployment.

```bash
docker compose up --build
```

## Evaluation

Evaluation helpers are in `evaluation/`:

```bash
python evaluation/retrieval_eval.py
python evaluation/translation_eval.py
python evaluation/latency_eval.py
python evaluation/grounding_eval.py
```

These scripts are smoke checks and do not claim benchmark scores. The end-to-end evaluator is `python evaluation/evaluate.py` and expects the API to be running.

## Tests

With the API running on port 8080, run `bash tests/api-smoke.sh`. It checks health, curriculum, translation, grounded asking, quiz generation, provider status, metrics, and unavailable voice fallbacks.

## References and licenses

See [docs/references.md](docs/references.md). IndicTrans2, IndicConformer, IndicLID, and IndicF5 are optional future providers and must be reviewed against their current model/repository licenses before distribution. The current offline phrasebook and curriculum samples are included for this prototype.

## Limitations and next steps

The current demo deliberately uses a deterministic offline provider so the core flow works without downloading large models or requiring an external API key. It should not be presented as production-quality Santali translation, ASR, TTS, or an LLM benchmark. Next steps are to add reviewed Santali parallel data, connect supported Indic models behind the same interfaces, persist question/response events, and package cached chunks and embeddings for Android 9+ devices.