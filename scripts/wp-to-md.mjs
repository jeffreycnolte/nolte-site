import { readFileSync, writeFileSync, mkdirSync } from 'fs';
import { join } from 'path';

const xml = readFileSync(join(import.meta.dirname, '../wp-exports/blog-posts.xml'), 'utf-8');

// Category mapping based on post content/topics
const categoryMap = {
  'the-predictability-gap': 'delivery',
  'why-we-dont-estimate-and-how-we-still-predict-delivery': 'delivery',
  'measuring-productivity-in-software-development': 'delivery',
  'budgeting-for-software-development-when-delivery-is-forecastable': 'delivery',
  'using-example-mapping-to-better-serve-our-clients': 'delivery',
  'how-the-kanban-methodology-benefits-founders': 'delivery',
  'what-experience-taught-us-turning-lessons-into-strategy': 'founders',
  'leading-tech-teams-without-a-tech-background-what-really-works': 'leadership',
  'enhancing-developer-experience-for-non-tech-founders': 'founders',
  'the-three-non-negotiables-of-successful-digital-product': 'product',
  'mvp-validation-why-the-best-products-start-before-theyre-built': 'product',
  'tailoring-your-team-for-startup-success': 'founders',
  'scaling-tech-teams-strategies': 'leadership',
  'the-perfect-product-roadmap': 'product',
  'navigating-ai-for-non-tech-founders': 'founders',
  'decoding-tech-debt-for-non-tech-founders': 'engineering',
  'validate-before-you-build-a-guide-for-early-stage-founders': 'product',
  'exploring-your-options-partnering-with-a-technical-co-founder-or-hiring-a-technical-expert-for-your-startup': 'founders',
  'the-hidden-costs-of-technical-debt-a-must-read-for-non-technical-founders': 'engineering',
  'the-ideal-team-structure-for-early-stage-startups-engaging-with-an-agency': 'founders',
  'founder-wellness-why-your-wellbeing-affects-the-success-of-your-startup': 'culture',
  'what-investors-look-for-during-the-product-development-stage': 'founders',
  'bugs-happen-a-guide-for-founders-on-how-to-avoid-freaking-out-and-when-you-should-take-action': 'engineering',
  'the-4-most-common-blockers-startup-founders-face-in-product-development-and-how-to-avoid': 'founders',
  '5-tips-to-stay-focused-in-a-distracted-world': 'culture',
  'deep-work-the-right-mindset-in-a-distracted-world': 'culture',
  'shifting-your-culture-in-3-steps': 'culture',
  'engineers-build-solutions-they-dont-check-off-tasks': 'engineering',
  'what-does-is-mean-to-be-a-senior-engineer': 'engineering',
};

