## Newthought tag will render anything in the tag with small caps
## Usage {% caps Your text string here} will render a span
## YOUR TEXT STRING HERE (sort of, you know, small caps) if you are using the tufte.css file

module Jekyll
  class RenderSmallCapsTag < Liquid::Tag

require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text = text.shellsplit
    end


    def render(context)
      "<span class='caps'>#{@text[0]}</span> "
    end
  end
end

Liquid::Template.register_tag('caps', Jekyll::RenderSmallCapsTag)