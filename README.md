# Sentences

The source for Ivy's notes site at <https://ivy-zhou.github.io/notes/>.

## Write and preview

Install Ruby 3.4.10, then install the locked dependencies:

```sh
bundle install
```

Posts live in `_posts`. Name a new post `YYYY-MM-DD-short-title.md` and start it with front matter like:

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

## Publish

Commit the source changes and push `master`:

```sh
git add _posts
git commit -m "Add post title"
git push origin master
```

The `Deploy notes to GitHub Pages` workflow builds the site and deploys the generated artifact to GitHub Pages. The generated `_site` directory and `gh-pages` branch are not edited by hand.
