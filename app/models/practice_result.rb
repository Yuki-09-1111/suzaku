class PracticeResult < ApplicationRecord
  belongs_to :user
  
  validates :chart_of_practice, presence: true, length: { maximum: 100 }
end
