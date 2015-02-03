TrelloClone.Views.CardShow = Backbone.View.extend({
  template: JST["cards/show"],

  tagName: "li",

  className: "cards-list-item",

  events: {
    "click .delete-card" : "deleteCard"
  },

  render: function() {
    var content = this.template({ card: this.model });
    this.$el.html(content);
    return this;
  },

  deleteCard: function(event) {
    event.preventDefault();
    var currentUrl = Backbone.history.fragment;
    this.collection.remove([this.model]);
    this.model.destroy();
    this.remove();
  }
});
