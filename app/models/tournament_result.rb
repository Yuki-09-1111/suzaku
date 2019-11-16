class TournamentResult < ApplicationRecord
  belongs_to :user
  
  validates :date_of_tournament, presence: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
end
