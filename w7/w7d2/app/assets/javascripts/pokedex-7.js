Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form": "savePokemon"
  },

  render: function () {
    var content = JST["pokemonForm"];
    this.$el.html(content);
  },

  savePokemon: function (event) {
    debugger
    event.preventDefault();
    var view = this
    var pokemon = this.model;
    var data = $(event.currentTarget).serializeJSON();
    pokemon.save(data.pokemon, {
      success: function (){
        view.collection.add([pokemon]);
        Backbone.history.navigate("pokemon/" + pokemon.get("id"), { trigger: true });
      }
    })
  }
});
