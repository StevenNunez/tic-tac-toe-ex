defmodule TicTacToe do
  alias TicTacToe.Game
  alias TicTacToe.CLIPresenter
  def start do
    {:ok, game} = Game.new
    welcome
    play(game)
  end

  def welcome do
    IO.puts "Welcome to tic-tac-toe!"
  end

  def play(game) do
    CLIPresenter.display(game)
    choice = IO.gets "It's #{game.current_player}'s turn. Where would you like to play?"
    case Integer.parse(choice) do
      {position, _} ->
        case Game.play_move(game, position) do
          {:ok, game} -> play(game)
          {:error, :spot_taken, _game} ->
            IO.puts "Looks like that spot is taken. Try again"
            play(game)
        end
    :error ->
      IO.puts "Invalid Input. Try again"
      play(game)
    end
  end
end

defmodule TicTacToe.CLIPresenter do
  alias __MODULE__

  def display(game) do

    Enum.chunk(game.board.positions, 3)
    |> Enum.each(fn (row) ->
      IO.puts Enum.join(row, " | ") <> "\n"
    end)
  end
end
