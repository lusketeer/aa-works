$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$items = $('.carousel').children('.items');
  this.$items.children().eq(this.activeIdx + 1).addClass("right");
  this.$items.children().eq(this.activeIdx - 1).addClass("left");
  this.$items.children().eq(0).addClass("active");
  $('.slide-right').on('click', this.slideRight.bind(this));
  $('.slide-left').on('click', this.slideLeft.bind(this));
};

$.Carousel.prototype.slide = function(dir) {
  var $images = this.$items.children();
  var idx = this.activeIdx = (this.activeIdx + dir) % ($images.length);
  $images.removeClass("left right active");
  if(dir === 1) {
    $images.eq(idx).addClass("right");
  } else {
    $images.eq(idx).addClass("left");
  }
  $images.eq(idx).addClass("active");
  setTimeout(function(){
    $images.eq(idx).removeClass("left right");
  }, 0);
  $images.eq((idx + 1) % ($images.length)).addClass("right");
  $images.eq((idx - 1) % ($images.length)).addClass("left");
};

$.Carousel.prototype.slideLeft = function(){
  this.slide(1);
};

$.Carousel.prototype.slideRight = function(){
  this.slide(-1);
};

$.fn.carousel = function () {
  return this.each(function(){
    new $.Carousel(this);
  });
};
