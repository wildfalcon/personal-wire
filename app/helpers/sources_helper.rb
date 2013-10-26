module SourcesHelper

  def display_enabled_sources
    content_tag(:ul) do
      Source.enabled.each  do |source|
        name = source.source_name
        concat(content_tag(:li) do
          [content_tag(:span, name),
            link_to("disable", disable_source_path(source))
          ].join(' ').html_safe
        end)
      end.join('').html_safe
    end
  end

  def display_configured_sources
    content_tag(:ul) do
      Source.disabled.each  do |source|
        name = source.source_name
        concat(content_tag(:li) do
          [content_tag(:span, name),
            link_to("enable", enable_source_path(source))
          ].join(' ').html_safe
        end)
      end.join('').html_safe
    end
  end

end
