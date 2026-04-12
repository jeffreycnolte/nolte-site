---
description: End-to-end skill for creating a new case study. Covers research, asset sourcing, press discovery, content writing, sensitivity review, ordering, and deployment. Use when creating or substantially revising a case study.
---

# Case Study Creation

This skill covers the full lifecycle of creating a case study for nolte.io — from research through deployment. Follow every phase in order. Do not skip steps.

---

## Phase 1: Research

### 1a. Analyze the JIRA Export (if provided)

Parse the CSV and extract:
- **Total tickets** and status breakdown (Done, In Progress, Backlog, Cancelled)
- **Date range** — earliest and latest ticket dates (determines partnership duration)
- **Issue type breakdown** — Stories, Tasks, Bugs, Epics, Sub-tasks
- **Epic names** — reveal project phases and feature areas
- **Assignees** — identifies the Nolte team members involved
- **Key feature areas** — scan summaries for recurring keywords
- **Integration systems** — identify third-party tools/APIs (but DO NOT name them publicly)

Calculate:
- **Deliveries** = Done tickets (Stories + Tasks + Bugs, exclude Sub-tasks and Epics)
- **Partnership duration** = earliest to latest ticket date
- **Cycle time** = estimate from epic cadence (monthly epics ~ 4-5d cycle time)

### 1b. Research the Client

Search the web for:
- **Company website** — product, market, positioning, brand voice
- **App Store / Google Play** — if mobile app, check ratings and descriptions
- **Crunchbase** — funding stage, founding date, team size
- **LinkedIn** — employee count, positioning, key team members

### 1c. Find Press Coverage

Search specifically for press articles about the client. Check:
- Major tech publications (TechCrunch, Forbes, Bloomberg, Wired)
- Industry-specific outlets (e.g. HousingWire for real estate, InsurTech News for insurance)
- Product Hunt — check if they were featured
- General news (Yahoo Finance, Business Insider)

For each article found, extract:
```yaml
press:
  - publication: "Publication Name"
    headline: "Exact Article Title"
    quote: "Short pull quote under 20 words that highlights the client's achievement"
    url: "https://exact-url-to-article"
```

**If no press coverage is found**, tell the user and ask if they have any articles or press links to include.

---

## Phase 2: Asset Sourcing

### 2a. Client Logo

- **Preferred format**: SVG wordmark (cleanest rendering)
- **Fallback**: High-resolution PNG (minimum 200px wide, transparent background)
- **Save to**: `public/images/logos/[client-slug].svg` or `.png`
- **Source**: Client website header/footer, press kit, or brand guidelines page

**Known pitfall**: Downloading images from URLs can silently fail — the file may contain a 404 HTML page instead of an actual image. After downloading, verify the file is a valid image (check file size, run `file` command). If the logo download fails, try extracting the inline SVG from the client's website HTML.

**If you cannot find a usable logo**, ask the user: "I couldn't find a high-quality logo for [Client]. Do you have one, or should I check a specific URL?"

### 2b. Featured Image

- **Save to**: `public/images/work/[client-slug]/featured.jpg` (or `.png`, `.avif`, `.webp`)
- **Specs**: At least 1200px wide, 16:10 aspect ratio works best
- **Content**: Real product screenshots, client hardware, brand photography
- **Never**: Generic stock photos, AI-generated imagery, or placeholder images
- **Source**: Client website hero section, app store screenshots, press kit

**Known pitfall**: Image URLs from CDNs may return 504 errors or redirects. Always verify downloaded files are valid images, not error pages.

**If you cannot find a suitable featured image**, ask the user: "I need a featured image for the case study. Options: [list what you found]. Do you have a preferred image, or should I use [best candidate]?"

### 2c. Gallery Images (optional but recommended)

- **Save to**: `public/images/work/[client-slug]/[descriptive-name].jpg`
- **Purpose**: Visual storytelling — app screenshots, design systems, before/after, architecture
- **Format**: Each needs `src`, `alt`, and optional `caption` in frontmatter

Good gallery images include:
- Product UI screenshots (customer-facing only — never admin/internal dashboards)
- Design system samples
- Mobile app screens
- Before/after comparisons
- Architecture diagrams (if non-confidential)

### 2d. Asset Verification Checklist

