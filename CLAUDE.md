# Nolte Marketing Site — Claude Code Context

## What This Is

Marketing site for Nolte (nolte.io) — a predictive software delivery company. Built with Astro 6, deployed to Netlify.

**Live:** https://nolte-site.netlify.app
**Netlify site:** nolte-site

## Positioning

Nolte provides **predictable software delivery for leaders who outsource engineering**. Key concepts:

- **NolteOS** — predictive delivery engine powered by 20 years of delivery data
- **Pay-per-delivery pricing** — no hourly billing, no retainers
- **Flow metrics** — cycle time, throughput, WIP, work item age
- **95% forecast accuracy** across thousands of deliveries
- **Little's Law** and **Monte Carlo simulation** for probabilistic forecasting

Target audience: CEOs, CTOs, CFOs, product leaders at scaling companies. Not early-stage startups.

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
- 4 studies: Breeze Oral Care, Odie, Pilou, Wake
- Schema includes: metrics (deliveries, timeline, accuracy, cycleTime, onTime), testimonial, team, platforms, phases

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

- **No stock photos.** Use real product screenshots, styled HTML mockups, or abstract on-brand visuals.
- **Positioning language:** "predictable delivery" not "agile development." "Leaders who outsource" not "non-tech founders." "Forecasting" not "estimation."
- **Voice:** Direct, experienced, opinionated. Jeffrey Nolte's voice. Not salesy.
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
