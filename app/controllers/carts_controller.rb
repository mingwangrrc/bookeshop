# class CartController < ApplicationController
#   before_action :set_book, only: [:create, :destroy]

#   def create()
#     @curent_cart.cart_items.create(book_id: @book.id)
#   end

#   private
#   def set_book
#     @book = Book.find(params[:book_id])
#   end

# end


class CartsController < ApplicationController
  before_action :set_book, only: [:create, :destroy]

  def create
    @current_cart.cart_items.create(book_id: @book.id)
  end

  def index
  end

  def show
  end

  def checkout
  end

  def destroy
    @cart_item = @current_cart.cart_items.find_by_book_id(@book.id)
    @cart_item.destroy
    redirect_to cart_path(@current_cart)
  end

  def stripe_session
    session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: [{
          # Provide the exact Price ID (e.g. pr_1234) of the book you want to sell
          price_data: {
            currency: "usd",
            # unit_amount: (@current_cart.books.sum(&:price) * 100).to_i,
            book_data: {
              name: @current_cart.books.map(&:name).join(", ")
            },
          },
          quantity: 1,
        }],
        shipping_address_collection: {
          allowed_countries: STRIPE_SUPPORTED_COUNTRIES
        },
        mode: 'payment',
        return_url: success_cart_url(@current_cart.secret_id),
    })

    render json: { clientSecret: session.client_secret }
  end

  def success
    if @current_cart.cart_items.any?
      session[:current_cart_id] = nil
    end
    @purchased_cart = Cart.find_by_secret_id(params[:id])
    redirect_to root_path if !@purchased_cart
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

end