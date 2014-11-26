class Dictionary
  WORDS_FILE_PATH = Rails.root.join("app","assets", "words.txt")
  
  def new_word
    File.read(WORDS_FILE_PATH).split.sample  
  end
end