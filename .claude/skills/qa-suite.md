---
name: qa
description: Run QA checks on the Nolte site after major changes. Validates build, links, design system, content, and SEO.
---

# QA Test Suite for Nolte Site

Run this after every major release to catch issues before they go live.

## Instructions

Run these checks in order. Report a summary at the end with PASS/FAIL for each category.

### 1. Build Check
- Run `cd /Users/jeffnolte/Claude/nolte-site && npx astro build 2>&1`
- Verify: zero errors, all pages built
- Report: page count and any warnings

### 2. Page Existence Check
Verify these pages exist in `dist/`:
- `/index.html` (homepage)
- `/work/index.html` (work index)
- `/work/breeze-oral-care/index.html`
- `/work/odie/index.html`
- `/work/pilou/index.html`
- `/blog/index.html`
- `/about/nolteos/index.html`
- `/industries/insurance/index.html`
- `/industries/healthcare/index.html`
- `/industries/finance/index.html`

Verify these pages do NOT exist (hidden):
- `/about/index.html` (Our Story — hidden)
- `/about/team/index.html` (Team — hidden)

### 3. Broken Links Check
Search all HTML files in `dist/` for internal links (`href="/..."`). Verify each target exists as a file in `dist/`. Report any broken links.

### 4. Image Check
Search all HTML files for `<img src="/images/...">`. Verify each image file exists in `public/images/`. Report any missing images.

### 5. Design System Check
Spot-check the homepage HTML (`dist/index.html`) for:
- All containers use `max-width: 1100px` or `780px` (not other values)
- No `border-radius` on card-level elements
- Font references include `var(--serif)`, `var(--mono)`, `var(--sans)`
- CTA text is "Get Your Delivery Plan" (not "See Your Forecast")
- No "forecast" in CTAs (allowed in article body content only)

### 6. SEO Check
For each page in `dist/`:
- Has `<title>` tag
- Has `<meta name="description">`
- Has `<link rel="canonical">`
- Has Open Graph tags (`og:title`, `og:description`)
- Homepage has JSON-LD schema

### 7. Content Check
- No placeholder text ("Lorem ipsum", "IMAGE NEEDED", "TODO", "placeholder")
- No fabricated names in case studies (check testimonial authors match: Dr. Josh Turnbull, Andrea de la Garza, Miles Thorson, Zabrina Janda, April Heasley)
- Blog posts have valid dates (not in the future beyond current month)

### 8. Performance Check
- Check total dist size: `du -sh dist/`
- Check largest files: `find dist -type f -size +500k`
- Verify no unoptimized images over 2MB in public/images/

## Output Format

```
QA REPORT — [date]
========================
1. Build:        PASS/FAIL — [details]
2. Pages:        PASS/FAIL — [details]
3. Links:        PASS/FAIL — [details]
4. Images:       PASS/FAIL — [details]
5. Design:       PASS/FAIL — [details]
6. SEO:          PASS/FAIL — [details]
7. Content:      PASS/FAIL — [details]
8. Performance:  PASS/FAIL — [details]
========================
RESULT: X/8 PASSED
```
