# VernacularAI

> ⚠️ **Copyright Notice**
>
> © 2026 VernacularAI Contributors. All rights reserved, subject to applicable third-party rights and licenses.
>
> This repository contains original project code, documentation, and design materials. Public visibility does not grant blanket permission to reproduce, redistribute, or commercially exploit these materials.
>
> Unauthorized copying or misrepresentation of original project materials may violate applicable intellectual property laws. Third-party components remain subject to their respective licenses.
>
⚠️ 
> Unauthorized reproduction, redistribution, or misrepresentation of these materials may result in a formal takedown request or other appropriate legal action where warranted.
>
> For permissions, licensing, or collaboration inquiries, please contact the project contributors.
> 
### Curriculum-Grounded Multilingual AI for Mother-Tongue-Based Primary Education

**VernacularAI** is an education-focused AI system designed to bridge the gap between multilingual content delivery and meaningful learning. It combines curriculum-grounded information retrieval, pedagogical response generation, Indic-language translation, and browser-based voice interaction into a unified teacher-to-learner workflow.

The prototype focuses on primary education, with a Grade 3 Environmental Studies demonstration built around **“Why do plants need sunlight?”** The workflow transforms a teacher's or learner's question into a curriculum-grounded explanation with Santali output. A smaller Grade 1 Mathematics sample is retained for regression testing.

---

## 🎯 Problem Statement

| Attribute | Details |
|---|---|
| Problem Statement ID | **SIH26042** |
| Title | AI-Powered Vernacular Pedagogy and Real-Time Translation Tool for Mother Tongue-Based Primary Education |
| Organization | Government of Jharkhand |
| Department | Department of Higher & Technical Education |
| Theme | Smart Education |
| Category | Software |
| Team | **Quantora** |

## 💡 Problem Definition

Language barriers can prevent primary-school students from fully understanding educational concepts presented in a language different from their mother tongue. Conventional translation systems focus primarily on linguistic conversion rather than curriculum alignment, age-appropriate explanations, and learning outcomes.

VernacularAI addresses this challenge through an integrated learning workflow that aims to provide:

- **Curriculum-grounded responses:** explanations supported by retrieved educational content.
- **Pedagogical adaptation:** concept explanations structured for the learner's grade level.
- **Multilingual accessibility:** a provider-based approach to Indic-language translation.
- **Interactive learning:** examples, practice questions, and quiz-oriented responses.
- **Voice-enabled interaction:** browser-supported speech input and spoken output where available.
- **Low-connectivity awareness:** a labeled offline phrasebook fallback for selected demo translations.

The objective is to move beyond direct translation toward **context-aware, learner-centered knowledge delivery**.

---

## 🧠 System Capabilities and Implementation Status

| Component | Current implementation |
|---|---|
| Curriculum ingestion | Curated passages loaded from `data/curriculum/` |
| Document processing | Curriculum content split into indexed chunks |
| Retrieval engine | Token-vector similarity using cosine similarity, top-k retrieval, and chapter filtering |
| Context grounding | Responses are generated only when matching curriculum context is available |
| Pedagogical response | Structured, age-appropriate explanations tied to retrieved chapter content |
| Indic translation | Translation provider abstraction with a labeled offline phrasebook fallback |
| Voice interaction | Browser SpeechRecognition and speechSynthesis when supported |
| Runtime observability | Actual pipeline timings measured for each response |
| Data persistence schema | Drizzle definitions for feedback, curriculum, questions, responses, documents, and chunks |
| Advanced model integration | Provider architecture prepared for additional translation, speech, and LLM integrations |

**Implementation note:** The offline phrasebook is a demonstration fallback, not a claim of IndicTrans2-equivalent translation quality. Advanced model integrations and low-end-device deployment are extension points, not claims that every model is already deployed.

---

## 🏗️ System Architecture

```text
┌───────────────────────────────────────────────┐
│             Interaction Layer                 │
│       Teacher / Student Text or Voice         │
└──────────────────────┬────────────────────────┘
                       │
                       ▼
┌───────────────────────────────────────────────┐
│              API Learning Workflow            │
│                                               │
│  Language Detection                           │
│          ↓                                    │
│  Translation Provider                         │
│          ↓                                    │
│  Curriculum Retrieval                         │
│          ↓                                    │
│  Pedagogical Response Provider                │
│          ↓                                    │
│  Voice-Ready Response Metadata                │
└──────────────────────┬────────────────────────┘
                       │
                       ▼
┌───────────────────────────────────────────────┐
│              Learning Response                │
│                                               │
│  Curriculum-Grounded Explanation              │
│  Contextual Examples                          │
│  Practice Questions / Quiz                    │
│  Target-Language Output                       │
└───────────────────────────────────────────────┘
```

