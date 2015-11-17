;
(function($, window, document, undefined) {
	
	"use strict";
	
	$.fn.websys.Area = function(options) {

		var components = new Array();
		var componentType = undefined;
		var componentData = undefined;

		/* COMPONENTS */

		var componentSettings = Array();
		componentSettings['square'] = {};
		componentSettings['square']['component-semaphore'] = {max : 4,scorecards : 1,sizeClass : 'col-md-6 half-height col-sm-6'};
		componentSettings['square']['component-gage'] = {max : 4,scorecards : 1,sizeClass : 'col-md-6 half-height col-sm-6'};
		componentSettings['square']['component-chartbar'] = {max : 1,scorecards : 6};
		componentSettings['square']['component-chartline'] = {max : 1,scorecards : 6};
		componentSettings['square']['component-chartpie'] = {max : 4,scorecards : 1,sizeClass : 'col-md-6 half-height col-sm-6'};
		componentSettings['square']['component-ranking'] = {max : 1,scorecards : 1};
		componentSettings['square']['component-list'] = {max : 1,scorecards : 3};
		componentSettings['square']['component-map'] = {max : 1,scorecards : 1};
		componentSettings['square']['component-mosaic'] = {max : 4,scorecards : 1, sizeClass : 'col-md-6 half-height col-sm-6'};

		componentSettings['rectangle'] = {};
		componentSettings['rectangle']['component-semaphore'] = {max : 8,scorecards : 1,sizeClass : 'half-height'};
		componentSettings['rectangle']['component-gage'] = {max : 4,scorecards : 1,sizeClass : 'col-md-3 col-sm-3'};
		componentSettings['rectangle']['component-chartbar'] = {max : 1,scorecards : 12};
		componentSettings['rectangle']['component-chartline'] = {max : 1,scorecards : 12};
		componentSettings['rectangle']['component-chartpie'] = {max : 4,scorecards : 4,sizeClass : 'col-md-3 col-sm-3'};
		componentSettings['rectangle']['component-map'] = {max : 1,scorecards : 1};
		
		componentSettings['square-up'] = componentSettings['square'];
		componentSettings['square-down'] = componentSettings['square'];

		componentSettings['square-left'] = componentSettings['square'];
		componentSettings['square-right'] = componentSettings['square'];

		componentSettings['rectangle-up'] = componentSettings['rectangle'];
		componentSettings['rectangle-down'] = componentSettings['rectangle'];

		var settings = $.extend({}, options);

		function Area(settings) {
			
			this.index = settings.index;
			this.element = settings.element;
			this.class = settings.class;
			this.position = settings.position;
			this.name = settings.name;
			this.componentsSettings = settings.components;
			
//			console.log('AREA['+ this.position +'] SETTINGS: '+ JSON.stringify(settings.components, null, 4));
		}

		Area.prototype = {
				
			createComponent: function(options){
				
				// default values + param options
				options = $.extend({componentType: this.getComponentType() , area: this}, options);
				var component = $.fn.websys.Component(options);
				
				components.push(component);

				if (options.id)
					components[options.id] = component;
				
				return component;
			},

			setComponent : function(comp, options) {
				
				var localOptions = {id: options.divId, component: comp};
				
				if(this.getComponent(options.index) == undefined)
					this.createComponent(localOptions);
				else
					this.updateComponent(comp, options);
			},
			
			updateComponent: function(component, options){
				
				var $compObj = components[options.divId] = components[options.index];
				
				$compObj.setId(options.divId);
				
				if(component != undefined)
					$compObj.setComponent(component);
				// TODO - Criar um update de options do component
			},
			
			getComponent : function(index) {
				if (!index && index != 0)
					return components;
				else
					return components[index];
			},

			resetComponent : function() {
				components = new Array();
			},

			setComponentType : function(type) {
				
				this.element.addClass(type);
				this.element.removeClass('empty');
				
				componentType = type;
			},

			getComponentType : function() {
				return componentType;
			},

			getComponentSettings : function() {
				return componentSettings[this.position][componentType];
			},

			getMaxComponents : function() {
				return this.getComponentSettings().max;
			},

			getMaxScorecard : function() {
				return this.getComponentSettings().scorecards;
			},

			getComponentSizeClass : function() {
				return this.getComponentSettings().sizeClass;
			},

			setComponentData : function(data) {
				componentData = data;
			},

			getComponentData : function() {
				return componentData;
			},

			getAreaElement : function() {
				return this.element;
			},

			getAreaBody : function() {
				return this.element.find('.panel-body');
			},

			canAcceptComponent : function(componentType) {
				return componentSettings[this.position][componentType] != undefined;
			},

			acceptableComponents : function() {

				var ac = '';
				$.each(componentSettings[this.position], function(index) {
					ac += index + ' ';
				});

				return ac;
			}

		};

		return new Area(settings);
	};

})(jQuery, window, document);
