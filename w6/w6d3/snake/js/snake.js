(function(){
  var Snakes = window.Snakes = window.Snakes || {};

  var Coord = Snakes.Coord = function(pos) {
    this.row = pos[0];
    this.col = pos[1];
  };

  Coord.prototype = {
    plus : function(coord) {
      this.row += coord.row;
      this.col += coord.col;
    }
  };

  var Snake = Snakes.Snake = function() {
    this.dir = "N";
    this.segments = [new Coord([5, 5])];

  };

  Snake.DIRS = ["N", "E", "S", "W"];

  Snake.prototype = {
    move : function() {
      var currentDir = this.dir
      this.segments.map(function(segment) {
        switch (currentDir) {
          case "N":
            segment.plus({row: -1, col: 0});
            break;
          case "S":
            segment.plus({row: 1, col: 0});
            break;
          case "W":
            segment.plus({row: 0, col: -1});
            break;
          case "E":
            segment.plus({row: 0, col: 1});
            break;
          default:
            console.log("Snake is moving!");
        }
      });
    },

    turn : function(newDir) {
      this.dir = newDir;
    }
  };


  var Board = Snakes.Board = function(snake) {
    this.snake = snake;
    this.grid = [];
    setInterval(this.step, 100);
  };

  Board.SIZE = {rows: 25, cols: 40};

  Board.prototype = {
    setGrid : function() {
        var grid = this.grid;
        var snake = this.snake;
        for (var row = 0; row < Board.SIZE.rows; row++) {
          var currentRow = [];
          for (var col = 0; col < Board.SIZE.cols; col++) {
            var currentCell = "";
            // snake.segments.map(function(segment){
            //   if (segment.row === row && segment.col === col) {
            //     currentRow.push("S");
            //     currentCell = "S";
            //   }
            // });
            if (currentCell !== "S") {
              currentRow.push(".");
            }
          }
          grid.push(currentRow);
        }
    },

    step : function() {
      // console.log("running");
      this.snake.move();
      this.render;
    },

    render : function() {

    }
  };

})();
