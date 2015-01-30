NewsReader.Views.FeedsIndex = Backbone.View.extend({

  initialize: function() {
    this.listenTo(this.collection, "sync", this.render);
  },

  template: JST['feeds/index'],

  tagName: "ul",

  className: "feeds-index",

  render: function() {
    var content = this.template();
    this.$el.html(content);

    this.collection.each(function(feed) {
      var feedItemView = new NewsReader.Views.FeedIndexItem({ model: feed });
      this.$el.append(feedItemView.render().$el);
    }, this);
    return this;
  }

});
