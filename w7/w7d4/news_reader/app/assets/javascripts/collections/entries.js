NewsReader.Collections.Entries = Backbone.Collection.extend({
  url: function () {
    return this.feed.url() + "/entries";
  },

  // model: NewsReader.Models.Entry,

  comparator: "published_at",
  initialize: function(models, options) {
    this.feed = options.feed;
  }
});
