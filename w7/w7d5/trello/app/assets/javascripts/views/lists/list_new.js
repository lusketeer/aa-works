TrelloClone.Views.ListNew = Backbone.View.extend({
  template: JST["lists/form"],

  className: "new-list",

  events: {
    "submit form.new-list-form": "createList"
  },

  render: function() {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    return this;
  },

  createList: function(event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON();
    this.model.save(data.list, {
      success: function() {
        this.collection.add(this.model);
        Backbone.history.navigate("/boards/" + this.model.get("board_id"), { trigger: true });
      }.bind(this)
    })
  }
});
