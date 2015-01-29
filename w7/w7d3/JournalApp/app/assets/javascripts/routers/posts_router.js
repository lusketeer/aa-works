JournalApp.Routers.Posts = Backbone.Router.extend({
  routes: {
    // "": "index",
    "posts/new": "new",
    "posts/:id": "show",
  },

  initialize: function() {
    this.createSidebar();
  },

  createSidebar: function(){
    this.collection = new JournalApp.Collections.Posts();
    var posts = this.collection;
    posts.fetch({
      success: function () {
        var indexView = new JournalApp.Views.PostsIndex({ collection: posts });
        $(".sidebar").html(indexView.render().$el);
      }
    });
  },

  show: function(id) {
    var router = this;
    var posts = this.collection;
    var post = this.collection.getOrFetch(id);// new JournalApp.Models.Post({ id: id });
    // post.fetch();

    var showView = new JournalApp.Views.PostShow({
      model: post,
      collection: posts
    });

    $(".content").html(showView.render().$el);
    router._swapView(showView);
  },

  new: function() {
    var posts = this.collection;
    var post = new JournalApp.Models.Post();
    var newView = new JournalApp.Views.PostForm({ model: post, collection: posts });
    $(".content").html(newView.render().$el);
    this._swapView(newView);
  },

  _swapView: function(newView) {
    if (!this._currentView) {
      this._currentView = newView;
      return;
    }
    this._currentView.remove();
    this._currentView = newView;
  }
});
