class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  validates :secret, presence: true

  def submit_guess(guess)
    guess = Guess.new(guess: guess)
    if !guess.save
      flash[:alert] = "Noope"
    end
  end

  def won?
    
  end


  private

  def has_turns_remaining?
    Guess.all.size < 12   
  end 
end
