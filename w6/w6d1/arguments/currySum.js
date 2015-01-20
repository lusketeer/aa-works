var curriedSum = function(numArgs) {
  var sum = 0;
  var numbers = [];
  var _curriedSum = function(num){
    numbers.push(num);
    if (numbers.length < numArgs) {
      return _curriedSum;
    }
    else if (numArgs === numbers.length){
      numbers.map(function(el){ sum+= el;});
      return sum;
    }
  };
  return _curriedSum;
};

function sum() {
  var result = 0;
  [].slice.call(arguments, 0).map(function(el) {
    result += el;
  });
  return result;
}

Function.prototype.curry = function(numArgs){
  var numbers = [];
  var origFunction = this;
  var _curry = function(num){
    numbers.push(num);
    if (numbers.length < numArgs) {
      return _curry;
    }
    else if (numArgs === numbers.length){
      return origFunction.apply({}, numbers);
    }
  };
  return _curry;
};





var sum = sum.curry(4);
console.log(sum(5)(30)(20)(1));