### Architectural Design Principles

- **Provider abstraction:** translation and pedagogical generation are separated from the workflow so that model providers can be integrated independently.
- **Grounded generation:** retrieved curriculum context is used as the basis for responses, with generation withheld when matching context is unavailable.
- **Graceful degradation:** browser voice capabilities and translation fallbacks are handled without assuming every environment supports every feature.
- **Observable execution:** pipeline timings are measured per request to support latency analysis.
- **Extensibility:** model integrations can evolve without making large model downloads a mandatory application startup dependency.

---

## 🔄 End-to-End Learning Workflow

```text
Teacher / Student Question
           │
           ▼
  Text Input or Browser Voice
           │
           ▼
 Language Detection / ASR
           │
           ▼
 Indic Translation Provider
           │
           ▼
 Curriculum Retrieval
  ├── Chapter Filtering
  ├── Token-Vector Matching
  ├── Cosine Similarity
  └── Top-k Context Selection
           │
           ▼
 Pedagogical Response Generation
           │
           ▼
 Context-Grounded Learning Content
  ├── Simplified Explanation
  ├── Contextual Examples
  └── Practice Questions / Quiz
           │
           ▼
 Target-Language Response
           │
           ▼
 Text Output / Browser Speech
```

The workflow is designed to transform educational content into a learner-friendly explanation rather than merely translate the original text. Speech recognition and advanced model stages depend on the relevant provider or browser capability being available.

---

## 🧩 Retrieval-Augmented Learning Pipeline

VernacularAI uses a curriculum-retrieval stage to identify relevant educational context before producing a response.

### Knowledge ingestion

```text
Curriculum Sources
        ↓
Document Extraction
        ↓
Text Normalization
        ↓
Chunking
        ↓
Chunk Indexing
        ↓
Retrievable Curriculum Knowledge Base
```

### Query-time retrieval

```text
Incoming Question
        ↓
Query Representation
        ↓
Chapter / Curriculum Filtering
        ↓
Token-Vector Similarity
        ↓
Cosine Similarity Ranking
        ↓
Top-k Relevant Chunks
        ↓
Grounded Response Generation
```

The current prototype uses token vectors and cosine similarity for retrieval. This should not be confused with a fully deployed dense-embedding retrieval system. The architecture can be extended to embedding-based retrieval as the knowledge base and evaluation requirements grow.

### Grounding strategy

1. Receive a learner or teacher question.
2. Identify the relevant curriculum scope and retrieve matching passages.
3. Rank candidate chunks using similarity and apply top-k selection.
4. Generate a response only when matching curriculum context is available.
5. Return structured educational content with language and voice-ready metadata.

---

## 🛠️ Technology Stack

### Frontend and User Interaction

- **React** — component-based interface development
- **Vite** — frontend development and build tooling
- **TypeScript** — static typing and maintainable UI code
- **Tailwind CSS** — utility-first interface styling
- **Web Speech APIs** — browser-supported speech recognition and speech synthesis

### Backend and API Layer

- **Express 5** — backend application and API workflow
- **OpenAPI-first API contracts** — structured API specifications
- **Orval** — generated React Query and Zod helpers for API integration and validation

### AI, NLP and Retrieval

- **Retrieval-Augmented Generation (RAG)** — curriculum-grounded response workflow
- **Token-vector similarity** — current lexical retrieval implementation
- **Cosine similarity and top-k ranking** — relevant curriculum chunk selection
- **LLM-based pedagogical generation** — provider integration point
- **IndicTrans2** — intended translation provider integration
- **IndicLID** — intended Indic-language identification integration
- **IndicConformer** — intended speech-recognition integration
- **IndicF5 / Indic-TTS** — potential text-to-speech integrations
- **Multilingual embeddings** — possible future enhancement to semantic retrieval

*The model names above identify intended or supported integration directions; they do not imply that all models are currently active in the running demo.*

### Database and Data Layer

- **PostgreSQL** — relational data persistence
- **Drizzle ORM** — typed database schema and ORM
- **Curriculum and interaction schemas** — document/chunk records, questions, responses, and feedback
- **pgvector / vector retrieval architecture** — potential extension for database-backed vector search

*The current retrieval implementation is token-vector based; pgvector-based semantic retrieval is an architectural extension rather than a claim of active use.*

### Deployment and Runtime

- **Replit** — hosted prototype environment
- **Docker / Docker Compose** — containerization and reproducible deployment direction
- **ONNX / quantized inference** — planned optimization options for lower-resource devices

