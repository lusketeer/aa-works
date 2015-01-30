NewsReader.Views.EntriesIndex = Backbone.View.extend({
  template: JST["entries/index"],

  tagName: "ul",
  // comparator: 'created_at',

  render: function() {
    var content = this.template();
    this.$el.html(content);

    this.collection.each(function(entry) {
      var entryItemView = new NewsReader.Views.EntryItem({ entry: entry });
      this.$el.append(entryItemView.render().$el);
    }, this);
    return this;
  }
});
