function range(start, end){
  if(end < start){
    return [];
  } else if (start === end - 3) {
    return  [start + 1, end - 1]
  } else if (start === end - 2) {
    return [start + 1]
  }else {
    return [start + 1].concat(range(start + 1, end - 1)).concat([end - 1]);
  }
}

// console.log(range(1, 10))

function exp_1(num, pow) {
  if (pow === 0) {
    return 1;
  } else {
    return num * exp_1(num, pow - 1);
  }
}

function exp_2(num, pow) {
  if (pow === 0) {
    return 1;
  } else {
    if (pow % 2 === 0) {
      return Math.pow(exp_2(num, pow / 2), 2);
    } else {
      return num * Math.pow(exp_2(num, (pow - 1) / 2), 2);
    }
  }
}

// console.log(exp_2(8, 4));

function fib(n) {
  if (n === 1) {
    return [1];
  } else if (n === 2) {
    return [1, 1];
  } else {
    var beforeLast = fib(n - 1)
    return beforeLast.concat([beforeLast[beforeLast.length - 2] + beforeLast[beforeLast.length - 1]]);
  }
}

// console.log(fib(13));

function binSearch(arr, target) {
  var middle = Math.floor(arr.length / 2)

  if(target === arr[middle]){
    return middle;
  } else if(target < arr[middle]) {
    var left = arr.slice(0, middle)
    return binSearch(left, target);
  } else {
    var right = arr.slice(middle + 1)
    return binSearch(right, target) + middle + 1;
  }

}

// console.log(binSearch([1, 2, 3, 4, 5, 6, 7, 8], 4));

function makeChange(amount, changes) {
  var result = [];

  if (changes.length === 0) {
    return [];
  } else {
    result.push(makeChangeHelper(amount, changes))
    return result.concat(makeChange(amount, changes.slice(1)));
  }

}

function makeChangeHelper(amount, changes) {
  var change = changes[0];
  if (changes.length === 0) {
    return [];
  }
  if (amount > changes[0]) {
    var num = Math.floor(amount / change);
    var remainder = amount % change;
    return [num].concat(makeChangeHelper(remainder, changes.slice(1)));
  } else {
    return [0].concat(makeChangeHelper(amount, changes.slice(1)));
  }
}

// console.log(makeChange(14, [10, 7, 1]));

function mergeSort(arr) {
  if (arr.length <= 1){
    return arr;
  } else {
    var middle = Math.floor(arr.length / 2);
    var leftArr = arr.slice(0, middle);
    var rightArr = arr.slice(middle);

    var left = mergeSort(leftArr);
    var right = mergeSort(rightArr);
    return merge(left, right);
  }
}

function merge(left, right) {
  var result = [];
  while ((left.length !== 0) || (right.length !== 0)) {
    if ((left.length !== 0) && (right.length !== 0)) {
      if (left[0] < right[0]) {
        result.push(left.splice(0, 1)[0]);
      } else {
        result.push(right.splice(0, 1)[0]);
      }
    } else if (left.length === 0) {
      result.push(right.splice(0, 1)[0]);
    } else {
      result.push(left.splice(0, 1)[0]);
    }

  }
  return result;
}


// console.log(mergeSort([4, 3, 1, 1, 2, 3]));

function subsets(arr) {
  var result = [];
  if (arr.length === 0) {
    return [[]];
  } else {
    var currentEl = arr[arr.length - 1]
    var beforeArr = subsets(arr.slice(0, arr.length - 1));
    beforeArr.forEach(function(el) {
      result.push(el.concat(currentEl));
    });
    return beforeArr.concat(result);
  }
}

console.log(subsets([1, 2, 3]))
