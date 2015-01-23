$.Zoomable = function(el){
  this.$el = $(el);
  this.focusBoxSize = 40;
  var zoomableObj = this;
	this.$focusBox = $('<div class="focus-box">');
	this.$focusBox.css({'height' : this.focusBoxSize, 'width' : this.focusBoxSize});
	this.$image = this.$el.children("img");
	this.$el.append(this.$focusBox);
	this.$zoomedImage = $('.zoomed-image');
	this.zoomLevel = (this.$image.height() / this.focusBoxSize) * 100;
  this.$el.on('mousemove mouseleave', function(event){
    switch (event.type) {
      case "mousemove":
        zoomableObj.showFocusBox(event);
        break;
      case "mouseleave":
        zoomableObj.removeFocusBox(event);
        break;
      default:
        console.log("Top Guns, Tom Curise is so Cute");
    }
  });
};

$.Zoomable.prototype = {
  showFocusBox : function(event) {
		var $img = this.$image;
		var offset = $img.offset();
		var left = event.clientX - this.focusBoxSize / 2;
		var top = event.clientY - this.focusBoxSize / 2;

		if (left <= offset.left) {
			left = offset.left;
		} else if (left >= offset.left + $img.width() - this.focusBoxSize) {
			left = offset.left + $img.width() - this.focusBoxSize;
		}

		if (top <= offset.top) {
			top = offset.top;
		} else if (top >= offset.top + $img.height() - this.focusBoxSize) {
			top = offset.top + $img.height() - this.focusBoxSize;
		}

		this.$focusBox.css({'display' : 'block', 'left' : left, 'top' : top });

		var xDiff = offset.left - left;
		var yDiff = offset.top - top;
		this.showZoom(xDiff, yDiff);
  },

  removeFocusBox : function() {
		this.$focusBox.css({'display' : 'none'});
  },

	showZoom : function(xDiff, yDiff) {
		this.$zoomedImage.css({
			'width' : $(window).width(),
			'height' : $(window).width(),
			'display' : 'block',
			'background-image' : "url(" + this.$image.attr('src') + ")",
			'background-size' : this.zoomLevel + "%",
			'background-position' : (xDiff * this.zoomLevel/100) + "px " + (yDiff * this.zoomLevel/100) + "px"
		});
	}
};


$.fn.zoomable = function() {
  return this.each(function(){
    new $.Zoomable(this);
  });
};
