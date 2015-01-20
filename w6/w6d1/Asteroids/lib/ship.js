(function(){
  window.Asteroids = window.Asteroids || {};
  var Asteroids = window.Asteroids;
  var MovingObject = Asteroids.MovingObject;

  var Ship = Asteroids.Ship = function(pos, game) {
    MovingObject.call(this, pos, game);
    this.radius = 25;
    this.color = "#000";
    this.vel = { x : 0, y: 0};
  };

  Asteroids.Util.inherits(Ship, MovingObject);

  Ship.prototype.relocate = function () {
    this.pos = this.game.randomPosition();
    this.vel = { x : 0, y: 0};
  };

  Ship.prototype.power = function(impulse) {
    this.vel.x += impulse.x;
    this.vel.y += impulse.y;
  };

  Ship.prototype.fireBullet = function() {
    var bulletPos = { x: this.pos.x, y: this.pos.y };
    var bullet = new Asteroids.Bullet(bulletPos, this.game);
    this.game.addBullets(bullet);
  };

})();
