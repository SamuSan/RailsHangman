class Secret < ActiveRecord::Base
	belongs_to :game
  validates :word, presence: true
#this model is bullshit we dont need it
end
