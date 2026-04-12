# Nolte Marketing Site — Claude Code Context

## What This Is

Marketing site for Nolte (nolte.io) — a consultative product partner for regulated industries. Built with Astro 6, deployed to Netlify.

**Live:** https://nolte-site.netlify.app
**Netlify site:** nolte-site
**Positioning brief:** See `NOLTE-POSITIONING-BRIEF.md` (v2) for the full governing document.

## Positioning

Nolte is a **consultative product partner for regulated industries**. We evolve ambitious ideas into products that ship — by doing the thinking most firms skip and backing the delivery with a guarantee.

**Positioning line: Innovate Predictably** — the client owns the ambition, we derisk it and deliver it. Predictability is the methodology, not the pitch. The consultative partnership is the product.

Key concepts:

- **Consultative product partner** — not an innovation studio, not a dev shop, not staff augmentation
- **Judgment before execution** — we figure out whether and how something should be built before writing code
- **Operator-led** — founded by people who've built, scaled, and exited companies
- **"We're not yes people"** — we challenge ideas, flag risks, say no when something shouldn't be built
- **Regulated industries** — insurance, healthcare, financial services
- **AI translates strategy into product** — senior humans do the thinking, AI and NolteOS handle execution
- **NolteOS** — predictive delivery engine powered by 20 years of delivery data
- **Per-delivery pricing** — no hourly billing; we carry the execution risk
- **95% forecast accuracy** — the guarantee that makes the consultative promise credible

Target audience: Operators and leadership teams with business maturity making a product bet in a regulated space outside their current execution capability. Defined by the bet, not the stage.

## Tech Stack

- **Astro 6** with MDX integration
- **Content Collections** with Zod schema validation (`src/content.config.ts`)
- **Vanilla CSS** with custom properties (`src/styles/global.css`)
- **Static site** deployed to Netlify

## Key Commands

```bash
npm run dev          # Dev server at localhost:4321
npm run build        # Production build to dist/
npx netlify-cli deploy --prod --dir=dist  # Deploy
```

## Content Structure

### Blog Posts (`src/content/blog/*.md`)
- 26 live posts, 3 drafted
- Categories: delivery, engineering, founders, product, leadership, culture
- Authors: jeffrey-nolte, dan-urruela, yanna-lopes
- Schema: title, description, date, author, category, image (optional), draft

### Case Studies (`src/content/work/*.md`)
- 10 studies ordered by industry tier then partnership duration (see `order` field)
- Schema includes: metrics (deliveries, timeline, accuracy, cycleTime, onTime), testimonial, team, platforms, phases, order
- **When creating or modifying case studies, you MUST follow `.claude/skills/case-study-creation.md`.** This covers research, asset sourcing, press discovery, sensitivity review, content writing, ordering, and verification. Do not skip phases.

### Authors (`src/content/authors/*.json`)
- 3 authors with name, role, bio, linkedin

### Categories (`src/content/categories/*.json`)
- Scoped to blog, work, or both

## Design System

### Typography
- `--serif`: Instrument Serif (headings)
- `--mono`: DM Mono (labels, metadata, uppercase)
- `--sans`: Geist (body text)

### Colors
- `--accent: #fe5101` (Nolte Red — CTAs, highlights)
- `--blue: #0369fc` (Digital Blue — secondary)
- `--black: #000000`, `--white: #fafaf8`
- `--gradient-hero` for dark hero backgrounds

### Patterns
- `.shot-window` / `.shot-window-dark` — browser frame mockups (see NolteOS page)
- `.shot-metrics-grid` — 2x2 metric cards
- `.shot-kanban` — kanban board mockup
- Case study template has scoped styles with `cs-` prefix

## File Map

| File | Purpose |
|------|---------|
| `src/pages/index.astro` | Landing page |
| `src/pages/work/[slug].astro` | Case study template (scoped styles) |
| `src/pages/blog/[slug].astro` | Blog post template (scoped styles) |
| `src/layouts/Base.astro` | Nav + footer + JSON-LD |
| `src/components/BaseHead.astro` | Meta tags, OG, fonts |
| `src/styles/global.css` | All global styles |
| `src/content.config.ts` | Content collection schemas |

## Conventions

- **Time durations:** 12+ months → express in years (1, 1.5, 2, 2+, etc.). Under 12 months → keep as months. Applies to case study timelines, phase durations, and any client-facing copy.
- **No stock photos.** Use real product screenshots, styled HTML mockups, or abstract on-brand visuals.
- **DO use:** "Consultative product partner," "evolve ideas into products," "regulated industries," "operator-led," "judgment," "derisk," "delivery guarantee," "predictive delivery" (as methodology), "fixed per-delivery pricing," "we're not yes people," "innovate predictably" (as thesis).
- **DO NOT use:** "Innovation studio," "agency," "dev shop," "staff augmentation," "resources" (for people), "offshore," "agile" as a selling point, "full-stack" as a differentiator, "end-to-end," "estimate" — we forecast, we predict, we commit. "Innovation" as something Nolte owns — the client owns the innovation, we enable and derisk it.
- **Hierarchy:** Lead with consultative depth and judgment. Predictability is the methodology, not the pitch. The delivery guarantee is proof, not the headline.
- **Voice:** Direct, confident, founder-to-founder. No hedging. Specific over vague. Back claims with numbers.
- **Blog posts** should link to `/blog/the-predictability-gap` as the anchor piece.
- **Internal links** use relative paths (`/blog/...`, `/work/...`), not `nolte.io/...`.
- **Case study metrics** use real delivery data from NolteOS. Don't invent numbers without flagging them.
- **CSS:** Use existing custom properties and patterns. No Tailwind, no CSS-in-JS.
- **Commits:** Descriptive messages. Don't batch unrelated changes.

## What's In Progress

See `DESIGN-BRIEF.md` for the full design brief being sent to the lead designer. Key gaps:
- Images needed throughout (team photos, product screenshots for Odie/Pilou/Wake, blog visuals)
- Typography could be refined (brand fonts vs. Google Fonts stand-ins)
- Trust logos need actual logo images
- Innovation section on landing page needs visual polish
