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
- **Business model** — determine if B2B SaaS, B2C, B2B2C, marketplace, etc. This drives the category.
- **Industry** — identify the primary industry (insurance, finance, healthcare, wellness, real-estate, sustainability, saas, consumer). Use the most specific regulated category that applies. Check `src/content/categories/` for existing categories; create a new one if needed.
- **Press coverage** — find articles from major publications (see Step 2b for detailed process)
- **App Store / Google Play** — if it's a mobile app, check ratings and descriptions
- **Crunchbase** — funding stage, founding date, team size
- **Social media** — LinkedIn company page for employee count and positioning

Download from their website:
- **Logo** — preferably SVG or high-res PNG wordmark
- **Featured image** — hero image, product screenshot, or brand photography
- Save to: `public/images/logos/[client].png` and `public/images/work/[client-slug]/featured.jpg`

## Step 2b: Press Coverage Research (CRITICAL)

This step is mandatory for every case study. Press coverage adds credibility.

### Finding articles

Search for the client across these publication types:
1. **Industry-specific** — search `"[client name]" site:[industry-publication].com`
2. **Business press** — search `"[client name]" site:yahoo.com OR site:reuters.com OR site:bloomberg.com`
3. **Local press** — search `"[client name]" site:nypost.com OR site:amny.com`
4. **Tech press** — search `"[client name]" site:techcrunch.com OR site:wired.com`
5. **General** — search `"[client name]" launch OR funding OR raises`

If a search returns no results, try the client name without quotes, try founder names, try the product name.

**IMPORTANT:** If the user says press exists but search doesn't find it, ask for the URL. Don't assume it doesn't exist — paywalls and recent articles may not be indexed yet.

### For each article found, extract:
- Publication name (exact, e.g., "New York Post" not "NY Post")
- Article headline
- A pull quote under 20 words (from the article body, not the headline — unless headline is the best quote)
- Full article URL

### Press logos (MANDATORY)

Every press entry MUST have a corresponding logo in `public/images/press/`. The PressBar component maps publication names to logo files.

**Check existing logos first:**
```bash
ls public/images/press/
```

**Current logo inventory:**
| Publication | File | Type |
|---|---|---|
| AM New York | `amnewyork.svg` | Real vector logo |
| Yahoo Finance | `yahoo-finance.svg` | Real vector logo |
| HousingWire | `housingwire.svg` | SVG text wordmark |
| Inman | `inman.svg` | SVG text wordmark |
| New York Post | `nypost.svg` | SVG text wordmark |

**If the publication logo doesn't exist, you MUST create one before adding the press entry.**

How to source a press logo:
1. **Best:** Download the actual SVG/PNG from the publication's website (look in `<header>`, `<footer>`, or press kit pages)
2. **Good:** Search `"[publication] logo SVG"` or check brandfetch.com, seeklogo.com, vtlogo.com
3. **Fallback:** Create an SVG text wordmark that matches the publication's font style:

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 [width] [height]" fill="none">
  <text x="0" y="[baseline]" font-family="[font]" font-size="[size]" font-weight="[weight]" fill="#181818">[Publication Name]</text>
</svg>
```

Font guidance for common publication styles:
- **Serif newspapers** (NY Post, WSJ): `font-family="'Times New Roman', Georgia, serif"` weight 700-900
- **Sans-serif tech** (TechCrunch, Wired): `font-family="'Helvetica Neue', Arial, sans-serif"` weight 800
- **Serif magazines** (Inman, Forbes): `font-family="'Playfair Display', Georgia, serif"` weight 900

Save to: `public/images/press/[slug].svg`

**Then register the logo in the PressBar component** (`src/components/PressBar.astro`):

```javascript
const logoMap: Record<string, string> = {
  // ... existing entries
  'Publication Name': '/images/press/[slug].svg',
};
```

The `publication` field in frontmatter MUST match the key in `logoMap` exactly (case-sensitive).

### Press entry format in frontmatter:

```yaml
press:
  - publication: "New York Post"    # Must match logoMap key exactly
    headline: "Article headline"
    quote: "Pull quote under 20 words"
    url: "https://full-article-url"