---

## 📚 Curriculum and Knowledge Base

The curriculum layer supplies the educational context required for retrieval and response generation.

### Data flow

```text
Curriculum Material
        ↓
Extraction and Preprocessing
        ↓
Text Chunking
        ↓
Index Construction
        ↓
Query-Time Retrieval
        ↓
Relevant Curriculum Context
        ↓
Pedagogical Response
```

The current prototype loads curated curriculum passages from `data/curriculum/`, splits them into indexed chunks, and supports chapter-filtered retrieval.

The initial demonstration focuses on Grade 3 Environmental Studies, with a smaller Grade 1 Mathematics sample available for regression checks.

---

## 📏 Proposed Evaluation Framework

VernacularAI should be evaluated across retrieval quality, language performance, learning effectiveness, and runtime behavior.

| Evaluation dimension | Proposed measurement |
|---|---|
| Translation quality | Human evaluation of meaning preservation and language correctness |
| Speech recognition | Word Error Rate (WER), where a suitable reference transcript is available |
| Retrieval accuracy | Precision@k, Recall@k, and relevance judgments for retrieved curriculum chunks |
| Curriculum grounding | Proportion of responses supported by relevant curriculum evidence |
| End-to-end latency | Median and p95 response latency |
| Explanation quality | Teacher-reviewed correctness, clarity, and grade-level suitability |
| Quiz performance | Correct-answer rate on generated or curated questions |
| Teacher usability | Task completion, feedback, and usability testing |
| Student comprehension | Pre-test/post-test comparison under an appropriate evaluation protocol |

These are **proposed evaluation metrics**, not measured performance claims. Reliable evaluation requires representative datasets, human review, and documented test conditions.

---

## 🌍 Expected Educational Impact

### For Students

- Access to explanations in a familiar language.
- Easier interaction with curriculum concepts through text or supported voice.
- Age-appropriate examples and practice-oriented learning content.
- Reduced dependence on proficiency in a single instructional language.

### For Teachers

- Multilingual teaching assistance for selected curriculum topics.
- Support for converting curriculum content into simplified explanations.
- Practice-question generation opportunities.
- Potential reduction in language-related classroom barriers.

### For Schools

- A reusable workflow for mother-tongue-based multilingual education.
- A foundation for extending educational content to additional Indic languages.
- A potential pathway toward accessible digital learning in lower-resource environments.

These are intended benefits that require usability studies and educational evaluation to validate.

---

## 🚀 Future Development Roadmap

- [ ] Integrate and evaluate production-grade Indic translation providers.
- [ ] Add robust Indic-language identification and speech-recognition pipelines.
- [ ] Integrate a pedagogical LLM with structured response validation.
- [ ] Evaluate semantic retrieval with multilingual embeddings and vector search.
- [ ] Add curriculum citations or passage references to learner-facing responses.
- [ ] Expand curriculum coverage across grades, subjects, and target languages.
- [ ] Benchmark retrieval quality, translation quality, and end-to-end latency.
- [ ] Explore ONNX and quantized inference for low-resource environments.
- [ ] Conduct teacher usability studies and student-comprehension evaluations.

---

## 📖 References and Live Resources

### Curriculum

- [NCERT Textbook Portal](https://www.ncert.nic.in/textbook.php)

### Indic Language AI

- [AI4Bharat IndicTrans2](https://github.com/AI4Bharat/IndicTrans2)
- [AI4Bharat Models](https://models.ai4bharat.org/)
- [AI4Bharat IndicConformer ASR](https://github.com/AI4Bharat/IndicConformerASR)
- [AI4Bharat IndicLID](https://github.com/AI4Bharat/IndicLID)
- [AI4Bharat IndicF5](https://github.com/AI4Bharat/IndicF5)
- [AI4Bharat Indic-TTS](https://github.com/AI4Bharat/Indic-TTS)

### Research

- [Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks](https://arxiv.org/abs/2005.11401)

For detailed references and license notes, see `docs/references.md`.

---

## 👨‍💻 Team Quantora

**Pranav Sharma**  
**Adil Khan**  
**Surya Pratap Tomar**

Built as part of **Team Quantora** for the Smart India Hackathon 2026.

## 🙏 Acknowledgements

We acknowledge the open-source Indian-language AI ecosystem, including AI4Bharat, and the publicly available educational and research resources that inform the prototype's design and implementation.

---

<div align="center">

### ⭐ VernacularAI

**Bridging the gap between language and learning.**

*Curriculum-grounded intelligence. Mother-tongue accessibility. Learner-centered education.*

</div>
