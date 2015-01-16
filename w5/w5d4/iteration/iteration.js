Array.prototype.bubbleSort = function() {
  var sorted = false;
  while (!sorted) {
    sorted = true;
    for (var i = 0; i < this.length; i++) {
      for (var k = i + 1; k < this.length; k++) {
        if (this[i] > this[k]) {
          temp = this[i];
          this[i] = this[k];
          this[k] = temp;
          sorted = false;
        }
      }
    }
  }
  return this;
};

// console.log([2, 3, 41, 1, 26, 3, 2].bubbleSort());

function substring(str) {
  var result = [];
  for (var i = 0; i < str.length; i++) {
    for (var len = i + 1; len <= str.length; len++) {
        result.push(str.substring(i, len));
    }
  }
  return result.uniq();
}

Array.prototype.uniq = function() {
  var result = [];
  this.forEach(function(el){
    if (result.indexOf(el) === -1) {
      result.push(el);
    }
  });
  return result;
};

console.log(substring("hello"));
