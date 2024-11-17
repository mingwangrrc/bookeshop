class Cart < ApplicationRecord
  def self.ransackable_associations(auth_object = nil)
    ["books", "cart_items"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "secret_id", "updated_at"]
  end


  has_many :cart_items
  has_many :books, through: :cart_items

  before_create :set_secret_id

  private

  def set_secret_id
    self.secret_id = SecureRandom.uuid + DateTime.now.to_i.to_s
  end
end
