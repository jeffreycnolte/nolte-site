# LinkedIn Post Draft

---

**After 20 years on WordPress, I moved our entire site to a modern stack in a week. With Claude Code. Here's the real story.**

This one is bittersweet.

I started with WordPress in 2006. It was the first CMS I ever used professionally. I contributed to the community, built dozens of client sites on it, and ran our own company site on WordPress/Pantheon for years.

But the honest truth: it wasn't working anymore. Slow to update, expensive to maintain, and it didn't reflect how we actually build software — which is predictive, data-driven, and fast.

So I sat down with Claude Code and rebuilt everything from scratch.

**What we shipped — March 19-27, 2026 (8 days):**

- 61 pages: homepage, 4 case studies, 29 blog posts, team, contact, industry pages, legal, NolteOS
- 3 reusable components (CtaSection, CaseCard, BaseHead)
- Full design system: normalized typography, responsive at every breakpoint
- SEO/GEO: JSON-LD schemas, FAQPage, sitemaps, canonical URLs, OG tags
- Contact form → Clarify CRM via Netlify serverless function
- 69 redirect rules preserving every old WordPress URL
- PostHog analytics with session replay, scroll depth, UTM capture
- Custom 404 page, privacy policy, terms of service
- Mobile responsive across all templates

**The cost comparison — this is the part that matters:**

If I had hired an agency (and I know, because I run one):

| | Agency Quote | Claude Code |
|---|---|---|
| Strategy & positioning | $8-12K | My time |
| UX/UI design | $15-25K | My time + Claude |
| Frontend development | $20-35K | Claude |
| Content migration | $3-5K | Claude |
| SEO setup | $3-5K | Claude |
| CRM integration | $2-4K | Claude |
| QA & responsive testing | $3-5K | Claude |
| **Total** | **$54-91K** | **~$200 (Claude subscription)** |
| **Timeline** | **8-14 weeks** | **8 days** |

That's not a typo. And the quality is production-grade — not a prototype, not an MVP. A live site with a design system, component architecture, SEO infrastructure, and CRM integration.

**What I actually did vs. what Claude did:**

Me: Product decisions. Positioning. Copy. Design direction. "This looks off." "Remove that quote." "The type is inconsistent." Every judgment call was mine.

Claude: All code. All CSS. All components. WordPress migration. Image optimization. SEO schemas. Serverless functions. Responsive testing. GitHub issues. Redirects.

**The honest take:**

This isn't "AI replaced my team." This is a founder operating at the speed of decisions instead of the speed of sprints.

I knew exactly what I wanted. I've done this work for 20 years. Claude removed the 8-14 week lag between deciding and shipping.

If you don't know what you want — if you need someone to challenge your thesis, shape the strategy, and tell you what shouldn't be built — that's what Nolte does. AI doesn't replace judgment. It removes the friction after judgment has been applied.

The site is live at nolte.io.

**Comment "playbook" and follow me — I'll send you the open-source migration guide.**

—

P.S. Goodbye WordPress. You were great for 20 years. I mean that.

---

## Posting instructions

**Images:** Take screenshots of:
1. Homepage hero (desktop) — the "Innovate Predictably" hero
2. Case study page (Breeze) — showing the dark testimonial
3. Mobile view — showing responsive nav + hero
4. The cost comparison table from this post (create as image)

**Format:** 1200x627px for LinkedIn. Post as a carousel if possible.

**Hashtags (add in first comment, not post body):**
#ClaudeCode #WordPress #Astro #WebDevelopment #AI #Anthropic #BuildInPublic #Migration #Netlify

**Engagement strategy:**
- Post between 7-9am EST Tuesday-Thursday for max visibility
- Reply to every comment within 1 hour
- When someone comments "playbook", reply with the GitHub link: https://github.com/jeffreycnolte/nolte-site/blob/main/WORDPRESS-TO-ASTRO-PLAYBOOK.md
- Pin a follow-up comment: "The full playbook is open source. 20 years of WordPress → Astro/Netlify in 8 days. Follow for more on how we use Claude across our entire delivery workflow."
- Tag @Anthropic and @ClaudeAI if they have company pages

**Key stats for comments/replies:**
- 37 commits over 8 days
- 61 pages built
- 29 blog posts migrated
- 69 redirect rules
- 220 files in the project
- First commit: March 19, last commit: March 27
- Build time: 1.9 seconds
