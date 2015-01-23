$.Thumbnails = function(el){
  this.$el = $(el);
  this.$images = this.$el.children(".gutter").children(".gutter-images").children();
  this.$images.css("width", "20%");
  this.$activeImg = this.$images.first();
  this.activate(this.$activeImg);
  this.gutterIdx = 0;
  this.fillGutterImages();

  var $thumbnails = this;
  this.$el.children(".gutter").on('click mouseover mouseleave', 'img', function(event) {
    var $currentImage = $(event.currentTarget);
    switch (event.type) {
      case "click":
        $thumbnails.$activeImg = $currentImage;
        $thumbnails.activate($thumbnails.$activeImg);
        break;
      case "mouseover":
        $thumbnails.activate($currentImage);
        break;
      case "mouseleave":
        $thumbnails.activate($thumbnails.$activeImg);
        break;
      default:
        console.log("Nothing special here");
    }
  });

  this.$el.on("click", "a.nav", function(event) {
    var $currentTarget = $(event.currentTarget);
    var idxDelta = $currentTarget.text() === "<" ? -1 : 1;
    if ($thumbnails.gutterIdx + idxDelta >= 0 && $thumbnails.gutterIdx + idxDelta < $thumbnails.$images.length - 4 ) {
      $thumbnails.gutterIdx += idxDelta;
      $thumbnails.fillGutterImages();
    }
  });

};



$.Thumbnails.prototype = {
  activate: function($img) {
    var src = $img.attr('src');
    $('.active').html('<img src ="' + src + '"/>');
  },

  fillGutterImages : function() {
    var $gutterImages = this.$images.slice(this.gutterIdx, this.gutterIdx + 5);
    $('.gutter-images').html($gutterImages);
  }
};

$.fn.thumbnails = function () {
  return this.each(function(){
    new $.Thumbnails(this);
  });
};
