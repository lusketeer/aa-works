Function.prototype.myBind = function(context) {
  var fn = this;
  return function(){
    return fn.apply(context);
  };
}

var cat = {
  name: 'Gizmo'
};

var myName = function(){
  return "Hello Cat " + this.name;
}

console.log(myName.myBind(cat)());
