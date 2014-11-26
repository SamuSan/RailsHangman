class Guess < ActiveRecord::Base
  belongs_to :game
  validates :guess, presence: true 
  validates_uniqueness_of :guess, scope: :game_id
end
