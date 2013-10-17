module DestinationsHelper

  def display_available_destinations
    content_tag(:ul) do
      Destinations.available.map(&:name).each  do |name|
        content_tag(:li, name)
      end.join('').html_safe
    end
  end

  def display_unavailable_destinations
    content_tag(:ul) do
      Destinations.unavailable.map(&:name).each  do |name|
        content_tag(:li, name)
      end.join('').html_safe
    end
  end


end