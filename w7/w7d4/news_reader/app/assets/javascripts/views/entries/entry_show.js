NewsReader.Views.EntryShow = Backbone.View.extend({
  template: JST["entries/show"],

  className: "entry",

  render: function() {
    var content = this.template({ entry: this.model });
    this.$el.html(content);
    return this;
  }
});
