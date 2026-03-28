# WordPress → Astro Migration Playbook (with Claude Code)

> How we migrated nolte.io from WordPress/Pantheon to Astro 6/Netlify in 8 days using Claude Code — and the lessons we learned doing it.

**What this covers:** Strategy, architecture, content migration, design system, componentization, SEO/GEO, CRM integration, DNS cutover, and post-launch monitoring.

**What you'll need:** Claude Code, a WordPress XML export, decision-making authority, and a positioning document.

**Realistic time:** 8-12 days of iterative work sessions. Each session is 2-4 hours. This is not a one-shot build — it's iterative product development with an AI development partner.

---

## Phase 0: Positioning & Brief (Before You Touch Code)

Write these documents before starting:

1. **Positioning brief** — Target audience, key messages, differentiators, voice. This prevents rework. Our brief was 466 lines and governed every design decision.
2. **CLAUDE.md** — Project conventions file Claude reads every session. Include: brand rules, language DO/DON'T list, design constraints, tech stack.
3. **Content audit** — What pages exist, what stays, what gets cut.

### Why this matters:
We did a complete positioning overhaul mid-project (v1 → v2 brief). That single change touched 24 files and was our largest commit (2,129 insertions/deletions). If we'd started with the right brief, we'd have saved 30% of the work.

---

## Phase 1: Architecture (1-2 hrs)

### Prompt Claude:

```
Build an Astro 6 static site with this structure:
- Blog: index, single post, author pages, category pages
- Work/Case Studies: index, single, categories
- Landing page with hero, proof strip, value props, case studies, testimonial, CTA
- Contact page with form

Use MDX integration, content collections with Zod schemas,
and sitemap generation. Deploy target: Netlify.
```

### What Claude builds:
- `astro.config.mjs` with MDX + sitemap + site URL
- `src/content.config.ts` with typed schemas for blog, work, authors, categories
- `src/layouts/Base.astro` (nav, footer, JSON-LD)
- `src/components/BaseHead.astro` (meta, OG, favicon)
- Page templates for all routes
- `netlify.toml` for deployment

### Lesson learned:
Architecture isn't a one-time phase. We modified the base layout, nav structure, and component architecture across 20+ commits. Set the foundation early, but expect to refactor as you iterate on design.

---

## Phase 2: WordPress Export & Migration (1-2 hrs)

### Step 1: Export from WordPress

```
WordPress Admin → Tools → Export → All Content
```

Or from Pantheon:
```
Dashboard → Backups → Files (downloads wp-content/uploads/)
```

### Step 2: Content migration

```
@/path/to/wordpress-export.xml
Migrate all blog posts from this WordPress export into
Astro content collection markdown files. Preserve: title,
date, author, description, and body content.
```

### Step 3: Media migration

```
Download all media from the WordPress export URLs and
organize into public/images/. Resize for web (max 1200px wide).
```

### What to watch for:
- WordPress XML has CDATA wrappers — Claude handles this
- Some images are lazy-loaded and won't appear in the XML — scrape the live site
- Real images take longer than code. Budget more time for assets than engineering
- **Testimonials are fragile** — store them in your content collection frontmatter, not scraped from the live site. If the live site changes before you launch, your copy becomes stale

---

## Phase 3: Design System (4-6 hrs across multiple sessions)

This is the longest phase. Don't underestimate it.

### The approach that works:

1. **Give Claude a brand reference + positioning brief**
2. **Iterate with screenshots** — Claude makes changes, takes a screenshot, you review
3. **Give specific feedback**: "the grid is off", "these logos aren't aligned", "the type is inconsistent" — not "make it better"

### Establish rules early:
- Max content width (e.g., 1100px matching nav container)
- Font system with two tiers: primary labels (11px/0.08em) and secondary labels (10px/0.06em)
- Body text tiers: main (16px), card (14px), small meta (13px)
- Section headings: all h2s at same size/weight
- No rounded corners (or whatever your style is)
- Color tokens in CSS custom properties

### Typography normalization is mandatory:
We found 6 different h2 sizes, 3 different label sizes, and wildly varying letter-spacing across the site. Run a full typography audit:

```
Inspect every heading, label, and body text element.
Create a consistent system: h2s should all be the same
size/weight. Mono labels should use two tiers only.
```

### Componentize early:
We extracted shared sections into Astro components mid-project. Do this from the start:
- `CtaSection.astro` — global CTA (used on 8 pages, one source of truth)
- `CaseCard.astro` — case study card (used on homepage + work index)
- These prevent "fix one thing, break another" — which happened to us multiple times

