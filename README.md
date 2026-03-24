# Nolte Marketing Site

Predictable software delivery for leaders who outsource. Built with [Astro 6](https://astro.build).

**Live:** https://nolte-site.netlify.app

## Quick Start

```bash
# Install dependencies
npm install

# Start dev server
npm run dev
# → http://localhost:4321

# Build for production
npm run build

# Preview production build
npm run preview
```

## Deploy

```bash
# Deploy to Netlify (requires netlify-cli)
npx netlify-cli deploy --prod --dir=dist
```

## Project Structure

```
src/
├── components/        # Reusable components (BaseHead)
├── content/
│   ├── authors/       # Author JSON files
│   ├── blog/          # Blog posts (Markdown)
│   ├── categories/    # Category JSON files
│   └── work/          # Case studies (Markdown)
├── layouts/           # Base layout (nav + footer)
├── pages/
│   ├── about/         # About pages (story, team, NolteOS)
│   ├── blog/          # Blog index, single, category, author, RSS
│   └── work/          # Work index, single, category
└── styles/
    └── global.css     # All styles

public/
├── images/            # Blog + work images
└── robots.txt

wp-exports/            # WordPress XML exports (reference)
scripts/               # Migration scripts
```

## Content

### Adding a Blog Post

Create a `.md` file in `src/content/blog/`:

```yaml
---
title: "Your Post Title"
description: "Meta description for SEO"
date: 2026-03-24
author: jeffrey-nolte
category: delivery
image: /images/blog/your-image.jpg  # optional
imageAlt: "Image description"        # optional
---

Your markdown content here.
```

**Categories:** delivery, engineering, founders, product, leadership, culture

**Authors:** jeffrey-nolte, dan-urruela, yanna-lopes

### Adding a Case Study

Create a `.md` file in `src/content/work/`:

```yaml
---
title: "Client Name"
client: "Client Name"
description: "One-line description"
category: healthcare
date: 2024-01-15
status: "Live"
partnership: "2+ years"
services:
  - Product Strategy
  - Full-Stack Development
metrics:
  deliveries: 47
  timeline: "4 months"
  accuracy: "100%"
  cycleTime: "4.2d"
  onTime: "98%"
testimonial:
  quote: "Quote text"
  author: "Person Name"
  role: "Title, Company"
team:
  - name: "Jeffrey Nolte"
    role: "Delivery Lead"
platforms:
  - Web
  - iOS
phases:
  - name: "Strategy"
    duration: "4 weeks"
  - name: "Build"
    duration: "12 weeks"
image: /images/work/client/hero.jpg
imageAlt: "Description"
---
```

## Working with Claude Code

This repo includes a `CLAUDE.md` file that gives Claude context about the project. Any team member with Claude Code can:

```bash
# Navigate to repo
cd nolte-site

# Start Claude Code
claude

# Claude will automatically read CLAUDE.md for project context
```

See `CLAUDE.md` for project conventions and guidelines.

## Design

See `DESIGN-BRIEF.md` for the full design brief, brand guidelines, and what needs refinement.

## Tech Stack

- **Framework:** Astro 6 (static site generator)
- **Content:** Markdown with Zod-validated frontmatter schemas
- **Styling:** Vanilla CSS with custom properties
- **Fonts:** Instrument Serif, DM Mono, Geist
- **Hosting:** Netlify
- **SEO:** Sitemap, RSS, JSON-LD, Open Graph, canonical URLs
