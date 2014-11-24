class Secret < ActiveRecord::Base
	belongs_to :game
  before_validation
  validates :word, presence: true

end