```

**Priority order:** If there are many articles, prioritize by publication prestige:
1. Major newspapers (NY Post, WSJ, NYT)
2. Industry leaders (The Real Deal, HousingWire, Inman)
3. Business press (Yahoo Finance, Bloomberg, Reuters)
4. Wire services (PR Newswire, Business Wire)
5. Local/niche (AM New York, tech blogs)

Show 3-5 press entries max. More than that dilutes impact.

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
category: insurance | finance | healthcare | wellness | real-estate | sustainability | saas | consumer
date: YYYY-MM-DD  # Use project start date
order: N  # See ordering rules below
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

### Ordering Rules (CRITICAL)

Case studies are sorted by the `order` field, NOT by date. The order reflects Nolte's positioning — regulated industries first.

**Industry tier priority:**
1. Insurance
2. Finance
3. Healthcare
4. Everything else (wellness, real-estate, sustainability, saas, consumer)

**Within each tier:** longer partnerships rank higher.

**To assign an order value:**
1. Read the `order` field from every existing case study in `src/content/work/`
2. Determine where the new study fits based on industry tier + partnership duration
3. Assign the next available integer. Use gaps (e.g., 10, 20, 30) if you want room for future inserts, or renumber as needed.

**Do not skip this.** A missing or wrong `order` value will cause the case study to sort incorrectly on the work index page.

Optional fields to add if data exists:
```yaml
press:
  - publication: "Publication Name"  # Must match PressBar logoMap key
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

Add the client logo to **ALL 3** files. Missing any one of these means the logo won't show on that page:
- `src/pages/index.astro` → `caseLogos` (homepage featured section)
- `src/pages/work/index.astro` → `logoMap` (work index grid)
- `src/pages/work/[slug].astro` → `clientLogos` (case study sidebar)

**Verify after adding:** search for the client slug across all three files to confirm all three maps have the entry.

## Step 7: Verify

```bash
npm run build   # Must pass with 0 errors
npm run dev     # Preview at localhost:4321/work/[slug]
```

Check:
- Case study page renders correctly
- Logo shows on cards (homepage + work index)
- **Press bar renders with logos** (not just text fallback) — verify each publication has a logo file and a logoMap entry
- Gallery images load
- Mobile responsive
- No sensitive information exposed

## Step 8: File GitHub Issues for Missing Content

After the case study is published, audit it for any gaps or follow-up items and create a **single** GitHub issue that tracks everything needed to complete the case study.

**Scan for these common gaps:**
- [ ] Missing or placeholder metrics (deliveries, accuracy, cycle time) — needs real NolteOS data
- [ ] No testimonial quote from the client
- [ ] Missing gallery images or product screenshots
- [ ] Missing press coverage that could be added
- [ ] Placeholder or low-quality featured image
- [ ] Missing team members (only partial team listed)
- [ ] Content sections that feel thin or need client input
- [ ] Logo is missing or low quality
- [ ] **Press logos using text fallback instead of real brand assets**

**Create one issue per case study using `gh`:**

```bash
gh issue create \
  --title "Content follow-ups: [Client Name] case study" \
  --label "P2 - content" \
  --body "$(cat <<'EOF'
## Missing content for `/work/[slug]`

The case study is live but needs the following items resolved:

- [ ] Item 1
- [ ] Item 2
- [ ] ...

These items require input from the client or internal team and could not be resolved during the initial build.
EOF
)"
```

**Rules:**
- Only create an issue if there are actual gaps. If the case study is complete, skip this step.
- Use the `P2 - content` label.
- Each checklist item should be specific and actionable (e.g., "Get testimonial quote from Sam Mogil" not "Add testimonial").
- Note which items need client approval vs. internal data (e.g., NolteOS metrics).
