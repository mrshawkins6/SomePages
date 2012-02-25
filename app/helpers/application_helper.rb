module ApplicationHelper

  def title
    base_title = 'Anketki'
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag "header_logo.png", :alt => "Anketki", :class => "round"
  end

end
