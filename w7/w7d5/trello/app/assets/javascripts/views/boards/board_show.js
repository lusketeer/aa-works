TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["boards/show"],

  className: "board-detail",

  events: {
    "click button.new-list"           : "renderNewListForm",
    "click button.cancel.list-form"   : "renderNewListButton",
    "click button.delete-board"       : "deleteBoard"
  },

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add remove", this.render);
  },

  render: function() {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    var listsIndexView = new TrelloClone.Views.ListsIndex({ collection: this.model.lists() });
    this.addSubview(".lists", listsIndexView);
    // this.$(".lists").html(listsIndexView.render().$el);
    this.onRender();
    return this;
  },


  renderNewListForm: function(event) {
    this._newListButton = $(event.currentTarget);
    $(event.currentTarget).remove();
    var list = new TrelloClone.Models.List({ board_id: this.model.id });
    var newListView = new TrelloClone.Views.ListNew({ model: list, collection: this.model.lists() });
    this.$el.append(newListView.render().$el);
  },

  renderNewListButton: function(event) {
    event.preventDefault();
    this.$(".new-list").remove();
    this.$el.append(this._newListButton);
  },

  deleteBoard: function(event) {
    event.preventDefault();
    this.model.destroy();
    this.remove();
    Backbone.history.navigate("/", { trigger: true });
  },

  onRender: function() {
    this.$(".lists .lists-list").sortable();
    Backbone.CompositeView.prototype.onRender.call(this);
  }

});
