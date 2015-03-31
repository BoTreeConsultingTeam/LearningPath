module ApplicationHelper

  def sidebar_active_link(active_link)
    css_class = ''
    active_link_param = params[:active_link]
    if active_link.present? && active_link_param.present? && active_link_param == active_link
      css_class = 'active'
    elsif active_link.blank? && active_link_param.present? && !PAGE_FILTERS.include?(active_link_param)
      css_class = 'active'
    elsif active_link.blank? && active_link_param.blank?
      css_class = 'active'
    end
    css_class
  end

end
