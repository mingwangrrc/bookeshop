class Page < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["about", "contact", "created_at", "id", "purpose", "story", "updated_at"]
  end

end
