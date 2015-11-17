/* Brower check old jquery */
jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();

/* Verify what kind of device it is */
var isMobile = {
    Android: function() {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
        return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
};

/* Actualy only controls dragging and scrolling events */
function touchHandler(event) {
    var self = this;
    var touches = event.changedTouches,
        first = touches[0],
        type = "";

    switch (event.type) {
    case "touchstart":
        type = "mousedown";
        window.startY = event.pageY;
        break;
    case "touchmove":
        type = "mousemove";
        break;
    case "touchend":
        type = "mouseup";
        break;
    default:
        return;
    }
    var simulatedEvent = document.createEvent("MouseEvent");
    simulatedEvent.initMouseEvent(type, true, true, window, 1, first.screenX, first.screenY, first.clientX, first.clientY, false, false, false, false, 0 /*left*/ , null);

    first.target.dispatchEvent(simulatedEvent);

    var scrollables = [];
    var clickedInScrollArea = false;
    // check if any of the parents has is-scollable class
    var parentEls = jQuery(event.target).parents().map(function() {
        try {
            if (!jQuery(this).hasClass('is-scrollable')) {
                clickedInScrollArea = true;
                // get vertical direction of touch event
                var direction = (window.startY < first.clientY) ? 'down' : 'up';
                // calculate stuff... :o)
                if (((jQuery(this).scrollTop() <= 0) && (direction === 'down')) || ((jQuery(this).height() <= jQuery(this).scrollTop()) && (direction === 'up')) ){

                } else {
                    scrollables.push(this);
                }
            }
        } catch (e) {}
    });
    // if not, prevent default to prevent bouncing
    if ((scrollables.length === 0) && (type === 'mousemove')) {
        event.preventDefault();
    }

}

function initTouchHandler() {
    document.addEventListener("touchstart", touchHandler, true);
    document.addEventListener("touchmove", touchHandler, true);
    document.addEventListener("touchend", touchHandler, true);
    document.addEventListener("touchcancel", touchHandler, true);

}