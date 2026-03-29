---
description: Research and prepare data for a new case study. Use when the user provides a JIRA export, client name, or asks to create a case study.
---

# Case Study Research Skill

When creating a case study for nolte.io, follow this research process before writing:

## Step 1: Analyze the JIRA Export (if provided)

Parse the CSV and extract:
- **Total tickets** and status breakdown (Done, In Progress, Backlog, Cancelled)
- **Date range** — earliest and latest ticket dates (this determines partnership duration)
- **Issue type breakdown** — Stories, Tasks, Bugs, Epics, Sub-tasks
- **Epic names** — these reveal the project phases and feature areas
- **Assignees** — identifies the Nolte team members involved
- **Key feature areas** — scan summaries for patterns (search for recurring keywords)
- **Integration systems** — identify any third-party tools/APIs mentioned (but DO NOT name them publicly)

Calculate:
- Deliveries = Done tickets (Stories + Tasks + Bugs, exclude Sub-tasks and Epics)
- Partnership duration = earliest to latest ticket date
- Cycle time = estimate from epic cadence (monthly epics = ~4-5d cycle time)

## Step 2: Research the Client

Search the web for:
- **Company website** — understand their product, market, and positioning
- **Press coverage** — find articles from major publications (extract publication name, headline, and a short pull quote under 20 words)
- **App Store / Google Play** — if it's a mobile app, check ratings and descriptions
- **Crunchbase** — funding stage, founding date, team size
- **Social media** — LinkedIn company page for employee count and positioning

Download from their website:
- **Logo** — preferably SVG or high-res PNG wordmark
- **Featured image** — hero image, product screenshot, or brand photography
- Save to: `public/images/logos/[client].png` and `public/images/work/[client-slug]/featured.jpg`

## Step 3: Sensitivity Review

Before writing, flag anything that should NOT be public:
- Third-party vendor/platform names (generalize: "HR provider" not "Rippling")
- Internal compensation structures or business rules
- Specific expansion plans or unreleased features
- Bug counts or defect rates
- Screenshots of admin interfaces or internal dashboards
- Anything the client hasn't approved for publication

**Default: generalize. When in doubt, don't name it.**

## Step 4: Write the Case Study

Follow the template in `CASE-STUDY-GUIDE.md`. Use these sections:
1. **The Bet** — What the client wanted and what was at stake
2. **The Complexity** — What made this hard
3. **The Thinking** — Our strategic approach
4. **The Build** — What we shipped (break into phases for long engagements)
5. **The Proof** — Metrics and outcomes
6. **The Partnership** — Why this matters

## Step 5: Populate Frontmatter

Required fields:
```yaml
title: "Client Name"
client: "Client Name"
description: "One sentence under 200 chars"
category: healthcare | insurance | finance | wellness | real-estate | delivery
date: YYYY-MM-DD  # Use project start date. Later dates = higher in sort order.
image: /images/work/[slug]/featured.jpg
status: "Live"
partnership: "X+ years"
services: [list]
metrics:
  deliveries: N  # from JIRA Done count
  timeline: "X years"
  accuracy: "XX%"
  cycleTime: "X.Xd"
```

Optional fields to add if data exists:
```yaml
press:
  - publication: "Publication Name"
    headline: "Article Title"
    quote: "Short pull quote under 20 words"
    url: "https://..."
gallery:
  - src: "/images/work/[slug]/image.jpg"
    alt: "Description"
    caption: "Optional caption"
testimonial:
  quote: "Client quote"
  author: "Name"
  role: "Title, Company"
```

## Step 6: Update Logo Maps

Add the client logo to all 3 files:
- `src/pages/index.astro` → `caseLogos`
- `src/pages/work/index.astro` → `logoMap`
- `src/pages/work/[slug].astro` → `clientLogos`

## Step 7: Verify

```bash
npm run build   # Must pass with 0 errors
npm run dev     # Preview at localhost:4321/work/[slug]
```

Check:
- Case study page renders correctly
- Logo shows on cards (homepage + work index)
- Press bar renders if press data provided
- Gallery images load
- Mobile responsive
- No sensitive information exposed
