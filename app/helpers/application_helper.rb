module ApplicationHelper
  def links_count
    current_user.current_user_links.count
  end

  def favourite_links_count
    current_user.favourite_links.count
  end
end
