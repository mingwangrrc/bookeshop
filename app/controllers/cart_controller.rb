class CartController < ApplicationController
  before_action: set_book
  def createf()
    @curent_cart.cart_items.create(book_id: @book.id)
  end

  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end

end
