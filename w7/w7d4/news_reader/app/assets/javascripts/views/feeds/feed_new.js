NewsReader.Views.FeedNew = Backbone.View.extend({
  template: JST["feeds/form"],

  events: {
    "submit form": "createFeed"
  },

  className: "feed-new",

  render: function() {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  },

  createFeed: function(event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON().feed;
    this.model.save(data, {
      success: function() {
        this.collection.add(this.model);
        Backbone.history.navigate("/feeds", {trigger: true});
      }.bind(this),
      error: function () {
      }
    })
  }
});
