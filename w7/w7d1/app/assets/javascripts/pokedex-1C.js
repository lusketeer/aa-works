Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon();
  var view = this;
  pokemon.save(attrs, {
    success: function() {
      view.pokes.add(pokemon);
      view.addPokemonToList(pokemon);
      callback(pokemon)
    },
    error: function() {
      console.log("WTF");
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var $form = $(event.target);
  var data = $form.serializeJSON();
  this.createPokemon(data, this.renderPokemonDetail.bind(this));
};
