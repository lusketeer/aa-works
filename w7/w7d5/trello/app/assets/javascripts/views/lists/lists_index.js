TrelloClone.Views.ListsIndex = Backbone.CompositeView.extend({
  template: JST["lists/index"],

  // className: "lists-list",

  events: {
    // "sortstart" : "dragStart",
    "sortstop" : "dragStop"
  },

  initialize: function() {
    // this.listenTo(this.collection, "change", this.render);
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);

    this.collection.each(function(list) {
      var listShowView = new TrelloClone.Views.ListShow({ model: list, collection: this.collection });
      this.addSubview(".lists-list", listShowView);
      // this.$el.append(listView.render().$el);
    }, this)
    return this;
  },

  dragStop: function(event) {
    var newOrder = $(event.target).children();
    _(newOrder).each(function(listItem, index) {
      var listId = $(listItem).data("id");
      var list = this.collection.get(listId);
      list.save({ ord: index});
    }, this)
    // for (var ord = 0; ord < newOrder.length; ord++) {
    //   this.collection.get()
    // }
  }
});
