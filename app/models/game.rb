class Game < ActiveRecord::Base
  MAXIMUM_TURNS = 12

  has_many :guesses, dependent: :destroy

	before_validation :generate_secret_word
  
  validates :secret_word, presence: true

  def in_progress?
    !won? && !lost?
  end

  def incorrectly_guessed_letters
    guesses.map { |guess| guess.guess if incorrect_single_letter_guess(guess) }.compact
  end

  def all_guessed_letters
    guesses.map { |guess| guess.guess if guess.single_letter? }
  end

  def won?
     (secret_word.chars - all_guessed_letters).empty? || word_guessed?
  end

  def total_incorrect_guesses
    incorrectly_guessed_letters.size + incorrect_whole_word_guesses.size
  end

  private

  def word_guessed?
    guesses.each(&:guess).any? { |guess| guess.matches_word?(secret_word) }
  end

  def incorrect_whole_word_guesses
    guesses.select { |guess| guess.whole_word? && !guess.matches_word?(secret_word) }
  end

  def incorrect_single_letter_guess(guess)
    guess.single_letter? && incorrect?(guess.guess)
  end

  def incorrect?(guess)
    !secret_word.chars.include?(guess)
  end

  def generate_secret_word
    dictionary = Dictionary.new
  	self.secret_word ||= dictionary.new_word
  end

  def lost?
    total_incorrect_guesses >= MAXIMUM_TURNS   
  end
end
