TrelloClone.Views.CardsIndex = Backbone.CompositeView.extend({
  template: JST["cards/index"],

  // tagName: "ul",
  //
  // className: "cards-list",

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.collection.each(function(card) {
      var cardShowView = new TrelloClone.Views.CardShow({ model: card, collection: this.collection });
      this.addSubview(".cards-list", cardShowView);
      // this.$el.append(cardShowView.render().$el);
    }, this);
    return this;
  },

  onRender: function() {
    this.$(".cards-list").sortable({
      connectWith: ".cards-list"
    });
  }
});
