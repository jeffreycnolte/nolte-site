#!/bin/bash
# Nolte Site Regression Test Suite
# Run after every deploy: ./scripts/regression-test.sh [url]
# Default URL: https://nolte-site.netlify.app

set -e

URL="${1:-https://nolte-site.netlify.app}"
PASS=0
FAIL=0
WARN=0
RESULTS=""

log_pass() { PASS=$((PASS+1)); RESULTS="$RESULTS\n  ✅ $1"; }
log_fail() { FAIL=$((FAIL+1)); RESULTS="$RESULTS\n  ❌ $1"; }
log_warn() { WARN=$((WARN+1)); RESULTS="$RESULTS\n  ⚠️  $1"; }

echo "============================================"
echo "  NOLTE REGRESSION TEST SUITE"
echo "  URL: $URL"
echo "  Date: $(date)"
echo "============================================"

# ─── 1. PAGE AVAILABILITY ───
echo ""
echo "1. Page Availability"
PAGES=(
  "/"
  "/work/"
  "/work/breeze-oral-care/"
  "/work/odie/"
  "/work/pilou/"
  "/blog/"
  "/about/nolteos/"
  "/industries/insurance/"
  "/industries/healthcare/"
  "/industries/finance/"
)
for page in "${PAGES[@]}"; do
  status=$(curl -s -o /dev/null -w "%{http_code}" "$URL$page" 2>/dev/null)
  if [ "$status" = "200" ]; then
    log_pass "$page → $status"
  else
    log_fail "$page → $status"
  fi
done

# Hidden pages should 404
HIDDEN=("/about/" "/about/team/")
for page in "${HIDDEN[@]}"; do
  status=$(curl -s -o /dev/null -w "%{http_code}" "$URL$page" 2>/dev/null)
  if [ "$status" = "404" ]; then
    log_pass "$page → 404 (correctly hidden)"
  else
    log_warn "$page → $status (expected 404)"
  fi
done

# ─── 2. SEO CHECKS ───
echo ""
echo "2. SEO"
homepage=$(curl -s "$URL/" 2>/dev/null)

echo "$homepage" | grep -q '<title>' && log_pass "Homepage has <title>" || log_fail "Missing <title>"
echo "$homepage" | grep -q 'og:title' && log_pass "Homepage has og:title" || log_fail "Missing og:title"
echo "$homepage" | grep -q 'og:description' && log_pass "Homepage has og:description" || log_fail "Missing og:description"
echo "$homepage" | grep -q 'canonical' && log_pass "Homepage has canonical" || log_fail "Missing canonical"
echo "$homepage" | grep -q 'application/ld+json' && log_pass "Homepage has JSON-LD" || log_fail "Missing JSON-LD"

# Check sitemap
sitemap_status=$(curl -s -o /dev/null -w "%{http_code}" "$URL/sitemap-index.xml" 2>/dev/null)
[ "$sitemap_status" = "200" ] && log_pass "Sitemap accessible" || log_fail "Sitemap missing ($sitemap_status)"

# Check robots.txt
robots_status=$(curl -s -o /dev/null -w "%{http_code}" "$URL/robots.txt" 2>/dev/null)
[ "$robots_status" = "200" ] && log_pass "robots.txt accessible" || log_fail "robots.txt missing"

# RSS feed
rss_status=$(curl -s -o /dev/null -w "%{http_code}" "$URL/blog/rss.xml" 2>/dev/null)
[ "$rss_status" = "200" ] && log_pass "RSS feed accessible" || log_fail "RSS feed missing"

# ─── 3. CONTENT INTEGRITY ───
echo ""
echo "3. Content Integrity"

# Check for placeholder text
placeholders=$(echo "$homepage" | grep -ci 'lorem ipsum\|IMAGE NEEDED\|TODO\|placeholder' || true)
[ "$placeholders" = "0" ] && log_pass "No placeholder text on homepage" || log_warn "Found $placeholders placeholder references"

# Check CTA consistency
echo "$homepage" | grep -q 'Get Your Delivery Plan' && log_pass "CTA: 'Get Your Delivery Plan' present" || log_fail "CTA text missing"
forecast_cta=$(echo "$homepage" | grep -c 'See Your Forecast' || true)
[ "$forecast_cta" = "0" ] && log_pass "No 'See Your Forecast' in CTAs" || log_warn "Found $forecast_cta 'See Your Forecast' references"

