module OffersHelper
  def show_title title
    if title.empty?
      "<EMPTY TITLE>"
    else
      title
    end
  end

  def show_description description
    if description.empty?
      "<EMPTY DESCRIPTION>"
    else
      description
    end
  end
end
