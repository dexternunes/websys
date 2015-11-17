function scorecardSettings (categoriaId, tipoAnaliseVertical) {	
	this.categoriaId = categoriaId; 
	this.tipoAnaliseVertical = tipoAnaliseVertical;	
};

function scorecard (scorecardType, scorecardSettings) {
	this.scorecardType = scorecardType;
	this.scorecardSettings = scorecardSettings;
};

function periodo (period, value) {
	this.period = period;
	this.value = value;
}

function meta (scorecard, periodos) {
	this.scorecard = scorecard;
	this.periodos = periodos;
};