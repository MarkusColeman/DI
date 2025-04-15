board = [" "] * 9

def display_board(board):
  first_row = f" {board[0]} | {board[1]} | {board[2]} "
  second_row = f" {board[3]} | {board[4]} | {board[5]} "
  third_row = f" {board[6]} | {board[7]} | {board[8]} "
  row_dividers = f"---+---+---"
  print(first_row)
  print(row_dividers)
  print(second_row)
  print(row_dividers)
  print(third_row)

def player_move(player):
  move = int(input(f"{player}'s move (1-9): "))
  while move < 1 or move > 9:
    print("Invalid move! Choose a number between 1 and 9.")
    move = int(input("Your next move: "))
  while board[move - 1] != " ":
    print("This space is taken", move)
    move = int(input("Choose a different position: "))
    while move < 1 or move > 9:
      print("Invalid move! Choose a number between 1 and 9.")
      move = int(input("Your next move: "))
  board[move - 1] = player
  display_board(board)

def check_win(board, player):
  win_combos = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]
  for combo in win_combos:
    if all(board[i] == player for i in combo):
      return True
  return False

def play():
  turn = 0
  current_player = "X"
  while turn < 9:
    player_move(current_player)
    if check_win(board, current_player):
      print(f"{current_player} wins!")
      return
    turn += 1
    current_player = "O" if current_player == "X" else "X"
  print("It's a tie!")

play()

