module LinksHelper
  include ActsAsTaggableOn::TagsHelper

  def is_favourite_link?(link)
    link.favourite
  end

  def set_category_icon(link)
    category = link.category
    case category
      when 'Video'
        "fa fa-video-camera"
      when 'Podcast'
        "fa fa-volume-up"
      when 'BlogPost'
        "fa fa-bold"
      else
        "fa fa-file-text"
    end
  end

  def set_tool_tip(link)
    category = link.category
    case category
      when 'Video'
        'Click here if you watched it again'
      when 'Podcast'
        'Click here if you listened it again'
      else
        'Click here if you read it again'
    end
  end
  
  def learning_count(link)
    link.learn_time.count
  end

  def set_tooltip_on_count(number)
      number == 0 ? "Never learned" : "#{number} time learned"
  end

  def set_tooltip_on_favourite(link)
    is_favourite?(link) ? "Mark as Favourite" : "Unmark as Favourite"
  end

  def is_favourite?(link)
    link.favourite.nil?
  end
end
