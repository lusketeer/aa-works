var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askIfLessThan(el1, el2, callback) {
  reader.question("Please tell us if: " + el1 + " < " + el2 + "? (yes/no)", function(answer) {
      callback(answer === 'yes');
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i === arr.length - 1) {
    outerBubbleSortLoop(madeAnySwaps);
  } else {
    console.log(i);
    askIfLessThan(arr[i], arr[i + 1], function(comparison) {
      if (!comparison) {
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        madeAnySwaps = true;
      }
      i++;
      innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop);
    });
  }
}

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function(arr){
  console.log("Sorted Array: " + JSON.stringify(arr));
  reader.close();
})


//
//
// askIfLessThan(3, 5, function(comparison){
//   if (comparison) {
//     console.log("el1 is smaller than el2");
//   } else {
//     console.log("el1 is not smaller than el2");
//   }
// });
