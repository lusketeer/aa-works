Pokedex.RootView.prototype.reassignToy = function(event) {
  // event.preventDefault();
  var view = this;

  var oldPokemonId = $(event.currentTarget).data("pokemon-id");
  var newPokemonId = $(event.currentTarget).find(":selected").val();

  var oldPokemon = this.pokes.get(oldPokemonId);

  var toyId = $(event.currentTarget).data("toy-id");
  var toy = oldPokemon.toys().get(toyId);

  toy.set("pokemon_id", newPokemonId);

  toy.save({}, {
    success: function() {
      delete oldPokemon.toys().get(toyId);
      view.renderPokemonDetail(oldPokemon);
      view.$toyDetail.empty();
    }
  });

};

Pokedex.RootView.prototype.renderToysList = function (toys) {
  var view = this;
  _.each(toys.models, function (toy) {
    view.addToyToList(toy);
  })
}
