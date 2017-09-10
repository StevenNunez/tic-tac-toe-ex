defmodule TicTacToe.Game do
  defstruct [:current_player, :board]
  alias TicTacToe.Game
  alias TicTacToe.Board
  alias TicTacToe.Player
  def new do
    {:ok, %Game{
      current_player: "X",
      board: get_new_board()
    }}
  end

  def new(current_player, board) do
    {:ok, %Game{
      current_player: current_player,
      board: board
    }}
  end

  def play_move(game, position) when is_integer(position) and position in 1..9 do
    case Board.play_move(game.board, game.current_player, position - 1) do
      {:ok, board} ->
        get_next_player(game.current_player) |> new(board)
      {:error, :spot_taken, _board} ->
        {:error, :spot_taken, game}
    end
  end
  def play_move(game, _), do: {:error, game}

  def won?(game) do
    Board.won?(game.board)
  end

  def winner(game) do
    Board.winner(game.board)
  end

  def locked?(game) do
    Board.full?(game.board)
  end

  defp get_new_board do
    {:ok, board} = Board.new
    board
  end

  defp get_next_player(current_player) do
   {:ok, player} = Player.next_player(current_player)
   player
  end
end

defmodule TicTacToe.Player do
  def next_player("X"), do: {:ok, "O"}
  def next_player("O"), do: {:ok, "X"}
end

defmodule TicTacToe.Board do
  defstruct [:positions]
  alias TicTacToe.Board
  @empty_position ""
  def new do
    {:ok, %Board{
      positions: [
          @empty_position,@empty_position,@empty_position,
          @empty_position,@empty_position,@empty_position,
          @empty_position,@empty_position,@empty_position
      ]
    }}
  end

  def new(positions) do
    {:ok, %Board{
      positions: positions
    }}
  end

  def play_move(%{positions: positions} = board, marker, position) do
    case Enum.at(positions, position) do
      @empty_position ->
        positions
        |> List.replace_at(position, marker)
        |> new
      _ ->
        {:error, :spot_taken, board}
      end
  end


  def won?(%{positions:
        [
          "O", "O", "O",
          _,  _,  _,
          _,  _,  _,
         ]}), do: true
  def won?(%{positions:
        [
          _,  _,  _,
          "O", "O", "O",
          _,  _,  _,
         ]}), do: true
  def won?(%{positions:
        [
          _,  _,  _,
          _,  _,  _,
          "O", "O", "O",
         ]}), do: true
  def won?(%{positions:
        [
          "O", _, _,
          "O", _, _,
          "O", _, _,
         ]}), do: true
  def won?(%{positions:
        [
          _, "O", _,
          _, "O", _,
          _, "O", _,
         ]}), do: true
  def won?(%{positions:
        [
          _, _, "O",
          _, _, "O",
          _, _, "O",
         ]}), do: true
  def won?(%{positions:
        [
          "O", _, _,
          _,  "O",_,
          _,  _, "O",
         ]}), do: true
  def won?(%{positions:
        [
          _, _, "O",
          _, "O", _,
          "O",_, _,
         ]}), do: true
  def won?(%{positions:
        [
          "X", "X", "X",
          _,  _,  _,
          _,  _,  _,
         ]}), do: true
  def won?(%{positions:
        [
          _,  _,  _,
          "X", "X", "X",
          _,  _,  _,
         ]}), do: true
  def won?(%{positions:
        [
          _,  _,  _,
          _,  _,  _,
          "X", "X", "X",
         ]}), do: true
  def won?(%{positions:
        [
          "X", _, _,
          "X", _, _,
          "X", _, _,
         ]}), do: true
  def won?(%{positions:
        [
          _, "X", _,
          _, "X", _,
          _, "X", _,
         ]}), do: true
  def won?(%{positions:
        [
          _, _, "X",
          _, _, "X",
          _, _, "X",
         ]}), do: true
  def won?(%{positions:
        [
          "X", _, _,
          _,  "X",_,
          _,  _, "X",
         ]}), do: true
  def won?(%{positions:
        [
          _, _, "X",
          _, "X", _,
          "X",_, _,
         ]}), do: true
  def won?(_), do: false
  def winner(%{positions:
        [
          "O", "O", "O",
          _,  _,  _,
          _,  _,  _,
         ]}), do: "O"
  def winner(%{positions:
        [
          _,  _,  _,
          "O", "O", "O",
          _,  _,  _,
         ]}), do: "O"
  def winner(%{positions:
        [
          _,  _,  _,
          _,  _,  _,
          "O", "O", "O",
         ]}), do: "O"
  def winner(%{positions:
        [
          "O", _, _,
          "O", _, _,
          "O", _, _,
         ]}), do: "O"
  def winner(%{positions:
        [
          _, "O", _,
          _, "O", _,
          _, "O", _,
         ]}), do: "O"
  def winner(%{positions:
        [
          _, _, "O",
          _, _, "O",
          _, _, "O",
         ]}), do: "O"
  def winner(%{positions:
        [
          "O", _, _,
          _,  "O",_,
          _,  _, "O",
         ]}), do: "O"
  def winner(%{positions:
        [
          _, _, "O",
          _, "O", _,
          "O",_, _,
         ]}), do: "O"

  def winner(%{positions:
        [
          "X", "X", "X",
          _,  _,  _,
          _,  _,  _,
         ]}), do: "X"
  def winner(%{positions:
        [
          _,  _,  _,
          "X", "X", "X",
          _,  _,  _,
         ]}), do: "X"
  def winner(%{positions:
        [
          _,  _,  _,
          _,  _,  _,
          "X", "X", "X",
         ]}), do: "X"
  def winner(%{positions:
        [
          "X", _, _,
          "X", _, _,
          "X", _, _,
         ]}), do: "X"
  def winner(%{positions:
        [
          _, "X", _,
          _, "X", _,
          _, "X", _,
         ]}), do: "X"
  def winner(%{positions:
        [
          _, _, "X",
          _, _, "X",
          _, _, "X",
         ]}), do: "X"
  def winner(%{positions:
        [
          "X", _, _,
          _,  "X",_,
          _,  _, "X",
         ]}), do: "X"
  def winner(%{positions:
        [
          _, _, "X",
          _, "X", _,
          "X",_, _,
         ]}), do: "X"
  def winner(_), do: :no_winner

  def full?(%{positions: positions}) do
    Enum.all?(positions, fn (position) ->
      position != @empty_position
    end)
  end
end
