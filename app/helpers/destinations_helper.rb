module DestinationsHelper

  def display_enabled_destinations
    content_tag(:ul) do
      Destinations.configured_and_enabled.each  do |destination|
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
       Destinations.configured_and_disabled.each  do |destination|
         name = destination.destination_name
         concat(content_tag(:li) do
           [content_tag(:span, name),
             link_to("enable", enable_destination_path(destination))
             ].join(' ').html_safe
           end)
         end.join('').html_safe
       end
     end


  def display_available_destinations
    content_tag(:ul) do
      Destinations.available.each  do |destination|
         name = destination.destination_service_name
         
         paths = destination.config_path

         links = paths.map{|name, path| link_to(name, path)}.join
         # raise links
         concat(content_tag(:li) do
           [content_tag(:span, name),
             links
             ].join(' ').html_safe
           end)
         end.join('').html_safe
       end
     end
      

  def display_unavailable_destinations
    content_tag(:ul) do
      Destinations.unavailable.map(&:destination_service_name).each  do |name|
        concat(content_tag(:li, name))
      end.join('').html_safe
    end
  end


end