module LinksHelper
  include ActsAsTaggableOn::TagsHelper

  def is_favourite_link?(link)
    link.favourite
  end

  def set_category_icon(link)
    if link.blank?
      category = link.link_type.name
    else
      category = 'No link'
    end


    # category = link.link_type.name
    case category
      when 'Video'
        "fa fa-video-camera"
      when 'Podcast'
        "fa fa-volume-up"
      when 'BlogPost'
        "fa fa-bold"
      when 'Book'
        "fa fa-book"
      when 'Online Course'
        "fa fa-arrow-circle-up"
      when 'Email Course'
        "fa fa-envelope"
      when 'No link'

        "fa fa-file-text"
    end
  end

  def set_tool_tip(link)
    link_type = link.link_type.name
    case link_type
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
    "#{link.favourite? ? 'Unmark ' : 'Mark'} as Favourite"
  end

  def get_order
    if params[:sort_by_desc] == "learn_count_desc"
      link_to '<i class="fa fa-sort-amount-asc ">Learn count</i>'.html_safe, root_path(sort_by: 'learn_count') 
    else
       link_to '<i class="fa fa-sort-amount-desc ">Learn count</i>'.html_safe, root_path(sort_by_desc: 'learn_count_desc')
    end
  end

  def get_title
     if params[:order_by_desc] == 'title_desending'
       link_to '<i class="fa fa-sort-amount-asc ">Title sort</i>'.html_safe, root_path(order: 'title_asending')
     else
        link_to '<i class="fa fa-sort-amount-desc ">Title sort</i>'.html_safe, root_path(order_by_desc: 'title_desending')
     end
  end

end
