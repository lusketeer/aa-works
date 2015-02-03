TrelloClone.Views.CardNew = Backbone.View.extend({
  template: JST["cards/form"],

  className: "new-card",

  events: {
    "submit form.new-card-form": "createCard"
  },

  initialize: function() {
    this.listenTo(this.collection, "add", this.render);
  },

  render: function() {
    var content = this.template({ card: this.model });
    this.$el.html(content);
    return this;
  },

  createCard: function(event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON();
    this.model.save(data.card, {
      success: function() {
        this.collection.add(this.model);
      }.bind(this)
    });
  }
});
