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
    {:ok, board} = Board.play_move(game.board, game.current_player, position - 1)

    get_next_player(game.current_player) |> new(board)
  end
  def play_move(game, _), do: {:error, game}

  def won?(game) do
    Board.won?(game.board)
  end

  def winner(game) do
    Board.winner(game.board)
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
  @x_winning_combinations [
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
      ]
     ]

    @o_winning_combinations [
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

  # when in 0..8
  def play_move(board, marker, position) do
    board.positions
    |> List.replace_at(position, marker)
    |> new
  end

  def won?(%{positions: positions }) when positions in @x_winning_combinations  or positions in @o_winning_combinations do
    true
  end
  def won?(_), do: false

  def winner(%{positions: positions}) when positions in @x_winning_combinations, do: "X"
  def winner(%{positions: positions}) when positions in @o_winning_combinations, do: "O"
  def winner(_), do: :no_winner

end
