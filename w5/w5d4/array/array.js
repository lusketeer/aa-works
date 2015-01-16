Array.prototype.uniq = function() {
  var result = [];
  this.forEach(function(el){
    if (result.indexOf(el) === -1) {
      result.push(el);
    }
  });
  return result;
};

// console.log([1, 2, 3, 4, 2, 2, 3].uniq());


Array.prototype.twoSum = function() {
  var result = [];
  for (var i = 0; i < this.length; i++) {
    for (var k = i + 1; k < this.length; k++) {
      if (this[i] + this[k] === 0) {
        result.push([i, k]);
      }
    }
  }
  return result;
}

// console.log([-1, 0, 2, -2, 1].twoSum());

Array.prototype.transpose = function() {
  var cols = this[0].length;
  var rows = this.length;
  var result = [];
  for (var row = 0; row < cols; row++) {
      var currentRow = [];
      for (var col = 0; col < rows; col++) {
        currentRow.push(this[col][row]);
      }
      result.push(currentRow);
  }
  return result;
}

console.log([[0, 1, 2], [3, 4, 5], [6, 7, 8]].transpose());
