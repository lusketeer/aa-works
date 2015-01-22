(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
  };

  View.prototype.bindEvents = function () {
    var view = this;
    this.$el.on("click", ".cell", function(event){
      var currentTarget = $(event.currentTarget);
      view.makeMove(currentTarget);
    });
  };

  View.prototype.makeMove = function ($square) {
    var game = this.game;
    var currentPlayer = game.currentPlayer;
    var pos = $square.data("pos");
    if (!game.isOver() && game.board.isEmptyPos(pos)) {
      $square.addClass("hover").text(currentPlayer);
      game.playMove(pos);
    } else {
      alert("Invalid!");
    }
    if (game.isOver()) {
      var $span = $("<span>Congratz </span>");
      $span.append(currentPlayer);
      $("body").append($span);
      this.$el.off("click");
    }
  };

  View.prototype.setupBoard = function () {
    var board = this.$el;
    for (var i = 0; i < 3; i++) {
      var row = $('<div class="row">');
      board.append(row);
      for (var k = 0; k < 3; k++) {
        var cell = $('<div class="cell">');
        cell.data("pos", [i, k]);
        row.append(cell);
      }
    }
    this.bindEvents();
  };
})();
