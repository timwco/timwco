module ApplicationHelper
  def nav_link(path, text)
    if current_page?(path)
      link_to text, path, class: "text-sm transition-opacity hover:opacity-70 text-primary font-heading"
    else
      link_to text, path, class: "text-sm transition-opacity hover:opacity-70 font-heading"
    end
  end
end
