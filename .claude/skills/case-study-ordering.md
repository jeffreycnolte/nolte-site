---
description: Rules for ordering case studies across the site. Use when adding, reordering, or displaying case studies.
---

# Case Study Ordering Rules

Case studies use an explicit `order` field (lower number = shown first). Do NOT rely on the `date` field for display order.

## Ordering Priority

1. **Industry tier** (primary sort) — regulated industries come first:
   - Insurance (highest priority)
   - Finance
   - Healthcare
   - All other industries (wellness, real-estate, sustainability, consumer, etc.)

2. **Partnership duration** (secondary sort within each tier) — longer partnerships rank higher.

## Current Order

| Order | Client | Industry | Partnership |
|-------|--------|----------|-------------|
| 1 | Odie | insurance | 3 years |
| 2 | Pilou | finance | 2 years |
| 3 | Lumos | finance | 4 months |
| 4 | Breeze Oral Care | healthcare | 2+ years |
| 5 | Barry's Bootcamp | wellness | 5+ years |
| 6 | Wake | wellness | 18 months |
| 7 | Morphus | wellness | 1+ year |
| 8 | Klipster | real-estate | 2+ years |
| 9 | Jules | sustainability | 2 years |
| 10 | Footprint | consumer | 1 year |

## When Adding a New Case Study

1. Determine its industry tier (insurance > finance > healthcare > other).
2. Within that tier, place it by partnership duration (longer = lower number).
3. Renumber subsequent studies to maintain gaps-free ordering.
4. Set the `order` field in frontmatter.
5. The homepage featured section is hardcoded — update manually if the new study should be featured. Featured studies should follow the same industry priority: insurance, finance, healthcare.

## Implementation

- Schema: `order: z.number().default(99)` in `src/content.config.ts`
- Work index (`src/pages/work/index.astro`): sorts by `order` ascending
- Category pages (`src/pages/work/category/[slug].astro`): sorts by `order` ascending
- Homepage (`src/pages/index.astro`): hardcoded featured cards — order: Odie, Pilou, Breeze
