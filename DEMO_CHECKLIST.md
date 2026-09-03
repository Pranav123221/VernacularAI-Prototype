# VernacularAI SIH demo checklist

## Before the presentation

1. Start the API workflow and confirm `GET /api/healthz` returns `{"status":"ok"}`.
2. Start the web workflow and open the app at its preview.
3. Open **Curriculum** and confirm `Numbers 1 to 10` is indexed with visible chunks.
4. Open **Teacher mode**.
5. Select Grade 1, Mathematics, and Santali.
6. Use the sample prompt: `बच्चों को 1 से 10 तक की संख्याएँ पहचानना और गिनना सीखना है।`
7. Submit the prompt.
8. Point out the visible pipeline: language detection, translation fallback, curriculum retrieval, pedagogy, quiz, and voice-ready output.
9. Expand or open the retrieved source context and show the source label, chapter, page, score, and chunk text.
10. Point out that the latency shown is measured at runtime, not hard-coded.
11. Click Play on the target-language answer. If the browser does not support speech, show the explicit text-only fallback.
12. Open Student mode and repeat the question with the large learner controls.
13. Open Dashboard to show the same run's status and grounding evidence.

## If voice is unavailable

Use the text input path. Voice is an enhancement; the curriculum-grounded learning flow remains usable.

## If there is no curriculum match

Ask an unrelated question such as `मंगल ग्रह पर मौसम कैसा है?`. The correct demo behavior is a no-match message and no invented quiz.

## What not to claim

- Do not call the phrasebook fallback a production translation model.
- Do not claim IndicTrans2, IndicConformer, IndicLID, or IndicF5 is active unless the corresponding provider is installed and its status says ready.
- Do not claim the demo uses official NCERT text; the included passages are original curriculum-aligned samples.