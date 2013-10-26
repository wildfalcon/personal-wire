module ServicesHelper
  def display_available_services
    content_tag(:ul) do
      Services.available.each  do |service|
         name = service.service_name
         
         paths = service.config_path

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
      

  
end