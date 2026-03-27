# WordPress → Astro Migration Playbook (with Claude Code)

> How to migrate a WordPress marketing site to Astro 6 + Netlify in a single session using Claude Code as your development team.

**What this covers:** Architecture, content migration, design system, SEO preservation, analytics, QA, and deployment.

**What you'll need:** Claude Code (or Claude Pro with agent mode), a WordPress XML export, and decision-making authority over your site.

**Time:** 4-8 hours of active work depending on site complexity.

---

## Phase 1: Architecture (30 min)

### Prompt Claude:

```
Build an Astro 6 static site with this structure:
- Blog: index, single post, author pages, category pages
- Work/Case Studies: index, single, categories
- About: team, story
- Landing page with hero, value props, case studies, CTA

Use MDX integration, content collections with Zod schemas,
and sitemap generation. Deploy target: Netlify.
```

### What Claude builds:
- `astro.config.mjs` with MDX + sitemap
- `src/content.config.ts` with typed schemas
- `src/layouts/Base.astro` (nav, footer, SEO head)
- `src/components/BaseHead.astro` (meta, OG, JSON-LD)
- Page templates for all routes
- `netlify.toml` for deployment

### Your decisions:
- Site structure and navigation
- Content types and their fields
- URL patterns

---

## Phase 2: WordPress Export & Migration (1 hr)

### Step 1: Export from WordPress

```
WordPress Admin → Tools → Export → All Content
```

Or from Pantheon:
```
Dashboard → Backups → Files (downloads wp-content/uploads/)
```

### Step 2: Give Claude the export

```
@/path/to/wordpress-export.xml
Migrate all blog posts from this WordPress export into
Astro content collection markdown files. Preserve: title,
date, author, description, and body content.
```

### Step 3: Media migration

Tell Claude:
```
Download all media from the WordPress export URLs and
organize into public/images/. Resize for web (max 1200px wide).
```

Claude will:
- Parse all `<wp:attachment_url>` entries from the XML
- Download images via `curl` in parallel
- Resize with `sips` (macOS) or `sharp`
- Organize by type (logos, team, blog, work)

### What to watch for:
- WordPress XML has CDATA wrappers — Claude handles this
- Some images are lazy-loaded and won't appear in the XML
- WebFetch can't download binary files — Claude uses `curl` instead

---

## Phase 3: Design System (1-2 hrs)

### The approach that works:

1. **Give Claude a brand reference:**
```
@/path/to/brandbook.pdf
Look at [competitor-site.com] for design inspiration.
Start with the landing page. Here's our brand book.
```

2. **Iterate with screenshots:**
   - Claude makes changes → takes a screenshot → you review
   - Give specific feedback: "the grid is off", "make logos same size", "too much spacing"
   - Don't say "make it better" — say what's wrong

3. **Establish rules early:**
   - Max content width (e.g., 1100px)
   - Font system (heading, body, mono)
   - Color tokens
   - Section spacing
   - No rounded corners (or whatever your style is)

### Pro tips:
- Create a `DESIGN-BRIEF.md` in the repo — Claude reads it for context
- Create a `CLAUDE.md` with project conventions — every Claude session reads this
- Reference the brief when things drift: "check the design system"

---

## Phase 4: Content & Copy (1 hr)

### Blog post rewriting (if needed):

```
Rewrite these blog posts to align with our positioning:
[your positioning statement]. Each post should link to
our anchor article. Voice: [your voice description].
```

Claude can process 5-6 posts in parallel using background agents.

### Case studies:

```
Scrape the content from [live-case-study-url] and rebuild
the markdown with real images. Use real client names,
real team members, real metrics.
```

### What to own yourself:
- Positioning decisions
- Voice and tone
- Which content to keep vs. sunset
- Client names and testimonials (don't let Claude fabricate)

---

## Phase 5: SEO Preservation (30 min)

### Critical checklist:

```
Build a 301 redirect map from old WordPress URLs to new
Astro paths. Output as a Netlify _redirects file.
```

- [ ] Sitemap auto-generated (Astro sitemap integration)
- [ ] robots.txt with sitemap reference
- [ ] Canonical URLs on every page
- [ ] Open Graph tags (title, description, image)
- [ ] JSON-LD structured data (Organization, BlogPosting)
- [ ] RSS feed
- [ ] Meta descriptions on all pages
- [ ] 301 redirects from old URLs

---

## Phase 6: Analytics (30 min)

### PostHog (recommended for PLG):

```
Add PostHog analytics with project key [your-key].
Track: CTA clicks with location, scroll depth milestones,
time on page, UTM parameters. Filter out localhost and bots.
Tag staging vs production.
```

Claude implements:
- PostHog JS snippet
- Custom events (CTA clicks, scroll depth, time on page)
- UTM parameter capture
- Bot/localhost filtering
- Environment tagging

---

## Phase 7: QA & Deploy (30 min)

### Create a QA skill:

```
Create a QA test suite that checks: build status, page
existence, broken links, missing images, design system
compliance, SEO tags, placeholder content, and performance.
```

### Deploy:

```bash
npx astro build
npx netlify-cli deploy --prod --dir=dist
```

### DNS switch (when ready):

```
Point your domain's DNS to Netlify. Add the domain in
Netlify dashboard. SSL auto-provisions.
```

---

## Phase 8: Project Management (15 min)

### Migrate everything to GitHub Issues:

```
Create GitHub issues for every remaining task in BACKLOG.md
with priority labels (P0-P5) and assignees.
```

Claude creates labeled issues you can track, assign, and link to commits.

---

## The Session Pattern

This is how the workflow actually flows:

```
You: [Decision or feedback]
Claude: [Implements, screenshots, deploys]
You: [Reviews live site, gives feedback]
Claude: [Iterates, deploys again]
```

**Your job:** Product decisions, design direction, content judgment, asset provision.

**Claude's job:** All code, migration, infrastructure, deployment, QA.

The ratio is roughly: **80% Claude execution, 20% your decisions.** But that 20% is where all the value lives.

---

## Files Claude Creates

```
├── CLAUDE.md              # Project context for future sessions
├── DESIGN-BRIEF.md        # Design system for your team
├── BACKLOG.md             # All remaining tasks
├── ASSETS-NEEDED.md       # Running list of images needed
├── CLIENT-HISTORY.md      # Client list for case study selection
├── .claude/skills/qa-suite.md  # QA automation
├── .claude/launch.json    # Dev server config
└── netlify.toml           # Deploy config
```

---

## Results

| Metric | Value |
|--------|-------|
| Pages built | 52 |
| Blog posts migrated | 26 |
| Media files backed up | 2,342 |
| GitHub issues created | 32 |
| Time to live site | ~6 hours active |
| WordPress dependency | Eliminated |

---

## License

MIT — Use this playbook however you want. If it helps, star the repo.

Built by [Nolte](https://nolte.io) using [Claude Code](https://claude.ai/code).
