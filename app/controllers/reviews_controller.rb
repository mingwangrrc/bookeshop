class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def showo
    @review = Review.find(params[:id])
  end
end
