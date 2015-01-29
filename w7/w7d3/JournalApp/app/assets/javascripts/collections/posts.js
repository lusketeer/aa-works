JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: '/posts',
  model: JournalApp.Models.Post,

  getOrFetch: function (id) {
    // using this id try to get from this,
    // if that was undefined, create a new post with the id
    var model = this.get(id);
    if (!model) {
      model = new this.model({ id: id });
    }
    this.add(model);
    return model;
  }

});
