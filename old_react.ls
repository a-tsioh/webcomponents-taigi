define do
  [ \jquery \react 'prelude-ls' \backbone \cello_core \utils \yaml \cello_ui \cello_gviz ]
  ($, React, Prelude, Backbone, Cello, Utils, Yaml) ->
   Ruby = React.create-class do
      render: ->
        ji = @props.cjk / ''
        content = (for i from 0 to ji.length - 1
          syl = @props.zhuyin[i]
          form = ''
          if @props.settings.zhuyin
            if syl.initial != ''
              form += \S
            if syl.medial != ''
              form += \J
            if syl.final != ''
              form += \Y
            diao = syl.tone
            yin = syl.initial + syl.medial + syl.final
            zhuyin = "<zhuyin><yin>#{yin}</yin><diao>#{diao}</diao></zhuyin>"
          else
            zhuyin = ''
            yin = ''
            diao = ''
          """
          <ru zhuyin="" diao="#{diao}" length="#{yin.length}" form="#{form}">
            <rb>#{ji[i]}</rb>
            #{zhuyin}
          </ru>
          """) * "\n"
        if not @props.settings.zhuyin
          content = @props.cjk
        html_ru = """
        <ru span="#{ji.length}" order="0" class="rightangle" annotation="#{if @props.settings.trs then @props.trs else ""}">
          #{content}
        </ru>
        """
        html_main = """
        <hruby class=\"rightangle\" rightangle=\"rightangle\">
          #{html_ru}
          <rt rbspan="#{ji.length}" style="text-indent: -9999px; color: transparent"></rt>
        </hruby>
        """
        inner = {__html: html_main}
        div {ref: \span, dangerouslySetInnerHTML:inner}
    Ruby

