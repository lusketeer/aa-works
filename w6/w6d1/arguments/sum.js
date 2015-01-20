function sum() {
  var argArr = [].slice.call(arguments, 0);
  var sum = 0;
  argArr.map(function(el) {
    sum += el;
  });
  return sum;
}

console.log(sum(1, 2, 3, 4) === 10);
console.log(sum(1, 2, 3, 4, 5) === 15);
