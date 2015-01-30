NewsReader.Views.FeedIndexItem = Backbone.View.extend({
  template: JST["feeds/indexFeedItem"],

  initialize: function() {
    this.listenTo(this.model, "destroy", this.removeView)
  },

  events: {"click button": "destroyFeed"},

  tagName: 'li',

  render: function() {
    var content = this.template({feed: this.model});
    this.$el.html(content);
    return this;
  },

  destroyFeed: function() {
    this.model.destroy();
  },

  removeView: function() {
    this.remove();
  }

})
