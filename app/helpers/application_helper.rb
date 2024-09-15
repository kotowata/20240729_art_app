module ApplicationHelper
  def page_title(title = "")
    base_title = "ArtSpotly"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
