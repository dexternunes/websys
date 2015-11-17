Lista = function(options) {

	var obj = this;

	if (options === null || options === undefined) {
		console.log('* lista: Informe as configura��es da lista ao construir o componente!');
		return false;
	}

	obj.config = {
		id : options.id,
		title : options.title,
		iconClass : options.iconClass,
		columnsTitle : options.columnsTitle,
		tableData : options.tableData,
		isRanking : options.isRanking,
		page : options.page,
		pages : null
	};

	this.render();
};

Lista.prototype.render = function() {

	var obj = this;
	
	var page = obj.config.page;
	var node = document.getElementById(obj.config.id);
	
	if(page == undefined)
		page = 1;
	
	node.innerHTML = "";
	
	if (!node) {
		console.log('* lista: Container para inclus�o da lista n�o encontrado');
		return false;
	}
		
	var tableData = { columns : obj.config.columnsTitle, values : obj.config.tableData};

	// Header
	var $panel = $(node).parents('.panel');
	$panel.find('.panel-head-icon').remove();
	$panel.find('.panel-heading').remove();
	
	var $panelHeadIcon = $('<div/>', {
		class : 'panel-head-icon',
		html : '<i class="' + obj.config.iconClass + '"></i>'
	});
	
	var $panelHeading = $('<div/>', {
		class : 'panel-heading',
		html : '<span>' + obj.config.title + '</span>'
	});

	$panel.prepend($panelHeadIcon);
	$panelHeading.insertAfter($panelHeadIcon);
	
	var $linesPerPage = Math.floor(($panel.find('.panel-body').height()-60)/31);
	var $nPages = Math.ceil(tableData.values.length/$linesPerPage);
	
	if($nPages < page){
		x = Math.floor((page-1)/$nPages);
		page = page - ($nPages*x);
	}
	    
	obj.config.pages = $nPages; 
	
	var $width = $panel.width();

	var $table = obj.addColumns(node, tableData, $width);
	var $tableBody = obj.addLines(node, tableData, false, page, $linesPerPage);

	$table.append($tableBody);
	$table.appendTo($(node));

};

Lista.prototype.addColumns = function(node, tableData, width) {

	var columns = tableData.columns;
	var $table = $(node).find('table');
	var $tableHead = $(node).find('.panel > .panel-body > * > thead');
	var $tableHeadColumns = $tableHead.find('tr');
	var $padding = 30;
	
	width = width - $padding;
	
	if ($table.size() == 0) {
		
		$table = $('<table/>', {
			class : 'table table-condensed',
			style : 'table-layout: fixed;width:'+width+'px;max-width:'+width+'px;'
		});
		
		$(node).find('.panel-body').append($table);

		$tableHead = $('<thead/>', { html : '<tr/>' }).appendTo($table);
		$tableHeadColumns = $tableHead.find('tr');
		$tableHead.append($tableHeadColumns);
	}

	for (var index = 0; index < columns.length; index++) {
		console.log('column head: ' + columns[index]);
		$tableHeadColumns.append('<th>' + columns[index] + '</th>');
	}

	return $table;
};

Lista.prototype.addLines =  function(node, tableData, forceNewLine, page, linesPerPage) {

	var values = tableData.values;
	var $tableBody = $(node).find('.panel > .panel-body > * > tbody');
	var $line = $tableBody.find('tr').first();
	var $startLine = (page*linesPerPage)-linesPerPage;
	var $endLine = ($startLine + linesPerPage);
	
	if($endLine > values.length)
		$endLine = values.length;

	if ($tableBody.size() == 0)
		$tableBody = $('<tbody/>');

	if (forceNewLine)
		$line = $();

	for (var index = $startLine; index < $endLine; index++) {
		// se n�o h� linha
		if ($line.size() == 0) {
			$line = $('<tr/>');
			$tableBody.append($line);
		}

		var lineValues = values[index];
		for (var valueIndex = 0; valueIndex < lineValues.length; valueIndex++) {
			var value = lineValues[valueIndex];
			
			if(valueIndex==0){
				var $column = $('<td/>', {
					class : 'tdDesc',
					style : 'overflow-x:hidden; overflow-y:hidden; white-space: nowrap;',
					html : value
				});
			}
			else{
				var $column = $('<td/>', {
					html : value
				});
			}

			$line.append($column);
		}
		$line = $line.next();
	}

	return $tableBody;
};