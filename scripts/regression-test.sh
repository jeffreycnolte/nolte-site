#!/bin/bash
# Nolte Site Regression Test Suite
# Change-aware: detects which files changed and only runs relevant tests.
# Usage:
#   ./scripts/regression-test.sh [url] [--all]
#   ./scripts/regression-test.sh https://nolte-site.netlify.app --all
#
# Default URL: https://nolte-site.netlify.app
# Pass --all to force the full suite regardless of what changed.

URL="${1:-https://nolte-site.netlify.app}"
FORCE_ALL=false
for arg in "$@"; do [ "$arg" = "--all" ] && FORCE_ALL=true; done

PASS=0; FAIL=0; WARN=0; RESULTS=""
log_pass() { PASS=$((PASS+1)); RESULTS="$RESULTS\n  ✅ $1"; }
log_fail() { FAIL=$((FAIL+1)); RESULTS="$RESULTS\n  ❌ $1"; }
log_warn() { WARN=$((WARN+1)); RESULTS="$RESULTS\n  ⚠️  $1"; }
log_skip() { RESULTS="$RESULTS\n  ⏭  $1 (skipped — file not changed)"; }

echo "============================================"
echo "  NOLTE REGRESSION TEST SUITE"
echo "  URL: $URL"
echo "  Date: $(date)"
echo "============================================"

# ─── CHANGE DETECTION ───
# Detect which files changed since the last commit.
# Falls back to full suite when: --all flag, no git context, or first commit.
RUN_AVAILABILITY=false
RUN_SEO=false
RUN_CONTENT=false
RUN_ANALYTICS=false
RUN_PERFORMANCE=false
RUN_RESPONSIVE=false
RUN_KEY_PAGES=false
CHANGE_SUMMARY=""

if $FORCE_ALL; then
  RUN_AVAILABILITY=true; RUN_SEO=true; RUN_CONTENT=true
  RUN_ANALYTICS=true; RUN_PERFORMANCE=true; RUN_RESPONSIVE=true; RUN_KEY_PAGES=true
  CHANGE_SUMMARY="Full suite (--all flag)"
elif ! command -v git >/dev/null 2>&1 || ! git rev-parse --git-dir >/dev/null 2>&1; then
  RUN_AVAILABILITY=true; RUN_SEO=true; RUN_CONTENT=true
  RUN_ANALYTICS=true; RUN_PERFORMANCE=true; RUN_RESPONSIVE=true; RUN_KEY_PAGES=true
  CHANGE_SUMMARY="Full suite (no git context)"
