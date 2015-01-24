$.FollowToggle = function(el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.render();
  var button = this;
  this.$el.on("click", function (event) {
    button.handleClick (event);
    });
};

$.FollowToggle.prototype = {
  render : function() {
    var state = "";
    if (this.followState === "unfollowed") {
      state = "Follow!";
    } else if (this.followState === "followed") {
      state = "Unfollow!";
    }
    if (this.followState === "following" || this.followState === "unfollowing") {
      this.$el.prop("disabled", true);

      if (this.followState === "unfollowing") {
        state = "unfollowing!";
        this.followState = "unfollowed";
      } else if (this.followState === "following") {
        state = "following!";
        this.followState = "followed";
      }
    } else {
      this.$el.prop("disabled", false);
    }
    this.$el.html(state);
  },

  handleClick : function(event) {
    event.preventDefault();
    var button = this;
    var action = button.followState === "followed" ? "delete" : "post";
    button.followState = button.followState === "followed" ? "unfollowing" : "following";
    button.render();

    $.ajax( {
      url: "/users/" + button.userId + "/follow",
      type: action,
      dataType: "json",
      success: function (data) {
        button.render();
      },
      error: function (data) {
      }
    });
  }
};

$.fn.followToggle = function(options) {
  return this.each(function() {
    new $.FollowToggle(this, options);
  });
};

$(function() {
  $("button.follow-toggle").followToggle();
});
