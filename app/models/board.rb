class Board < ApplicationRecord
  validates :name, presence: true, length: { maximum: 1000 }
  validates :email, presence: true, length: { maximum: 100 } 

  # Validates email format with the built in Ruby email regex
  validates_format_of :email, :with => URI::MailTo::EMAIL_REGEXP
  validates :height, :width, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :mine_count, presence: true
  validate :mine_count_size

  # Ensures that provided values for the mine count.
  # Validates that the mine count is a positive integer.
  # Validates that the mine count is not larger than the board area.
  def mine_count_size
    return unless mine_count

    if mine_count < 1 || mine_count > self.height * self.width
      errors.add(:mine_count, 'The number of mines must be a positive integer smaller than the board area (height * width)')
    end
  end

  has_many :rows, dependent: :destroy
end
