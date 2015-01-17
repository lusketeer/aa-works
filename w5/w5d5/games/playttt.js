var TTT = require("./ttt");

var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
})

var board = new TTT.Board();
var player1 = new TTT.Player.HumanPlayer("Luke", "X", reader);
var player2 = new TTT.Player.HumanPlayer("Timur", "O", reader);
var game = new TTT.Game(player1, player2, board);

game.run(function() {
  game.board.printBoard();
  console.log(game.board.winner + " won!");
  reader.close();
});
