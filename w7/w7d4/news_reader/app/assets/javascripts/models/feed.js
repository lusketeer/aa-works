NewsReader.Models.Feed = Backbone.Model.extend({
  urlRoot: "api/feeds",

  parse: function(response) {
    if(response.latest_entries) {
      var entriesData = response.latest_entries;
      this.entries().set(entriesData, {parse:true});
      delete response.latest_entries;
    }
  return response

  },

  entries: function() {
    if (!this._entries) {
      this._entries = new NewsReader.Collections.Entries([], { feed: this });
    }
    return this._entries;
  }
});
