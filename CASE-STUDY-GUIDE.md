# How to Create a Case Study

This guide explains how to add a new case study to nolte.io. Follow it exactly and the site will build and deploy automatically.

---

## Quick Start

1. Create a markdown file: `src/content/work/[client-slug].md`
2. Add a featured image: `public/images/work/[client-slug]/featured.jpg`
3. Add the client logo to `public/images/logos/[client].png` (or `.svg`)
4. Update the logo maps in 3 files (see step 5)
5. Commit and push — Netlify auto-deploys

---

## Step 1: Create the Markdown File

Create `src/content/work/[client-slug].md` using this template:

```markdown
---
title: "Client Name"
client: "Client Name"
description: "One sentence. What we built, for whom, and the outcome. Keep under 200 characters."
category: healthcare
date: 2024-01-15
image: /images/work/[client-slug]/featured.jpg
imageAlt: "Client Name — short description of image"
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
  quote: "The testimonial quote from the client."
  author: "Client Contact Name"
  role: "Title, Company"
team:
  - name: "Team Member"
    role: "Role on Project"
platforms:
  - Web
  - iOS
phases:
  - name: "Strategy"
    duration: "4 weeks"
  - name: "Launch"
    duration: "12 weeks"
  - name: "Evolve"
    duration: "2+ years"
---

## The Bet

What the client wanted to build and why. What was at stake.

## The Complexity

What made this hard. Technical, regulatory, market, or operational challenges.

## The Thinking

How we approached the problem. Strategy decisions, architecture choices, what we said no to.

## The Build

What we actually shipped. Break into phases if it's a long engagement.

## The Proof

Metrics, outcomes, results. Use real numbers.

## The Partnership

Why this engagement matters. What it demonstrates about how we work.
```

### Frontmatter Field Reference

| Field | Required | Type | Notes |
|-------|----------|------|-------|
| `title` | Yes | string | Full client name |
| `client` | Yes | string | Display name (can be shorter) |
| `description` | Yes | string | One sentence for cards and SEO. Under 200 chars. |
| `category` | Yes | string | Must match a category slug: `healthcare`, `insurance`, `finance`, `wellness`, `delivery` |
| `date` | Yes | date | Project start date (YYYY-MM-DD) |
| `image` | Yes | path | Featured image path (see Step 2) |
| `imageAlt` | Yes | string | Descriptive alt text for the image |
| `status` | Yes | string | Usually "Live" |
| `partnership` | Yes | string | Duration: "2+ years", "6 months", etc. |
| `services` | Yes | string[] | List of services provided |
| `metrics.deliveries` | Yes | number | Total deliveries shipped |
| `metrics.timeline` | Yes | string | Project timeline |
| `metrics.accuracy` | Yes | string | Forecast accuracy percentage |
| `metrics.cycleTime` | Yes | string | Average cycle time |
| `metrics.onTime` | Optional | string | On-time delivery rate |
| `testimonial.quote` | Optional | string | Leave empty string `""` if none — section won't render |
| `testimonial.author` | Optional | string | Client contact name |
| `testimonial.role` | Optional | string | Title at company |
| `team` | Optional | object[] | Team members: `name` + `role` |
| `platforms` | Optional | string[] | Platforms built (Web, iOS, Android, etc.) |
| `phases` | Optional | object[] | Always use: Strategy → Launch → Evolve |

---

## Step 2: Add Images

### Featured image (required)
- Path: `public/images/work/[client-slug]/featured.jpg`
- Size: at least 1200px wide, 16:10 aspect ratio works best
- Can be `.jpg`, `.png`, or `.avif`
- Should represent the product or client brand — not generic stock photos

### Client logo (required for cards)
- Path: `public/images/logos/[client].png` (or `.svg`)
- Should be the wordmark or icon mark
- Will be rendered in grayscale on the site

### Additional images (optional)
- Place in `public/images/work/[client-slug]/`
- Reference in markdown body: `![Alt text](/images/work/[client-slug]/image.jpg)`

---

## Step 3: Add Category (if new)

If the client's industry doesn't match an existing category, create one:

