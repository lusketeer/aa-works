JournalApp.Views.PostsIndex = Backbone.View.extend({

  initialize: function() {
    this.listenTo(this.collection,
                  "sync add change:title remove reset",
                  this.render);
  },


  template: JST['posts/index'],

  render: function() {
    var content = this.template();
    this.$el.html(content);

    var view = this;
    this.collection.each(function(post) {
      var itemView = new JournalApp.Views.PostsIndexItem({ model: post });
      view.$el.find("ul.posts").append(itemView.render().$el);
    });
    return this;
  }

});
