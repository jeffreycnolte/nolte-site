# Nolte Site Backlog

Tasks to tackle after launch. Ordered by priority.

---

## P0 — Pre-Launch (Tonight)

- [x] Hide pages: Our Story, Team, Wake case study
- [ ] Design grid standardization across all pages
- [ ] Work page: 3 case studies, categories, card design
- [ ] Blog index: date formatting, read more, author/category, pagination
- [ ] NolteOS page design system audit
- [ ] QA test suite / skill

## P0.5 — Tomorrow (1.5h migration window)

- [ ] **Deep-dive migration audit** — Tools, technology, SEO (redirects, canonical URLs, meta tags, sitemap), content parity, analytics, forms/CTAs, DNS, SSL. Ensure nothing is missed migrating from WordPress/Pantheon to Astro/Netlify.
- [ ] **WordPress migration plan** — Step-by-step 1.5h timeline: DNS switch, 301 redirects, SSL verification, smoke test, Pantheon sunset. Include rollback plan.
- [ ] **Restore hidden pages** — Our Story (`src/pages/about/index.astro.draft`), Team (`src/pages/about/team.astro.draft`), Wake case study (remove `draft: true`)

## P1 — Post-Launch Polish

- [ ] **@Yanna — Case study delivery data from JIRA** — Pull real delivery metrics (deliveries count, cycle time, on-time %, accuracy) from JIRA for each case study: Breeze, Odie, Pilou. Update frontmatter in `src/content/work/*.md` with actual numbers.
- [ ] **Blog SVG graphics for remaining posts** — Top 3 done (Predictability Gap, Why We Don't Estimate, Measuring Productivity). Generate unique data-viz SVG headers for remaining 23 blog posts in the same dark bg + accent line style. Each should reflect the post topic (WIP limits, Monte Carlo, throughput, etc.)
- [ ] **Jeffrey headshot** — Replace initials placeholder with proper headshot in "We've been in your seat" section
- [ ] **Testimonials section + page** — Collect real quotes from clients (Breeze, Odie, Pilou, others). Build testimonial section on homepage and dedicated `/testimonials` page similar to withcoverage.com/testimonials. Need: real quotes, headshots, approval from clients to publish.
- [ ] **Case study images** — Source/create product screenshots for Odie, Pilou (Breeze already has real images)
- [ ] **Mobile responsive audit** — Full pass on all pages at mobile/tablet breakpoints
- [ ] **Blog post images** — Assign SVG data graphics or on-brand visuals to all blog posts

## P2 — Content & SEO

- [ ] **Turris & Penelope case studies** — Create case study pages for these clients
- [ ] **Secure CPG case study** — Create case study page
- [ ] **Blog internal linking** — Ensure all posts link to The Predictability Gap and cross-reference related posts
- [ ] **Blog categories cleanup** — Review category assignments, ensure consistency
- [ ] **Meta descriptions audit** — Some posts had incorrect/missing meta descriptions from WP migration
- [ ] **301 redirects** — Map old nolte.io URLs to new paths for SEO continuity
- [ ] **Canonical URLs** — Verify canonical tags point to new domain once DNS is switched

## P3 — Design & Brand

- [ ] **Brand typography** — Evaluate Söhne/GT Super vs current Google Fonts (Instrument Serif, DM Mono, Geist)
- [ ] **Trust logos on dark sections** — White/light variants for use on dark backgrounds
- [ ] **Team page photos** — Real headshots for all team members on `/about/team`
- [ ] **About page content** — Expand "Our Story" with more narrative, timeline, milestones
- [ ] **Living style guide** — Build `/brand` page showing all components, colors, typography live

## P4 — Features

- [ ] **Live delivery data** — Connect week-over-week chart to real NolteOS API data
- [ ] **NolteOS integration** — Embed or deep-link to os.nolte.io from case study metrics
- [ ] **Contact/booking flow** — Cal.com integration or contact form
- [ ] **Newsletter signup** — Email capture on blog index
- [ ] **Search** — Blog search functionality
- [ ] **Dark mode** — Optional, evaluate brand application

## P5 — Infrastructure

- [ ] **Custom domain** — Point nolte.io DNS to Netlify
- [ ] **Analytics** — Add Plausible/Fathom or GA4
- [ ] **Performance audit** — Lighthouse scores, image optimization, lazy loading
- [ ] **WordPress sunset** — Decommission Pantheon site after DNS switch + redirect verification
