(function(){
  window.Asteroids = window.Asteroids || {};
  var Asteroids = window.Asteroids;
  var MovingObject = Asteroids.MovingObject;

  var Bullet = Asteroids.Bullet = function(pos, game) {
    MovingObject.call(this, pos, game);
    this.radius = 2;
    this.color = "#000";
    var xSpeed = 2.5;
    var ySpeed = 2.5;
    if(game.ship.vel.x < 0){
      xSpeed *= -1;
    }
    if(game.ship.vel.y < 0){
      ySpeed *= -1;
    }
    this.speed = 2.5;
    this.vel = {x : xSpeed + game.ship.vel.x , y : ySpeed + game.ship.vel.y };
  };

  Asteroids.Util.inherits(Bullet, MovingObject);

})();
