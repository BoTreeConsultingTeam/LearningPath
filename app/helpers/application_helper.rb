module ApplicationHelper
  def links_count
    current_user.links.count
  end

  def favourites_links_count
    current_user.links.where(favourite: true).count
  end
end
