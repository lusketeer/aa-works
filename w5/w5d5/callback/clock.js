function Clock() {
  this.currentTime = "";
}

Clock.TICK = 5000;

Clock.prototype = {
  printTime : function () {
    var now = new Date(this.currentTime);
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var seconds = now.getSeconds();
    console.log(hours + ":" + minutes + ":" + seconds);
  },
  run : function () {
    var clock = this;
    clock.currentTime = Date.now();
    clock.printTime();

    setInterval(function(){
      clock._tick();
      }, Clock.TICK)
  },
  _tick : function () {
    this.currentTime += Clock.TICK;
    this.printTime();
  }
}

var clock = new Clock();
clock.run();
