class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true)
  end

  def show
    @review = Review.find(params[:id])
  end
end
