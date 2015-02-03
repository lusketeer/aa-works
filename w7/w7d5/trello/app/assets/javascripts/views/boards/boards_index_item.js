TrelloClone.Views.BoardsIndexItem = Backbone.View.extend({
  template: JST["boards/index_item"],

  // tagName: "li",

  className: "boards-list-item",

  render: function() {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  }
});
