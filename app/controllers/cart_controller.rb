class CartController < ApplicationController
  before_action: set_current_cart
  def createf()
    @curent_cart.cart_items.create(product_id: params[:product_id]))
  end

  end

  private
  def  set_current_cart
    if session[:current_cart_id]
      @curent_cart = Cart.find_by_secret_id(session[:current_cart_id])
    else
      @curent_cart = Cart.create
      session[:current_cart_id] = @curent_cart.secret_id
    end
  end

end
