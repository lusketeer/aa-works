
function Game(player1, player2, board) {
  this.players = [player1, player2];
  this.turn = 0;
  this.board = board;
}

Game.prototype = {
  run : function(completionCallback){
    this.makeMove(function () {
      if (this.board.wonEh()){
        completionCallback();
      } else {
        this.run(completionCallback);
      }
    });

  },

  makeMove : function(cb) {
    var game = this;
    game.board.printGrid();
    var currentPlayer = game.players[game.turn];

    currentPlayer.pickPos(function(position, mark){
      var move = game.board.placeMark(position, mark);
      if (move){
        game.turn = game.players.length - 1 - game.turn;
      } else {
        game.makeMove();
      }
      cb()
    });

  }
};

module.exports = Game;
