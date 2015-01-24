$.InfiniteTweets = function (el) {
  this.$el = $(el);
  this.$ul = this.$el.find("#feed");
  this.maxCreatedAt = null;
  this.params = {}
  var that = this;
  this.$el.on("click", "a.fetch-more", function (event) {
    event.preventDefault();
    that.fetchTweets(event);
  });
};

$.InfiniteTweets.prototype = {
  fetchTweets: function (event) {
    var that = this;
    if (this.maxCreatedAt !== null) {
      this.params.max_created_at = this.maxCreatedAt;
    }
    $.ajax({
      url: "/feed",
      dataType: "json",
      data: this.params,
      type: "get",
      success: function(data) {
        that.insertTweets(data);
        if (data.length !== 0) {
          that.params.max_created_at = data[data.length - 1].created_at;
        }
        if (data.length < 20) {
          that.$el.find("a.fetch-more").remove();
        }
      },
      error: function(data) {

      }
    });
  },

  insertTweets: function(data) {
    var that = this;
    $(data).each(function() {
      var $li = $("<li>");
      $li.append(JSON.stringify(this));
      that.$ul.append($li);
    });
  }
};

$.fn.infiniteTweets = function () {
  return this.each(function () {
    new $.InfiniteTweets(this);
  })
};

$(function () {
  $(".infinite-tweets").infiniteTweets();
})