else
  # Get changed files: staged + unstaged, or since last commit
  if git rev-parse HEAD >/dev/null 2>&1; then
    CHANGED=$(git diff --name-only HEAD 2>/dev/null; git diff --name-only --cached 2>/dev/null)
    # Also check what changed in the last commit (for post-deploy runs)
    if git rev-parse HEAD~1 >/dev/null 2>&1; then
      LAST_COMMIT_CHANGES=$(git diff --name-only HEAD~1 HEAD 2>/dev/null || true)
      CHANGED="$CHANGED"$'\n'"$LAST_COMMIT_CHANGES"
    fi
  else
    CHANGED=""
  fi

  CHANGED=$(echo "$CHANGED" | sort -u | grep -v '^$' || true)

  if [ -z "$CHANGED" ]; then
    # No changes detected — run full suite to be safe
    RUN_AVAILABILITY=true; RUN_SEO=true; RUN_CONTENT=true
    RUN_ANALYTICS=true; RUN_PERFORMANCE=true; RUN_RESPONSIVE=true; RUN_KEY_PAGES=true
    CHANGE_SUMMARY="Full suite (no changes detected — running all)"
  else
    CHANGE_SUMMARY="Selective ($(echo "$CHANGED" | wc -l | tr -d ' ') files changed)"

    while IFS= read -r file; do
      [ -z "$file" ] && continue
      case "$file" in
        # CSS changes → responsive + performance
        src/styles/global.css)
          RUN_RESPONSIVE=true; RUN_PERFORMANCE=true ;;

        # Head/layout changes → SEO, analytics, availability
        src/components/BaseHead.astro)
          RUN_SEO=true; RUN_ANALYTICS=true ;;
        src/layouts/Base.astro)
          RUN_SEO=true; RUN_ANALYTICS=true; RUN_AVAILABILITY=true; RUN_CONTENT=true ;;

        # Landing page → everything
        src/pages/index.astro)
          RUN_AVAILABILITY=true; RUN_CONTENT=true; RUN_SEO=true ;;

        # Blog pages/content → blog checks
        src/pages/blog*|src/content/blog*)
          RUN_AVAILABILITY=true; RUN_KEY_PAGES=true ;;

        # Work/case study pages → work checks
        src/pages/work*|src/content/work*)
          RUN_AVAILABILITY=true; RUN_KEY_PAGES=true ;;

        # About/industry pages → availability
        src/pages/about*|src/pages/industries*)
          RUN_AVAILABILITY=true ;;

        # Delivery/brand pages → availability
        src/pages/delivery.astro|src/pages/brand.astro)
          RUN_AVAILABILITY=true ;;

        # Content schema → availability + key pages
        src/content.config.ts)
          RUN_AVAILABILITY=true; RUN_KEY_PAGES=true ;;

        # Public assets → availability + performance
        public/*)
          RUN_PERFORMANCE=true ;;

        # Config files → full suite
        astro.config*|package.json|netlify.toml)
          RUN_AVAILABILITY=true; RUN_SEO=true; RUN_CONTENT=true
          RUN_ANALYTICS=true; RUN_PERFORMANCE=true; RUN_RESPONSIVE=true; RUN_KEY_PAGES=true ;;
      esac
    done <<< "$CHANGED"

    # Print changed files summary
    echo ""
    echo "  Changed files:"
    echo "$CHANGED" | while IFS= read -r f; do [ -n "$f" ] && echo "    · $f"; done
  fi
fi

echo ""
echo "  Mode: $CHANGE_SUMMARY"
echo "  Running:"
$RUN_AVAILABILITY && echo "    · Page Availability" || true
$RUN_SEO         && echo "    · SEO" || true
$RUN_CONTENT     && echo "    · Content Integrity" || true
$RUN_ANALYTICS   && echo "    · Analytics" || true
$RUN_PERFORMANCE && echo "    · Performance" || true
$RUN_RESPONSIVE  && echo "    · Responsive" || true
$RUN_KEY_PAGES   && echo "    · Key Page Content" || true

# ─── 1. PAGE AVAILABILITY ───
if $RUN_AVAILABILITY; then
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
    "/delivery/"
    "/brand/"
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
else
  echo ""
  log_skip "1. Page Availability"
fi

# ─── 2. SEO CHECKS ───
if $RUN_SEO; then
  echo ""
  echo "2. SEO"
  homepage=$(curl -s "$URL/" 2>/dev/null)

  echo "$homepage" | grep -q '<title>' && log_pass "Homepage has <title>" || log_fail "Missing <title>"
  echo "$homepage" | grep -q 'og:title' && log_pass "Homepage has og:title" || log_fail "Missing og:title"
  echo "$homepage" | grep -q 'og:description' && log_pass "Homepage has og:description" || log_fail "Missing og:description"
  echo "$homepage" | grep -q 'canonical' && log_pass "Homepage has canonical" || log_fail "Missing canonical"
  echo "$homepage" | grep -q 'application/ld+json' && log_pass "Homepage has JSON-LD" || log_fail "Missing JSON-LD"

  sitemap_status=$(curl -s -o /dev/null -w "%{http_code}" "$URL/sitemap-index.xml" 2>/dev/null)
  [ "$sitemap_status" = "200" ] && log_pass "Sitemap accessible" || log_fail "Sitemap missing ($sitemap_status)"

  robots_status=$(curl -s -o /dev/null -w "%{http_code}" "$URL/robots.txt" 2>/dev/null)
  [ "$robots_status" = "200" ] && log_pass "robots.txt accessible" || log_fail "robots.txt missing"

  rss_status=$(curl -s -o /dev/null -w "%{http_code}" "$URL/blog/rss.xml" 2>/dev/null)
  [ "$rss_status" = "200" ] && log_pass "RSS feed accessible" || log_fail "RSS feed missing"
else
  echo ""
  log_skip "2. SEO"
fi

# ─── 3. CONTENT INTEGRITY ───
if $RUN_CONTENT; then
  echo ""
  echo "3. Content Integrity"
  homepage=$(curl -s "$URL/" 2>/dev/null)

  placeholders=$(echo "$homepage" | grep -ci 'lorem ipsum\|IMAGE NEEDED\|TODO\|placeholder' || true)
  [ "$placeholders" = "0" ] && log_pass "No placeholder text on homepage" || log_warn "Found $placeholders placeholder references"

  echo "$homepage" | grep -q 'Get Your Delivery Plan' && log_pass "CTA: 'Get Your Delivery Plan' present" || log_fail "CTA text missing"
  forecast_cta=$(echo "$homepage" | grep -c 'See Your Forecast' || true)
  [ "$forecast_cta" = "0" ] && log_pass "No 'See Your Forecast' in CTAs (correct)" || log_fail "Found $forecast_cta 'See Your Forecast' references (use 'Get Your Delivery Plan')"

  # Spot-check industry pages for CTA consistency
  for ind_page in "/industries/insurance/" "/industries/healthcare/" "/industries/finance/"; do
    ind_html=$(curl -s "$URL$ind_page" 2>/dev/null)
    ind_bad=$(echo "$ind_html" | grep -c 'See Your Forecast' || true)
    if [ "$ind_bad" = "0" ]; then
      log_pass "$ind_page CTA text correct"
    else
      log_fail "$ind_page has wrong CTA text ('See Your Forecast')"
    fi
  done

  echo "$homepage" | grep -q 'nolte-white.svg\|nolte-black.svg' && log_pass "Nolte SVG logo present" || log_fail "Nolte logo missing"
else
  echo ""
  log_skip "3. Content Integrity"
fi

# ─── 4. ANALYTICS ───
if $RUN_ANALYTICS; then
  echo ""
  echo "4. Analytics"
  homepage=$(curl -s "$URL/" 2>/dev/null)
  echo "$homepage" | grep -q 'posthog' && log_pass "PostHog snippet present" || log_fail "PostHog missing"
  echo "$homepage" | grep -q 'phc_' && log_pass "PostHog project key present" || log_fail "PostHog key missing"
  echo "$homepage" | grep -q 'isLocal\|isBot' && log_pass "Bot/localhost filtering active" || log_warn "Bot filtering may be missing"
else
  echo ""
  log_skip "4. Analytics"
fi

# ─── 5. PERFORMANCE ───
if $RUN_PERFORMANCE; then
  echo ""
  echo "5. Performance"

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

  echo "$URL" | grep -q 'https' && log_pass "HTTPS enabled" || log_warn "Not using HTTPS"
else
  echo ""
  log_skip "5. Performance"
fi

# ─── 6. RESPONSIVE CHECKS ───
if $RUN_RESPONSIVE; then
  echo ""
  echo "6. Responsive (CSS checks)"

  homepage=$(curl -s "$URL/" 2>/dev/null)
  css_url=$(echo "$homepage" | grep -o '/_astro/[^"]*\.css' | head -1)
  if [ -n "$css_url" ]; then
    css=$(curl -s "$URL$css_url" 2>/dev/null)
    echo "$css" | grep -q 'max-width:768px\|max-width: 768px' && log_pass "768px breakpoint present" || log_warn "Missing 768px breakpoint"
    echo "$css" | grep -q 'max-width:600px\|max-width: 600px' && log_pass "600px breakpoint present" || log_warn "Missing 600px breakpoint"
    echo "$css" | grep -q 'grid-template-columns:1fr\|grid-template-columns: 1fr' && log_pass "Single-column mobile layouts present" || log_warn "Missing mobile single-column"
  else
    log_warn "Could not locate CSS file for responsive check"
  fi
else
  echo ""
  log_skip "6. Responsive"
fi

# ─── 7. KEY PAGES CONTENT ───
if $RUN_KEY_PAGES; then
  echo ""
  echo "7. Key Page Content"

  blog=$(curl -s "$URL/blog/" 2>/dev/null)
  blog_posts=$(echo "$blog" | grep -c 'Read article' || true)
  [ "$blog_posts" -gt 0 ] && log_pass "Blog index has $blog_posts posts" || log_fail "Blog index empty"

  work=$(curl -s "$URL/work/" 2>/dev/null)
  echo "$work" | grep -q 'Breeze\|breeze' && log_pass "Work page has Breeze" || log_fail "Breeze missing from work"
  echo "$work" | grep -q 'Odie\|odie' && log_pass "Work page has Odie" || log_fail "Odie missing from work"
  echo "$work" | grep -q 'Pilou\|pilou' && log_pass "Work page has Pilou" || log_fail "Pilou missing from work"
else
  echo ""
  log_skip "7. Key Page Content"
fi

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
echo "  Total: $TOTAL checks run"
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
