# LinkedIn Post Draft

---

**I migrated our company site off WordPress in a single Claude Code session. Here's what actually happened.**

We've been on WordPress/Pantheon for years. It worked, but it was slow to update, expensive to maintain, and didn't reflect how we actually work — which is predictive, data-driven software delivery.

So I sat down with Claude Code and said: "Let's build a new site from scratch, migrate everything, and launch before end of week."

Here's what we shipped in one extended session:

**Architecture → Live site**
- Astro 6 static site, deployed to Netlify
- 52 pages: homepage, 3 case studies, 26 blog posts, industry pages, NolteOS product page
- Content collections with type-safe schemas
- Full SEO: sitemap, RSS, JSON-LD, Open Graph, canonical URLs

**WordPress migration**
- Exported 2,342 media files from Pantheon
- Migrated all blog content with frontmatter
- Downloaded real client logos, team photos, product screenshots
- Preserved URL structure for SEO continuity

**Design iteration in real-time**
- I gave feedback directly on screenshots: "the circles need to be the same size" / "make the logos the same color" / "this grid is off"
- Claude adjusted CSS, took a screenshot, I reviewed, we iterated
- We went through ~50 design rounds on the homepage alone

**The parts that surprised me:**
- Claude pulled real images from our WordPress export, resized them, and wired them into the site
- It created SVG data visualizations for blog post headers — cycle time charts, throughput graphs, forecast vs. estimate lines — all on-brand
- It built a QA test suite I can run after every deploy
- It migrated our entire backlog into 32 GitHub issues with priority labels
- PostHog analytics with custom event tracking, scroll depth, UTM capture — done in 10 minutes

**What I actually did vs. what Claude did:**

Me:
- Product decisions (positioning, copy, what to show/hide)
- Design direction ("this looks off", "align with the grid", "use their brand logo")
- Content judgment ("use real names, not fabricated ones")
- Provided assets (headshots, client logos, brand guidelines)

Claude:
- All code (HTML, CSS, Astro, JavaScript)
- WordPress data extraction and migration
- Image downloading, resizing, optimization
- SEO infrastructure
- Analytics implementation
- GitHub issue creation
- QA automation

**The honest take:**
This isn't "AI replaced my developer." This is "AI let me operate at the speed of my decisions." Every design choice, every copy edit, every positioning call was mine. Claude just removed the 2-week lag between deciding and shipping.

We're launching this week. The site is at nolte-site.netlify.app if you want to see it.

I've open-sourced the migration playbook on GitHub so you can do the same thing: [link to repo]

---

**P.S.** We're an Anthropic partner. This is how we build software for our clients too — predictably, with committed scope, timeline, and cost. That's what NolteOS does. If you're curious: os.nolte.io

---

*Suggested hashtags: #ClaudeCode #WordPress #WebDevelopment #AI #Anthropic #BuildInPublic*

*Suggested image: Screenshot of the before (WordPress) and after (new site) side by side*
