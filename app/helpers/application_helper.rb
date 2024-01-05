module ApplicationHelper

  # For the navbar, this will add active to the tag of the current page for proper styling.
  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
   end
end
