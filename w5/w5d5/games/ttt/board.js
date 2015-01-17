Array.prototype.transpose = function() {
  var cols = this[0].length;
  var rows = this.length;
  var result = [];
  for (var row = 0; row < cols; row++) {
    var currentRow = [];
    for (var col = 0; col < rows; col++) {
      currentRow.push(this[col][row]);
    }
    result.push(currentRow);
  }
  return result;
}

function Board() {
  this.grid = [
    Array(3), Array(3), Array(3)
  ];
  this.winner = "";
}

Board.WINNINGS = [["X", "X", "X"], ["O", "O", "O"]];

Board.prototype = {
  printGrid : function() {
    this.grid.map(function(innerArray){
      console.log(innerArray);
    });
  },
  emptyEh : function(pos) {
    var row = pos[0],
        col = pos[1];
    return this.grid[row][col] === undefined;
  },
  placeMark : function(pos, mark) {

    if (this.emptyEh(pos)){
      var row = pos[0],
      col = pos[1];

      this.grid[row][col] = mark;
      return true;
    } else {
      return false;
    }
  },
  diagonals : function() {
    var left = [this.grid[0][0], this.grid[1][1], this.grid[2][2]];
    var right = [this.grid[2][0], this.grid[1][1], this.grid[0][2]];
    var result = [left, right];
    return result;
  },
  wonEh : function() {
    var board = this;
    // Iterate through winning combinations
    Board.WINNINGS.map(function(winning) {
      // Check each row
      board.grid.map(function(row) {
        if (row.toString() === winning.toString()) {
          board.winner = winning[0];
          return true;
        }
      });
      // End of check row

      // Check each col
      board.grid.transpose().map(function(col) {
        if (col.toString() === winning.toString()) {
          board.winner = winning[0];
          return true;
        }
      });
      // End of check col

      // Check each diag
      board.diagonals().map(function(diag) {
        if (diag.toString() === winning.toString()) {
          board.winner = winning[0];
          return true;
        }
      });
      // End of check diag


    });
    // End of Iterate through winning combinations
    return false;

  }
};


module.exports = Board;
