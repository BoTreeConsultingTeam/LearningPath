module ApplicationHelper
  def is_favourite_link?(link)
    link.favourite
  end

  def set_category_icon(link)
    category = link.category
    case category
      when 'Video'
        "fa-video-camera"
      when 'Podcast'
        "fa-volume-up"
      when 'BlogPost'
        "fa-bold"
      else
        "fa-file-text"
      end
  end

  def set_tool_tip(link)
    category = link.category
    case category
      when 'Video'
        "Video"
      when 'Podcast'
        "Podcast"
      when 'BlogPost'
        "Blogpost"
      else
        "Tutorial"
    end
  end
end
