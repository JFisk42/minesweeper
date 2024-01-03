class Board < ApplicationRecord
  validates :name, presence: true, length: { maximum: 1000 }
  validates :email, presence: true, length: { maximum: 100 } # TODO add email validation 
  validates :height, :width, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :mine_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :rows, dependent: :destroy
end