### Lessons learned:
- **Grid alignment is iterative** — expect 3-5 rounds of padding/margin fixes
- **Hero is the hero** — spend extra time here, test on all viewports
- **Animations should be minimal** — we built a full animation system (scroll reveals, micro-interactions, nav underlines) then stripped it all back to just the hero entrance fade-in. Hero entrance animation is enough.
- **Don't do full file rewrites** — use surgical edits. We lost a dark-background testimonial section during a full page rewrite. Use `Edit` not `Write` for existing files. Trust was broken and had to be rebuilt.

---

## Phase 4: Content & Copy (1-2 hrs)

### Case studies:
```
Scrape the content from [live-case-study-url] and rebuild
the markdown with real images. Use real client names,
real team members, real metrics.
```

### Blog post review:
Review each post against your positioning. We had 29 posts — some aligned perfectly, others needed copy updates.

### What to own yourself:
- Positioning decisions (this is the 20% that matters)
- Voice and tone
- Which content to keep vs. sunset
- Client names, testimonials, and metrics (don't let Claude fabricate)
- Legal pages (Privacy Policy, Terms of Service) — update jurisdiction, services, data practices

---

## Phase 5: SEO & GEO Preservation (1-2 hrs)

### Critical — do this before launching:

**301 Redirects:**
```
Build a 301 redirect map from ALL old WordPress URLs to new
Astro paths. Include: blog slug changes, category/tag pages,
author pages, WordPress artifacts (wp-admin, xmlrpc, wp-json),
RSS feed, and sitemap.
```

Our `_redirects` file has 101 lines covering ~70 redirect rules. Test them before launch.

**SEO checklist:**
- [ ] Sitemap auto-generated (Astro sitemap integration)
- [ ] robots.txt with sitemap reference
- [ ] Canonical URLs on every page (use `Astro.site` — set this to your production domain)
- [ ] Open Graph tags (title, description, image)
- [ ] JSON-LD: Organization, WebSite, BlogPosting, FAQPage, BreadcrumbList
- [ ] Author LinkedIn `sameAs` in article schema
- [ ] RSS feed
- [ ] Meta descriptions on all pages
- [ ] 301 redirects from all old URLs

**GEO (Generative Engine Optimization):**
- FAQPage JSON-LD on any page with Q&A content
- `knowsAbout` field in Organization schema
- Author credentials with LinkedIn links
- Internal linking between related content (editorial task)

---

## Phase 6: Integrations (1-2 hrs)

### Contact form → CRM:
```
Create a Netlify serverless function that receives form
submissions and creates a person record in [your CRM].
```

We built `netlify/functions/contact.mjs` that creates Clarify CRM records. The form also submits to Netlify Forms as backup. Set the API key as a Netlify environment variable.

### Analytics (PostHog):
```
Add PostHog analytics with project key [your-key].
Track: CTA clicks with location, scroll depth milestones,
time on page, UTM parameters. Filter out localhost and bots.
Tag staging vs production.
```

**Lesson learned:** Filter out your own traffic on day 1. Claude's page loads during development will pollute your metrics. Add bot detection for known crawlers.

### Calendar/scheduling:
If you use Cal.com or Calendly, add booking links to your CTA sections.

---

## Phase 7: Pre-Launch (2-4 hrs)

### Pages to create before launch:
- [ ] Privacy Policy (`/privacy`) — legal requirement
- [ ] Terms of Service (`/terms`) — legal requirement
- [ ] Custom 404 page — make it on-brand with navigation links
- [ ] Team page (if needed)
- [ ] Any client-facing resource pages (billing guides, payment instructions)

### Hide in-progress content:
Rename incomplete pages to `.astro.draft` — keeps them in the repo but out of the build.

### Responsive testing:
Test every template at 375px (mobile), 768px (tablet), and desktop.

**Known traps:**
- **Hamburger menu z-index** — the mobile dropdown renders behind the hero content. Add `z-index: 100` to `nav`.
- **Horizontal overflow** — add `overflow-x: hidden` to `body`. Wide elements (nav links, hero images) can force horizontal scroll on mobile.
- **Blog card footers** — date + author + link on one line breaks at narrow widths. Stack them vertically.

### Create a regression test script:
We built a 177-line shell script that checks mobile, tablet, and desktop breakpoints. Run it after every deploy.

### Favicon:
- Check that you've replaced the default Astro favicon
- SVG favicon takes priority in modern browsers — make sure it's your brand, not the Astro rocket
- Test in an incognito window (browsers cache favicons aggressively)

---

## Phase 8: DNS Migration & Go-Live

### This is the scariest part. Here's exactly what happened to us:

**Pre-migration:**
1. Add your domain as a custom domain in Netlify dashboard (Domain settings → Add custom domain)
2. Wait for Netlify to show the domain with a green checkmark
3. Lower your DNS TTL to 300 seconds (5 min) before switching

**DNS switch:**
1. Update your A record to Netlify's IP (ours: `75.2.60.5`)
2. **Delete AAAA (IPv6) records** pointing to your old host — this caught us. IPv6 clients were still hitting Pantheon even after the A record changed
3. Keep MX records untouched (email stays on Google Workspace or wherever it is)

**SSL provisioning:**
- Netlify auto-provisions a Let's Encrypt certificate
- This took ~15 minutes for us, but can take up to 24 hours
- During this gap, HTTPS doesn't work — browsers show a cert error
- Click "Verify DNS configuration" in Netlify dashboard to kick the provisioning
- The site content is served correctly even before SSL provisions (verifiable with `curl -k`)

**Post-launch verification (first 24 hrs):**
- [ ] `https://yourdomain.com` loads the new site (not old host)
- [ ] SSL certificate shows your domain name (not `*.netlify.app`)
- [ ] Redirects work: test 10+ old URLs
- [ ] `www.` redirects to apex domain
- [ ] Contact form submits successfully
- [ ] Analytics tracking works (check PostHog/GA dashboard)
- [ ] Email still works (send yourself a test)
- [ ] Google Search Console: submit sitemap, request indexing for key pages
- [ ] Monitor 404 logs for missed redirects

**Keep old host alive for 30 days** as fallback. Decommission after you're confident.

---

## Phase 9: Project Management (15 min)

### Migrate remaining tasks to GitHub Issues:

```
Create GitHub issues for every remaining task with
priority labels. Include editorial work (blog images,
internal linking, source citations).
```

We created 3 issues:
- #36 — SEO/GEO editorial content improvements
- #37 — Blog featured images (26 posts need images)
- #38 — Full migration plan with pre/post-launch checklists

---

## The Session Pattern

```
You: [Decision or feedback]
Claude: [Implements, takes screenshot, verifies]
You: [Reviews, gives specific feedback]
Claude: [Iterates, verifies again]
```

**Your job:** Product decisions, positioning, design direction, content judgment, asset provision.

**Claude's job:** All code, migration, infrastructure, components, SEO, analytics, deployment, QA.

The ratio is roughly: **80% Claude execution, 20% your decisions.** But that 20% is where all the value lives.

---

## Lessons Learned

### Trust & safety:
- **Never do full file rewrites on existing pages.** We lost a testimonial section during a Write operation that replaced the entire file. Use Edit for surgical changes. Always.
- **Componentize shared sections immediately.** We had the same CTA block copy-pasted across 5 pages. When we updated one, the others drifted. Extract to components early.

### Design:
- **Typography normalization is a phase, not a task.** Budget a full session for auditing every heading, label, and body text element site-wide.
- **Animations: less is more.** We built scroll reveals, card hovers, nav underlines, proof strip pops — then stripped everything except the hero entrance. Ship the hero animation, skip the rest.
- **Container width must match the nav.** Our nav inner was 1100px but content containers varied. Standardize early.

### Technical:
- **`overflow-x: hidden` on body.** Mobile viewports break silently when wide elements force horizontal scroll.
- **Nav z-index: 100.** Mobile hamburger menus render behind dark hero sections without this.
- **`is:global` for dynamically injected content.** Astro's scoped styles don't apply to elements added via JavaScript (like "Load More" buttons).
- **Favicon SVG overrides ICO.** If you have both, modern browsers use the SVG. Make sure it's your brand.

### Operational:
- **Write the positioning brief first.** Our v1 → v2 positioning change was our largest commit. Start with the right brief.
- **Delete IPv6 AAAA records during DNS migration.** IPv6 clients will keep hitting your old host even after A records change.
- **SSL takes time.** Plan for a 15-minute to 24-hour gap between DNS switch and cert provisioning.
- **Google Search Console can't read your sitemap until SSL is live.** Submit it after the cert provisions, not before.

---

## Final Stats

| Metric | Value |
|--------|-------|
| Pages built | 61 |
| Blog posts migrated | 29 |
| Case studies | 4 |
| Reusable components | 3 |
| Redirect rules | ~70 |
| Commits | 42 |
| Calendar days | 8 (March 19-27, 2026) |
| Build time | 1.9 seconds |
| WordPress dependency | Eliminated |

---

## Cost Comparison

| | Agency Quote | Claude Code |
|---|---|---|
| Strategy & positioning | $8-12K | Your time |
| UX/UI design | $15-25K | Your time + Claude |
| Frontend development | $20-35K | Claude |
| Content migration | $3-5K | Claude |
| SEO setup | $3-5K | Claude |
| CRM integration | $2-4K | Claude |
| QA & responsive testing | $3-5K | Claude |
| **Total** | **$54-91K** | **~$200 (Claude sub)** |
| **Timeline** | **8-14 weeks** | **8 days** |

---

## License

MIT — Use this playbook however you want. If it helps, star the repo.

Built by [Nolte](https://nolte.io) using [Claude Code](https://claude.ai/code).