Before proceeding, confirm you have:
- [ ] Client logo (SVG or high-res PNG) — verified as valid image file
- [ ] Featured image (1200px+ wide) — verified as valid image file
- [ ] Gallery images (if available) — all verified
- [ ] All images saved to correct paths under `public/`

**If any required asset is missing, stop and ask the user before proceeding to content writing.**

---

## Phase 3: Sensitivity Review

Run this review BEFORE writing content. Flag anything that should NOT be public.

### Hard Rules — Never Include

- **Third-party vendor or platform names** — generalize always. "HR provider" not "Rippling." "Class management platform" not "Mariana Tek." "Payment processor" not "Stripe."
- **Internal compensation structures** — no salary bands, bonus formulas, or incentive details
- **Business rules or proprietary logic** — no pricing algorithms, underwriting rules, or approval workflows
- **Specific expansion plans** — no unreleased markets, upcoming features, or internal roadmaps
- **Bug counts or defect rates** — never cite raw bug numbers or failure rates
- **Confidential metrics** — only use metrics the client has approved or that are publicly available
- **Internal dashboards or admin UI** — never screenshot or describe admin-only interfaces
- **Compliance failures or legal risk** — never imply the client had regulatory problems; frame as complexity we navigated
- **Personally identifiable information** — no customer names, user data, or internal employee details beyond approved team members

### Guiding Principle

**When in doubt, generalize.** It's always safe to be less specific. The case study should make the client look good — never expose anything that could embarrass, harm, or create legal risk for them.

### Ask When Uncertain

If you encounter information that seems borderline (e.g., a metric that might be confidential, a vendor name that might be public knowledge), ask the user: "Is it okay to include [specific detail]? I want to make sure this is approved for publication."

---

## Phase 4: Content Writing

### Frontmatter

```yaml
---
title: "Client Name"
client: "Client Name"
description: "One sentence under 200 chars. What we built, for whom, and the outcome."
category: healthcare | insurance | finance | wellness | real-estate | sustainability | consumer
date: YYYY-MM-DD  # Use project start date
image: /images/work/[client-slug]/featured.jpg
imageAlt: "Client Name — short description of image"
status: "Live"
partnership: "X+ years"
order: N  # See Phase 6 for ordering rules
services:
  - Product Strategy
  - Full-Stack Development
metrics:
  deliveries: 47        # number type — from JIRA Done count
  timeline: "4 months"  # string type
  accuracy: "95%"       # string type
  cycleTime: "4.2d"     # string type
  onTime: "98%"         # string type, optional
testimonial:            # optional — omit entirely or set quote: "" to skip rendering
  quote: "Client quote"
  author: "Name"
  role: "Title, Company"
team:                   # optional
  - name: "Team Member"
    role: "Role on Project"
platforms:              # optional
  - Web
  - iOS
  - Android
phases:                 # optional — always use Strategy > Launch > Evolve
  - name: "Strategy"
    duration: "4 weeks"
  - name: "Launch"
    duration: "12 weeks"
  - name: "Evolve"
    duration: "Ongoing"
press:                  # optional — from Phase 1c research
  - publication: "Publication Name"
    headline: "Article Title"
    quote: "Pull quote under 20 words"
    url: "https://..."
gallery:                # optional — from Phase 2c
  - src: "/images/work/[client-slug]/image.jpg"
    alt: "Description"
    caption: "Optional caption"
---
```

**Type gotchas:**
- `metrics.deliveries` must be a **number** (not a string) — `47` not `"47"`
- All other metric fields are **strings** — `"95%"` not `95`
- `category` must match a slug in `src/content/categories/` or the build will fail

### Six-Section Structure

Always use these sections in this exact order:

1. **The Bet** — What the client wanted to build and what was at stake. Frame it as the client's ambition, not our pitch. What problem were they solving? Why did it matter?

2. **The Complexity** — What made this hard. Technical challenges, regulatory requirements, market constraints, operational hurdles. This is where we show we understand the problem space.

3. **The Thinking** — Our strategic approach. What did we decide, and what did we say no to? Architecture choices, trade-offs, phasing decisions. Demonstrate judgment.

4. **The Build** — What we actually shipped. For long engagements (1+ year), break into phases. Be specific about features and technical work without exposing sensitive details.

