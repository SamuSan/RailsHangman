module GameHelper
  def letters_filterd_by_guessed(game, guessed_letters)
    game.secret_word.chars.map { |letter| game.all_guessed_letters.member?(letter) ? letter : "?" } 
  end

  def hangman_image_filename(game)
    size = game.incorrectly_guessed_letters.size
    "hangman_#{size}.png"
  end

  def win_lose_image(game)
    game.won? ? "win.png" : "lose.png"
  end
end
