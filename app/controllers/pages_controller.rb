class PagesController < ApplicationController
  def about
    @page = StaticPage.find_by!(slug: "about")
  end

  def contact
    @page = StaticPage.find_by!(slug: "contact")
  end
end
