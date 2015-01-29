JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  initialize: function (){
    this.listenTo(this.model, 'change', this.render);
  },

  tagName: "li",

  template: JST['posts/index_item'],

  events: {
    "click .delete": "deletePost"
  },

  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  deletePost: function(event) {
    event.preventDefault();
    this.model.destroy();
  }

});
