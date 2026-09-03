# VernacularAI

VernacularAI is an education-specific AI layer for mother-tongue-based primary education. It combines curriculum-grounded retrieval, pedagogical generation, Indic-language translation, and voice-ready interaction into one teacher-to-learner workflow.

This prototype addresses Smart India Hackathon problem statement **SIH26042** under the **Smart Education** theme. Its primary demo is a Grade 3 Environmental Studies flow for **“Why do plants need sunlight?”**, from teacher input to a grounded explanation with Santali output. A smaller Grade 1 Mathematics sample remains available for regression checks.

## 🚀 Live Demo

**Hosted Prototype:**  
https://vernacular-ai-sih-demo--123pra.replit.app

> The hosted prototype demonstrates the current MVP workflow. Some advanced Indic speech and translation providers remain optional and are designed behind provider interfaces.

---

## 🎯 Problem Statement

**SIH Problem Statement ID:** SIH26042  
**Title:** AI-Powered Vernacular Pedagogy and Real-Time Translation Tool for Mother Tongue-Based Primary Education  
**Organization:** Government of Jharkhand  
**Department:** Department of Higher & Technical Education  
**Theme:** Smart Education  
**Category:** Software  
**Team:** Quantora

---

## 💡 What is VernacularAI?

VernacularAI focuses on the gap between **language translation and actual learning**.

A general translation system can convert words from one language to another, but primary education also requires:

- Curriculum-grounded explanations
- Age-appropriate language
- Contextual examples
- Practice questions and quizzes
- Teacher assistance
- Voice-ready interaction
- Support for low-connectivity environments

VernacularAI combines these capabilities into a single education-focused workflow.

---

## ✨ What is Real in this MVP

- Curated curriculum passages are loaded from `data/curriculum/` and split into indexed chunks.
- Retrieval uses token vectors and cosine similarity, with top-k results and chapter filtering.
- Responses are generated only when matching curriculum context is found.
- Pedagogical output is age-appropriate, structured, and tied to the retrieved chapter.
- Hindi-to-Santali is behind a provider boundary.
- The included offline provider is a labeled phrasebook fallback for the demo and does not claim IndicTrans2 quality.
- Voice input and text-to-speech use browser capabilities when available and visibly degrade to text when unavailable.
- Actual pipeline timings are measured on every response.
- Feedback, curriculum, questions, responses, and document/chunk tables are defined in Drizzle.
- The provider boundary is ready for IndicTrans2, IndicLID, IndicConformer, IndicF5, and an API/local LLM without making large model downloads a startup requirement.

---

## 🏗️ Architecture

```text
Teacher / Student Text or Browser Voice
                    |
                    v
          API Learning Workflow
                    |
       +------------+------------+
       | Language Detection     |
       | Translation Provider   |
       | Curriculum Retrieval   |
       | Pedagogical Provider   |
       | Voice-ready Metadata   |
       +------------+------------+
                    |
                    v
       Grounded Bilingual Learning
                Response
--

🔄 Core Learning Workflow

Text / Voice Question
        ↓
Language Detection + ASR
        ↓
Indic Translation
        ↓
Curriculum Retrieval (RAG)
        ↓
Pedagogical AI
        ↓
Simple Explanation
+ Examples
+ Quiz
        ↓
Text / Voice Response

The objective is not simply to translate content, but to convert curriculum content into a learner-friendly experience.

--
🛠️ Technology Stack

Frontend
React
Vite
TypeScript
Tailwind CSS
Backend
Express 5
OpenAPI-first API contracts
Orval-generated React Query and Zod helpers
AI / NLP
IndicTrans2 — translation provider
IndicLID — language identification
IndicConformer — speech recognition
IndicF5 / Indic-TTS — future text-to-speech integration
LLM — pedagogical generation
RAG — curriculum-grounded generation
Multilingual embeddings
Database
PostgreSQL
Drizzle ORM
pgvector / vector retrieval architecture
Deployment & Runtime
Replit hosted prototype
Docker / Docker Compose
ONNX / quantized model deployment planned for low-end devices
Browser Voice
SpeechRecognition
speechSynthesis
--

📚 Curriculum & Knowledge Base

Curriculum Content
       ↓
Document Extraction
       ↓
Chunking
       ↓
Embeddings
       ↓
Vector Retrieval
       ↓
Relevant Curriculum Context
       ↓
Pedagogical Generation

-

📖 References & Live Resources

Curriculum

NCERT Textbook Portal
https://www.ncert.nic.in/textbook.php

Indic Language AI

AI4Bharat IndicTrans2
https://github.com/AI4Bharat/IndicTrans2

AI4Bharat Models
https://models.ai4bharat.org/

AI4Bharat IndicConformer ASR
https://github.com/AI4Bharat/IndicConformerASR

AI4Bharat IndicLID
https://github.com/AI4Bharat/IndicLID

AI4Bharat IndicF5
https://github.com/AI4Bharat/IndicF5

AI4Bharat Indic-TTS
https://github.com/AI4Bharat/Indic-TTS

Research

Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks
https://arxiv.org/abs/2005.11401

See docs/references.md for detailed references and license notes.


--
📈 Proposed Evaluation Metrics

Translation quality
Speech recognition quality
Retrieval accuracy
Curriculum-grounding rate
End-to-end latency
Explanation quality
Quiz performance
Teacher usability
Student comprehension improvement

The goal is to measure whether the system improves the learning workflow, not just translation quality.

--
🌱 Impact

Students
Learn concepts in a familiar language
Receive simple explanations
Ask questions using text or voice
Practice through quizzes
Teachers
Receive multilingual teaching assistance
Explain Hindi-origin curriculum in target languages
Generate practice material
Reduce language-related classroom barriers
Schools
Support mother-tongue-based multilingual education
Provide a reusable digital learning workflow
Extend access to multilingual educational content

--
👨‍💻 Author

Pranav Sharma

Built as part of Team Quantora for Smart India Hackathon 2026.

--
🙏 Acknowledgements

We acknowledge the open-source Indian language AI ecosystem, including AI4Bharat, as well as publicly available educational and research resources that inform the prototype architecture.

--

⭐ VernacularAI

Bridging the gap between language and learning.
