class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :login_id, presence: true, length: { maximum: 50 }
  has_secure_password
  
  has_many :boards
  has_many :current_recruting_events
  has_many :tournament_results
  has_many :practice_results
  
  def feed_current_recruting_events
    CurrentRecrutingEvent.all
  end
  
  def feed_boards
    Board.all
  end
  
  def feed_tournament_results
    TournamentResult.all
  end
  
  def feed_practice_results
    PracticeResult.all
  end
end
