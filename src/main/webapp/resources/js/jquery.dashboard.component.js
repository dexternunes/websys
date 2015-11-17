;
(function($, window, document, undefined) {

	"use strict";

	$.fn.websys.Component = function(options) {

		var settings = $.extend({}, options);

		function Component(settings) {

			this.id = settings.id;
			
			this.scorecardType = new Array();			
			if($.isArray(settings.scorecardType))
				this.scorecardType = settings.scorecardType;
			
			this.component = settings.component;
			this.componentType = settings.area.getComponentType();
			this.componentTitle = settings.componentTitle;
			this.area = settings.area;			
		}

		Component.prototype = {

			getArea : function() {
				return this.area;
			},
			
			setId: function(newId){
				this.id = newId;
			},
			
			getId: function(){
				return this.id;
			},
			
			setComponent: function(component) {
				this.component = component;
			},

			getComponent : function() {
				return this.component;
			},
			
			getComponentType : function() {
				return this.componentType;
			},
			
			addScorecardType: function(scorecardTypeDropped){				
				this.scorecardType.push(scorecardTypeDropped);
			},
			
			resetAndSetScorecardType: function(scorecardTypeDropped){
				this.scorecardType = new Array();
				this.scorecardType.push(scorecardTypeDropped);
			},
			
			setScorecardSetting: function(attribute, indexScorecard, value){
				
				if(this.scorecardType[indexScorecard].scorecardSettings == undefined)
					this.scorecardType[indexScorecard].scorecardSettings = new scorecardSettings(null, null);
				
				this.scorecardType[indexScorecard].scorecardSettings[attribute] = value;
			},
			
			getScorecardType: function(){
				return this.scorecardType;
			},			
		};

		return new Component(settings);
	};

})(jQuery, window, document);