(function(){
  var Snakes = window.Snakes = window.Snakes || {};

  var View = Snakes.View = function($el, board) {
    this.$el = $el;
    this.board = board;
    this.board.setGrid();

    $("body").on("keydown", function(event){
      // var board = this.board;
      // console.log(event.keyCode);
      switch(event.keyCode) {
        case 38:
          if (board.snake.dir !== "S") {
            board.snake.turn("N");
          }
          break;
        case 39:
          if (board.snake.dir !== "W") {
            board.snake.turn("E");
          }
          break;
        case 40:
          if (board.snake.dir !== "N") {
            board.snake.turn("S");
          }
          break;
        case 37:
          if (board.snake.dir !== "E") {
            board.snake.turn("W");
          }
          break;
        default:
          console.log("Wrong Key");
      }
    });

    setInterval(this.render, 100);


  };

  View.prototype = {
    render : function() {
      var view = this;
      var board = this.board;
      board.setGrid();
      view.$el.empty();

      for (var row = 0; row < Snakes.Board.SIZE.rows; row++) {
        var $currentRow = $('<div class="row">');
        for (var col = 0; col < Snakes.Board.SIZE.cols; col++) {
          var $currentCol = $('<div class="col">');
          board.snake.segments.map(function(segment){
            if (segment.row === row && segment.col === col) {
              $currentCol.addClass("snake-segment");
            }
          });
          var currentCell = board.grid[row][col];
          if (currentCell === "S") {
            $currentCol.addClass("snake-segment");
          }
          $currentRow.append($currentCol);
        }
        view.$el.append($currentRow);
      }
    }
  };


})();
