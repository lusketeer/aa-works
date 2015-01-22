(function(){
  var Hanoi = window.Hanoi = window.Hanoi || {};
  var View = Hanoi.View = function(game, $el) {
    this.game = game;
    this.$el = $el;
    this.pickTower = undefined;
  };

  View.prototype = {
    render : function() {
      var $el = this.$el,
          game = this.game;
      $el.empty();
      for (var i = 0; i < 3; i++) {
        var $tower = $('<div class="tower">').data("index", i);
        var disks = game.towers[i];
        disks.map(function(disk){
          var $disk = $('<div class="disk">').css("width", disk * 20 + "px");
          $tower.append($disk);
        });
        $el.append($tower);
      }
    },

    clickTower : function() {
      var view = this;
      view.$el.on("click", ".tower", function(event){
        // console.log("Clicked");
        var currentTarget = $(event.currentTarget);
        if (view.pickTower === undefined){
          view.pickTower = currentTarget.data("index");
        } else {
          var move = view.game.move(view.pickTower, currentTarget.data("index"));
          if (!move) {
            alert("Invalid Move");
          }
          view.pickTower = undefined;
          view.render();
          if (view.game.isWon()){
            view.$el.off('click');
            alert("you win");
          }
        }
      });

    }
  };
})();
