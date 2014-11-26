class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    guess = game.guesses.new(params.require(:guess).permit(:guess))

    if !guess.save
      flash[:alert] = "Letter already used!"
    end
      redirect_to game
  end
end
