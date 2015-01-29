JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST['posts/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync change', this.render);
  },

  events: {
    "click .delete": "deletePost",
    "dblclick .editable": "editField",
    "blur .editable": "saveField"
  },

  render: function() {
    var content = this.template({ post: this.model, show: true });
    this.$el.html(content);
    return this;
  },

  deletePost: function(event) {
    event.preventDefault();
    if (window.confirm("Are you sure?")) {
      var post = this.model;
      post.destroy();
      this.collection.remove([post]);
      this.remove();
    }
  },

  editField: function(event) {
    event.preventDefault();
    var $currTarget = $(event.currentTarget);
    var value = $currTarget.text();
    var $input = $("<input>");
    $input.attr("value", value);
    $currTarget.html($input);
  },

  saveField: function(event){
    event.preventDefault();
    var view = this;
    var $currTarget = $(event.currentTarget);
    var $input = $currTarget.find("input");
    var value = $input.val();
    var attr = $currTarget.attr("name");
    this.model.set(attr, value);
    this.model.save({}, {
      success: function() {
        view.render();
      }
    });
  }

});
