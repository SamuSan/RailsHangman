class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

	before_validation :generate_secret_word
  
  validates :secret_word, presence: true

  def in_progress?
    !won? && !lost?
  end

  def incorrectly_guessed_letters
    guesses.map { |guess| guess.guess if incorrect_single_letter_guess(guess.guess) }.compact
  end

  def all_guessed_letters
    guesses.map { |guess| guess.guess if single_letter?(guess.guess) }
  end

  def won?
     (secret_word.chars - all_guessed_letters).empty?
  end

  private

  def incorrect_single_letter_guess(guess)
    single_letter?(guess) && incorrect?(guess)
  end

  def single_letter?(guess)
    guess.size == 1
  end
  
  def incorrect?(guess)
    !secret_word.chars.include?(guess)
  end

  def generate_secret_word
    dictionary = Dictionary.new
  	self.secret_word ||= dictionary.new_word
  end

  def lost?
    incorrectly_guessed_letters.size >= 12   
  end
end
