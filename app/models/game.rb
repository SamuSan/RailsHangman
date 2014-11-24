class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  validates :secret, presence: true
end
