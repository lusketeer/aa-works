NewsReader.Routers.Feeds = Backbone.Router.extend({
  routes: {
    "": "feedsIndex",
    "feeds/new": "feedNew",
    "feeds/:id": "feedShow",
    "feeds/:feed_id/entries/:id": "entryShow"
  },

  initialize: function() {
    this.createSidebar();
  },

  createSidebar: function() {
    if (!this._feeds) {
      this._feeds = new NewsReader.Collections.Feeds();
    }
    this._feeds.fetch({
      success: function() {
        var indexView = new NewsReader.Views.FeedsIndex({ collection: this._feeds });
        $("#sidebar").html(indexView.render().$el);
      }.bind(this)
    });
  },

  feedShow: function(id) {
    // if (!this._feeds) {
    //   this._feeds = new NewsReader.Collections.Feeds();
    // }
    var feed = this._feeds.getOrFetch(id);
    feed.fetch({
      success: function(){
        var showView = new NewsReader.Views.FeedShow({feed: feed});
        $("#content").html(showView.render().$el);
        this._swapView(showView);
      }.bind(this),
      error: function() {
        Backbone.history.navigate("/", { trigger: true });
      }
    })
  },

  entryShow: function(feed_id, id) {
    // if (!this._feeds) {
    //   this._feeds = new NewsReader.Collections.Feeds();
    // }
    var feed = this._feeds.getOrFetch(feed_id);
    feed.fetch({
      success: function(){
        var entry = feed.entries().get(id);
        var entryShowView = new NewsReader.Views.EntryShow({model: entry});
        $("#content").html(entryShowView.render().$el);
        this._swapView(entryShowView);
      }.bind(this)
    })
  },

  feedNew: function(){
    var feed = new NewsReader.Models.Feed();
    var feedNewView = new NewsReader.Views.FeedNew({ model: feed, collection: this._feeds });
    $("#content").html(feedNewView.render().$el);
    this._swapView(feedNewView);
  },

  _swapView: function(newView) {
    if(!this._currentView) {
      this._currentView = newView;
      return;
    }
    this._currentView.remove();
    this._currentView = newView;
  }
});
