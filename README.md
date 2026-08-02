# Sentences

The source for Ivy's notes site at <https://ivy-zhou.github.io/notes/>.

## Write and preview

Install Ruby 3.4.10, then install the locked dependencies:

```sh
bundle install
```

Create a dated post directory, Markdown file, and starter front matter with:

```sh
bin/new-post "Short title" notes
```

The remaining arguments become tags. Without any tags, the post gets the `notes` tag. If you prefer to create a post manually, posts live in `_posts` and use front matter like:

```yaml
---
title: Short title
tags: [notes]
---
```

Post-specific images can live beside a post when the post uses its own directory. `jekyll-postfiles` copies those files into the generated site.

Preview drafts and saved changes locally with live reload:

```sh
bundle exec jekyll serve --livereload --drafts
```

Open <http://127.0.0.1:4000/notes/>. LaTeX, tags, syntax highlighting, post assets, and existing permalinks are handled by the current Jekyll configuration and TeXt theme.

Before publishing, run the same production build and content audit used by CI:

```sh
bin/check
```

This catches malformed generated HTML, broken local links and images, duplicate IDs, missing image descriptions, and unbalanced code fences.

## Publish

Commit the source changes and push `master`:

```sh
git add _posts
git commit -m "Add post title"
git push origin master
```

The `Deploy notes to GitHub Pages` workflow runs `bin/check` and deploys the generated artifact to GitHub Pages. The generated `_site` directory and `gh-pages` branch are not edited by hand.
