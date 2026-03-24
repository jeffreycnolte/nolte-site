#!/bin/bash
# Download all blog images and update markdown paths

BLOG_DIR="/Users/jeffnolte/Claude/nolte-site/src/content/blog"
IMG_DIR="/Users/jeffnolte/Claude/nolte-site/public/images/blog"

mkdir -p "$IMG_DIR"

# Find all image URLs in blog posts
grep -r -oE 'https://(nolte\.io/wp-content|lh[0-9]\.googleusercontent\.com)/[^)\"]+' "$BLOG_DIR"/*.md | sort -u | while read -r line; do
  file=$(echo "$line" | cut -d: -f1)
  url=$(echo "$line" | cut -d: -f2-)

  # Generate a clean filename from the URL
  filename=$(echo "$url" | sed 's|.*/||' | sed 's|[?#].*||')

  # Skip if no extension (googleusercontent)
  if [[ "$filename" != *.* ]]; then
    filename="${filename}.jpg"
  fi

  # Download if not already present
  if [ ! -f "$IMG_DIR/$filename" ]; then
    echo "Downloading: $filename"
    curl -sL -o "$IMG_DIR/$filename" "$url"
  else
    echo "Already have: $filename"
  fi

  # Replace URL in all markdown files
  escaped_url=$(echo "$url" | sed 's|[&/\]|\\&|g')
  sed -i '' "s|${url}|/images/blog/${filename}|g" "$BLOG_DIR"/*.md
done

echo ""
echo "Done! Downloaded images:"
ls -la "$IMG_DIR"
