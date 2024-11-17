class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book

  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "cart_id", "created_at", "id", "updated_at"]
  end
end
