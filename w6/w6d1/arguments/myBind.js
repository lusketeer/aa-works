Function.prototype.myBind = function(obj) {
  var bindArgs = [].slice.call(arguments, 1);
  var functionToCall = this;
  return function() {
      var callArgs = [].slice.call(arguments, 0);
      return functionToCall.apply(obj, bindArgs.concat(callArgs));
  };
};

function myFunction() {
  console.log([].slice.call(arguments, 0));
}

var myObj = {};

var myBoundFunction = myFunction.myBind(myObj, 1, 2);

// equivalent to `obj.myFunction(1, 2, 3)`
myBoundFunction(3);
