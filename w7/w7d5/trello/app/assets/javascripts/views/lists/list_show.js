TrelloClone.Views.ListShow = Backbone.CompositeView.extend({

  template: JST['lists/show'],

  // tagName: "li",

  className: "lists-list-item col-lg-3 col-md-3 col-sm-4 col-xs-12",

  events: {
    "click button.new-card"           : "renderNewCardForm",
    "click button.cancel.card-form"   : "renderNewCardButton",
    "click .delete-list"              : "deleteList"
  },

  initialize: function() {
    this.listenTo(this.model.cards(), "add sync remove", this.render);
  },

  render: function() {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    var cardIndexView = new TrelloClone.Views.CardsIndex({ collection: this.model.cards() });
    this.addSubview(".row.cards", cardIndexView);
    this.$el.attr("data-id", this.model.id);
    // this.$(".row.cards").html(cardIndexView.render().$el);

    return this;
  },

  renderNewCardForm: function(event) {
    this._newCardButton = $(event.currentTarget);
    $(event.currentTarget).remove();
    var card = new TrelloClone.Models.Card({ list_id: this.model.id })
    var newCardView = new TrelloClone.Views.CardNew({ model: card, collection: this.model.cards() });
    this.$el.append(newCardView.render().$el);
  },

  renderNewCardButton: function(event) {
    event.preventDefault();
    this.$(".new-card").remove();
    this.$el.append(this._newCardButton);
  },

  deleteList: function(event) {
    event.preventDefault();
    // var boardId = this.model.get("board_id");
    this.collection.remove([this.model]);
    this.model.destroy();
    this.remove();
    // Backbone.history.navigate("/boards/" + boardId, { trigger: true });
  }

});
