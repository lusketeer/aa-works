var readline = require("readline");
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = [[3, 2, 1], [], []];
  this.startingPile = [3, 2, 1];
}

HanoiGame.prototype = {
  renderStacks: function() {
    this.stacks.map(function(innerArray) {
      console.log(innerArray);
    });
  },

  run: function(completionCallback) {
    var game = this;

    game.promptMove(function(startIndex, endIndex){
      if (!game.move(startIndex, endIndex)) {
        console.log("Invalid Moves");
      }

      if (game.isWon()){
        completionCallback();
      } else {
        game.run(completionCallback);
      }
    });
  },

  isWon: function() {
    return ((this.startingPile.toString() === this.stacks[1].toString()) || (this.startingPile.toString() === this.stacks[2].toString()));
  },

  isValidMove: function(startTowerIdx, endTowerIdx){
    var startTower = this.stacks[startTowerIdx];
    var endTower = this.stacks[endTowerIdx];

    if (startTower.length === 0){
      return false;
    } else if ( endTower.length === 0){
      return true;
    } else if (startTower[startTower.length - 1] < endTower[endTower.length - 1]){
      return true;
    } else {
      return false;
    }
  },

  move: function(startTowerIdx, endTowerIdx) {
    if (this.isValidMove(startTowerIdx, endTowerIdx)) {
      var startTower = this.stacks[startTowerIdx];
      var endTower = this.stacks[endTowerIdx];

      endTower.push(startTower.pop());
      return true;
    } else {
      return false;
    }
  },

  promptMove: function(callback) {
    var that = this;
    this.renderStacks();
    reader.question("Start Tower Index: ", function(startIndex){
      reader.question("End Tower Index: ", function(endIndex){
        callback.call(that, startIndex, endIndex);
      });
    });
  }
}

var game1 = new HanoiGame();

game1.run(function () {
    game1.renderStacks();
    console.log("you just won!");
    reader.close();
});
