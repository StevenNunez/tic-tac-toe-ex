defmodule TicTacToe.GameTest do
  use ExUnit.Case
  alias TicTacToe.Game
  alias TicTacToe.Board

  test "returns an empty board" do
    {:ok, game} = Game.new
    assert game.current_player == "X"
    assert game.board.positions == ["","","", "","","", "","",""]
  end

  test "can play a valid position" do
    with {:ok, game} <- Game.new,
         {:ok, game} <- Game.play_move(game, 1)
     do
      assert game.board.positions == ["X","","", "","","", "","",""]
    end
  end

  test "it updates the player after every move" do
    with {:ok, game} <- Game.new,
         {:ok, game} <- Game.play_move(game, 1)
     do
      assert game.current_player == "O"
    end
  end

  test "it deals with invalid positions" do
    with {:ok, game} <- Game.new,
         {:error, game} <- Game.play_move(game, 100)
    do
      assert game.board.positions == ["","","", "","","", "","",""]
      assert game.current_player == "X"
    else
      {:ok, _game} ->
        assert false, "Should have given error"
    end
  end

  test "it deals with invalid types" do
    with {:ok, game} <- Game.new,
         {:error, game} <- Game.play_move(game, "Wubalubadubdub")
    do
      assert game.board.positions == ["","","", "","","", "","",""]
      assert game.current_player == "X"
    else
      {:ok, _game} ->
        assert false, "Should have given error"
    end
  end

  test "it knows when a game is still not won" do
    {:ok, game} = Game.new
    refute Game.won?(game)
  end

  test "it knows when a game is won" do
   winning_combinations = [
   [
     "X", "X", "X",
     "",  "",  "",
     "",  "",  "",
    ],
   [
     "",  "",  "",
     "X", "X", "X",
     "",  "",  "",
    ],
   [
     "",  "",  "",
     "",  "",  "",
     "X", "X", "X",
    ],
   [
     "X", "", "",
     "X", "", "",
     "X", "", "",
    ],
   [
     "", "X", "",
     "", "X", "",
     "", "X", "",
    ],
   [
     "", "", "X",
     "", "", "X",
     "", "", "X",
    ],
   [
     "X", "", "",
     "",  "X","",
     "",  "", "X",
    ],
   [
     "", "", "X",
     "", "X", "",
     "X","", "",
    ],
   [
     "O", "O", "O",
     "",  "",  "",
     "",  "",  "",
    ],
   [
     "",  "",  "",
     "O", "O", "O",
     "",  "",  "",
    ],
   [
     "",  "",  "",
     "",  "",  "",
     "O", "O", "O",
    ],
   [
     "O", "", "",
     "O", "", "",
     "O", "", "",
    ],
   [
     "", "O", "",
     "", "O", "",
     "", "O", "",
    ],
   [
     "", "", "O",
     "", "", "O",
     "", "", "O",
    ],
   [
     "O", "", "",
     "",  "O","",
     "",  "", "O",
    ],
   [
     "", "", "O",
     "", "O", "",
     "O","", "",
    ],
   ]
    Enum.each(winning_combinations, fn (winning_combo) ->
      {:ok, board} = Board.new(winning_combo)
      {:ok, won_game} = Game.new("X", board)
      assert Game.won?(won_game)
    end)
  end

  test "it knows who won the game" do
    winning_combo = [ "X", "X", "X", "",  "",  "", "",  "",  ""]
    {:ok, board} = Board.new(winning_combo)
    {:ok, won_game} = Game.new("X", board)
    assert Game.winner(won_game) == "X"
  end

  test "it knows if there's not a winnner" do
    combo = [ "X", "X", "O", "",  "",  "", "",  "",  ""]
    {:ok, board} = Board.new(combo)
    {:ok, game} = Game.new("X", board)
    assert Game.winner(game) == :no_winner
  end
  # locked Game
end