// Slug mapping for cleaner filenames
const slugMap = {
  'why-we-dont-estimate-and-how-we-still-predict-delivery': 'why-we-dont-estimate',
  'what-experience-taught-us-turning-lessons-into-strategy': 'what-experience-taught-us',
  'leading-tech-teams-without-a-tech-background-what-really-works': 'leading-tech-teams-without-a-tech-background',
  'the-three-non-negotiables-of-successful-digital-product': 'the-three-non-negotiables-of-a-successful-digital-product',
  'mvp-validation-why-the-best-products-start-before-theyre-built': 'mvp-validation',
  'tailoring-your-team-for-startup-success': 'tailoring-your-team-for-startup-success',
  'scaling-tech-teams-strategies': 'scaling-tech-teams-strategies',
  'the-perfect-product-roadmap': 'the-perfect-product-roadmap',
  'navigating-ai-for-non-tech-founders': 'navigating-ai-for-non-tech-founders',
  'decoding-tech-debt-for-non-tech-founders': 'decoding-tech-debt-for-non-tech-founders',
  'validate-before-you-build-a-guide-for-early-stage-founders': 'validate-before-you-build',
  'exploring-your-options-partnering-with-a-technical-co-founder-or-hiring-a-technical-expert-for-your-startup': 'exploring-your-options-technical-cofounder-vs-agency',
  'the-hidden-costs-of-technical-debt-a-must-read-for-non-technical-founders': 'the-hidden-costs-of-technical-debt',
  'budgeting-for-software-development-when-delivery-is-forecastable': 'budgeting-for-software-development',
  'how-the-kanban-methodology-benefits-founders': 'how-the-kanban-methodology-benefits-founders',
  'using-example-mapping-to-better-serve-our-clients': 'using-example-mapping',
  'the-ideal-team-structure-for-early-stage-startups-engaging-with-an-agency': 'ideal-team-structure-for-startups',
  'founder-wellness-why-your-wellbeing-affects-the-success-of-your-startup': 'founder-wellness',
  'what-investors-look-for-during-the-product-development-stage': 'what-investors-look-for',
  'bugs-happen-a-guide-for-founders-on-how-to-avoid-freaking-out-and-when-you-should-take-action': 'bugs-happen',
  'the-4-most-common-blockers-startup-founders-face-in-product-development-and-how-to-avoid': 'common-blockers-in-product-development',
  '5-tips-to-stay-focused-in-a-distracted-world': '5-tips-to-stay-focused',
  'deep-work-the-right-mindset-in-a-distracted-world': 'deep-work',
  'shifting-your-culture-in-3-steps': 'shifting-your-culture-in-3-steps',
  'engineers-build-solutions-they-dont-check-off-tasks': 'engineers-build-solutions',
  'what-does-is-mean-to-be-a-senior-engineer': 'what-does-it-mean-to-be-a-senior-engineer',
  'the-predictability-gap': 'the-predictability-gap',
  'measuring-productivity-in-software-development': 'measuring-productivity-in-software-development',
  'enhancing-developer-experience-for-non-tech-founders': 'enhancing-developer-experience-for-non-tech-founders',
};

// Author mapping
const authorMap = {
  'jnolte': 'jeffrey-nolte',
  'Dan Urruela': 'dan-urruela',
  'Yanna Lopes': 'yanna-lopes',
};

function extractCDATA(text) {
  const match = text.match(/<!\[CDATA\[([\s\S]*?)\]\]>/);
  return match ? match[1] : text;
}

