## This has a fairly harmless hack that wraps the img tag in a div to prevent it from being
## wrapped in a paragraph tag instead, which would totally fuck things up layout-wise
## Usage {% limgsmall TEXT 'caption goes here in quotes' %}
#
module Jekyll
  class RenderSmImgLeftTag < Liquid::Tag
require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text = text.shellsplit
    end

    def render(context)
      "<figure class='alignleft'><img src='#{@text[0]}' class='resrc' /> " +
      "<figcaption><p>#{@text[1]}</p></figcaption>" +
      "</figure>"
    end
  end
end

Liquid::Template.register_tag('sm-img-left', Jekyll::RenderSmImgLeftTag)