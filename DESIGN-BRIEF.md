# Design Brief: Nolte Marketing Site

## Project Overview

This is the new Nolte marketing site built on Astro 6, deployed to Netlify. The site is ~90% complete structurally — all pages, content, and components are in place. We need a designer to refine the visual identity, ensure brand consistency, source/create images, and add creative elements that elevate the site.

**Live site:** https://nolte-site.netlify.app
**Repo:** https://github.com/jeffreycnolte/nolte-site
**Brand book:** `/wp-exports/` contains the WordPress export; the Nolte brandbook PDF was used as reference

---

## Positioning

**Predictable software delivery for leaders who outsource.**

NolteOS is a predictive delivery engine that turns 20 years of delivery data into forecasted, fixed-price software delivery. Pay-per-delivery pricing. 95% forecast accuracy.

Target audience: CEOs, CTOs, CFOs, and product leaders at scaling companies who outsource engineering and need predictable outcomes.

---

## Current Design System

### Typography
- **Headings:** Instrument Serif (Google Fonts) — italic for emphasis words
- **Labels/metadata:** DM Mono — uppercase, letter-spaced
- **Body:** Geist (system-ui fallback)

**Brand book fonts (not yet implemented):**
- Soehne (sans) — could replace Geist for a more premium feel
- GT Super (serif italic) — could replace Instrument Serif for highlights

### Colors
| Token | Value | Usage |
|-------|-------|-------|
| `--black` | `#000000` | Primary text, dark backgrounds |
| `--white` | `#fafaf8` | Page background (warm white) |
| `--accent` | `#D63F18` | Nolte Red — CTAs and category pills only |
| `--blue` | `#0369fc` | Digital Blue — minimal use, links only |
| `--gray-100` | `#f2f1ed` | Light backgrounds, cards |
| `--gray-200` | `#e0ded8` | Borders |
| `--gray-400` | `#9e9b94` | Labels, metadata |
| `--gray-600` | `#5a5854` | Body copy (minimum contrast) |
| `--gradient-hero` | pure dark | Hero backgrounds (no blue tint) |

### Layout
- Max content width: 1100px (`.wide-wrap`)
- Blog prose: 780px max
- Consistent 2rem horizontal padding
- Section spacing: 5rem vertical

---

## What's Working (Keep)

1. **Clean, minimal aesthetic** — The simplicity works for the brand. Don't over-design.
2. **Dark hero sections** — Strong contrast, on-brand
3. **Mono label system** — Uppercase DM Mono for eyebrows, labels, metadata
4. **Case study metrics grid** — 2x2 boxes in hero, delivery data visualizations
5. **NolteOS product shots** — Styled HTML mock UIs (not images) on `/about/nolteos`
6. **Blog typography** — Reading time, breadcrumbs, author blocks, inline images
7. **Split hero on case studies** — Content left, product image right

---

## What Needs Refinement

### 1. Brand Typography
The site uses Google Fonts (Instrument Serif, DM Mono, Geist) as stand-ins. Consider implementing brand fonts (Soehne, GT Super) if licensed, or find closer matches. The serif headings feel slightly generic — a more distinctive serif would help.

### 2. Images Throughout
**Missing images:**
- Landing page "We've been in your seat" section — currently a dark CSS element, needs a real team/culture photo
- Landing page "Craft that speaks" photo grid — placeholder elements
- Case studies (Odie, Pilou, Wake) — no product screenshots yet
- Blog posts — most have no hero images
- About/Team page — team member photos needed

**Image direction:**
- Real product screenshots in device frames for case studies
- Team photography that feels authentic (not stock)
- Abstract/geometric visuals for blog posts (on-brand patterns, not generic stock)
- Consider the "Symbiotic O" motif from the brand book as a recurring visual element

### 3. Landing Page Polish
- **Trust logos bar** — Currently text-only brand names. Need actual client logos (HBO, Amtrak, Barry's, etc.)
- **Innovation section** — 3 cards feel flat. Could use subtle icons or illustrations
- **Stats section** — Large numbers work but could have more visual impact
- **Photo placeholders** — All need real imagery

### 4. Case Study Design Showcase
The Breeze case study has real product images. The format should be a template for showing design quality:
- Device frames (phone/browser) around screenshots
- Before/after or process visuals
- Design system callouts (color, typography, components)
- The current inline images work but could be more intentionally art-directed

### 5. Color & Contrast
- The warm white background (`#fafaf8`) is good but some sections feel washed out
- Consider more intentional use of the blue accent — currently underused
- Dark sections (hero, NolteOS, footer CTA) work well; consider more dark/light rhythm throughout

### 6. Creative Ideas to Explore
- **Data visualization as brand identity** — Nolte's differentiator is delivery data. Could we make flow metrics, cycle time distributions, or throughput charts into visual motifs?
- **Animated elements** — Subtle animations on the NolteOS dashboard, metrics counters, or phase timelines could add polish
- **Gradient evolution** — The orange→blue gradient is in the CSS but underused. Could become a stronger brand signature
- **Case study comparison** — Visual "before Nolte / with Nolte" showing unpredictable vs. predictable delivery

---

## Site Structure

```
/                       Landing page
/work                   Case studies grid (4 studies)
/work/[slug]            Individual case study
/about                  Our Story
/about/team             Team page
/about/nolteos          NolteOS marketing page (product shots)
/blog                   Blog index (26 posts, 6 categories)
/blog/[slug]            Blog post
/blog/category/[slug]   Category archive
/blog/author/[slug]     Author page
```

---

## Key Files for Design Work

| File | What it controls |
|------|-----------------|
| `src/styles/global.css` | All styles — CSS variables, layout, components |
| `src/pages/index.astro` | Landing page |
| `src/pages/work/[slug].astro` | Case study template (includes scoped styles) |
| `src/pages/blog/[slug].astro` | Blog post template (includes scoped styles) |
| `src/layouts/Base.astro` | Global nav + footer |
| `src/components/BaseHead.astro` | Meta tags, font imports |
| `src/content/work/*.md` | Case study content + frontmatter data |
| `public/images/` | All images (blog + work) |

---

## Deliverables Expected

1. **Typography refinement** — Finalize heading/body/label font choices
2. **Image sourcing/creation** — Real photos, product screenshots, blog visuals
3. **Landing page polish** — Client logos, photo sections, innovation cards
4. **Case study template** — Device frames, design showcases, art direction for screenshots
5. **Color/spacing refinements** — Tighten the visual system
6. **Creative elements** — Any ideas that strengthen the "predictable delivery" positioning visually
7. **Mobile responsive review** — Ensure everything works on mobile

---

## Brand Personality (from brand book)

- **Archetypes:** Magician + Hero
- **Voice:** Leader / Coach
- **Tone:** Human / empathetic, Clear / direct
- **Motif:** "Symbiotic O" — circular, co-creation, partnership
- **Not:** Corporate, salesy, startup-bro, generic tech
