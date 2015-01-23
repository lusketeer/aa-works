$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data('content-tabs'));
  this.$activeTab = this.$contentTabs.children(".active");
  this.$el.on("click", "a", this.clickTab.bind(this));
};

$.Tabs.prototype = {
  clickTab: function (event) {
    event.preventDefault();
    var tabs = this;
    var currentTarget = event.currentTarget;
    tabs.$activeTab.addClass("transitioning");
    tabs.$activeTab.one("transitionend webkitTransitionEnd", function(event) {
      tabs.$activeTab.removeClass("transitioning active");
      var tabId = $(currentTarget).attr("href");
      tabs.$activeTab = $(tabId).addClass("active transitioning");
      setTimeout(function(){
        tabs.$activeTab.removeClass("transitioning");
      }, 0);
    });
  }
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
