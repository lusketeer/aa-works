(function(){
  window.Asteroids = window.Asteroids || {};
  var Asteroids = window.Asteroids;

  var GameView = Asteroids.GameView = function(game, ctx){
    this.game = game;
    this.ctx = ctx;
  };

  GameView.prototype.start = function(){
    var gameView = this;

    this.bindKeyHandlers();

    setInterval(function(){
      gameView.game.step();
      gameView.game.draw(gameView.ctx);
    }, 20);

  };

  GameView.prototype.bindKeyHandlers = function(){
    var speed = 1;
    var ship = this.game.ship;
    key('up', function(){
      ship.power({x : 0, y : -speed});
    });
    key('down', function(){
      ship.power({x : 0, y : speed});
    });
    key('left', function(){
      ship.power({x : -speed, y : 0});
    });
    key('right', function(){
      ship.power({x : speed, y : 0});
    });
    key('space', function(){
      ship.fireBullet();
    });
  };
})();
