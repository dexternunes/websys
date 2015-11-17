;
(function($, window, document, undefined) {
	
//	"use strict";

	$.fn.Dashboard = function(options) {

		var $WINDOW = $(window);
		var $BODY = $('body');
		
		var ID_GENERIC_MODAL = '#genericModal';
		var ATTR_ID = 'id';
		var ATTR_DIVIDER = '__';
		
		var period = 'DIARIA';
		
		var resizeTimer = 0;

		var settings = $.extend({
			appDesc : "Dashboard plugin 0.01"
		}, options);

		var appendDot = function(s, append) {
			return (append == true) ? '.' + s : s;
		};

		var classes = {
			mainContainer : function(dot) {
				return appendDot('dashboard-main-container', dot);
			},

			overlayConfigArea : function(dot) {
				return appendDot('config-area-overlay', dot);
			},

			editingConfigArea : function(dot) {
				return appendDot('editing-config', dot);
			},

			allComponentClasses : function() {
				return 'component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list component-map component-mosaic component-ranking';
			},

			allAreasClasses : function() {
				return 'square-up square-down rectangle-up rectangle-down square-left square-right';
			},

			allAreasClassesWithDots : function() {
				return '.square-up, .square-down, .rectangle-up, .rectangle-down, .square-left, .square-right';
			}
		};
		
		function Dashboard(settings) {

			this.version = settings.appDesc;
			this.setPeriod(settings.period);
			
			// View Events
			this.initViewEvents();
			
			// INITIAL LOADED DATA
			var loadedData = settings.loadedData;
			areasDTO = loadedData.areas;
			metasDTO = loadedData.metas;

			this.setLogo(loadedData.logo);
			this.setBackground(loadedData.background);
			this.setRssAddress(loadedData.rssAddress);
			
			// LOAD DE METAS
			this.loadMetas();
			
			// LOAD AREAS SETTINGS
			this.loadAreaSettings();		
			
			// init dash
			this.initAreas();
			
			// init components
			this.initComponents();
			
			// initEvents: listners to click and so on over whole the dashboard.
			if(DASHBOARD_SETUP == true)
				this.initSetupEvents();
			
			LOADING = false;
		}

		Dashboard.prototype = {
				
			/* ELEMENTS */
			getSidebar : function() {
				return $('.sidebar-nav.affix-top');
			},
			
			getRed : function(type) {
				if(type == "hexa")
					return '#dd5928';
				return 'rgb(221,89,40)';
			},

			getGreen : function(type) {
				if(type == "hexa")
					return '#349e49';
				return 'rgb(52,158,73)';
			},
			
			getYellow : function(type) {
				if(type == "hexa")
					return '#f2c118';
				return 'rgb(242,193,24)';
			},
			
			getAllAreas : function() {
				return $('.square-up, .square-down, .rectangle-up, .rectangle-down, .square-left, .square-right');
			},

			getMainContainer : function() {
				return $(classes.mainContainer(true));
			},

			getActiveAreaOnSidebar : function() {
				return $('.nav-header.active-area');
			},

			getEditingAreaOnDashboard : function() {
				return $('div[class*=square-].editing-config, div[class*=rectangle-].editing-config');
			},

			getNotEditingAreasOnDashboard : function() {
				return $('div[class*=square-], div[class*=rectangle-]').not(
						'.editing-config');
			},

			getSideBarSearcher : function() {
				return $('#ui-search > li > div > .sidebar-search');
			},

			getSideBarSearchButton : function() {
				return $('#ui-search > li > div > * > button');
			},

			getComponentsItemOnSidebar : function() {
				return $('#components');
			},

			getScorecardsItemOnSidebar : function() {
				return $('#scorecards');
			},

			getComponentsListOnSidebar : function() {
				return $('#components-list');
			},

			getScorecardsListOnSidebar : function() {
				return $('#scorecards-list');
			},
			
			getBaseFormGoalSettingsValues: function(){
				
				return $('.scorecard-goal-settings-values > form#baseFormGoalSettingsValues');
			},
			
			getPeriodControlSelectedLink: function(){
				return $('.period-controls > ul > li > a.selected-control');
			},
			
			getPeriodControlLinks: function(){
				return $('.period-controls > ul > li > a');
			},
			
			getPeriodSelectedLink: function(){
				return $('.period > ul > li > a.selected-period');
			},
			
			getPeriodLinks: function(){
				return $('.period > ul > li > a');
			},
			
			setPeriod: function(value){
				period = value;
			},
			
			getPeriod: function(){
				return period;
			},
			
			isSetupMode: function(){
				
				return DASHBOARD_SETUP;
			},
			
			setRssAddress: function(value){
				rssAddress = value;
			},
			
			getRssAddress: function(){
				return rssAddress;
			},
			
			setBackground: function(value){
				background = value;
			},
			
			getBackground: function(){
				return background;
			},
			
			setLogo: function(value){
				logo = value;
			},
			
			getLogo: function(){
				return logo;
			},
			
			setLogoAndBackgroundStyleTag: function(value){
				this.logoAndBackgroundStyleTag = value;
			},
			
			getLogoAndBackgroundStyleTag: function(){
				return this.logoAndBackgroundStyleTag;
			},
			
			getOverlaysConfigDivs: function(){
				return $(classes.overlayConfigArea(true));
			},
			
			getGoalSettingsMenu: function(){
				return $('.scorecards-goals-settings-menu > div > ul > li > ul > li');
			},
			
			getGoalSettingsForms: function(){
				return $('form[id*=goalSettings]');
			},

			resetAreas : function() {
				Dashboard.prototype.area = [];
			},
			
			isCategory: function(scorecardType){
				var possibleCategories = ['VFC', 'QFC'];
				
				return possibleCategories.indexOf(scorecardType) > -1;
			},
			
			getDashboardPrototype : function(){
				return Dashboard.prototype;
			},
			
			getComponent: function(id){
				
				if(!id) return;
				
				var component = undefined;
				for(var index = 0; index < this.area.length; index++){
					
					var $area = Dashboard.prototype.area[index];
					
					if($area.getComponent(id) != undefined)
					{
						component = $area.getComponent(id);
						break;
					}
					
				}
				
				return component;
			},
			
			getMeta: function(scorecardType, period){
				
				return this.metas[scorecardType][period];
			},
			
			configureRss: function(){
				
				var id = "rss_config";
				var title = "Configuração RSS";
				
				var $customModalBody = $('<div/>', {class: 'menu-slider-custom-bootstrap row-fluid'});
				
				var $pSPAN = $('<label/>');
				$pSPAN.html("Endereço RSS:");
				
				var $pINPUT = $('<input type="text" id="rss_adress" class="col-sm-12 col-md-12" value="'+Dashboard.prototype.getRssAddress()+'">');
				
				var $div = $('<div/>', {class: 'bs-docs-sidebar hidden-print', role: 'complementary'});					
				$div.append($pSPAN);
				$div.append($pINPUT);
				
				$customModalBody.append($div);
				
				this.createModal($customModalBody, id, title, function($modal){											
					
					Dashboard.prototype.setRssAddress($($modal).find('#rss_adress').val());					
				});
				
			},
			
			loadMetas: function(){
				this.metas = metasDTO;				
				Dashboard.prototype.metas = this.metas;
			},
			
			getToConfigureMetas: function(){
				
				var usedMetas = [];
				
				for(var indexArea = 0; indexArea < this.area.length; indexArea++)
				{
					var $areaObj = this.area[indexArea];
					
					var $componentsList = $areaObj.getComponent();
					for(var indexComponents = 0; indexComponents < $componentsList.length; indexComponents++)
					{
						var $componentObj = $areaObj.getComponent(indexComponents);
							
						var component = {};
						component.scorecard = $componentObj.getScorecardType();
						
						for(var indexScorecard = 0; indexScorecard < component.scorecard.length; indexScorecard++){
							
							var sc = component.scorecard[indexScorecard];
							usedMetas.push(sc.scorecardType);
						}
					}
				}
				
				return usedMetas;
			},
			
			getToConfigureCategories: function (){
				
				var categoriesToConfigure = {};
				
				for(var indexArea = 0; indexArea < this.area.length; indexArea++)
				{
					var $areaObj = this.area[indexArea];
					
					var $componentsList = $areaObj.getComponent();
					for(var indexComponents = 0; indexComponents < $componentsList.length; indexComponents++)
					{
						var $componentObj = $areaObj.getComponent(indexComponents);
							
						var component = {};
						component.scorecard = $componentObj.getScorecardType();
						
						for(var indexScorecard = 0; indexScorecard < component.scorecard.length; indexScorecard++){
							
							var sc = component.scorecard[indexScorecard];
							if(this.isCategory(sc.scorecardType))
							{
								if(categoriesToConfigure[sc.scorecardType] == undefined)
									categoriesToConfigure[sc.scorecardType] = [];
								
								if(sc.scorecardSettings != undefined)
									categoriesToConfigure[sc.scorecardType].push(sc.scorecardSettings.categoriaId);
							}
						}
					}
				}
				
				return categoriesToConfigure;
			},
			
			loadAreaSettings: function(){
				
				var areas = {};
				$.each(areasDTO, function(index, areaDTO){
					
					var area = areas[areaDTO.tipoArea];
					
					if(area === undefined)
						area = {};
					
					var components = {};
					$.each(areaDTO.components, function(index, componentDTO){
						
						components[index] = {componentType: componentDTO.componentType, 
											scorecardType: componentDTO.scorecard,
											componentTitle: componentDTO.componentTitle};
					});
					area.components = components;
					
					areas[areaDTO.tipoArea] = area;
				});
				this.areasSettings = areas;
			},
			
			initComponents: function() {
				
				for(var index = 0; index < this.area.length; index++){
					
					// Área
					var $area = Dashboard.prototype.area[index];
					
					// Pega as informações carregadas do banco para esta área
					var areaSettings = this.areasSettings[$area.position];
					
					if(areaSettings == undefined)
						continue;
					
					// Calcula o número de components definidos
					var componentNumbers = Dashboard.prototype.utils.objectSize(areaSettings.components);
					
					setTimeout(this.createComponent(componentNumbers, areaSettings, $area),0);

					// Salva as alterações no objeto area para a dashboard
					Dashboard.prototype.area[index] = $area;
				}
			},
			
			createComponent : function(componentNumbers, areaSettings, $area) {
				
				// Cria os componentes
				for(var compIndex = 0; compIndex < componentNumbers; compIndex++)
				{
					var componentSettings = areaSettings.components[compIndex];
					
					// Considerando que a área pode ter apenas um tipo de componente
					// o tipo de componente está na área :)
					if($area.getComponentType() == undefined)
						$area.setComponentType(componentSettings.componentType);
					
					console.log('tipo componente: '+ componentSettings.componentType);
					
					$area.createComponent({scorecardType: componentSettings.scorecardType, componentTitle: componentSettings.componentTitle});
				}

				// Adiciona o componente a esta área
				setTimeout(this.addComponent,0, $area);
			},

			/* INIT AREAS */
			initAreas : function() {
				
				this.resetAreas();

				// initialize area objects
				var areaNames = classes.allAreasClasses().split(' ');
				var dottedClasses = classes.allAreasClassesWithDots()
						.split(' ');
				
				var loadedAreaOptions = this.areasSettings;

				$.each(this.getAllAreas(), function(index, value) {
					
					// CAUTION!!! - Se posteriormente for possível mudar as posições, vai dar problema aqui :)
					var areaLocation = areaNames[index];
					
					// Informações vindas do banco de dados
					var loadedOptions = loadedAreaOptions[areaLocation];

					// Informações produzidas com informa??es da tela
					var localOptions = {
						index: index,
						element : $(value),
						name : 'Área ' + (index + 1),
						position : areaNames[index],
						class : dottedClasses[index]
					};
					
					var options = $.extend(localOptions, loadedOptions);
					
					Dashboard.prototype.area.push(new $.fn.websys.Area(options));
					Dashboard.prototype.area[areaLocation] = Dashboard.prototype.area[index];
				});

			},
			
			getComponentBuilder : function(componentType) {

				var componentFunction = Array();
				componentFunction['component-semaphore'] = this.addComponentSemaphore;
				componentFunction['component-gage'] = this.addComponentGage;
				componentFunction['component-chartbar'] = this.addComponentChartBar;
				componentFunction['component-chartline'] = this.addComponentChartLine;
				componentFunction['component-chartpie'] = this.addComponentChartPie;
				componentFunction['component-ranking'] = this.addComponentList;
				componentFunction['component-list'] = this.addComponentList;
				componentFunction['component-map'] = this.addComponentMap;
				componentFunction['component-mosaic'] = this.addComponentMosaic;

				return componentFunction[componentType];
			},
			
	        getAreaObject: function($area){
	        	
	        	var object = undefined;
	  			$.each(Dashboard.prototype.area, function( index, $areaObj ) {
	  				
	  				if($areaObj.element.is($area))
					{
	  					object = $areaObj;
	  					return false;
					}
	  			});
	        	
	  			return object;
	        },
	        
	        initViewEvents: function() {
	        	
	        	Dashboard.prototype.resizeDashboard();
	        	
	        	// Changing dashboard period
        		this.events.addEvent(this.getPeriodLinks(), 'click', this.events.onPeriodClick);
				
				// Changing dashboard period controls
        		this.events.addEvent(this.getPeriodControlLinks(), 'click', this.events.onPeriodControlClick);
				
				// Resize Dashboard
				window.onresize = function() {
					clearTimeout(resizeTimer);
					resizeTimer = setTimeout(Dashboard.prototype.resizeDashboard(), 200);
				};
				
				// Clock update
				this.events.startClockUpdate();
				
				// RSS update
				this.events.startRssReader();
			
				// Carrossel
				if(DASHBOARD_SETUP == false && this.getPeriodControlSelectedLink().attr('data-action') == 'play')				
					this.events.addTimeout(this.events.carrossel, 30000);				

	        },

			initSetupEvents : function() {
				
				/* Overlay das configs e drag and drop */
				var overlayConfigAreaClass = classes.overlayConfigArea(true);

				function showConfigOverlay() {
					$(this).find(overlayConfigAreaClass).addClass('on');
				};
				
				function hideConfigOverlay() {
					$(this).find(overlayConfigAreaClass).removeClass('on');
				};

				var $areas = this.getAllAreas();
				$areas.mouseenter(showConfigOverlay);
				$areas.mouseleave(hideConfigOverlay);
				
				var configOverlayControl = {
						start: function(){
							$areas.unbind('mouseenter');
							$areas.unbind('mouseleave');
							
							Dashboard.prototype.getEditingAreaOnDashboard().find('.config-area-overlay').removeClass('on');
							
							Dashboard.prototype.getSidebar().addClass('dragging');
						},
				
						stop: function(){
							$areas.mouseenter(showConfigOverlay);
							$areas.mouseleave(hideConfigOverlay);
							
							Dashboard.prototype.getEditingAreaOnDashboard().find('.config-area-overlay').addClass('on');
							
							Dashboard.prototype.getSidebar().removeClass('dragging');
						}
				};
				
				// Draggable components on the sidebar
				// Components
				$('ul#components-list > li[class^="component-"]').draggable({
					helper : 'clone',
					revert : 'invalid',
					appendTo : 'body',
					start: configOverlayControl.start,
					stop: configOverlayControl.stop
					
				});

				// Scorecards
				$('#scorecards-list > li').draggable({
					helper : 'clone',
					revert : 'invalid',
					appendTo : 'body',
					start: configOverlayControl.start,
					stop: configOverlayControl.stop
				});
				
				function initSetupSidebar() {
									
					var dashboard = window.Dashboard;
					
					var $sidebar = dashboard.getSidebar();
					var $parent = $(this).parent();
					var $areaObj = dashboard.getAreaObject($parent);
					var areaName = $(this).find('span.area-description').text();
					var areaIcon = "<i class='fa fa-bar-chart-o'></i>";
					var $activeAreaItem = dashboard.getActiveAreaOnSidebar();

					// Prepare droppable area
					// Needs to be called before reseting classes and so on...
					dashboard.removeActualDroppableAreaEvent();
					dashboard.createDroppableAreaEvent($parent);

					// Reset classes from editable areas
					var $areas = Dashboard.prototype.getAllAreas();
					$areas.removeClass(classes.editingConfigArea()).removeClass('not-editing');

					// Prepare SIDEBAR
					if ($activeAreaItem.text() != areaName || $sidebar.css('display') == 'none') {
						if ($sidebar.css('display') == 'block') {
							$sidebar.hide();

							// Resets the sidebar search
							dashboard.getSideBarSearcher().val('');
							dashboard.getSideBarSearchButton().click();
						}

						// Se não, deixa visível apenas os
						// componentes aceitos nesta área
						var componentsList = dashboard.getComponentsListOnSidebar();
						componentsList.find('li').hide();

						$.each($.trim($areaObj.acceptableComponents()).split(' '),	
							function(index,componentType) {
								componentsList.find('li.'+ componentType).show();
						});

						// Aplica filtro do componente em edição
						if ($areaObj.getComponentType()) {
							var scorecardsList = dashboard.getScorecardsListOnSidebar();
							scorecardsList.find('li').hide();
							scorecardsList.find('li.'+ $areaObj.getComponentType()).show();
						}

						$parent.addClass(classes.editingConfigArea());

						$activeAreaItem.text('').append(areaIcon + areaName).show();

						dashboard.toggleSidebar();

						dashboard.getNotEditingAreasOnDashboard().addClass('not-editing');

						// Closes scorecards list and open the
						// components list
						setTimeout(function() {
							if ($parent.hasClass('empty') && !dashboard.getComponentsItemOnSidebar().hasClass('active'))
								dashboard.getComponentsItemOnSidebar().trigger('click');
							else if ($areaObj.getComponentType() && !dashboard.getScorecardsItemOnSidebar().hasClass('active'))
								dashboard.getScorecardsItemOnSidebar().trigger('click');
						}, 400);
					} else {
						$sidebar.hide();
					}

				};
				
				// What happens when a config overlay is clicked
				$(overlayConfigAreaClass).click(initSetupSidebar);

				// New insensitive contains JQuery expression
				jQuery.expr[":"].containsIS = jQuery.expr.createPseudo(function(arg) {
					return function(elem) {
						return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
					};
				});

				// SEARCH
				this.getSideBarSearcher().keyup(function(event) {
					
					var _$self = Dashboard.prototype;
					var $areaObj = _$self.getAreaObject(_$self.getEditingAreaOnDashboard());
					var scorecardsList = _$self.getScorecardsListOnSidebar();

					// Enter
					if (event.keyCode == 13) {
						event.preventDefault();
					}
					// Esc
					else if(event.keyCode == 27){
						$(this).val('');
					}

					var inputVal = $(this).val();

					scorecardsList.find('li').hide();

					var query;
					if ($areaObj && $areaObj.getComponentType() != undefined)
						query = 'li.'+ $areaObj.getComponentType() + ':containsIS("' + inputVal+ '")';
					else
						query = 'li:containsIS("' + inputVal+ '")';

					scorecardsList.find(query).show();

					if (inputVal == '')
						scorecardsList.find('li'+ ($areaObj ? ($areaObj.getComponentType() != undefined ? '.'+ $areaObj.getComponentType(): '') : '')).show();
				});

				this.getSideBarSearchButton().click(function() {
					Dashboard.prototype.getSideBarSearcher().keyup();
				});

				// Events on Goals Modal Settings
				Dashboard.prototype.events.initGoalsModalEvents();
				
				
				// Preenche os forms de metas carregados do banco de dados
				this.setLoadedGoalSettings();
				
				// Save Dashboard
				$('a.dashboard-save-button').click(Dashboard.prototype.events.onDashboardSaveButtonClick);
				
				
				// device specific
				if(isMobile.any()){
				  	// Fix para ipad e iphone que não abriam no bootstram 3.1.0 a modal
					$('a[data-target]').click(function(e){
						
						var dispatcherLink = $(this).data();
						
						if(dispatcherLink.toggle == 'modal')
						{
							$(dispatcherLink.target).modal('show');
						 	e.preventDefault();
						}
						 
					});
				}
				else
				{
					// Só ativar slimscroll se não for mobile
					$('#sidebar-menu').slimScroll({
					    height: 'auto',
					    width: 'auto',
						size: '8px',
						distance: '3px',
					    alwaysVisible: false,
					    wheelStep: 10,
					    allowPageScroll: false,
					    disableFadeOut: false
					});
				}
				
				// Fix fixed position on ipad virtual keyboard close
				$(document).on('blur', 'input', function () {
				    setTimeout(function () {
				        window.scrollTo(document.body.scrollLeft, document.body.scrollTop);
				    }, 0);
				});
				
				// Fix touch events
				initTouchHandler();
			 
			},
			
			events: {
				
				/* CONTROLE DE ENVENTOS - INICIO */
				uisList: [],
				
				addEvent: function($source, eventType, callback){
					
					$source.bind(eventType, callback);
					this.uisList.push({source: $source, eventType: eventType});
				},
				
				timeoutsList: [],
				
				addTimeout: function(callback, time, param1, param2, param3, param4){
					
					var timeout = setTimeout(callback, time, param1, param2, param3, param4);
					this.timeoutsList.push({target: callback, timeout: timeout});
				},
				
				intervalsList: [],
				
				addSetInterval: function(callback, time){
					
					var interval = setInterval(callback, time);
					this.intervalsList.push({target: callback, interval: interval});
				},
				
				cleanUpEvents: function(){
					
					var uisListSize = this.uisList.length;
					
					for(var indexEvent = 0; indexEvent < uisListSize; indexEvent++)
					{
						var obj = this.uisList.shift();
						var $source = obj.source;
						var eventType = obj.eventType;
						
						$source.unbind(eventType);
					}
					
					var timeoutsListSize = this.timeoutsList.length;
					for(var indexTimeout = 0; indexTimeout < timeoutsListSize; indexTimeout++)
						clearTimeout(this.timeoutsList.shift().timeout);
					
					var intervalsListSize = this.intervalsList.length;
					for(var indexInterval = 0; indexInterval < intervalsListSize; indexInterval++)
						clearInterval(this.intervalsList.shift().interval);
				},
				/* CONTROLE DE ENVENTOS - FIM */
				
				carrossel : function() {
					
					var periodos = ["DIARIA", "SEMANAL", "MENSAL", "TRIMESTRAL", "SEMESTRAL", "ANUAL"];
					
					var idxCurrentPeriod = $.inArray(DASHBOARD_PERIOD, periodos);										
					var newPeriod = periodos[idxCurrentPeriod == 5 ? 0 : idxCurrentPeriod + 1];
					
					$('.period > ul > li > a[data-period="'+ newPeriod +'"]').click();
				},
				
				startRssReader: function(){
					
					var _Dashboard = Dashboard.prototype;
					
					_Dashboard.request.loadRss();
				},
				
				startClockUpdate: function()
			    {
					function clockUpdater(){
						
						var currentTime = new Date ( );
					    var currentHours = currentTime.getHours ( );
					    var currentMinutes = currentTime.getMinutes ( );
					    var currentSeconds = currentTime.getSeconds ( );
					    
					    // Pad the minutes and seconds with leading zeros, if required
					    currentMinutes = ( currentMinutes < 10 ? "0" : "" ) + currentMinutes;
					    currentSeconds = ( currentSeconds < 10 ? "0" : "" ) + currentSeconds;
					 
					    var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds;
					    
					    $('a[data-component-name="dashboard-clock"] > i').text(' '+ currentTimeString);
					};
					
					this.addSetInterval(clockUpdater, 1000);
			    },
			    
			    slideLista: function(component){
					
					var linhas = $("#"+component).find("tbody").find(".tdDesc");
					
					linhas.each(function(){
						
						element = $(this),
						elementPosition = element.position().left,
						elementsWidth = element.outerWidth(),
						scrollAmount = elementPosition + 2 * elementsWidth;

						$(this).animate({
							scrollLeft : scrollAmount
						}, 7000, function() {
						});
						
					});
					
				},
				
			    nextPageLista: function(component, div){
			    	var config = component.component.config;
			    	config.page = config.page + 1;
			    	config.divId = component.id;
			    	config.$div = div;
			    	
			    	$(document.getElementById(config.divId)).fadeOut(duration = "100",function() {});
			    	Dashboard.prototype.addComponentList(config, false);
			    	$(document.getElementById(config.divId)).fadeIn(duration = "100",function() {});
				},
				
				onPeriodClick: function(){
					
					var $this = $(this);					
					var _$self = Dashboard.prototype;		
					
					if(_$self.isSetupMode())
					{
						_$self.warnWindow('notice', 'Não é possível alterar o periodo em modo de edição do Painel de Indicadores.');
						return false;
					}
					
					_$self.getPeriodSelectedLink().removeClass('selected-period');
					$this.addClass('selected-period');
					
					// resets dashboard to its roots :)
					Dashboard.prototype.events.cleanUpDashboard();
					
					LOADING = true;
					
					$("#loading-period").fadeIn( "slow", function() {					
						Dashboard.prototype.loadPeriod();
					});											
														
				},
				
				onPeriodControlClick: function(){
					
					var $this = $(this);					
					var _$self = Dashboard.prototype;	
					
					if(_$self.isSetupMode())
					{
						_$self.warnWindow('notice', 'Não é possível iniciar o carrossel em modo de edição do Painel de Indicadores.');
						return false;
					}
					
					_$self.getPeriodControlLinks().removeClass('selected-control');
					$this.addClass('selected-control');
					
					if($this.attr('data-action') == 'pause')
					{
						for(var index = 0; index < _$self.events.timeoutsList.length; index++)
						{
							if(_$self.events.timeoutsList[index].target == _$self.events.carrossel)
							{
								clearTimeout(_$self.events.timeoutsList[index].timeout);
								_$self.events.timeoutsList.splice(index, 1);
								
								console.log('Carrossel parado!');
								break;
							}
						}
					}
					else
					{
						console.log('Carrossel iniciado!');
						_$self.events.addTimeout(_$self.events.carrossel , 30000);
					}
					
				},
				
				onDashboardSaveButtonClick: function(){
					
					Dashboard.prototype.loaderModal('Salvando Dashboard...');
					
					// Só para dar tempo da modal aparecer antes do travamento da tela pois é uma requisição sincrona
					setTimeout(Dashboard.prototype.request.save, 500);
				},
				
				initGoalsModalEvents: function(){
					
					var _Dashboard = Dashboard.prototype;
					
					function createCategoriesList(scorecardType){
						
						var categoriesObjects = [];
						var configuredCategories = [];
						var categories = _Dashboard.getToConfigureCategories();

						for(var indexCat = 0; indexCat < categories[scorecardType].length; indexCat++)
						{
							var categoriaId = categories[scorecardType][indexCat];
							
							// se esta categoria já não foi adicionada
							if(configuredCategories.indexOf(categoriaId) == -1)
							{
								console.log('precisa configurar: '+ categoriaId);
								var catObj = _Dashboard.request.getCategoria(categoriaId);
								categoriesObjects.push(catObj);
								configuredCategories.push(categoriaId);
							}
						}
						
						var params = {
							'data-categoria-id' : 'id',
							html : 'nome',
							classes : 'lista-categorias nav'
						};
						
						
						var $ul = _Dashboard.utils.createHtmlList(categoriesObjects, params);
						
						$ul.find('a').on( 'click', function(event) {
							
							var $a = $(this);
							
							var categoriaId = $a.attr('data-categoria-id');
							
							var formId = scorecardType + ATTR_DIVIDER + categoriaId;
							var $form = _Dashboard.getGoalSettingsValueForm(formId);
							
							if($a.parent().hasClass('active'))
							{
								$form.toggle();
								$a.parent().removeClass('active');
								$a.parent().siblings().slideDown();
							}
							else
							{
								$a.parent().siblings().slideUp();
								$a.parent().addClass('active');
								_Dashboard.events.goalModal.showValuesForm($form);
							}
							
							event.preventDefault();
							return false;
						});
						
						return $ul;
					};
					
					// Goal Settings Modal	
					// acho que dá para melhorar este selector :)
					$('.scorecards-goals-settings-menu > div > ul > li > ul > li').not('.active').click(function(){
						
						$(this).siblings().slideUp();
						
						var scorecardType = $(this).find('a').attr('data-scorecard-goal');
						var isCategory = Dashboard.prototype.isCategory(scorecardType);
						
						if(isCategory)
						{
							var $ul = $(this).find('ul');
							
							if($ul.size() == 0)
							{
								var $ul = createCategoriesList(scorecardType);
								$(this).append($ul);
								$ul.slideDown();
							}
							else
							{
								if($ul.parent().hasClass('active'))
								{
									var scorecardType = $ul.parent().find('a').attr('data-scorecard-goal');
									
									var $forms = $('.scorecard-goal-settings-values > form[id*=goalSettings__'+ scorecardType +']');
									$forms.hide();
									
									$ul.slideUp();
//									$ul.parent().siblings().slideDown();
									Dashboard.prototype.events.goalModal.hideNotUsedMetas();
									
									$ul.find('li').removeClass('active');
									$ul.parent().removeClass('active');
								}
								else
								{
									var scorecardType = $ul.parent().find('a').attr('data-scorecard-goal');
									console.log('scorecardType: '+ scorecardType);
									
									$ul.remove();
									$ul = createCategoriesList(scorecardType);
									$(this).append($ul);
									
									$ul.slideDown();
									$ul.find('li').slideDown();
									$ul.parent().addClass('active');
								}
							}
						}
						else
						{
							
							var $form = _Dashboard.getGoalSettingsValueForm(scorecardType);
							
							if($(this).hasClass('active'))
							{
								$form.hide();
								
								$(this).removeClass('active');
								Dashboard.prototype.events.goalModal.hideNotUsedMetas();
							}
							else
							{
								$(this).addClass('active');
								_Dashboard.events.goalModal.showValuesForm($form);
							}
							
							$('.scorecards-goals-settings-menu > .back-to-top').toggle();
							
							$('.scorecards-goals-settings-menu > .back-to-top').click(function(){
								
								var $lastActiveGoal = $('.scorecards-goals-settings-menu > div > ul > li > ul > li.active');
								
								$lastActiveGoal.removeClass('active');
//								$lastActiveGoal.siblings().slideDown();
								Dashboard.prototype.events.goalModal.hideNotUsedMetas();
								
								var $scorecardType = $lastActiveGoal.find('a').attr('data-scorecard-goal');
								var $form = $('.scorecard-goal-settings-values > form#goalSettings__'+ $scorecardType);
								$form.toggle();
								
								$('.scorecards-goals-settings-menu > h4').fadeIn();
								
								$(this).slideUp();
							});
						}
					});
					
				},
				
				goalModal: {
					
					showValuesForm: function($form){
						
						$('.scorecards-goals-settings-menu > h4').slideUp(500,function(){
							
							$form.find('input').mask('#.##0,00', {reverse:true, maxlength: false});
							$form.slideDown();
						});
					},
					
					hideNotUsedMetas: function(){
						
						var notHide = '.' + Dashboard.prototype.getToConfigureMetas().join(',.');
						var showList = $('.scorecards-goals-settings-menu > div > ul > li > ul').find(notHide);
						showList.slideDown();
					},
					
					clearValues: function(){
						
						var $lastActiveGoal = $('.scorecards-goals-settings-menu > div > ul > li > ul > li.active');
						var scorecardType = $lastActiveGoal.find('a').attr('data-scorecard-goal');
						var $form = Dashboard.prototype.getGoalSettingsValueForm(scorecardType);
						
						$form.find('input').val('');
					}
				},
				
				cleanUpDashboard: function(){
					
					// Reset events
					this.cleanUpEvents();
					window.websys.events.cleanUpEvents();
					
					window.Dashboard = null;
					delete window.Dashboard;
				}
			},
			
			loadPeriod : function() {
				
				var _$self = Dashboard.prototype;
				
				var newPeriodValue = _$self.getPeriodSelectedLink().attr('data-period');
				_$self.setPeriod(newPeriodValue);
				
				DASHBOARD_PERIOD = newPeriodValue;
				
				_$self.request.loadDashboard();				
			},
			
			hidePeriodLoader : function() {				
				if(!LOADING)
					$("#loading-period").fadeOut("slow");
				else
					this.events.addTimeout(Dashboard.prototype.hidePeriodLoader, 1000);
			},
			
			toggleSidebar: function(){
				
				var $sidebar = this.getSidebar();
				$sidebar.removeAttr('style');
				 
				var $sidebarLists = $sidebar.find('div.nav-collapse.subnav-collapse.collapse');
				$sidebarLists.hide();
				
				$sidebar.animate({width: 'toggle'}, 350, function(){$sidebarLists.animate({height: 'toggle'});});
			},

			resizeDashboard : function() {
				var periodBar = new Number("40");
				var bottomBar = new Number("41");
				var windowHeight = $WINDOW.height();
				var windowWidth = $WINDOW.width();

				// TODO - Qual é o tamanho minimo para executar a limitação do
				// body?
				if (windowWidth < 992) {
					// var documentHeight = $DOCUMENT.height();
					//  		        		
					// $BODY.height(documentHeight);
					// this.getMainContainer().height((documentHeight
					// - bottomBar));
				} else {
					var mainContainerHeight = windowHeight
							- (bottomBar + periodBar);
					var bodyHeight = windowHeight - bottomBar;

					this.getMainContainer().height(mainContainerHeight);
					$BODY.height(bodyHeight);
				}
			},

			dispatchResizeEvent : function() {
				$(window).trigger('resize');
			},

			removeActualDroppableAreaEvent : function() {
				this.getEditingAreaOnDashboard().droppable('destroy');
			},

			handleComponentDrop : function(self, ui) {
				
				var component = $(ui.draggable).attr('class').split(' ')[0];
				var droppedArea = $(self).attr('class').split(' ')[1];
				var $areaObj = this.area[droppedArea];
				
				// Se 'dropar' em uma área que não está em edição mas tem um componente
				if(!$areaObj.element.hasClass(classes.editingConfigArea()))
				{
					this.warnWindow('notice', 'Esta área não está em edição!', 3000);
					return;
				}

				// Se não está vazio, remove a classe do último componente que
				// estava nesta ?rea
				if (!$(self).hasClass('empty'))
					$(self).removeClass(classes.allComponentClasses(true));
				
				$(self).removeClass('empty');
				$(self).addClass(component);
				
				$areaObj.setComponentType(component);
				
				// TODO - fazer verificações necessárias aqui
				$(self).find(classes.overlayConfigArea(true)).removeClass('on');

				//var componentAdded = this.addComponent($areaObj, true);
				this.addComponent($areaObj, true);

				var scorecardsList = this.getScorecardsListOnSidebar();
				scorecardsList.find('li').hide();
				scorecardsList.find('li.' + component).show();

				// enable when finish implementation
				// if(componentAdded)
				this.getScorecardsItemOnSidebar().click();
				
			},

			createModal : function($content, id, title, callback) {

				// Element
				var $elemModal = $( ID_GENERIC_MODAL ).clone();
				$elemModal.attr( ATTR_ID , id);

				// Title
				if (title)
					$elemModal.find('.modal-header').append('<h4>' + title + '</h4>');

				// Modal Body
				var $modalBody = $elemModal.find('.modal-body');
				$modalBody.append($content);

				$BODY.append($elemModal);

				// Events
				var $modal = $elemModal.modal();
				$modal.on('hidden.bs.modal', function() {  if(callback) callback($modal); $modal.remove(); });
				
//				$modal.on('shown.bs.modal', function() {
//					var maxHeight = $WINDOW.height() / 2;
//					$(this).css('max-height', maxHeight);
//				});

			},

			buildNiveisList : function() {
				
				// pega niveis e faz a lista
				var niveisList = this.request.getNiveis();

				var params = {
					'data-numero-nivel' : 'nivel',
					html : 'nome',
					classes : 'lista-modal-nivel-categoria nav'
				};
				var $ul = this.utils.createHtmlList(niveisList, params);

				// Tamanho máximo da modal
				// TODO - criar um resizer em evento para este tipo de função
				var headerHeight = 40;
				var footerHeight = 30;

				var maxContentHeight = ($WINDOW.height() / 2)
						- (headerHeight + footerHeight);
				$ul.css('max-height', maxContentHeight);

				// Click em nivel
				$ul.find('a').on( 'click', function() {
					
					var $liParent = $(this);
					var nNivel = $liParent.attr('data-numero-nivel');

					if (!$liParent.hasClass('loaded')) {
						$liParent.addClass('loaded');
						Dashboard.prototype.loadCategoryList(nNivel, $liParent);

						// Click em categoria
						$liParent.find('ul > li > a').on( 'click',
							function(event) {
								
								var $modal = $(this).parents().closest('div[id].modal.fade.in');
								var modalId = $modal.attr('id');
								var ids = modalId.split('__');
								var componentId = ids[1];
								
								var categoriaId = $(this).attr('categoriaid');
								var $componentObj = Dashboard.prototype.getComponent(componentId);
																
								var index = 0;
								if($componentObj.getScorecardType().length > 0)
									index = $componentObj.getScorecardType().length-1;
								
								$componentObj.setScorecardSetting("categoriaId", index, categoriaId);
								
								$modal.modal('hide');
							}
						);
					} else
						$liParent.children().toggle();
				});

				return $ul;
			},

			handleScorecardDrop : function(self, ui) {
				
				var _Dashboard = Dashboard.prototype;
				
				var $scorecardObj = $(ui.draggable);
				var scorecardType = $scorecardObj.attr('class').split(' ')[0];
				var droppedComponent = $(self).attr('id');
				// var $areaObj = this.area[droppedArea];
				var $componentObj = this.getComponent(droppedComponent);	
				
				
				// Se 'dropar' em uma área que não está em edição mas tem um componente
				if(!$componentObj.area.element.hasClass(classes.editingConfigArea()))
				{
					this.warnWindow('notice', 'Esta área não está em edição!', 3000);
					return;
				}

//				this._log.debug('add scorecard: ' + scorecard);
//				this._log.debug('to component: ' + droppedComponent);

				if($scorecardObj.hasClass('open-category-modal'))
				{
					var $list = this.buildNiveisList();
					var id = scorecardType + '__' + droppedComponent;
					var title = $scorecardObj.find($('a')).text();
					
					var $customModalBody = $('<div/>', {class: 'menu-slider-custom-bootstrap row-fluid'});
					var $div = $('<div/>', {class: 'bs-docs-sidebar hidden-print', role: 'complementary'});
					
					$list.addClass('nav');
					
					var $pUL = $('<ul class="nav bs-docs-sidenav"/>');
					var $pLI = $('<li class="active"><a href="#NIVEIS">Níveis</a> </li>');
					
					$pUL.append($pLI);
					$pLI.append($list);
					
					$div.append($pUL);
					$customModalBody.append($div);
					
					this.createModal($customModalBody, id, title);
				}
				
				if($scorecardObj.hasClass('open-av-modal')){
					
					var id = scorecardType + '__' + droppedComponent;
					var title = $scorecardObj.find($('a')).text();
					
					var $customModalBody = $('<div/>', {class: 'menu-slider-custom-bootstrap row-fluid'});
					
					var $pSPAN = $('<span/>');
					$pSPAN.html("Definição do Tipo de AV para o componente:");
					
					var $pUL = $('<ul class="nav bs-docs-sidenav"/>');
					
					var $pLI = $('<li class="active"><input type="radio" id="AV_'+droppedComponent+'_QF" name="AV_'+droppedComponent+'" value="QF"> <label for="AV_'+droppedComponent+'_QF">Quantidade Faturada</label></li>');
					$pUL.append($pLI);
					
					var $pLI = $('<li class="active"><input type="radio" id="AV_'+droppedComponent+'_VF" name="AV_'+droppedComponent+'" value="VF"> <label for="AV_'+droppedComponent+'_VF">Valor Faturado</label></li>');
					$pUL.append($pLI);					
					
					var $div = $('<div/>', {class: 'bs-docs-sidebar hidden-print', role: 'complementary'});					
					$div.append($pSPAN);
					$div.append($pUL);
					
					$customModalBody.append($div);
					
					this.createModal($customModalBody, id, title, function($modal){						
						var $componentObj = Dashboard.prototype.getComponent(droppedComponent);
						if($($modal).find('#AV_'+droppedComponent+"_QF").is(':checked')) {
							$componentObj.setScorecardSetting("tipoAnaliseVertical", 0, "QUANTIDADE");
						}
						else {
							$componentObj.setScorecardSetting("tipoAnaliseVertical", 0, "VALOR");							
						}
					});
				}
				
//				this._log.debug('Contexto no componente: ', $componentObj);
				
				var componentTitle = this.utils.justGetMyTitle(scorecardType);
				var componentTitleSafe = this.utils.justGetMyTitle(scorecardType, true);
				
				// fazer update do title
				// fazer update do valor fake
				// tudo isso já no setScorecardType
				if($componentObj.getComponentType() == 'component-gage')
				{
					$componentObj.resetAndSetScorecardType(new scorecard(scorecardType, undefined));		
					
					$componentObj.component = _Dashboard.component.gauge.reload($componentObj.component, getRandomInt(0, 100), componentTitleSafe);
				}
				else if($componentObj.getComponentType() == 'component-chartpie')
				{
					$componentObj.resetAndSetScorecardType(new scorecard(scorecardType, undefined));
					
					var plot = $componentObj.component;
					
					var data = [{ label : componentTitleSafe, color : "#4A98BE", data : 65.7 }, { label : "Não atingido", color : "#D2D2D2", data : 34.3 }];
					$componentObj.component = $.plot(plot.getPlaceholder(), data, plot.getOptions());
					
					console.log('data: ');
					console.log(data);
					
				}
				else if($componentObj.getComponentType() == 'component-chartbar')
				{
					$componentObj.addScorecardType(new scorecard(scorecardType, undefined));
					
					var current = $componentObj.component.options.data.pop();					
					if(current.x != "Não Definido")
						$componentObj.component.options.data.push(current);					
					$componentObj.component.options.data.push({x: componentTitle, y: getRandomInt(0, 100)});					
					$componentObj.component = _Dashboard.component.chartBar.reload($componentObj, componentTitle);				
				}
				else if($componentObj.getComponentType() == 'component-chartline')
				{					
					$componentObj.addScorecardType(new scorecard(scorecardType, undefined));
					
					$componentObj.component.options.data.push({x: componentTitleSafe, y: getRandomInt(0, 100)});					
					$componentObj.component = _Dashboard.component.chartLine.reload($componentObj, componentTitle);		
				}
				else if($componentObj.getComponentType() == 'component-semaphore')
				{	 
					$componentObj.resetAndSetScorecardType(new scorecard(scorecardType, undefined));
					
					var data = {value: getRandomInt(0, 100) + '%', label: componentTitle};
					$componentObj.component = _Dashboard.component.semaphore.reload($componentObj, data, componentTitle);				
				}
				else if($componentObj.getComponentType() == 'component-ranking'){				
					
					$componentObj.resetAndSetScorecardType(new scorecard(scorecardType, undefined));
					
					var columnsTitle = [ '', 'Qtde Fat', 'Vlr Fat' ];
					var tableData = [ [ 'Item A', '1500', 'R$ 16.500,00' ], [ 'Item B', '1300', 'R$ 14.300,00'] ];
					if(scorecardType != 'RP'){					
						columnsTitle.push('AV%');
						$(tableData).each(function(index, value){
							tableData[index].push(getRandomInt(0, 100) + '%');
						});
					}

					var data = {
						title : componentTitle,
						iconClass : 'fa fa-bar-chart-o',
						columnsTitle : columnsTitle,
						tableData : tableData,
						isRanking : true
					};
					
					$componentObj.component = _Dashboard.component.lista.reload($componentObj, data);
				}
				else if($componentObj.getComponentType() == 'component-list'){				
					
					$componentObj.addScorecardType(new scorecard(scorecardType, undefined));
					
					var current = $componentObj.component.config.columnsTitle.pop();	
					var replaced = (current == "Indicador A");
					if(!replaced) 
						$componentObj.component.config.columnsTitle.push(current);																
					$componentObj.component.config.columnsTitle.push(componentTitleSafe);					
								
					if(!replaced) {
						$($componentObj.component.config.tableData).each(function(index, value){
							value.push('999');
						});
					}
					
					var columnsTitle = $componentObj.component.config.columnsTitle;
					var tableData = $componentObj.component.config.tableData;
					
					var data = {
						title : "Listagem por Entidade",
						iconClass : 'fa fa-bar-chart-o',
						columnsTitle : columnsTitle,
						tableData : tableData,
						isRanking : false
					};
					
					$componentObj.component = _Dashboard.component.lista.reload($componentObj, data);
				}
				else if($componentObj.getComponentType() == 'component-map')
				{
					$componentObj.resetAndSetScorecardType(new scorecard(scorecardType, undefined));
					
					_Dashboard.component.map.reload($componentObj, undefined, componentTitle);	
				}
				else if($componentObj.getComponentType() == 'component-mosaic')
				{
					for(var index = 0; index < $componentObj.area.getComponent().length; index++){
						$componentObj.area.getComponent(index).resetAndSetScorecardType(new scorecard(scorecardType, undefined));
					}
				}
				
				_Dashboard.warnWindow('success', 'Indicador "'+ componentTitle + '" adicionado ao componente com sucesso!');
			},

			utils : {

				createHtmlList : function(list, params) {

					var $ul = $('<ul/>');

					if (params.classes != undefined)
						$ul.addClass(params.classes);

					$.each( list, function(index, obj) {
						var objProperties = {};
						for ( var propertyName in params) {
							
							// console.log('objeto['+propertyName +']: '+ obj[params[propertyName]]);
							objProperties[propertyName] = obj[params[propertyName]];
						}

						$li = $('<li/>');
						$li.append( $('<a />', objProperties) );
						$ul.append($li);
					});

					return $ul;
				},

				objectSize : function(obj) {
					var size = 0, key = '';
					for (key in obj) {
						if (obj.hasOwnProperty(key))
							size++;
					}
					return size;
				},
				
				
				justGetMyTitle: function(scorecardType, safe){
					
					var scorecardTypes = Array();
					scorecardTypes['VF'] = 'Valor Faturado';
					scorecardTypes['QF'] = 'Quantidade Faturada';
					scorecardTypes['VFC'] = 'Valor Faturado por Categoria';
					scorecardTypes['QFC'] = 'Qtde Faturada por Categoria';
					scorecardTypes['QA'] = 'Qtde de Atendimentos';
					scorecardTypes['QV'] = 'Quantidade de Vendas';
					scorecardTypes['PA'] = 'Peças por Atendimento';
					scorecardTypes['TM'] = 'Ticket Médio';
					scorecardTypes['CMV'] = 'Custo da Mercadoria Vendida';
					scorecardTypes['MG'] = 'Margem';
					scorecardTypes['MG_P'] = 'Margem %';
					scorecardTypes['QE'] = 'Quantidade em Estoque';
					scorecardTypes['QEC'] = 'Qtde em Estoque a Preço de Custo';
					scorecardTypes['QEV'] = 'Qtde em Estoque a Preço de Venda';
					scorecardTypes['VFV'] = 'Valor Faturado a Vista';
					scorecardTypes['VFP'] = 'Valor Faturado a Prazo';
					scorecardTypes['FV_P'] = '% Faturado a Vista';
					scorecardTypes['FP_P'] = '% Faturado a Prazo';
					scorecardTypes['RR'] = 'Ranking de Região';
					scorecardTypes['RL'] = 'Ranking de Lojas';
					scorecardTypes['RV'] = 'Ranking de Vendedores';
					scorecardTypes['RP'] = 'Ranking de Produtos';
					
					if(safe)
						return scorecardTypes[scorecardType].replace("Valor", "Vlr").replace("Quantidade", "Qtde").replace("Faturado", "Fat").replace("Faturada", "Fat").replace("Categoria", "Cat");
					else
						return scorecardTypes[scorecardType];
				},
				
				getRankingIcon: function(scorecardType){
					
					var scorecardTypes = Array();
					scorecardTypes['RR'] = 'fa fa-map-marker';
					scorecardTypes['RL'] = 'fa fa-home';
					scorecardTypes['RV'] = 'fa fa-users';
					scorecardTypes['RP'] = 'fa fa-shopping-cart';					
					
					return scorecardTypes[scorecardType];
					
				},
				
				getRankingItemTitle: function(scorecardType){
					
					var scorecardTypes = Array();
					scorecardTypes['RR'] = 'Região';
					scorecardTypes['RL'] = 'Loja';
					scorecardTypes['RV'] = 'Vendedor';
					scorecardTypes['RP'] = 'Produto';					
					
					return scorecardTypes[scorecardType];
					
				},
				
				getScorecardUnitInList: function(scorecardType){
					
					var scorecardTypes = Array();
					scorecardTypes['VF'] = 'CURRENCY';
					scorecardTypes['QF'] = 'UN';
					scorecardTypes['VFC'] = 'CURRENCY';
					scorecardTypes['QFC'] = 'UN';
					scorecardTypes['QA'] = 'UN';
					scorecardTypes['QV'] = 'UN';
					scorecardTypes['PA'] = 'UN';
					scorecardTypes['TM'] = 'CURRENCY';
					scorecardTypes['CMV'] = 'CURRENCY';
					scorecardTypes['MG'] = 'UN';
					scorecardTypes['MG_P'] = 'PERCENT';
					scorecardTypes['QE'] = 'UN';
					scorecardTypes['QEC'] = 'UN';
					scorecardTypes['QEV'] = 'UN';
					scorecardTypes['VFV'] = 'CURRENCY';
					scorecardTypes['VFP'] = 'CURRENCY';
					scorecardTypes['FV_P'] = 'PERCENT';
					scorecardTypes['FP_P'] = 'PERCENT';					
					
					return scorecardTypes[scorecardType];
				},
				
				getMetaColor: function(scoredValue){
					
			    	if(scoredValue < 79.5)
			    		return Dashboard.prototype.getRed('hexa');
			    	else if(scoredValue < 99.5)
			    		return Dashboard.prototype.getYellow('hexa');
			    	else 
			    		return Dashboard.prototype.getGreen('hexa');
				},
			},

			loadCategoryList : function(nNivel, $parent) {

				var categoriasList = this.request.getCategoriasByNivel(nNivel);

				var params = {
					categoriaid : 'id',
					html : 'nome'
				};
				var $ul = this.utils.createHtmlList(categoriasList, params);

				$parent.append($ul);
			},

			createDroppableAreaEvent : function($area) {

				function isComponent(ui) {
					return $(ui.draggable).parent().is(
							Dashboard.prototype.getComponentsListOnSidebar());
				};

				$area.droppable({
					accept : 'li',
					drop : function(event, ui) {

						if (isComponent(ui))
							Dashboard.prototype.handleComponentDrop(this, ui);
					}
				});
			},

			createDroppableComponentEvent : function($componentDiv) {

				function isComponent(ui) {
					return $(ui.draggable).parent().is(
							Dashboard.prototype.getComponentsListOnSidebar());
				}

				$componentDiv.droppable({
					accept : 'li',
					drop : function(event, ui) {

						if (!isComponent(ui))
							Dashboard.prototype.handleScorecardDrop(this, ui);
					}
				});

			},

			cleanAreaContents : function($areaBody) {
				$areaBody.siblings().remove();				
				$areaBody.html('');
			},

			setDefaultOptions : function(options, componentType) {

				var settings = new Array();
				if (componentType == 'component-gage') {
					// mock
					settings[0] = { title : "Não Definido",  min : 0, max : 100, value : getRandomInt(0, 100), symbol : "%" };
					settings[1] = { title : "Não Definido",  min : 0, max : 100, value : getRandomInt(0, 100), symbol : "%" };
					settings[2] = { title : "Não Definido",  min : 0, max : 100, value : getRandomInt(0, 100), symbol : "%" };
					settings[3] = { title : "Não Definido",  min : 0, max : 100, value : getRandomInt(0, 100), symbol : "%" };
				
				} else if (componentType == 'component-semaphore') {
					
					if(options.$areaObj.position.indexOf('rectangle') > -1)
					{
						//rectangle
						 settings[0] = {icon: 'fa fa-bar-chart-o', size: 3, status: 'red', value: '0%', label: 'Não Definido'};
						 settings[1] = {icon: 'fa fa-bar-chart-o', size: 3, status: 'yellow', value: '0%', label: 'Não Definido'};
						 settings[2] = {icon: 'fa fa-bar-chart-o', size: 3, status: 'green', value: '0%', label: 'Não Definido'};
						 settings[3] = {icon: 'fa fa-bar-chart-o', size: 3, status: 'yellow', value: '0%', label: 'Não Definido'};
						 settings[4] = {icon: 'fa fa-bar-chart-o', size: 3, status: 'yellow', value: '0%', label: 'Não Definido'};
						 settings[5] = {icon: 'fa fa-bar-chart-o', size: 3, status: 'green', value: '0%', label: 'Não Definido'};
						 settings[6] = {icon: 'fa fa-bar-chart-o', size: 3, status: 'red', value: '0%', label: 'Não Definido'}; 
						 settings[7] = {icon: 'fa fa-bar-chart-o', size: 3, status: 'green', value: '0%', label: 'Não Definido'};
					}
					else
					{
						// square
						settings[0] = { icon : 'fa fa-bar-chart-o', size : 6, status : 'red', value : '0%', label: 'Não Definido' };
						settings[1] = { icon : 'fa fa-bar-chart-o', size : 6, status : 'yellow', value : '0%', label: 'Não Definido' };
						settings[2] = { icon : 'fa fa-bar-chart-o', size : 6, status : 'green', value : '0%', label: 'Não Definido' };
						settings[3] = { icon : 'fa fa-bar-chart-o', size : 6, status : 'green', value : '0%', label: 'Não Definido' };
					}
				
				} else if (componentType == 'component-chartbar') {
										
					// Mock
					//Não mudar essas labels - são usadas no drop de scorecard
					data = [ { x : 'Não Definido', y : 75}];

					settings = new Array();
					settings[0] = { data : data, xkey : 'x', ykeys : [ 'y' ], labels : [ 'Atingido', 'Não Atingido' ] };
				
				} else if (componentType == 'component-chartline') {
					
					// Mock
					data = [ { x : 'Não Definido', y : 0 } ];

					settings = new Array();
					settings[0] = { data : data, xkey : 'x', ykeys : [ 'y' ], labels : [ 'Total Meta' ] };
					settings[1] = { data : data, xkey : 'x', ykeys : [ 'y' ], labels : [ 'Total Meta' ] };
				
				} else if (componentType == 'component-chartpie') {
					
					var data = [ { label : "Não Definido", color : "#4A98BE", data : 65}, { label : "Não Atingido", color : "#D2D2D2", data : 35} ];
					
					function labelFormatter(label, series) {
				        return "<div style='font-size:8pt; text-align:center; padding:2px; color:#555;'>" + label + "<br/>" + Math.round(series.percent) + "%</div>";
					};
					var op = {series : { pie : {show : true, radius: 1, label: { show: true, radius: 2/4, formatter: labelFormatter, background: { opacity: 0 } } } }, legend: {show: false} };

					settings = new Array();
					settings[0] = { values : data, options : op };
					settings[1] = { values : data, options : op };
					settings[2] = { values : data, options : op };
					settings[3] = { values : data, options : op};
				
				} else if (componentType == 'component-map') {
					
					//http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=A|39b54a
					var locations = [ {
						lat : -26.304444,
						lon : -48.845556,
						title : 'Joinville',
						html : '<h4>Joinville, Brasil</h4> <br /> Valor Faturado: 99%',
						icon : 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=A|39b54a',
						
						address: 'Joinville, BR'
					}];

					settings = new Array();
					settings[0] = { locations : locations  };
					
				} else if (componentType == 'component-list') {
					
					//Não mudar essas labels - são usadas no drop de scorecard
					var columnsTitle = [ 'Entidade', 'Indicador A' ];
					var data = [ [ 'Item A', '999' ], [ 'Item B', '999' ] ];

					settings[0] = { iconClass : 'fa fa-bar-chart-o', title : 'Listagem por Entidade', columnsTitle : columnsTitle, tableData : data, isRanking : false};
					
				} else if (componentType == 'component-ranking') {
					
					var columnsTitle = [ '', 'Qtde Fat', 'Vlr Fat', 'AV%' ];
					var data = [ [ 'Item A', '1500', 'R$ 16.500,00', '60%' ], [ 'Item B', '1300', 'R$ 14.300,00', '40%' ] ];

					settings[0] = { iconClass : 'fa fa-bar-chart-o', title : 'Ranking', columnsTitle : columnsTitle, tableData : data, isRanking : true};
				}
				
				else if (componentType == 'component-mosaic')
				{
					// square
					settings[0] = {size : 6, value : '1', label: 'Não Definido', img: 'resources/images/img_not_found.gif' };
					settings[1] = {size : 6, value : '2', label: 'Não Definido', img: 'resources/images/img_not_found.gif'};
					settings[2] = {size : 6, value : '3', label: 'Não Definido', img: 'resources/images/img_not_found.gif' };
					settings[3] = {size : 6, value : '4', label: 'Não Definido', img: 'resources/images/img_not_found.gif' };
//					settings[3] = {size : 6, value : '4', label: 'Não Definido', img: 'http://joaocarlos.net.br/wp-content/uploads/2012/03/legal.png' };
				
				}

				options = $.extend(options, { data : settings });
			},
			
			component: {
				
				createAreaHeader: function(settings){
					
					// Header
					var $panel = settings.$area.find('.panel');
					$panel.find('.panel-head-icon').remove();
					$panel.find('.panel-heading').remove();
					
					var $panelHeadIcon = $('<div/>', {
						class : 'panel-head-icon',
						html : '<i class="'+ settings.iconClass +'"></i>'
					});
					
					var $panelHeading = $('<div/>', {
						class : 'panel-heading',
						html : '<span>'+ settings.headerTitle +'</span>'
					});

					$panel.prepend($panelHeadIcon);
					$panelHeading.insertAfter($panelHeadIcon);
				},
				
				gauge: {
					
					reload: function reload(gid, gaugevalue, gaugetitle) {
				        var id = gid.config.id;
				        var title = (gaugetitle == undefined ) ? gid.config.title : gaugetitle;
				        var label = gid.config.label;
				        var donut = gid.config.donut;
				        var symbol = gid.config.symbol;
				        var showMinMax = gid.config.showMinMax;
				        var min = gid.config.min;
				        var max = gid.config.max;
				        var customSectors = gid.config.customSectors;
			
				        var notNumber = isNaN(gaugevalue);
			
				        if (notNumber) {
				          alert("Please enter integer or float value!");
				          return false;
				        }
			
				        $('#' + id).empty();
				        gid = "";
				        gid = new JustGage({
				          id: id,
				          value: gaugevalue,
				          relativeGaugeSize : true,
				          symbol: '%',
				          min: min,
				          max: max,
				          showMinMax : showMinMax ,
				          title: title,
				          label: label,
				          donut: donut,
				          customSectors: customSectors,
				        });
				        
				        // fix - cria segunda linha na mão
				        $label = $(gid.canvas.canvas).find('text').first();
				        var labels = $label.find('tspan').text().split(' - ');
				        
				        $label.find('tspan').text(labels[0]);
				        
				        if(labels.length == 2)
			        	{
					        var $line2  = $label.find('tspan').clone();
					        $line2.attr('dy', 17);
					        $line2.attr('x', 100);
					        $line2.text(labels[1]);
					        $line2.css('font-size', '0.90em');
					        
					        $label.append($line2);
			        	}
						
				        return gid;
					},
			
				},
				
				semaphore : {
					
					reload: function(gid, data) {
								
						var id = gid.getId();				        
				        var status = gid.component.config.status;
				        var icon = gid.component.config.icon;
				        var size = gid.component.config.size;
				        var value = data.value;
				        var label = data.label;
						
						var l = new Semaphore({
							id : id,
							status : status,
							icon : icon,
							size : size,
							value : value,
							label : label
						});
						
						return l;						
					}					
				},
				
				lista : {
					
					reload: function(gid, data){
						
						var l = new Lista({
							id : gid.getId(),
							title : data.title,
							iconClass : data.iconClass,
							columnsTitle : data.columnsTitle,
							tableData : data.tableData, 
							isRanking : data.isRanking
						}, 1);

						return l;						
					}					
				},
				
				chartBar : {
					
					reload: function reload(gid, chartData, chartTitle) {
				    
						var id = gid.getId();				        
				        var data = gid.component.options.data;
				        var xkey = gid.component.options.xkey;
				        var ykeys = gid.component.options.ykeys;
				        var labels = gid.component.options.labels;
			
						$('#' + id).empty();
				        gid.component = "";
						var gid = Morris.Bar({
							element : id,
							data : data,
							xkey : xkey,
							ykeys : ykeys,
							labels : labels,
							hideHover : 'auto',
							resize : true,
							barColors: function (row, series, type) {
							    if (type === 'bar') {
							    	if(row.y < 79.5)
							    		return Dashboard.prototype.getRed('rgb');
							    	else if(row.y < 99.5)
							    		return Dashboard.prototype.getYellow('rgb');
							    	else 
							    		return Dashboard.prototype.getGreen('rgb');
							    }
							    else {
							      return '#000';
							    }
							}
						});
										       
				        return gid;
					}, 
				},
				
				chartLine : {
					
					reload: function reload($compObj, chartData, chartTitle) {
				    
						var compOptions = $compObj.component.options;
						var id = $compObj.getId();				        
				        var data = compOptions.data;
				        var xkey = compOptions.xkey;
				        var ykeys = compOptions.ykeys;
				        var labels = compOptions.labels;
			
						$('#' + id).empty();
						$compObj.component = "";
						var gid = Morris.Line({
							element : id,
							data : data,
							xkey : xkey,
							ykeys : ykeys,
							labels : labels,
							hideHover : 'auto',
							resize : true
						});
										       
				        return gid;
					}, 					
				},
				
				map : {
					reload: function($compObj){
						
						var $componentJS  = $compObj.component;
						
						var location = {
								lat : -26.304444,
								lon : -48.845556,
								title : 'Não Carregado',
								html : '<h4>Não Carregado</h4>Para visualizar valores, salve e vá para o modo visualização.',
								icon : 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=A|39b54a',
							};
						
						$componentJS.AddLocation(location);
						$componentJS.Load();
					},
					
					getProximityFroMmap: function (map) {
					    // http://stackoverflow.com/questions/3525670/radius-of-viewable-region-in-google-maps-v3
					    // Get Gmap radius / proximity start
					    // First, determine the map bounds
					    var bounds = map.getBounds();
	
					    
					    if(bounds == undefined)
					    	return 1;
					    
					    // Then the points
					    var swPoint = bounds.getSouthWest();
					    var nePoint = bounds.getNorthEast();
	
					    // Now, each individual coordinate
	//				    var swLat = swPoint.lat();
	//				    var swLng = swPoint.lng();
	//				    var neLat = nePoint.lat();
	//				    var neLng = nePoint.lng();
	
					    var proximitymeter = google.maps.geometry.spherical.computeDistanceBetween(swPoint, nePoint);
					    var proximitymiles = proximitymeter * 0.000621371192;
					    console.log("Proxmity " + proximitymiles + " miles");
					    console.log("Proxmity " + proximitymeter/1000 + " kilometers");
					    
					    return  (proximitymeter/ 1000); //km
					},
					
				},
				
			},
			
			addComponent : function($areaObj, resetArea, onlyFakeData) {
				
				var _$self = this;
				
				// Se estiver chamando fora do contexto, pegar da window
				if(_$self.getComponentBuilder == undefined)
					_$self = window.Dashboard;
				
				if(resetArea)
					$areaObj.resetComponent();
				
				var componentType = $areaObj.getComponentType();
				
				var builder = _$self.getComponentBuilder(componentType);

				if (!builder) {
					console.info('Handler para o componente especificado não encontrado.');
					return false;
				}

				// Base options
				var options = {
					$areaObj : $areaObj,
					$area : $areaObj.getAreaElement(),
					$areaBody : $areaObj.getAreaBody()
				};

				console.time("cleanArea");
				_$self.cleanAreaContents(options.$areaBody);
				console.timeEnd("cleanArea");

				var limit = $areaObj.getMaxComponents();
				
				for (var index = 0; index < limit; index++) {
					
					var options = {
						$areaObj : $areaObj,
						$area : $areaObj.getAreaElement(),
						$areaBody : $areaObj.getAreaBody()
					};
					
					// Its index on this area
					options.index = index;
					
					// DivId
					options.divId = componentType + getRandomInt(0, 9999);
					
					// Div builder
					options.$div = $('<div/>', {
						id : options.divId,
						index : options.index,
						class : $areaObj.getComponentSizeClass()
					}).appendTo( $areaObj.getAreaBody() );
					
					_$self.setDefaultOptions(options, componentType);
					
					// load data from database
					if($areaObj.getComponent(index) != undefined)
					{
						var $compObj = $areaObj.getComponent(index);
						
						var period = _$self.getPeriod();
						var scorecards = $compObj.getScorecardType();						
					
						new AsyncLoader({						
							scorecards : scorecards,
							period : period,
							componentOptions : options,
							areaObj : $areaObj,
							builder : builder,
							componentType : componentType,
							buildOptions : _$self.buildOptions,
							indexFakeData : index,
						});					
					}
					else
					{
						
						_$self.setDefaultOptions(options, componentType);
						
						// fake data
						options = $.extend(options, options.data[index]);
						
						// component settings
						$areaObj.setComponent(builder(options), options);
					}
				}				

			},
			
			buildOptions: {
				
				toLine: function(baseOptions, loadedData){
					
					if(loadedData != undefined)
					{
						dataScoreCard = new Array();
						
						for(var loadedIdx = 0; loadedIdx < loadedData.length; loadedIdx++){							
							var computedValue = Dashboard.prototype.math.toFixed2(loadedData[loadedIdx].valor);
							
							var component = baseOptions.$areaObj.getComponent(baseOptions.index);
							var st = component.scorecardType[loadedIdx];
							
							var title = Dashboard.prototype.utils.justGetMyTitle(loadedData[loadedIdx].tipoIndicador, true);
							
							if(Dashboard.prototype.isCategory(st.scorecardType))
							{
								var catObj = Dashboard.prototype.request.getCategoria(st.scorecardSettings.categoriaId);
								title = title + '\n'+ catObj.nome;
							}
							
							dataScoreCard.push({x: title, y: computedValue});				
						}
						
						localOptions = {
								data: dataScoreCard,
								xkey: 'x',
								ykeys: ['y'],
								labels: ['Total Meta']
						};
						
						return $.extend(baseOptions, localOptions);
					}
					
					return $.extend(baseOptions, loadedData);					
				},
				
				toMap: function(baseOptions, loadedData, geometry){

					if(loadedData != undefined)
						return $.extend(baseOptions, loadedData[0]);
					
					return null;
					
				},
				
				toGage: function(baseOptions, loadedData){
					
					if(loadedData[0] != undefined)
					{
						var component = baseOptions.$areaObj.getComponent(baseOptions.index);
						var st = component.scorecardType[0];
						
						var title = Dashboard.prototype.utils.justGetMyTitle(st.scorecardType, true);
						
						if(Dashboard.prototype.isCategory(st.scorecardType))
						{
							var catObj = Dashboard.prototype.request.getCategoria(st.scorecardSettings.categoriaId);
							title = title + ' - '+ catObj.nome;
						}
						
						var localOptions = {
								title : title,
								min : 0,
								max : 180,
								symbol : '%',
								value : loadedData[0].valor,
								levelColorsGradient: false
							};
						
						return $.extend(baseOptions, localOptions);
					}
				},
				
				toPie: function(baseOptions, loadedData){
					
					if(loadedData[0] != undefined)
					{
						
						var component = baseOptions.$areaObj.getComponent(baseOptions.index);
						var st = component.scorecardType[0];
						
						var title = Dashboard.prototype.utils.justGetMyTitle(st.scorecardType, true);
						
						if(Dashboard.prototype.isCategory(st.scorecardType))
						{
							var catObj = Dashboard.prototype.request.getCategoria(st.scorecardSettings.categoriaId);
							title = title + '<br />'+ catObj.nome;
						}
						
						var computedValue = Dashboard.prototype.math.toFixed2(loadedData[0].valor);
						var resto = Dashboard.prototype.math.toFixed2(100 - computedValue);
						
						console.log('computedValue: '+ computedValue);
						
						var levelColors = [ Dashboard.prototype.getGreen('hexa'), Dashboard.prototype.getYellow('hexa'), Dashboard.prototype.getRed('hexa')];
						
						var data = [];
						if(resto < 0)
						{
							data.push({
								label : title,
								color : levelColors[0],
								data : computedValue
							});
						}
						else
						{							
							data = [ {
								label : title,
								color : (computedValue >= 99.5 ? levelColors[0] : computedValue < 79.5 ? levelColors[2] : levelColors[1]),
								data : computedValue
							}, {
								label : "Não Atingido",
								color : "#D2D2D2",
								data : resto
							} ];
						}
						
						function labelFormatter(label, series) {
						        return "<div style='font-size:8pt; text-align:center; padding:2px; color:#555;'>" + label + "<br/>" + Math.round(series.percent) + "%</div>";
					    };
						
						var op = {series : { pie : {show : true, radius: 1, label: { show: true, radius: 2/4, formatter: labelFormatter, background: { opacity: 0 } } } }, legend: {show: false} };
						
						var localOptions = { values : data,  options : op };
						
						return $.extend(baseOptions, localOptions);
					}
				},
				
				toChartBar: function(baseOptions, loadedData){
					
					if(loadedData != undefined)
					{
						dataScoreCard = new Array();
						for(var loadedIdx = 0; loadedIdx < loadedData.length; loadedIdx++){							
							var computedValue = Dashboard.prototype.math.toFixed2(loadedData[loadedIdx].valor);
							
							var component = baseOptions.$areaObj.getComponent(baseOptions.index);
							var st = component.scorecardType[loadedIdx];
							
							var title = Dashboard.prototype.utils.justGetMyTitle(loadedData[loadedIdx].tipoIndicador, true);
							
							if(Dashboard.prototype.isCategory(st.scorecardType))
							{
								var catObj = Dashboard.prototype.request.getCategoria(st.scorecardSettings.categoriaId);
								title = title + '\n'+ catObj.nome;
							}
							
							dataScoreCard.push({x: title, y: computedValue});														
						}
						
						var localOptions = {
							data: dataScoreCard,
						    xkey: 'x',
						    ykeys: ['y'],
						    labels: ['Atingido', 'Não Atingido']	
						};
						
						return $.extend(baseOptions, localOptions);					
					}
				},
				
				toSemaphore: function(baseOptions, loadedData){
					
					if(loadedData != undefined)
					{	
						var computedValue = Dashboard.prototype.math.toFixed2(loadedData[0].valor);
						var size = (baseOptions.$areaObj.position.indexOf('rectangle') > -1 ? 3 : 6);
						
						var computedValue = Dashboard.prototype.math.toFixed2(loadedData[0].valor);
							
						var component = baseOptions.$areaObj.getComponent(baseOptions.index);
						var st = component.scorecardType[0];

						var title = Dashboard.prototype.utils.justGetMyTitle(loadedData[0].tipoIndicador, true);

						if(Dashboard.prototype.isCategory(st.scorecardType))
						{
							var catObj = Dashboard.prototype.request.getCategoria(st.scorecardSettings.categoriaId);
							title = title + '<br />'+ catObj.nome;
						}
						
						var localOptions = {
							id : baseOptions.divId,
							status : (computedValue >= 99.5 ? 'green' : computedValue < 79.5 ? 'red' : 'yellow'),
							icon : "fa fa-bar-chart-o",
							size : size,
							value : computedValue + "%",
							label : title
						};

						return $.extend(baseOptions, localOptions);					
					}
				},
				
				toRanking: function(baseOptions, scorecards){
										
					var tipoIndicador = scorecards[0].scorecardType;						
					var label = Dashboard.prototype.utils.justGetMyTitle(tipoIndicador);					
					var icon = Dashboard.prototype.utils.getRankingIcon(tipoIndicador);
					var itemTitle = Dashboard.prototype.utils.getRankingItemTitle(tipoIndicador);
					
					
					var loadedData = $.ajax({
						async : false,
						type : 'GET',
						traditional: true,
						dataType : "json",
						url : 'api/indicadores/get/ranking/'+ tipoIndicador +'/'+ Dashboard.prototype.getPeriod()
					}).responseJSON;
					
					var tableData = new Array();
					
					$(loadedData).each(function (index, value){
						
						var nomeRanking = value.nome;
						var dataRanking = value.data;							
					
						try {

							if(tipoIndicador == 'RR')
								nomeRanking = nomeRanking.split(',')[0];
							
							var $vlrEl = $('<input/>', {
								value : Dashboard.prototype.math.toFixed2(dataRanking.valorFaturado),
								type : 'text'
							}).mask('#.##0,00', {reverse:true, maxlength: false});;
																				
							var quantidade = Dashboard.prototype.math.toFixed2(dataRanking.quantidadeFaturada);
							var valor = ($vlrEl.val() != "" ? 'R$' : "") + $vlrEl.val();							
							
							var data = [nomeRanking, quantidade, valor];							
							if(tipoIndicador != 'RP')
								data[3] = Dashboard.prototype.math.toFixed2(dataRanking.av);
							
							tableData.push(data);
						}
						catch(e){
							console.log(e);
						}
						
					});
					
					var columnsTitle = [ itemTitle, 'Qtde Fat', 'Vlr Fat', 'AV%' ];					
					if(tipoIndicador == 'RP')
						columnsTitle.pop();					
					
					var localOptions = {
						id : baseOptions.divId,
						title : label,
						iconClass : icon,
						columnsTitle : columnsTitle,
						tableData : tableData,
						isRanking : true
					};
					
					return $.extend(baseOptions, localOptions);
				},
				
				toLista: function(baseOptions, scorecards){

					var loadedData = $.ajax({
						async : false,
						contentType: "application/json",
						type : 'POST',
						traditional: true,
						data: JSON.stringify(scorecards),
						dataType : "json",
						url : 'api/indicadores/get/lista/'+ Dashboard.prototype.getPeriod()
					}).responseJSON;
					
					var tableData = new Array();					
					var columnsTitle = [ 'Entidade'];
					var columnsSet = false;
					
					if(loadedData != null && loadedData != undefined){
						loadedData.page = 1;
						
						$(loadedData).each(function (index, value){
						
							try {
								
								var data = [value.nome];
								
								$(value.itens).each(function (index, valueItem){
								
									var scorecard = valueItem.tipoIndicador;
									
									var valor = null;
									if(Dashboard.prototype.utils.getScorecardUnitInList(scorecard) == 'CURRENCY'){
									
										var $vlrEl = $('<input/>', {
											value : Dashboard.prototype.math.toFixed2(valueItem.valor),
											type : 'text'
										}).mask('#.##0,00', {reverse:true, maxlength: false});
										
										valor = ($vlrEl.val() != "" ? 'R$' : "") + $vlrEl.val();
									}
									else if(Dashboard.prototype.utils.getScorecardUnitInList(scorecard) == 'PERCENT')
										valor = Dashboard.prototype.math.toFixed2(valueItem.valor) + '%';
									else 
										valor = Dashboard.prototype.math.toFixed2(valueItem.valor);								
									
									if(!columnsSet)
										columnsTitle.push(Dashboard.prototype.utils.justGetMyTitle(scorecard, true));
								
									data.push(valor);
								});
								
								columnsSet = true;
								
								tableData.push(data);
							}
							catch(e){
								console.log(e);
							}
							
						});
					}
					
					var localOptions = {
						id : baseOptions.divId,
						title : "Listagem por Entidade",
						iconClass : 'fa fa-bar-chart-o',
						columnsTitle : columnsTitle,
						tableData : tableData,
						isRanking : false,
						page : 1
					};
					
					return $.extend(baseOptions, localOptions);
				},
				
				toMosaic: function(baseOptions){
					
					var loadedData = $.ajax({
						async : false,
						type : 'GET',
						traditional: true,
						dataType : "json",
						url : 'api/indicadores/get/mosaico/RP/'+ Dashboard.prototype.getPeriod()
					}).responseJSON;
					
					
					loadedData =  loadedData[baseOptions.index];
					
					var localOptions = {};
					if(loadedData != undefined)
					{
						// Se não tem imagem
						if(loadedData.nome.indexOf('http') == -1)
							loadedData.nome = 'resources/images/img_not_found.gif';
	
						localOptions = {size : 6, value : (baseOptions.index + 1), label: 'Não Definido', img: loadedData.nome };
					}
					else
						localOptions = baseOptions.data[baseOptions.index];
					
					return $.extend(baseOptions, localOptions);
				}
			},

			addComponentGage : function(settings) {
				
				var g = new JustGage({
					id : settings.divId,
					relativeGaugeSize : true,
					value : settings.value,
					min : settings.min,
					max : settings.max,
					showInnerShadow : true,
					shadowOpacity : 0.3,
					valueFontColor : [ '#4A98BE' ],
					customSectors: [{
					    color : Dashboard.prototype.getRed('hexa'),
					    lo : 0,
					    hi : 79.5
					}, {
					    color : Dashboard.prototype.getYellow('hexa'),
					    lo : 79.5,
					    hi : 99.5
					}, {
					    color : Dashboard.prototype.getGreen('hexa'),
					    lo : 99.5,
					    hi : 180
					}],
					title : settings.title
				});
				
				//FIXME - fix para carregar corregamente com as cores
				Dashboard.prototype.events.addTimeout(Dashboard.prototype.component.gauge.reload, 0, g, settings.value, settings.title);

				// drop event
				Dashboard.prototype.createDroppableComponentEvent(settings.$div);

				return g;
			},

			addComponentChartBar : function(settings) {
				
				var b = Morris.Bar({
					element : settings.divId,
					data : settings.data,
					xkey : settings.xkey,
					ykeys : settings.ykeys,
					labels : settings.labels,
					hideHover : 'auto',
					resize : true,
					barColors: function (row, series, type) {
						
					    if (type === 'bar') {					      				     
					    	if(row.y < 79.5)
					    		return Dashboard.prototype.getRed('rgb');
					    	else if(row.y < 99.5)
					    		return Dashboard.prototype.getYellow('rgb');
					    	else 
					    		return Dashboard.prototype.getGreen('rgb');
					    }
					    else {
					      return '#000';
					    }
					}
				});
				
				// drop event
				Dashboard.prototype.createDroppableComponentEvent(settings.$div);

				return b;
			},

			addComponentChartLine : function(settings) {
				
				var l = new Morris.Line({
					element : settings.divId,
					xkey : settings.xkey,
					ykeys : settings.ykeys,
					labels : settings.labels,
					data : settings.data,
					resize : true
				});
				
				// drop event
				Dashboard.prototype.createDroppableComponentEvent(settings.$div);

				return l;
			},

			addComponentChartPie : function(settings) {
				
				var p = $.plot(settings.$div, settings.values, settings.options);
				
				// drop event
				Dashboard.prototype.createDroppableComponentEvent(settings.$div);
								
				return p;
			},

			addComponentMap : function(settings) {
				
				settings.iconClass = 'fa fa-map-marker';
				settings.headerTitle = 'Ranking Regional';
				Dashboard.prototype.component.createAreaHeader(settings);
				
				function onLocationsReady(coords, loadedValues){
					
					//console.log('map');
					//console.log(coords);
					
					// resets fake data
					settings.locations = [];
					
					var valuesCalcRadius = new Object();
					
					for(var locationIndex = 0; locationIndex < coords.length; locationIndex++)
					{
						var coord = coords[locationIndex];
						
						var shop = loadedValues[coord.source];
						
						valuesCalcRadius[coord.formatted_address] = shop;
						
						// Exibir o mapa em cima do Brasil quando não tiver nenhum dado encontrado
						if(shop == undefined)
						{
							var html = '';
							
							if(Dashboard.prototype.utils.objectSize(loadedValues) == 0)
							{
								var location = {
										lat : coord.lat,
										lon : coord.lon,
										title : coord.formatted_address,
										html: html,
										icon : 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=0|349e49',
										type : 'marker'
									};
								
								settings.locations.push(location);
							}
							
							// continua para o próximo endereço
							console.info('Dados para shop['+ coord.source +'] não encontrados.');
							continue;
						}
						
						var quantidadeFaturada = Dashboard.prototype.math.toFixed2(shop.quantidadeFaturada);
						var valorFaturado = Dashboard.prototype.math.toFixed2(shop.valorFaturado);
						var av = Dashboard.prototype.math.toFixed2(shop.av);
						var pinColor = Dashboard.prototype.utils.getMetaColor(av).replace('#', '');
						
						var html = '<h4>'+ coord.source +': </h4> Vlr Fat: '+  valorFaturado + '<br /> Qtde Fat: '+  quantidadeFaturada + '<br /> AV: '+ av + '%';
						
						var location = {
							lat : coord.lat,
							lon : coord.lon,
							title : coord.formatted_address,
							html: html,
							icon : 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld='+ locationIndex +'|'+ pinColor,
							
							// new options
							type : 'circle',
//					        circle_options: {
//					            radius: 300000
//					            //Dashboard.area[1].getComponent(0).component.circles[0].setRadius(100000)
//					        },
					        stroke_options: {
					        	strokeColor: '#0000FF',
					            strokeOpacity: 0.8,
					            strokeWeight: 2,
					            fillColor: '#0000FF',
					            fillOpacity: 0.4
					        }
						};
						
						settings.locations.push(location);
						
						COOOORD = coords;
						LOADDDD = loadedValues;
					}
					
					// Quando não tem nenhuma loja, mostrar uma área maior
					var zoom = Dashboard.prototype.utils.objectSize(loadedValues) == 0 ? 3 : 4;
					
					var map = new Maplace({
						
						map_div : '#' + settings.divId,
						locations : settings.locations,
						controls_div : settings.controlsdiv,
						controls_type : 'list',
						controls_on_map : false,
						type: 'circle',
						show_markers : false,
						map_options: { zoom: zoom }
						
					});
					
					map.Load();
					settings.$areaObj.setComponent(map, settings);
					
					
					google.maps.event.addListener(map.oMap, 'zoom_changed', function () {
					    for (var i = 0; i < map.circles.length; i++) {
					        
					    	if(valuesCalcRadius[map.circles[i].title] != undefined)
				    		{
						    	var p = Math.pow(2, (21 - map.oMap.getZoom()));
						        
						    	var baseRadius = (p * 1128.497220 * 0.0027);
						    	
						    	var fraction = valuesCalcRadius[map.circles[i].title].av;
						        var newRadius = (baseRadius * (fraction/100));
						        
						        map.circles[i].setRadius(newRadius);
				    		}
					    }
					});
				};
				
				function geoSearch(coords, maxIndex, address, callback, callbackParam){
					
			        var geocoder = new google.maps.Geocoder();
			        if (geocoder) {
			            geocoder.geocode({'address': address}, function (results, status) {
			                if (status == google.maps.GeocoderStatus.OK) {
			                    
			                	var location = results[0].geometry.location;
			                	coords.push({lat: location.lat(), lon: location.lng(), formatted_address: results[0].formatted_address, source: address});
			                    
			                    if(coords.length == maxIndex) {
			                        if( typeof callback == 'function' ) {
			                            callback(coords, callbackParam);
			                        }
			                    }
			                }
			                else
			                {
			                    throw('No results found: ' + status);
			                }
			            });
			        }
				};
				
				
				function loadAddresses(addresses, callback, callbackParam) {
				    
					var coords = [];
				    for(var i = 0; i < addresses.length; i++) {
				        var currAddress = addresses[i];
				       
				        geoSearch(coords, addresses.length, currAddress, callback, callbackParam);
				    }
				};
				
				var loadedData = Dashboard.prototype.request.doSyncRequest('api/indicadores/get/ranking/RR/'+ Dashboard.prototype.getPeriod());
				
				var addresses = new Array();
				var rankingValues = new Object();
				$(loadedData).each(function(index, value){
					addresses.push(value.nome);					
					rankingValues[value.nome] = value.data;					
				});				
				
				if(addresses.length == 0)
					addresses = ['BR'];
				
				console.log('Endereços: '+ addresses);
				loadAddresses(addresses, onLocationsReady, rankingValues);
				
				// drop event
				Dashboard.prototype.createDroppableComponentEvent(settings.$div);
			},

			addComponentSemaphore : function(settings) {
				
				var l = new Semaphore({
					id : settings.divId,
					status : settings.status,
					icon : settings.icon,
					size : settings.size,
					value : settings.value,
					label : settings.label
				});
				
				// drop event
				Dashboard.prototype.createDroppableComponentEvent(settings.$div);

				return l;
				
			},
			
			addComponentMosaic: function(settings){
				
				settings.iconClass = 'fa fa-shopping-cart';
				settings.headerTitle = 'Ranking de Produtos';
				Dashboard.prototype.component.createAreaHeader(settings);
				
				var l = new Semaphore({
					id : settings.divId,
					status : settings.status,
					size : settings.size,
					value : settings.value,
					label : settings.label,
					img: settings.img,
					class: 'mosaic'
				});
				
				// drop event
				Dashboard.prototype.createDroppableComponentEvent(settings.$div);

				return l;
			},

			addComponentList : function(settings, slidePageEvents) {
				
				var l = new Lista({
					id : settings.divId,
					title : settings.title,
					iconClass : settings.iconClass,
					columnsTitle : settings.columnsTitle,
					tableData : settings.tableData,
					isRanking : settings.isRanking,
					page  : settings.page
				});

				var	area = settings.$areaObj.index;
				
				if(settings.isRanking && (slidePageEvents == true || slidePageEvents == undefined)){
					if(isNaN(settings.page))
						settings.page = 1;
					Dashboard.prototype.events.addTimeout(Dashboard.prototype.events.slideLista, 2500, settings.divId);
					
					if(l.config.pages == undefined || l.config.pages > 1)
						Dashboard.prototype.events.addTimeout(Dashboard.prototype.events.nextPageLista, 5000, Dashboard.prototype.area[area].getComponent(0), settings.$div);
				}
				// drop event
				Dashboard.prototype.createDroppableComponentEvent(settings.$div);
				
				return l;
			},
			
			getGoalSettingsValueForm: function(complementaryId){
				
				var $form = $('.scorecard-goal-settings-values > form#goalSettings__'+ complementaryId);
				
				// Se não existir, cria um novo form de valores para este indicador
				if($form.size() == 0)
				{
					$form = $('.scorecard-goal-settings-values > form#baseFormGoalSettingsValues').clone();
					$form.attr('id', 'goalSettings__'+ complementaryId);
				}
			   
				 $('.scorecard-goal-settings-values').append($form);
				 
				 return $form;
				
			},
			
			setLoadedGoalSettings: function() {
				
				for(var indexMeta = 0; indexMeta < this.metas.length; indexMeta++){
					
					var meta = this.metas[indexMeta];
					
					var formId = meta.scorecard.scorecardType;
					
					if(this.isCategory(meta.scorecard.scorecardType))
						formId = formId + ATTR_DIVIDER + meta.scorecard.scorecardSettings.categoriaId;
					
					var $form = this.getGoalSettingsValueForm(formId);
				
					for(var indexPeriod = 0; indexPeriod < meta.periodos.length; indexPeriod++) {					 
				        
				        console.log(meta.scorecard.scorecardType +"["+ meta.periodos[indexPeriod].period +"]" + " = " + meta.periodos[indexPeriod].value);
				        
				        var metaValue = meta.periodos[indexPeriod].value;
				        
				        // Maikon.Will - 22/07/2014 - Fix para o valor double que chega sem casas decimais
			        	metaValue = metaValue.toFixed(2);
				        
				        $form.find('input[data-goal-period="'+ meta.periodos[indexPeriod].period +'"]').val(metaValue);						 
					}
				}				
			},
			
			/* REQUESTS */
			request : {

				doSyncRequest : function(url, data) {

					var r = $.ajax({
						type : 'GET',
						async : false,
						data: ((data) ? data : {}),
						dataType : "json",
						url : url,
					});

					return r.responseJSON;
				},

				getNiveis : function() {

					return this.doSyncRequest('api/nivel/get');
				},
				
				getCategoria : function(id) {

					return this.doSyncRequest('api/categoria/get/' + id);
				},

				getCategoriasByNivel : function(nNivel) {

					return this.doSyncRequest('api/categoria/getByNivel/' + nNivel);
				},
				
				save: function(){
					
					// Objeto Dashboard
					var _Dashboard = Dashboard.prototype;
					
					if(_Dashboard.getRssAddress() == undefined)
						_Dashboard.setRssAddress("https://news.google.com/?output=rss&hl=pt-BR");
					
					// Objeto que será enviado na requisição
					var dashboard = {areas: [], metas: [], rssAddress : _Dashboard.getRssAddress(), logo: _Dashboard.getLogo(), background: _Dashboard.getBackground()};
					
					// Usado para validar as metas configuradas/usadas
					var configuredMetas = {};
					var notDefinedMetaUsed = false;
					
					// Scorecard ranking
					var ranking = ['RR','RL','RP','RV'];
					
					// Metas
					$.each(_Dashboard.getGoalSettingsForms(), function(index, form) {
												
						var $form = $(form);
						var scorecardTypeForm = $form.attr('id').split('__')[1];
						var notRanking = ranking.indexOf(scorecardTypeForm) == -1;
						
						configuredMetas[scorecardTypeForm] = true;
						
						var categoriaId = $form.attr('id').split('__')[2] == undefined ? null : $form.attr('id').split('__')[2]; 
						var scorecardObj = new scorecard(scorecardTypeForm, new scorecardSettings(categoriaId, "NONE"));
						
						var periodos = new Array();
						$form.find('input').each(function(index, input){
							
							var $input = $(input);
							var period = $input.attr('data-goal-period');
							var value = ($input.val().indexOf(',') != -1 ) ? $input.val().split(".").join("").replace(",", ".") : $input.val();
							
							if(value == '' && notRanking)
							{
								var meta = Dashboard.prototype.utils.justGetMyTitle(scorecardTypeForm);
								var msg = 'Meta com um valor não configurado! Meta: '+ meta + ' - Periodo: '+ period;
								Dashboard.prototype.warnWindow('error', msg, 10000);
								throw new Error(msg);
							}
							
							periodos.push(new periodo(period, value));
						}); 
						
						dashboard.metas.push(new meta(scorecardObj, periodos));
					});
					
					// Areas
					for(var indexArea = 0; indexArea < _Dashboard.area.length; indexArea++)
					{
						var $areaObj = Dashboard.prototype.area[indexArea];
						
						var area = {components: []};
						area.tipoArea = $areaObj.position;
						
						var $componentsList = $areaObj.getComponent();
						
						for(var indexComponents = 0; indexComponents < $componentsList.length; indexComponents++)
						{
							var $componentObj = $areaObj.getComponent(indexComponents);
								
							var component = {};
							component.componentType = $componentObj.getComponentType();
							component.scorecard = $componentObj.getScorecardType();
							
							for(var indexScorecard = 0; indexScorecard < component.scorecard.length; indexScorecard++){
								var notRanking = ranking.indexOf(component.scorecard[indexScorecard].scorecardType) == -1;
								if(!configuredMetas[component.scorecard[indexScorecard].scorecardType] && notRanking && component.componentType != "component-list")
									notDefinedMetaUsed = true;
							}
							
							area.components[indexComponents] = component;
						}
						
						dashboard.areas[indexArea] = area;
					}
					
					if(notDefinedMetaUsed)
					{
						_Dashboard.warnWindow('error', 'Meta definida em um componente não foi configurada. Configure antes de prosseguir.', 10000);
						return;
					}
					
					console.log('Dashboard: '+ JSON.stringify(dashboard));
					
					var response = $.ajax({
						async : false,
						contentType: "application/json",
						type : 'POST',
						traditional: true,
						data: JSON.stringify(dashboard),
						dataType : "json",
						url : 'api/setup/save',
					});
					
					var responseObject = response.responseJSON;
					
					if(response.status == 400)
						 _Dashboard.warnWindow('error', 'Houve um problema ao salvar. <br/>Detalhes: "'+ responseObject.message + '" :( <br />', 10000);
					else
						 _Dashboard.warnWindow('success', 'Está tudo salvo. Pode confiar!');
				},
				
				resetDashboard: function(){
					
					function sendResetDashboardRequest(){
						
						// Objeto Dashboard
						var _Dashboard = Dashboard.prototype;
						
						var response = Dashboard.prototype.request.doSyncRequest('api/setup/reset');
						
						if(response.status == 400)
							 _Dashboard.warnWindow('error', 'Houve um problema ao reconfigurar o Dashboard. <br/>Detalhes: "'+ response.message + '" :( <br />', 10000);
						else
						{
							_Dashboard.warnWindow('success', 'Tudo pronto, aqui vamos nós!');
							
							function resetRedirect(){window.location = window.location;};
							Dashboard.prototype.events.addTimeout(resetRedirect, 2000);
						}
					}

					var id = 'confirmDashboardReset';
					var title = 'Reconfigurar Painel de Indicadores';
					
					var $customModalBody = $('<div/>', {class: 'menu-slider-custom-bootstrap row-fluid'});
					
					var $pSPAN = $('<span/>');
					$pSPAN.html('Deseja realmente reconfigurar seu Painel de Indicadores?');
					
					var $pUL = $('<ul class="nav bs-docs-sidenav"/>');
					
					var $pLI = $('<li class="active"><input type="radio" name="resetDashboard" value="true"> <label>Sim</label></li>');
					$pUL.append($pLI);
					
					var $pLI = $('<li class="active"><input type="radio" name="resetDashboard" value="false" checked> <label>Não</label></li>');
					$pUL.append($pLI);					
					
					var $div = $('<div/>', {class: 'bs-docs-sidebar hidden-print', role: 'complementary'});					
					$div.append($pSPAN);
					$div.append($pUL);
					
					$customModalBody.append($div);
					
					Dashboard.prototype.createModal($customModalBody, id, title, function($modal){						
						
						if($('input[name=resetDashboard]:checked').val() == "true")
							sendResetDashboardRequest();
					});
				},
				
				loadDashboard: function(){

					var loadedData = {loadedData: window.DashboardCache};
					
					loadedData.period = DASHBOARD_PERIOD;
				
					console.log("del: " + new Date());
					window.Dashboard = null;
					delete Dashboard;
					console.log("del: " + new Date());
					
					window.Dashboard = $.fn.Dashboard(loadedData);
					
					Dashboard.prototype.events.addTimeout(Dashboard.prototype.hidePeriodLoader, 1000);
					
				},
											
				loadRss: function(){
					
					$.ajax({
						async : true,
						type : 'GET',
						traditional: true,
						dataType : "json",
						url : 'api/setup/loadRss',
					}).done(function(rssList) {
						
						if(rssList == null || rssList.message != undefined)
						{
							 if(rssList == null)
								 _Dashboard.warnWindow('notice', 'Não foi possível atualizar o RSS. :( <br />', true);
							 else
								 _Dashboard.warnWindow('notice', 'Não foi possível atualizar o RSS. <br/>Detalhes: "'+ rssList.message + '" :( <br />', true);
							 return;
						}
						
						var rssIndex = 0;
						var listSize = rssList.length;
						
						Dashboard.prototype.events.addSetInterval(rssUpdate, 6000);
						
						function rssUpdate() {
							
							var rssItem = rssList[rssIndex];
							var rssTitle = rssItem[0];
						    
							var $rssText = $('a[data-component-name="dashboard-rss"] > span');
							
							$rssText.fadeOut('slow', function(){
								$rssText.text(rssTitle);
								$rssText.fadeIn();
							});
							
							// Inicia a lista novamente
							if(rssIndex == listSize - 1)
								rssIndex = 0;
							else
								rssIndex++;
						};
						rssUpdate();
					});
				}
			},
			
			warnWindow: function(type, message, stayTime) {
				
				var sticky = false;
				
				if(stayTime == undefined)
					stayTime = 3000;
				
				$().toastmessage('showToast', {
					 text     : message,
					 stayTime : stayTime,
					 sticky   : sticky,
					 position : 'top-right',
					 type     : type,
					 close    : function () {}
				 });
			},
			
			loaderModal: (function(text, timeout) {
				  var $modal = $('.js-loading-bar'),
			      $bar = $modal.find('.progress-bar');
			  
				  $modal.modal('show');
				  $bar.addClass('animate');
				  
				  if(text)
				  	$modal.find('h4').text(text);
			
				  setTimeout(function() {
				    $bar.removeClass('animate');
				    $modal.modal('hide');
				  }, (timeout) ? timeout : 1500);
			}),
			
			removeInitialLoaderModal: function(){
			
				setTimeout(function() {
					window.$initLoaderModalbar.removeClass('animate');
					window.$initLoaderModal.modal('hide');
					
					delete window.$initLoaderModalbar;
					delete window.$initLoaderModal;
				}, 2000);
			},
			
			
			/* DEBUG */
				
		    _log: (function (methods, undefined) {

		    	// PRETTY JSON PRINT
		    	// JSON.stringify(YOUR_OBJECT_HERE, null, 4);
		    }),
		    
		    math: {
		    	
		    	toFixed2: function(number) {
		    		return parseFloat(this.precise_round(number, 2)).toFixed(2);
		    	},
			
				precise_round: function(num,decimals){
				    var sign = num >= 0 ? 1 : -1;
				    return (Math.round((num*Math.pow(10,decimals))+(sign*0.001))/Math.pow(10,decimals)).toFixed(decimals);
				},
				
				percentage: function(value, meta){
					
					var finalValue = (value / 100) * meta;
					return this.toFixed2(finalValue);
				},
				
				money2float: function(number){
					return Number(number.replace(/[^0-9\.]+/g,""));
				}
		    }
			
		};
			

		return new Dashboard(settings);
	};
	
	
	$( document ).ready(function() {
		
		$('#sidebar-menu').sidebarMenu();
		
		if(DASHBOARD_SETUP == undefined)
			DASHBOARD_SETUP = false;
		
		// Passar para um evento
		$('.period > ul > li > a[data-period="'+ DASHBOARD_PERIOD +'"]').addClass('selected-period');
		
		// BEFORE INIT DASHBOARD

		var r = $.ajax({
			type : 'GET',
			async : false,
			dataType : "json",
			url : 'api/setup/load',
		});
		
		window.DashboardCache = r.responseJSON;
		
		console.log('loadedData: '+ r.responseJSON);

		// TODO - Colocar aqui o loader do dashboard
		var loadedData = {loadedData: r.responseJSON};
		
		// TODO - Verificar aqui quando não houver dado do banco
		loadedData.period = DASHBOARD_PERIOD;
		
		// ON INIT
		window.Dashboard = $.fn.Dashboard(loadedData);
		window.websys.dispatchResizeEvent();
		window.websys.removeInitialLoaderModal();
		
		console.timeEnd("initialize dashboard init");
	});
	
})(jQuery, window, document);