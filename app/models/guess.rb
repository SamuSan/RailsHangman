class Guess < ActiveRecord::Base
  belongs_to :game
  validates :guess, presence: true 
  validates_uniqueness_of :guess, scope: :game_id

  def single_letter?
    guess.size == 1    
  end

  def whole_word?
    !single_letter?
  end

  def matches_word?(word)
    guess == word
  end
end