5. **The Proof** — Metrics and outcomes. Use real numbers from NolteOS / JIRA. Link outcomes to the original bet — did the client get what they came for?

6. **The Partnership** — Why this engagement matters. What it demonstrates about how Nolte works. Connect to broader positioning (regulated industries, consultative depth, predictability).

### Writing Voice

- **Direct, confident, specific** — no hedging, no "we believe," no "solutions"
- **Problem-first** — lead with the client's challenge, not Nolte's capabilities
- **Real numbers** — cite actual metrics. Never fabricate.
- **Operator-to-operator tone** — write as founders talking to founders
- **Strategic specificity** — show the thinking, not just the output
- **Generalize vendor names** — always (see Sensitivity Review)

### Embedding Images in Body

Reference gallery or additional images inline:
```markdown
![Alt text](/images/work/[client-slug]/image.jpg)
```

Place images between sections to break up text and add visual context.

---

## Phase 5: Category Management

If the client's industry doesn't match an existing category, create one:

1. Create `src/content/categories/[slug].json`:
```json
{
  "title": "Display Name",
  "description": "One sentence describing this industry vertical.",
  "scope": "work"
}
```

2. Add pill color in `src/styles/global.css`:
```css
.case-pill-[slug] {
  border-color: #HEX;
  color: #HEX;
  background: rgba(R, G, B, 0.05);
}
```

Existing categories: `healthcare`, `insurance`, `finance`, `wellness`, `real-estate`, `sustainability`, `consumer`

---

## Phase 6: Ordering

Case studies use an explicit `order` field (lower = shown first). Do NOT rely on date for display order.

**Industry tier** (primary sort — regulated industries first):
1. Insurance
2. Finance
3. Healthcare
4. All other industries

**Partnership duration** (secondary sort within tier — longer partnerships rank higher).

When adding a new case study:
1. Determine its industry tier
2. Within that tier, place by partnership duration
3. Renumber subsequent studies to keep ordering gaps-free
4. Check current order values: `grep "^order:" src/content/work/*.md`

See `.claude/skills/case-study-ordering.md` for the full current order table.

---

## Phase 7: Logo Map Registration

The client logo must be registered in **3 separate files**. Missing any one causes the logo to disappear from that view.

### `src/pages/index.astro` → `caseLogos`
```javascript
'client-slug': { src: '/images/logos/client.svg', height: '20px' },
```
**Only needed if this case study is featured on the homepage.**

### `src/pages/work/index.astro` → `logoMap`
```javascript
'client-slug': { src: '/images/logos/client.svg', height: '20px' },
```

### `src/pages/work/[slug].astro` → `clientLogos`
```javascript
'client-slug': { src: '/images/logos/client.svg', height: '26px' },
```

**Height guidelines:**
- Homepage cards: 18-24px
- Work index cards: 18-24px
- Case study detail page: 22-28px
- Adjust per logo to balance visual weight

**Always update all 3 files in the same operation.** This is a common source of bugs.

---

## Phase 8: Build and Verify

```bash
npm run build   # Must pass with 0 errors
npm run dev     # Preview at localhost:4321/work/[client-slug]
```

### Verification Checklist

- [ ] Case study page renders with correct content
- [ ] Featured image loads and looks good
- [ ] Logo shows on work index cards
- [ ] Logo shows on case study detail page
- [ ] Category pill renders with correct color
- [ ] Press bar renders (if press data provided)
- [ ] Gallery images load (if provided)
- [ ] Testimonial renders (if provided) — or is correctly hidden if quote is empty
- [ ] Metrics display correctly in sidebar
- [ ] No sensitive information exposed (re-read the full page)
- [ ] Case study appears in correct position in work index (check `order` value)
- [ ] Build passes with 0 errors

---

## Phase 9: Post-Creation Notes

- **Featured images evolve.** It's common to swap the featured image after initial publication. Don't agonize over the first choice — it can be changed.
- **Gallery images can be added later.** Some case studies publish text-first and add visuals in a follow-up.
- **Keep the ordering skill updated.** After adding a new case study, update the order table in `.claude/skills/case-study-ordering.md`.
- **Update CASE-STUDY-GUIDE.md** existing case studies table if needed.
