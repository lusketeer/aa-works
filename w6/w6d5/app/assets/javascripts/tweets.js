$.TweetCompose = function(el) {
  this.$el = $(el);
  this.$ul = $(this.$el.data("tweets-ul"));
  this.$charsLeft = this.$el.find(".chars-left");
  this.$mentionedUsers = this.$el.find(".mentioned-users");
  var form = this;
  this.$el.find("textarea").on("input", function(event) {
    var charLength = $(event.currentTarget).val().length;
    form.$charsLeft.html((140 - charLength) + " left");
  });
  this.$el.on("submit", function(event) {
    form.submit(event);
  });
  this.$el.on("click", "a.add-mentioned-user, a.remove-mentioned-user", function(event) {
    event.preventDefault();
    if ($(event.currentTarget).attr("class") === "remove-mentioned-user" ) {
      form.removeMentionUser(event);
    } else if ($(event.currentTarget).attr("class") === "add-mentioned-user") {
      form.addMentionedUser(event);
    }
  });
};


$.TweetCompose.prototype = {
  submit: function(event) {
    event.preventDefault();
    var form = this;
    var data = this.$el.serializeJSON();
    form.$el.find(":input").prop("disabled", true);


    $.ajax({
      url: form.$el.attr("action"),
      type: form.$el.attr("method"),
      dataType: "json",
      data: data,
      success: function(data) {
        form.handleSuccess(data);
      },
      error: function(data) {

      }
    });
  },

  handleSuccess: function (data) {
    var form = this;
    var $li = $("<li>");
    $li.append(data.content + " -- ");
    var $a = $("<a>");
    $a.attr("href", "/users/" + data.user_id);
    $a.html(data.user.username);
    $li.append($a);
    $li.append(" -- " + data.created_at);
    if (data.mentions.length !== 0) {
      $mentions = $("<ul>");
      data.mentions.map(function(mention) {
        var $mention = $("<li>");
        var $mentionLink = $("<a>");
        $mentionLink.attr("href", "/users/" + mention.user_id);
        $mentionLink.html(mention.user.username);
        $mention.append($mentionLink);
        $mentions.append($mention);
      });
      $li.append($mentions);
    }
    form.$ul.prepend($li);
    form.clearInput();
    form.$el.find(":input").prop("disabled", false);
  },

  clearInput: function () {
    this.$el.eq(0).trigger("reset");
    this.$mentionedUsers.empty();
  },

  addMentionedUser: function (event) {
    var $scriptTag = $("#user-list");
    this.$mentionedUsers.append($scriptTag.html());
  },

  removeMentionUser: function(event) {
    var $mention = $(event.currentTarget);
    $mention.parent().remove();
  }
};


$.fn.tweetCompose = function() {
  return this.each(function() {
    new $.TweetCompose(this);
  });
};

$(function() {
  $(".tweet-compose").tweetCompose();
});
