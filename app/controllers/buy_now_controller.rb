class BuyNowController < ApplicationController
  def show
  end

  def success
  end

  private

  def set_product
    @book = Book.find(params[:book_id])
  end

end
