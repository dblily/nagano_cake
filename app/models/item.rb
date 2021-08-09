class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  
  attachment :image
  
  def add_tax_price
    (self.price * 1.10).round
  end
  
  validates :name, uniqueness: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :genre_id, presence: true
  
end
