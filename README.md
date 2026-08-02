# Notes

The source for Ivy's notes site at <https://ivy-zhou.github.io/notes/>.

## Write and preview

Install Ruby 3.4.10, then install the locked dependencies:

```sh
bundle install
```

### Create a post

`bin/new-post` turns a title into a dated post directory, Markdown filename, and starter front matter:

```sh
bin/new-post "Short title"
```

The remaining arguments become tags. Without any tags, the post gets the `notes` tag:

```sh
bin/new-post "How I take notes" writing process
```

That example creates `_posts/YYYY-MM-DD-how-i-take-notes/YYYY-MM-DD-how-i-take-notes.md` with `writing` and `process` tags. Run `bin/new-post --help` for terminal help.

If you prefer to create a post manually, posts live in `_posts` and use front matter like:

```yaml
---
title: Short title
tags: [notes]
---
```

Post-specific images can live beside a post when the post uses its own directory. `jekyll-postfiles` copies those files into the generated site.

### Preview before publishing

`bin/preview` is the local review gate to run before committing or pushing:

```sh
bin/preview
```

It first runs the production build and content audit. If those pass, it starts a live-reloading preview with drafts enabled. Open <http://127.0.0.1:4000/notes/> and keep editing; saved changes appear automatically. Stop it with `Ctrl-C`. This command never commits or pushes anything. Run `bin/preview --help` for terminal help.

LaTeX, tags, syntax highlighting, post assets, and existing permalinks are handled by the current Jekyll configuration and TeXt theme.

For a final check without starting the preview server, run the same production build and content audit used by CI:

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
