module DestinationsHelper

  def display_enabled_destinations
    content_tag(:ul) do
      Destination.enabled.each  do |destination|
        name = destination.destination_name
        concat(content_tag(:li) do
          [content_tag(:span, name),
            link_to("disable", disable_destination_path(destination))
            ].join(' ').html_safe
          end)
        end.join('').html_safe
      end
    end


    def display_configured_destinations
     content_tag(:ul) do
       Destination.disabled.each  do |destination|
         name = destination.destination_name
         concat(content_tag(:li) do
           [content_tag(:span, name),
             link_to("enable", enable_destination_path(destination))
             ].join(' ').html_safe
           end)
         end.join('').html_safe
       end
     end




end