function wpHtmlToMarkdown(html) {
  let md = html;

  // Remove WordPress block comments
  md = md.replace(/<!-- \/?wp:[^\n]*?-->\n?/g, '');

  // Remove figure wrappers but keep content
  md = md.replace(/<figure[^>]*>([\s\S]*?)<\/figure>/gi, '$1');

  // Remove div wrappers
  md = md.replace(/<div[^>]*class="[^"]*responsive-img[^"]*"[^>]*>([\s\S]*?)<\/div>/gi, '$1');
  md = md.replace(/<div[^>]*class="[^"]*desktop-img[^"]*"[^>]*>([\s\S]*?)<\/div>/gi, '$1');
  // Remove mobile-only images (keep desktop versions)
  md = md.replace(/<div[^>]*class="[^"]*mobile-img[^"]*"[^>]*>[\s\S]*?<\/div>/gi, '');

  // Images
  md = md.replace(/<img[^>]*src="([^"]*)"[^>]*alt="([^"]*)"[^>]*\/?>/gi, '![$2]($1)');
  md = md.replace(/<img[^>]*src="([^"]*)"[^>]*\/?>/gi, '![]($1)');

  // Figcaption
  md = md.replace(/<figcaption[^>]*>([\s\S]*?)<\/figcaption>/gi, '*$1*');

  // Headers
  md = md.replace(/<h1[^>]*>([\s\S]*?)<\/h1>/gi, '# $1');
  md = md.replace(/<h2[^>]*>([\s\S]*?)<\/h2>/gi, '## $1');
  md = md.replace(/<h3[^>]*>([\s\S]*?)<\/h3>/gi, '### $1');
  md = md.replace(/<h4[^>]*>([\s\S]*?)<\/h4>/gi, '#### $1');
  md = md.replace(/<h5[^>]*>([\s\S]*?)<\/h5>/gi, '##### $1');
  md = md.replace(/<h6[^>]*>([\s\S]*?)<\/h6>/gi, '###### $1');

  // Bold and italic
  md = md.replace(/<strong>([\s\S]*?)<\/strong>/gi, '**$1**');
  md = md.replace(/<b>([\s\S]*?)<\/b>/gi, '**$1**');
  md = md.replace(/<em>([\s\S]*?)<\/em>/gi, '*$1*');
  md = md.replace(/<i>([\s\S]*?)<\/i>/gi, '*$1*');

  // Links
  md = md.replace(/<a[^>]*href="([^"]*)"[^>]*>([\s\S]*?)<\/a>/gi, '[$2]($1)');

  // Blockquotes
  md = md.replace(/<blockquote[^>]*>([\s\S]*?)<\/blockquote>/gi, (_, content) => {
    const cleaned = content.replace(/<\/?p[^>]*>/gi, '').trim();
    return cleaned.split('\n').map(line => `> ${line.trim()}`).filter(l => l !== '> ').join('\n');
  });

  // Lists
  md = md.replace(/<ul[^>]*>([\s\S]*?)<\/ul>/gi, (_, content) => {
    return content.replace(/<li[^>]*>([\s\S]*?)<\/li>/gi, '- $1').trim() + '\n';
  });
  md = md.replace(/<ol[^>]*>([\s\S]*?)<\/ol>/gi, (_, content) => {
    let i = 0;
    return content.replace(/<li[^>]*>([\s\S]*?)<\/li>/gi, () => {
      i++;
      return `${i}. ` + arguments[1]; // won't work, fix below
    }).trim() + '\n';
  });
  // Fix ordered lists properly
  md = md.replace(/<ol[^>]*>([\s\S]*?)<\/ol>/gi, (_, content) => {
    let i = 0;
    const items = [];
    content.replace(/<li[^>]*>([\s\S]*?)<\/li>/gi, (__, text) => {
      i++;
      items.push(`${i}. ${text.trim()}`);
    });
    return items.join('\n') + '\n';
  });

  // Paragraphs
  md = md.replace(/<p[^>]*>([\s\S]*?)<\/p>/gi, '$1\n\n');

  // Horizontal rules
  md = md.replace(/<hr[^>]*\/?>/gi, '\n---\n');

  // Line breaks
  md = md.replace(/<br\s*\/?>/gi, '\n');

  // Remove remaining HTML tags (spans, divs, etc)
  md = md.replace(/<\/?span[^>]*>/gi, '');
  md = md.replace(/<\/?div[^>]*>/gi, '');
  md = md.replace(/<\/?section[^>]*>/gi, '');

  // Clean up entities
  md = md.replace(/&amp;/g, '&');
  md = md.replace(/&lt;/g, '<');
  md = md.replace(/&gt;/g, '>');
  md = md.replace(/&quot;/g, '"');
  md = md.replace(/&#8217;/g, "'");
  md = md.replace(/&#8216;/g, "'");
  md = md.replace(/&#8220;/g, '"');
  md = md.replace(/&#8221;/g, '"');
  md = md.replace(/&#8211;/g, '–');
  md = md.replace(/&#8212;/g, '—');
  md = md.replace(/&#8230;/g, '…');
  md = md.replace(/&nbsp;/g, ' ');

  // Clean up excessive newlines
  md = md.replace(/\n{4,}/g, '\n\n\n');

  return md.trim();
}

// Parse items from XML
const itemRegex = /<item>([\s\S]*?)<\/item>/g;
let match;
const posts = [];

while ((match = itemRegex.exec(xml)) !== null) {
  const item = match[1];

  // Only process posts (not attachments)
  const postType = item.match(/<wp:post_type><!\[CDATA\[(.*?)\]\]><\/wp:post_type>/);
  if (!postType || postType[1] !== 'post') continue;

  // Skip drafts
  const status = item.match(/<wp:status><!\[CDATA\[(.*?)\]\]><\/wp:status>/);
  if (status && status[1] !== 'publish') continue;

  const title = extractCDATA(item.match(/<title>(.*?)<\/title>/)?.[1] || '');
  const slug = item.match(/<wp:post_name><!\[CDATA\[(.*?)\]\]><\/wp:post_name>/)?.[1] || '';
  const pubDate = item.match(/<wp:post_date><!\[CDATA\[(.*?)\]\]><\/wp:post_date>/)?.[1] || '';
  const modDate = item.match(/<wp:post_modified><!\[CDATA\[(.*?)\]\]><\/wp:post_modified>/)?.[1] || '';
  const author = item.match(/<dc:creator><!\[CDATA\[(.*?)\]\]><\/dc:creator>/)?.[1] || '';
  const contentMatch = item.match(/<content:encoded><!\[CDATA\[([\s\S]*?)\]\]><\/content:encoded>/);
  const content = contentMatch ? contentMatch[1] : '';
  const excerptMatch = item.match(/<excerpt:encoded><!\[CDATA\[([\s\S]*?)\]\]><\/excerpt:encoded>/);
  const excerpt = excerptMatch ? excerptMatch[1].trim() : '';

  // Get featured image (attachment URL from postmeta)
  const thumbMatch = item.match(/<wp:postmeta>\s*<wp:meta_key><!\[CDATA\[_yoast_wpseo_opengraph-image\]\]><\/wp:meta_key>\s*<wp:meta_value><!\[CDATA\[(.*?)\]\]><\/wp:meta_value>/);
  const featuredImage = thumbMatch ? thumbMatch[1] : '';

  // Get meta description
  const metaDescMatch = item.match(/<wp:postmeta>\s*<wp:meta_key><!\[CDATA\[_yoast_wpseo_metadesc\]\]><\/wp:meta_key>\s*<wp:meta_value><!\[CDATA\[([\s\S]*?)\]\]><\/wp:meta_value>/);
  const metaDesc = metaDescMatch ? metaDescMatch[1].trim() : '';

  const date = pubDate ? pubDate.split(' ')[0] : '';
  const updated = modDate && modDate !== pubDate ? modDate.split(' ')[0] : '';

  posts.push({ title, slug, date, updated, author, content, excerpt, metaDesc, featuredImage });
}

console.log(`Found ${posts.length} posts\n`);

const outDir = join(import.meta.dirname, '../src/content/blog');

for (const post of posts) {
  const fileSlug = slugMap[post.slug] || post.slug;
  const category = categoryMap[post.slug] || 'delivery';
  const authorId = authorMap[post.author] || 'jeffrey-nolte';
  const description = post.metaDesc || post.excerpt || post.title;

  const markdown = wpHtmlToMarkdown(post.content);

  // Build frontmatter
  let fm = `---\ntitle: ${JSON.stringify(post.title)}\n`;
  fm += `description: ${JSON.stringify(description)}\n`;
  fm += `date: ${post.date}\n`;
  if (post.updated && post.updated !== post.date) {
    fm += `updated: ${post.updated}\n`;
  }
  fm += `author: ${authorId}\n`;
  fm += `category: ${category}\n`;

  // Add image for predictability gap (we already downloaded it)
  if (post.slug === 'the-predictability-gap') {
    fm += `image: /images/blog/predictability-gap/hero.jpg\n`;
    fm += `imageAlt: "The Predictability Gap — Nolte"\n`;
  }

  fm += `---\n\n`;

  const filePath = join(outDir, `${fileSlug}.md`);
  writeFileSync(filePath, fm + markdown);
  console.log(`✓ ${fileSlug}.md (${post.date}) — ${post.title}`);
}

console.log(`\nDone! ${posts.length} posts written.`);
