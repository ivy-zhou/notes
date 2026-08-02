require "nokogiri"
require "pathname"
require "uri"

root = Pathname(ARGV.fetch(0, "_site")).expand_path
abort "Built site not found: #{root}" unless root.directory?

issues = []
html_files = Dir[root.join("**/*.html")].sort

def local_target(root, file, raw)
  value = URI::DEFAULT_PARSER.unescape(raw.to_s.split(/[?#]/, 2).first)
  return if value.empty? || value.start_with?("#", "mailto:", "tel:", "javascript:", "data:", "//")
  return if value.match?(%r{\A[a-z][a-z0-9+.-]*:}i)

  if value.start_with?("/")
    root.join(value.sub(%r{\A/notes/?}, ""))
  else
    Pathname(file).dirname.join(value)
  end
end

html_files.each do |file|
  relative = Pathname(file).relative_path_from(root)
  document = Nokogiri::HTML5(File.read(file))
  document.errors.each do |error|
    issues << "#{relative}:#{error.line}: invalid HTML: #{error.message}"
  end

  document.css("[id]").map { |node| node["id"] }.tally.each do |id, count|
    issues << "#{relative}: duplicate id ##{id}" if count > 1
  end

  document.css("img").each do |image|
    next if image["aria-hidden"] == "true"

    issues << "#{relative}: image is missing alt text: #{image['src']}" if image["alt"].to_s.strip.empty?
  end

  document.css("a[href], img[src], script[src], link[href]").each do |node|
    attribute = node.key?("href") ? "href" : "src"
    target = local_target(root, file, node[attribute])
    next unless target

    candidates = [target, target.join("index.html"), Pathname("#{target}.html")]
    issues << "#{relative}: broken local #{attribute}: #{node[attribute]}" unless candidates.any?(&:exist?)
  end
end

Dir["_posts/**/*.md"].sort.each do |post|
  fences = File.readlines(post).count { |line| line.match?(/^\s*```/) }
  issues << "#{post}: unbalanced fenced code blocks" if fences.odd?
end

if issues.empty?
  puts "Audit passed: #{html_files.length} HTML pages, no broken local assets, duplicate IDs, missing image alt text, or malformed HTML."
else
  warn issues.join("\n")
  abort "Audit failed with #{issues.length} issue(s)."
end
