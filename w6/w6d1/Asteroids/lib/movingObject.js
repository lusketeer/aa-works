(function(){
  window.Asteroids = window.Asteroids || {};
  var Asteroids = window.Asteroids;

  var MovingObject = Asteroids.MovingObject = function(pos, game, vel, radius, color){
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.color = color;
    this.game = game;
  };

  MovingObject.prototype = {

    draw : function(ctx){
      ctx.fillStyle = this.color;
      ctx.beginPath();

      ctx.arc(
        this.pos.x,
        this.pos.y,
        this.radius,
        0,
        2 * Math.PI,
        false
      );

      ctx.fill();
    },

    move : function() {
      this.pos.x += this.vel.x;
      this.pos.y += this.vel.y;
      this.pos = this.game.wrap(this.pos);
    },

    isCollidedWith : function(otherObject) {
      var x1 = this.pos.x,
          y1 = this.pos.y,
          x2 = otherObject.pos.x,
          y2 = otherObject.pos.y;
      var distance = Math.sqrt(Math.pow((x1 - x2), 2) + Math.pow((y1 - y2), 2));
      if (distance < this.radius + otherObject.radius) {
        return true;
      } else {
        return false;
      }
    }

  };

})();
