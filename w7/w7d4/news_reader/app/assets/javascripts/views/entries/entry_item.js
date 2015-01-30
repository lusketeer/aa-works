NewsReader.Views.EntryItem = Backbone.View.extend({
  template: JST["entries/entry_item"],

  tagName: "li",

  initialize: function(options) {
    this.entry = options.entry;
  },

  render: function() {
    // debugger
    var content = this.template({ entry: this.entry });
    this.$el.html(content);
    return this;
  }
});
