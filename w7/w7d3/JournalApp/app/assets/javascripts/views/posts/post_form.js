JournalApp.Views.PostForm = Backbone.View.extend({
  events: {
    "submit form": "submit"
  },

  template: JST['posts/form'],

  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  submit: function(event) {
    event.preventDefault();
    var view = this;
    var post = this.model;
    var data = $(event.currentTarget).serializeJSON();
    post.save(data, {
      success: function () {
        view.collection.add(post);
        Backbone.history.navigate("/posts/" + post.id, { trigger: true });
      },
      error: function (model, response) {
        view.$el.find(".errors").empty();

        var errors = response.responseJSON;
        errors.map(function(error) {
          var $li = $("<li>");
          $li.html(error);
          view.$el.find(".errors").append($li);
        });
      }
    })
  }

});
