TrelloClone.Routers.Boards = Backbone.Router.extend({
  routes: {
    "": "boardsIndex",
    "boards/:id": "boardShow"
  },

  initialize: function() {
    this._boards = new TrelloClone.Collections.Boards();
    this._boards.fetch();
  },

  boardsIndex: function() {
    this._boards.fetch({
      success: function() {
        var view = new TrelloClone.Views.BoardsIndex({ collection: this._boards})
        $("#main").html(view.render().$el);
        this._swapView(view);
      }.bind(this)
    })
  },

  boardShow: function(id) {
    var board = this._boards.getOrFetch(id);
    var view = new TrelloClone.Views.BoardShow({ model: board });
    $("#main").html(view.render().$el);
    this._swapView(view);
  },

  _swapView: function(newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
  }
});