`src/content/categories/[slug].json`

```json
{
  "title": "Display Name",
  "description": "One sentence describing this industry vertical.",
  "scope": "work"
}
```

Then add a pill color in `src/styles/global.css`:

```css
.case-pill-[slug] {
  border-color: #HEX;
  color: #HEX;
  background: rgba(R, G, B, 0.05);
}
```

---

## Step 4: Update Logo Maps

The client logo needs to be registered in **3 files**. This ensures the logo appears on the homepage cards, work index, and case study detail page.

### `src/pages/index.astro` (homepage)
```javascript
const caseLogos: Record<string, { src: string; height: string }> = {
  // ... existing entries
  'client-slug': { src: '/images/logos/client.png', height: '20px' },
};
```

### `src/pages/work/index.astro` (work index)
```javascript
const logoMap: Record<string, { src: string; height: string }> = {
  // ... existing entries
  'client-slug': { src: '/images/logos/client.png', height: '20px' },
};
```

### `src/pages/work/[slug].astro` (case study detail)
```javascript
const clientLogos: Record<string, { src: string; height: string }> = {
  // ... existing entries
  'client-slug': { src: '/images/logos/client.png', height: '26px' },
};
```

> **Note:** The detail page uses a larger height (26-28px) than the card views (18-22px). Adjust per logo to balance visual weight.

### Testimonial avatar (optional)
If the case study has a testimonial with a photo, also add to `[slug].astro`:
```javascript
const testimonialAvatars: Record<string, string> = {
  // ... existing entries
  'client-slug': '/images/work/client-slug/avatar.jpg',
};
```

---

## Step 5: Content Writing Guidelines

### Section structure
Always use these six sections in this order:
1. **The Bet** — What the client wanted and what was at stake
2. **The Complexity** — What made this hard
3. **The Thinking** — Our strategic approach
4. **The Build** — What we shipped (break into phases for long engagements)
5. **The Proof** — Metrics and outcomes
6. **The Partnership** — Why this matters

### Voice
- Direct, confident, specific
- Lead with the client's problem, not our capabilities
- Use real numbers — never fabricate metrics
- Phases are always: **Strategy → Launch → Evolve**

### Sensitivity checklist
Before publishing, verify the case study does NOT include:
- [ ] Names of the client's vendors, platforms, or third-party tools
- [ ] Internal compensation structures or business rules
- [ ] Specific locations of planned expansion
- [ ] Bug counts or defect rates
- [ ] Language implying legal risk or compliance failures
- [ ] Confidential metrics the client hasn't approved for publication
- [ ] Screenshots of internal dashboards or admin interfaces

**When in doubt, generalize.** Say "HR provider" not "Rippling." Say "class management platform" not "Mariana Tek."

---

## Step 6: Build and Deploy

```bash
# Test locally
npm run dev
# Visit http://localhost:4321/work/[client-slug]

# Build (must pass with 0 errors)
npm run build

# Commit and push (Netlify auto-deploys)
git add .
git commit -m "Add [Client] case study"
git push origin main
```

---

## Existing Case Studies

| Client | Slug | Category | Partnership |
|--------|------|----------|-------------|
| Breeze Oral Care | `breeze-oral-care` | healthcare | 2+ years |
| Barry's | `barrys-bootcamp` | wellness | 5+ years |
| Klipster | `klipster` | wellness | 2+ years |
| Odie | `odie` | insurance | 3 years |
| Pilou | `pilou` | finance | 2 years |
| Wake | `wake` | wellness | 12 months |

---

## Common Issues

**Build fails after adding a case study**
- Check that `category` matches an existing category slug in `src/content/categories/`
- Check that `date` is valid YYYY-MM-DD format
- Check that `metrics` fields have the correct types (deliveries is a number, everything else is a string)

**Logo not showing on cards**
- Check you updated all 3 logo map files
- Check the image path is correct and the file exists in `public/images/logos/`

**Testimonial section showing when it shouldn't**
- Set `quote: ""` (empty string) — the template checks for a non-empty quote before rendering

**Case study not appearing on work index**
- Make sure there's no `draft: true` in the frontmatter
