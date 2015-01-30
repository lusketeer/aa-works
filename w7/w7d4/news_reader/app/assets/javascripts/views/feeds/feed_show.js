NewsReader.Views.FeedShow = Backbone.View.extend({
  events: {
    "click button.refresh": "refresh"
  },

  initialize: function(options) {
    this.feed = options.feed;
  },

  template: JST["feeds/show"],

  render: function() {
    var content = this.template({feed: this.feed});
    this.$el.html(content);
    var entriesView = new NewsReader.Views.EntriesIndex({collection: this.feed.entries()});
    this.$("div.entries").html(entriesView.render().$el);
    return this;
  },

  refresh: function() {
    this.feed.fetch({
      success: function(){
        console.log(this.feed.entries().length);
        this.render();
    }.bind(this)
  })
  }
})
