Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  this.$toyDetail.empty();
  this.$toyDetail.hide();
  var view = this;
  var $detail = $('<div class="detail">');
  var $name = $('<h2>')
  $name.append(pokemon.get("name"));
  $detail.append($name);
  var $img = $('<img>');
  $img.attr("src", pokemon.get("image_url"));
  var $ulDetail = $('<ul class="pokemon-detail">');

  var $ulToys = $('<ul class="toys">');

  var $moves = $('<ul class="moves">Moves</ul>')

  _.each(pokemon.attributes, function(val, key) {
    if (key === "name" || key === "id") {
    } else if (key === "moves") {
      _.each(val, function(move) {
        $moves.append("<li>" + move + "</li>");
      });
    } else if (key !== "image_url") {
      var $li = $('<li>');
      $li.html(key + ": " + val);
      $ulDetail.append($li)
    }
  });
  pokemon.fetch({
    success: function() {
      view.renderToysList(pokemon.toys());
    }
  });

  $detail.append($img);
  $detail.append($moves);
  $detail.append($ulDetail);
  $detail.append($ulToys);
  this.$pokeDetail.html($detail);
  this.$pokeDetail.hide().show("fast")
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data('id');
  var pokemon = this.pokes.get(id);
  this.renderPokemonDetail(pokemon);
};
