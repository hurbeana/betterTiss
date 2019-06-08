##
# Used to provide the full site title and the base tiss link.
module ApplicationHelper

  ##
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'BetterTiss'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  ##
  # Returns the current link to tiss
  def tiss_link
    'https://tiss.tuwien.ac.at'
  end
end
