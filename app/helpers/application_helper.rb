module ApplicationHelper
  def page_title(title = "")
    base_title = "(仮)卒業制作APP"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
