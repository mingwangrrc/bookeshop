class BuyNowController < ApplicationController
  def show
  end

  def success
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

end
