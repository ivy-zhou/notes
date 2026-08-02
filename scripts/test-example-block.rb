# frozen_string_literal: true

require "liquid"
require_relative "../_plugins/example_block"

def assert(condition, message)
  abort "Example block test failed: #{message}" unless condition
end

source = <<~LIQUID
  {% example %}
  **Question:** What is $1+1$?

  **Answer:** $2$.
  {% endexample %}
LIQUID

rendered = Liquid::Template.parse(source).render

assert(rendered.include?('<div class="note-example" markdown="1">'), "expected the semantic wrapper")
assert(rendered.include?("**Question:** What is $1+1$?"), "expected Markdown question content")
assert(rendered.include?("**Answer:** $2$."), "expected Markdown answer content")
assert(rendered.scan('<div class="note-example"').length == 1, "expected one opening wrapper")
assert(rendered.scan("</div>").length == 1, "expected one closing wrapper")

puts "Example block tests passed."
