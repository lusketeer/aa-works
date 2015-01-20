(function(){
  window.Asteroids = window.Asteroids || {};
  var Asteroids = window.Asteroids;
  var MovingObject = Asteroids.MovingObject;

  var Asteroid = Asteroids.Asteroid = function(pos, game) {
    MovingObject.call(this, pos, game);
    this.color = Asteroids.Util.randomColor();
    this.radius = 50;
    this.vel = Asteroids.Util.randomVec(1.5);
  };


  Asteroids.Util.inherits(Asteroid, MovingObject);
})();
