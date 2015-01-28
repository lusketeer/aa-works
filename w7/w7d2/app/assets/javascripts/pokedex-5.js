Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({pokemon: pokemon});
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    var view = this;
    // this.collection.set([], options)
    this.collection.fetch({
      success: function(){
        view.render();
        if (options.callback) {
          options.callback();
        }
      }
    })

  },

  render: function () {
    var view = this;
    this.$el.empty();
    this.collection.each(function(pokemon) {
      view.addPokemonToList(pokemon);
    });
  },

  selectPokemonFromList: function (event) {
    var pokemonId = $(event.currentTarget).data("id");

    Backbone.history.navigate("pokemon/" + pokemonId, { trigger: true });

  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var pokemon = this.model;
    var view = this;
    pokemon.fetch({
      success: function(){
        view.render();
        if (options.callback) {
          options.callback();
        }
      }
    })
  },

  render: function () {
    var view = this;
    var content = JST["pokemonDetail"]({ pokemon: this.model });
    view.$el.html(content);
    view.model.toys().each(function(toy) {
      var toyContent = JST["toyListItem"]({ toy: toy });
      view.$el.find(".toys").append(toyContent);
    });
  },

  selectToyFromList: function (event) {

    var toyId = $(event.currentTarget).data("id");

    Backbone.history.navigate("pokemon/" + this.model.get("id") + "/toys/" + toyId, { trigger: true })
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  events: {
    "change select": "reassignToy"
  },

  render: function () {
    var view = this;
    view.collection.fetch({
      success: function(){
        var content = JST["toyDetail"]({ toy: view.model, pokes: view.collection });
        view.$el.html(content);
      }
    })

  },

  reassignToy: function (event) {
    var $currentTarget = $(event.currentTarget);
    var pokemonId = $currentTarget.data("pokemon-id");
    var pokemon = this.collection.get(pokemonId);
    var toy = pokemon.toys().get($currentTarget.data("toy-id"));

    toy.set("pokemon_id", $currentTarget.val());
    toy.save({}, {
      success: (function () {
        pokemon.toys().remove(toy);

        Backbone.history.navigate("pokemon/" + pokemonId, { trigger: true });
        // this.renderToysList(pokemon.toys());
        // this.$toyDetail.empty();
      })
    });
  }

});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
