class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show #get /game/[someid]
    @game = Game.find(params[:id])
    @guesses = @game.guesses.order(:id)
  end
  
  def create
    game  = Game.create!
    redirect_to game
  end
end
