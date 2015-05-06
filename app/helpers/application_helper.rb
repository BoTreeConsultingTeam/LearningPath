module ApplicationHelper
  def links_count
    Link.all.count
  end

  def favourites_links_count
    Link.where(favourite: true).count
  end
end
