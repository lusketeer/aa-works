Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId": "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    var router = this;
    if (!this._pokemonIndex){
      router.pokemonIndex(router.pokemonDetail.bind(this, id, callback));
    } else {
      var pokemon = this._pokemonIndex.collection.get(id);

      this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});

      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      this._pokemonDetail.refreshPokemon({callback: callback});
    }
  },

  pokemonIndex: function (callback) {
    if (!this._pokemonIndex){
      this._pokemonIndex = new Pokedex.Views.PokemonIndex();

    }
    this._pokemonIndex.refreshPokemon({callback: callback});
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);

    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    var router = this;
    if (!this._pokemonDetail){
      router.pokemonDetail(pokemonId, router.toyDetail.bind(this, pokemonId, toyId))
    } else {
      var toy = this._pokemonDetail.model.toys().get(toyId);
      var toyDetail = new Pokedex.Views.ToyDetail({
        model: toy,
        collection: this._pokemonIndex.collection
      });
      $("#pokedex .toy-detail").html(toyDetail.$el);
      toyDetail.render();
    }
  },

  pokemonForm: function () {

    var formView = new Pokedex.Views.PokemonForm({
      model: new Pokedex.Models.Pokemon(),
      collection: this._pokemonIndex.collection
    });

    formView.render();
    $('#pokedex .pokemon-form').html(formView.$el)


  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
