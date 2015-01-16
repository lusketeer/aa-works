function Cat(name, owner) {
  this.name = name;
  this.owner = owner;

}

Cat.prototype = {
  cuteStatement : function() {
                    return "Everyone loves " + this.name;
                  },
  rollAround : function() {
                    return "I roll around.";
  },
  meow : function() {
                    return "meowwwww";
  }


}


// Cat.prototype.what = function () {};
var c = new Cat("Sassy", 'Tim');

c.meow = function() {
  return "not meow";
};
console.log(c.meow());

var d = new Cat("Fluffy", "David");
console.log(d.meow());
