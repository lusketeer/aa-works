TrelloClone.Views.BoardsIndex = Backbone.View.extend({

  template: JST['boards/index'],

  events: {
    "click button.new-board": "renderNewBoardForm",
    "click button.cancel" : "renderNewBoardButton"
  },

  initialize: function() {
    this.listenTo(this.collection, "sync add remove", this.render);
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.collection.each(function(board) {
      var indexItemView = new TrelloClone.Views.BoardsIndexItem({ model: board });
      this.$(".boards-list").append(indexItemView.render().$el);
    }, this)
    return this;
  },

  renderNewBoardForm: function(event) {
    this._newBoardButton = $(event.currentTarget);
    $(event.currentTarget).remove();
    var board = new TrelloClone.Models.Board();
    var newBoardView = new TrelloClone.Views.BoardNew({ model: board, collection: this.collection });
    this.$el.append(newBoardView.render().$el);
  },

  renderNewBoardButton: function(event) {
    event.preventDefault();
    this.$(".new-board").remove();
    this.$el.append(this._newBoardButton);
  }

});
