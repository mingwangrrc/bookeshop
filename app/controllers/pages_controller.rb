class PagesController < ApplicationController

  def about
    @page = Page.last
  end

end
