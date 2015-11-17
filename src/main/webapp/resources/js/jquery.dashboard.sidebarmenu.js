/*!
 * jQuery Sidebar Menu Controller - v0.1 - 03/06/2014
 * 
 * "wmaikon" -  Maikon Will
 */

;(function ($, window, document, undefined) {

    var pluginName = "sidebarMenu",
        defaults = {
            toggle: true
        };
        
    function Plugin(element, options) {
        this.element = element;
        this.settings = $.extend({}, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.init();
    }

    Plugin.prototype = {
        init: function () {
        	
            var $this = $(this.element),
                $toggle = this.settings.toggle;

            $this.find('a.active').next('ul').addClass('collapse in');
            $this.find('a').not('.active').next('ul').addClass('collapse');

            $this.children('a').on('click', function (e) {
                e.preventDefault();
                
                $(this).toggleClass('active').children('ul').collapse('toggle');

                if ($toggle) {
                    $(this).siblings().removeClass('active').addClass('collapsed').next('ul.in').collapse('hide');
                }
            });
        }
    };

    $.fn[ pluginName ] = function (options) {
        return this.each(function () {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName, new Plugin(this, options));
            }
        });
    };

})(jQuery, window, document);
