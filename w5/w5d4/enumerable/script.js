var testArray = [1, 2, 3, 4];

Array.prototype.myEach = function(callBack) {
  for (var i = 0; i < this.length; i++) {
    callBack(this[i]);
  }
}

function printAddOne(el) {
  console.log(el + 1);
}


// console.log(testArray.myEach(printAddOne));


Array.prototype.myMap = function(callBack) {
  var result = [];
  this.myEach(function(el) {
    result.push(callBack(el));
  });
  return result;
}

function addOne(el) {
  return el + 1;
}

var result = testArray.myMap(addOne);
// console.log(result);

Array.prototype.myInject = function(callback) {

  var tempArr = this;
  var result = tempArr.splice(0,1)[0];

  tempArr.myEach(function(el) {
    result = callback(result, el);
  });
  return result;
};

function add(a, b) {
    return a + b;
};

console.log(testArray.myInject(add))
