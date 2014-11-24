class Guess < ActiveRecord::Base
  belongs_to :game
  validates :guess, presence: true
end
