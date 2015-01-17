function HumanPlayer(name, mark, reader) {
   this.name = name;
   this.mark = mark;
   this.reader = reader;
}

HumanPlayer.prototype = {
  pickPos : function(callback){
    var that = this;
    this.reader.question("Pick a row?", function(row) {
      this.reader.question("Pick a col?", function(col) {
        var position = [parseInt(row), parseInt(col)];
        callback.call(that, position, this.mark);
      });
    });
  }
}

function ComputerPlayer() {

}


module.exports = {
  HumanPlayer : HumanPlayer,
  ComputerPlayer : ComputerPlayer
}
