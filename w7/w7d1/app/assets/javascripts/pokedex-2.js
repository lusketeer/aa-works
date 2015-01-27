Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $toys = this.$pokeDetail.find('ul.toys')
  var $ul = $('<ul class="toy-list-item">');
  $ul.data("toy-id", toy.get("id"));
  $ul.data("pokemon-id", toy.get("pokemon_id"));
  var $liName = $('<li>');
  var $liHappiness = $('<li>');
  var $liPrice = $('<li>');

  $liName.html("name: " + toy.get("name") + " ");
  $liHappiness.html("happiness: " + toy.get("happiness") + " ");
  $liPrice.html("price: " + toy.get("price"));

  $ul.append($liName);
  $ul.append($liHappiness);
  $ul.append($liPrice)

  $toys.prepend($ul);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  this.$toyDetail.hide();
  this.$toyDetail.show("fast");
  var $detail = $('<div class="detail">');
  var $img = $('<img>');
  $img.attr("src", toy.get("image_url"));
  var $ul = $("<ul>");

  var $selectPokesList = $('<select class="pokes-list">');
  $selectPokesList.data("pokemon-id", toy.get("pokemon_id"));
  $selectPokesList.data("toy-id", toy.get("id"));

  this.pokes.each(function(poke) {
    var $option = $('<option>');
    $option.attr("value", poke.get("id"));
    $option.text(poke.get("name"));
    if (poke.get("id") === toy.get("pokemon_id")) {
      $option.prop("selected", true)
    }
    $selectPokesList.append($option);
  });

  _.each(toy.attributes, function(val, key) {
    var $li = $("<li>");
    if (key !== "image_url") {
      if (key === "pokemon_id") {
          $li.append("pokemon: ");
          $li.append($selectPokesList);
      } else {
        $li.html(key + ": " + val);
      }
      $ul.append($li)
    }
  });


  $detail.append($img);
  $detail.append($ul);
  this.$toyDetail.html($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  event.preventDefault();
  var toyId = $(event.currentTarget).data("toy-id");
  var pokemonId = $(event.currentTarget).data("pokemon-id");
  var pokemon = this.pokes.get(pokemonId);
  var toy = pokemon.toys().get(toyId);
  this.renderToyDetail(toy);
};
