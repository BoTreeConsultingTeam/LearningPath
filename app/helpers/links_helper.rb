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
      "#{number == 0 ? 'Never' : pluralize(number, 'time')} learned"
  end

  def favourite_action_tooltip(link)
    "#{marked_as_favorite?(link) ? 'Unmark ' : 'Mark'} as Favourite"
  end

  def marked_as_favorite?(link)
    link.favourite?
  end
end
