STRIPE_SUPPORTED_COUNTRIES = ["AU", "AT", "BE", "BG", "CA", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR", "HK", "HU", "IE", "IT", "JP", "LV", "LT", "LU", "MT", "NL", "NZ", "NO", "PL", "PT", "RO", "SG", "SK", "SI", "ES", "SE", "CH", "GB", "US"].freeze

class CartsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_book, only: [:create, :destroy, :increase, :decrease]

  def create
    @current_cart.cart_items.create(book_id: @book.id)
  end

  def index
  end

  def show
  end

  def checkout
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      # customer_email: "yarving@qq.com",  # Pass user's email here
      mode: 'payment',
      # ui_mode: 'embedded',
      line_items: [{
          # Provide the exact Price ID (e.g. pr_1234) of the book you want to sell
          price_data: {
            currency: "usd",
            unit_amount: (@current_cart.cart_items.sum{|item| item.book.price * item.quantity} * 100).to_i,
            product_data: {
              name: @current_cart.books.map(&:title).join(", ")
            },
          },
          quantity: @current_cart.cart_items.sum(&:quantity).to_i,
        }],
        shipping_address_collection: {
          allowed_countries: STRIPE_SUPPORTED_COUNTRIES
        },
        success_url: success_cart_url(@current_cart.secret_id),
        # cancel_url: carts_path(@current_cart.secret_id),
    })
  end

  def destroy
    @cart_item = @current_cart.cart_items.find_by_book_id(@book.id)
    @cart_item.destroy
    redirect_to carts_path(@current_cart.secret_id)
  end

  def increase
    @cart_item = @current_cart.cart_items.find_by_book_id(@book.id)
    @cart_item.quantity += 1
    @cart_item.save

    redirect_to carts_path(@current_cart.secret_id)
  end

  def decrease
    @cart_item = @current_cart.cart_items.find_by_book_id(@book.id)
    @cart_item.quantity -= 1
    @cart_item.save

    @cart_item.destroy if @cart_item.quantity < 1

    redirect_to carts_path(@current_cart.secret_id)
  end


  def stripe_session
    session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: [{
          # Provide the exact Price ID (e.g. pr_1234) of the book you want to sell
          price_data: {
            currency: "usd",
            # unit_amount: (@current_cart.books.sum(&:price) * 100).to_i,
            unit_amount: (@current_cart.cart_items.sum{|item| item.book.price * item.quantity} * 100).to_i,
            book_data: {
              name: @current_cart.books.map(&:title).join(", ")
            },
          },
          # quantity: 1,
          quantity: @current_cart.cart_items.sum(&:quantity).to_i,
        }],
        shipping_address_collection: {
          # allowed_countries: STRIPE_SUPPORTED_COUNTRIES
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