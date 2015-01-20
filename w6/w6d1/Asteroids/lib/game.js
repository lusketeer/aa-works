(function(){
  window.Asteroids = window.Asteroids || {};
  var Asteroids = window.Asteroids;

  var Game = Asteroids.Game = function() {
    this.DIM_X = 900;
    this.DIM_Y = 900;
    this.NUM_ASTEROIDS = 10;
    this.asteroids = [];
    this.bullets = [];
    this.addAsteroids();
    this.ship = new Asteroids.Ship({x : this.DIM_X/2, y : this.DIM_Y/2}, this);
  };

  Game.prototype = {

    allObjects : function(){
      return [this.ship].concat(this.asteroids).concat(this.bullets);
    },

    addAsteroids : function(){
      var game = this;
      for(var i = 0; i < game.NUM_ASTEROIDS; i++) {
        var pos = game.randomPosition();
        var asteroid = new Asteroids.Asteroid(pos, game);
        game.asteroids.push(asteroid);
      }
    },

    addBullets : function(bullet) {
      this.bullets.push(bullet);
    },

    randomPosition : function() {
      return {
        x : Math.random() * this.DIM_X,
        y : Math.random() * this.DIM_Y
      };
    },

    draw : function(ctx) {
      ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
      this.allObjects().forEach(function(a) {
        a.draw(ctx);
      });
    },

    moveObjects : function() {
      this.allObjects().forEach(function(a) {
        a.move();
      });
    },

    wrap : function(pos) {
      if(pos.x > this.DIM_X){
        pos.x -= this.DIM_X;
      }else if(pos.x < 0){
        pos.x += this.DIM_X;
      }
      if(pos.y > this.DIM_Y){
        pos.y -= this.DIM_Y;
      }else if(pos.y < 0){
        pos.y += this.DIM_Y;
      }
      return pos;
    },

    checkCollisions : function() {
      var flyingRocks = this.allObjects();
      var collidedRocks = [];
      for(var i = 0; i < flyingRocks.length - 1; i++){
        for(var j = i + 1; j < flyingRocks.length; j++) {
          if (flyingRocks[i].isCollidedWith(flyingRocks[j])) {
            if((flyingRocks[i] instanceof Asteroids.Ship) && (flyingRocks[j] instanceof Asteroids.Asteroid)){
              flyingRocks[i].relocate();
            }
            // collidedRocks.push(flyingRocks[i]);
            // collidedRocks.push(flyingRocks[j]);
          }
        }
      }
      var game = this;
      // collidedRocks.forEach(function(rock){
      //   game.remove(rock);
      // });
    },

    step : function() {
      this.moveObjects();
      this.checkCollisions();
    },

    remove : function(asteroid) {
      var index = this.asteroids.lastIndexOf(asteroid);
      this.asteroids.splice(index, 1);
    }


  };
})();
