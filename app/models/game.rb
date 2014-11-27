class Game < ActiveRecord::Base
  MAXIMUM_TURNS = 12

  has_many :guesses, dependent: :destroy

	before_validation :generate_secret_word
  
  validates :secret_word, presence: true

  def in_progress?
    !won? && !lost?
  end

  def incorrect_single_letter_guesses
    letter_guesses.select { |guess| incorrect_letter?(guess.guess) }.map(&:guess)
  end

  def all_guessed_letters
    letter_guesses.map(&:guess)
  end

  def won?
    all_letters_guessed? || word_guessed?
  end

  def total_incorrect_guesses
    incorrect_single_letter_guesses.size + incorrect_whole_word_guesses.size
  end

  private

  def all_letters_guessed?
    (secret_word.chars - all_guessed_letters).empty? 
  end

  def word_guesses
    guesses.select(&:whole_word?)
  end

  def letter_guesses
    guesses.select(&:single_letter?)
  end

  def word_guessed?
    word_guesses.any? { |guess| guess.matches_word?(secret_word) } 
  end

  def incorrect_whole_word_guesses
    word_guesses.select { |guess| !guess.matches_word?(secret_word) }
  end

  def incorrect_letter?(guess)
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
