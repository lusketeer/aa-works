var readline = require("readline");

var reader = readline.createInterface({
  input  : process.stdin,
  output : process.stdout
})





function addNumbers(sum, numsLeft, completionCallBack) {
  if (numsLeft === 0) {
    completionCallBack(sum);
    reader.close();
  } else {
      numsLeft--;
      reader.question("Give me a number: ", function(answer) {
        var newSum = sum + parseInt(answer);
        console.log("Current Sum: " + newSum);
        addNumbers(newSum, numsLeft, completionCallBack);
      })
  }
}

addNumbers(0, 3, function(sum) {
  console.log("Total Sum: " + sum);
});
