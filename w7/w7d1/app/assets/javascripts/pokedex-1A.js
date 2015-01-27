Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  // pokemon.name, pokemon.
  var $li = $('<li class="poke-list-item">');
  $li.data('id', pokemon.get('id'));
  $li.html(pokemon.get("name"));
  $li.addClass(pokemon.get("poke_type"));
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var view = this;
  var pokes = this.pokes;
  pokes.fetch({
    success: function() {
      pokes.each(function(poke) {
        view.addPokemonToList(poke);
      })
    }
  });
};
