class Board < ApplicationRecord
  validates :name, presence: true, length: { maximum: 1000 }
  validates :email, presence: true, length: { maximum: 100 } # TODO add email validation 
  validates :height, :width, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :mine_count, presence: true
  validate :mine_count_size

  def mine_count_size
    if mine_count < 1 || mine_count > self.height * self.width
      errors.add(:mine_count, 'The number of mines must be a positive integer smaller than the board area (height * width)')
    end
  end

  has_many :rows, dependent: :destroy
end