# Check Nolte logo
echo "$homepage" | grep -q 'nolte-white.svg\|nolte-black.svg' && log_pass "Nolte SVG logo present" || log_fail "Nolte logo missing"

# ─── 4. ANALYTICS ───
echo ""
echo "4. Analytics"
echo "$homepage" | grep -q 'posthog' && log_pass "PostHog snippet present" || log_fail "PostHog missing"
echo "$homepage" | grep -q 'phc_' && log_pass "PostHog project key present" || log_fail "PostHog key missing"
echo "$homepage" | grep -q 'isLocal\|isBot' && log_pass "Bot/localhost filtering active" || log_warn "Bot filtering may be missing"

# ─── 5. PERFORMANCE ───
echo ""
echo "5. Performance"

# Check response time
start=$(date +%s%N)
curl -s -o /dev/null "$URL/" 2>/dev/null
end=$(date +%s%N)
ms=$(( (end - start) / 1000000 ))
if [ "$ms" -lt 2000 ]; then
  log_pass "Homepage loads in ${ms}ms"
elif [ "$ms" -lt 5000 ]; then
  log_warn "Homepage loads in ${ms}ms (slow)"
else
  log_fail "Homepage loads in ${ms}ms (very slow)"
fi

# Check HTTPS
echo "$URL" | grep -q 'https' && log_pass "HTTPS enabled" || log_warn "Not using HTTPS"

# ─── 6. RESPONSIVE CHECKS ───
echo ""
echo "6. Responsive (CSS checks)"

# Check for mobile breakpoints in CSS
css_url=$(echo "$homepage" | grep -o '/_astro/[^"]*\.css' | head -1)
if [ -n "$css_url" ]; then
  css=$(curl -s "$URL$css_url" 2>/dev/null)
  echo "$css" | grep -q 'max-width:768px\|max-width: 768px' && log_pass "768px breakpoint present" || log_warn "Missing 768px breakpoint"
  echo "$css" | grep -q 'max-width:600px\|max-width: 600px' && log_pass "600px breakpoint present" || log_warn "Missing 600px breakpoint"
  echo "$css" | grep -q 'grid-template-columns:1fr\|grid-template-columns: 1fr' && log_pass "Single-column mobile layouts present" || log_warn "Missing mobile single-column"
else
  log_warn "Could not locate CSS file for responsive check"
fi

# ─── 7. KEY PAGES CONTENT ───
echo ""
echo "7. Key Page Content"

# Blog has posts
blog=$(curl -s "$URL/blog/" 2>/dev/null)
blog_posts=$(echo "$blog" | grep -c 'Read article' || true)
[ "$blog_posts" -gt 0 ] && log_pass "Blog index has $blog_posts posts" || log_fail "Blog index empty"

# Work page has case studies
work=$(curl -s "$URL/work/" 2>/dev/null)
echo "$work" | grep -q 'Breeze\|breeze' && log_pass "Work page has Breeze" || log_fail "Breeze missing from work"
echo "$work" | grep -q 'Odie\|odie' && log_pass "Work page has Odie" || log_fail "Odie missing from work"
echo "$work" | grep -q 'Pilou\|pilou' && log_pass "Work page has Pilou" || log_fail "Pilou missing from work"

# ─── RESULTS ───
echo ""
echo "============================================"
echo "  RESULTS"
echo "============================================"
printf "$RESULTS\n"
echo ""
TOTAL=$((PASS+FAIL+WARN))
echo "  ✅ PASS: $PASS"
echo "  ❌ FAIL: $FAIL"
echo "  ⚠️  WARN: $WARN"
echo "  Total: $TOTAL checks"
echo ""
if [ "$FAIL" -gt 0 ]; then
  echo "  STATUS: ❌ FAILING ($FAIL issues)"
  exit 1
elif [ "$WARN" -gt 0 ]; then
  echo "  STATUS: ⚠️  PASSING WITH WARNINGS"
  exit 0
else
  echo "  STATUS: ✅ ALL PASSING"
  exit 0
fi
