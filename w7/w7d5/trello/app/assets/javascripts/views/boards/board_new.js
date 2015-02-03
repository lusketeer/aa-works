TrelloClone.Views.BoardNew = Backbone.View.extend({
  template: JST["boards/form"],

  className: "new-board",

  events: {
    "submit form": "createBoard"
  },

  render: function() {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  },

  createBoard: function(event){
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON();
    this.model.save(data.board, {
      success: function() {
        this.collection.add(this.model);
        Backbone.history.navigate("/boards/" + this.model.id, { trigger: true });
      }.bind(this)
    })
  }
});
