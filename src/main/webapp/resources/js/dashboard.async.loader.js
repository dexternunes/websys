AsyncLoader = function(options) {

	var obj = this;
	
	obj.loadedData = new Array();
	
	obj.loaders = 0;
	
	if (options === null || options === undefined) {
		console.log('* lista: Informe as configura��es do loader!');
		return false;
	}

	obj.config = {
		scorecards : options.scorecards,
		period : options.period,
		componentOptions : options.componentOptions,
		areaObj : options.areaObj,
		builder : options.builder,
		componentType : options.componentType,
		buildOptions : options.buildOptions,
		indexFakeData : options.indexFakeData,
	};
	
	if(obj.config.componentType == 'component-ranking' || obj.config.componentType == 'component-list' || 
			obj.config.componentType == 'component-mosaic' || obj.config.componentType == 'component-map'){	
		obj.loadedData = undefined;
		this.loadComplete(obj);
	}

	obj.loadData(obj);
};

AsyncLoader.prototype.done = function (dados, instance) {

	var obj = instance;
	
	obj.loaders--;
	
	if(obj.loadedData instanceof Array)
		obj.loadedData.push(dados);
	else
		console.warn('LoadedData não é instância de um Array.');
	
	if(obj.loaders == 0)
		obj.loadComplete(obj);	
};

AsyncLoader.prototype.loadComplete = function (instance) {

	var obj = instance;

	if(obj.config.componentType == 'component-gage')
		options = obj.config.buildOptions.toGage(obj.config.componentOptions, obj.loadedData);
	else if(obj.config.componentType == 'component-chartline')
		options = obj.config.buildOptions.toLine(obj.config.componentOptions, obj.loadedData);
	else if(obj.config.componentType == 'component-chartpie')
		options = obj.config.buildOptions.toPie(obj.config.componentOptions, obj.loadedData);
	else if(obj.config.componentType == 'component-map')
		options = obj.config.buildOptions.toMap(obj.config.componentOptions, obj.loadedData);
	else if(obj.config.componentType == 'component-chartbar')
		options = obj.config.buildOptions.toChartBar(obj.config.componentOptions, obj.loadedData);
	else if(obj.config.componentType == 'component-semaphore')
		options = obj.config.buildOptions.toSemaphore(obj.config.componentOptions, obj.loadedData);
	else if(obj.config.componentType == 'component-ranking')
		options = obj.config.buildOptions.toRanking(obj.config.componentOptions, obj.config.scorecards);
	else if(obj.config.componentType == 'component-list')
		options = obj.config.buildOptions.toLista(obj.config.componentOptions, obj.config.scorecards);
	else if(obj.config.componentType == 'component-mosaic')
		options = obj.config.buildOptions.toMosaic(obj.config.componentOptions);
	
	obj.config.areaObj.setComponent(obj.config.builder(obj.config.componentOptions), obj.config.componentOptions);
	
};

AsyncLoader.prototype.loadData = function (instance) {
	
	var obj = instance;
	
	var ranking = ['RR','RL','RP','RV'];			
	
	for(var scorecardIdx = 0; scorecardIdx < obj.config.scorecards.length; scorecardIdx++){
	
		var isRanking = false;
		for(var rankingIdx = 0; rankingIdx < ranking.length && !isRanking; rankingIdx++){
			if(obj.config.scorecards[scorecardIdx].scorecardType === ranking[rankingIdx])
				isRanking = true;
		}
		
		if(!isRanking) {		
			
			obj.loaders++;
			
			if(obj.config.scorecards[scorecardIdx].scorecardSettings != undefined && obj.config.scorecards[scorecardIdx].scorecardSettings.categoriaId != undefined){				
				$.ajax({
					async : true,
					type : 'GET',
					traditional: true,
					dataType : "json",
					context: obj,
					url : 'api/indicadores/get/indicador/'+ obj.config.scorecards[scorecardIdx].scorecardType +'/'+ obj.config.period +'/'+ obj.config.scorecards[scorecardIdx].scorecardSettings.categoriaId,
				}).done(function (dados) {
					this.done(dados, obj);
				});				
			}
			else {		
				$.ajax({
					async : false,
					type : 'GET',
					traditional: true,
					dataType : "json",
					context: obj,
					url : 'api/indicadores/get/indicador/'+ obj.config.scorecards[scorecardIdx].scorecardType +'/'+ obj.config.period,
				}).done(function (dados) {
					this.done(dados, obj);
				});
			}
		}
	}
};