$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$ul = this.$el.find("ul");

  var search = this;
  this.$el.on("keyup", function(event) {
    search.handleInput(event);
  });
};

$.UsersSearch.prototype = {
  handleInput: function (event) {
    var search = this;
    var $input = search.$input;
    $.ajax({
      url: "/users/search",
      type: "get",
      dataType: "json",
      data: {query: $input.val()},
      success: function(data) {
        search.renderResults(data);
      },
      error: function(data) {
        console.log(data)
      }
    })
  },

  renderResults: function(data) {
    var $ul = this.$ul;
    $ul.empty();
    $(data).each( function () {
      var $li = $("<li>");
      var $a = $("<a>");
      $a.attr("href", "/users/" + this.id);
      $a.html(this.username);
      $li.html($a);
      var $button = $("<button class='follow-toggle'>");
      var followState = this.followed ? "followed" : "unfollowed";
      $button.followToggle({userId: this.id, followState: followState});
      $li.append($button);
      $ul.append($li);
    });
  }
};

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  })
};

$(function () {
  $(".users-search").usersSearch();
})
