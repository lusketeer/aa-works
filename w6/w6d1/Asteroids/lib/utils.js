(function() {
  window.Asteroids = window.Asteroids || {};
  var Asteroids = window.Asteroids;

  Asteroids.Util = {

    inherits : function(ChildClass, ParentClass) {
      function Surrogate() {}
      Surrogate.prototype = ParentClass.prototype;
      ChildClass.prototype = new Surrogate();
    },

    randomColor : function(){
      var HEX_DIGITS = "0123456789ABCDEF";
      var color = "#";
      for (var i = 0; i < 6; i++) {
        color += HEX_DIGITS[Math.floor((Math.random() * 16))];
      }
      return color;
    },

    randomVec : function(length) {
      var xSign = (Math.random() > 0.5) ? 1 : -1;
      var ySign = (Math.random() > 0.5) ? 1 : -1;
      return { x : length * Math.random() * xSign, y : length * Math.random() * ySign};
    }

  };

})();
