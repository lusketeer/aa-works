Function.prototype.inherits = function(ancestor) {
  function Surrogate() {}
  Surrogate.prototype = ancestor.prototype;
  this.prototype = new Surrogate();
};
