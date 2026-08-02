# frozen_string_literal: true

module Notes
  class ExampleBlock < Liquid::Block
    def render(context)
      content = super.strip

      <<~HTML
        <div class="note-example" markdown="1">

        #{content}

        </div>
      HTML
    end
  end
end

Liquid::Template.register_tag("example", Notes::ExampleBlock)
