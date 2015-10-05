## This has a fairly harmless hack that wraps the img tag in a div to prevent it from being
## wrapped in a paragraph tag instead, which would totally fuck things up layout-wise
## Usage {% feature TEXT 'caption goes here in quotes' %}
#
module Jekyll
  class RenderFeatureHeadTag < Liquid::Tag
require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text = text.shellsplit
    end

    def render(context)
      "<div class='feature-block'><h2 class='h3'><span>#{@text[0]}</span></h2> " +
      "<p class='desc'>#{@text[1]}</p></div>"
    end
  end
end

Liquid::Template.register_tag('feature', Jekyll::RenderFeatureHeadTag)