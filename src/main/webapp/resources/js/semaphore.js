Semaphore = function(options) {

	var obj = this;

	if (options === null || options === undefined) {
		console.log('* semaphore: Informe as configurações do semáforo ao construir o componente!');
		return false;
	}

	obj.config = {
		id : options.id,
		status : options.status,
		icon : options.icon,
		size : options.size,
		value : options.value,
		label : options.label,
		class: ((options.class == undefined) ? 'semaphore' : options.class) + ' ',
		img : options.img
	};

	this.render();
};

Semaphore.prototype.render = function() {

	var obj = this;

	node = document.getElementById(obj.config.id);
	
	node.innerHTML = "";
	
	if (!node) {
		console.log('* semaphore: Container para inclusão do semáforo %s não encontrado', config.id);
		return false;
	}

	$(node).addClass('col-md-' + obj.config.size);
	
	var div = $('<div />', {
		id : obj.config.id,
		class : obj.config.class + ((obj.config.status == undefined) ? '' : obj.config.status) 
	});

	if(obj.config.icon != undefined)
	{
		$('<span/>', {
			class : 'icon',
			html : '<i class="' + obj.config.icon + '"></i>'
		}).appendTo(div);
	}
	
	$('<span/>', {
		class : 'value',
		html : obj.config.value
	}).appendTo(div);
	
	$('<span/>', {
		class : 'desc',
		html : obj.config.label
	}).appendTo(div);
	
	
	if(obj.config.img != undefined)
	{
		var $img = $('<img>',{
			id: obj.config.id + '__img',
			src: obj.config.img,
			style: 'display: none;'
		}).appendTo(div);
		
		$img.load(function(){
			
			if($img.height() >= $img.width())
				$img.addClass('by-height by-width-sm');
			else
				$img.addClass('by-width by-height-sm');
			
			if($img.height() == $img.width())
				$img.removeClass('by-height-sm by-width-sm');
			
			// Fix vertical Align
			var fixVerticalAlign = $(node).height() - $img.height();
			if(fixVerticalAlign > 0)
			{
				var marginTop = (fixVerticalAlign/2);
				$img.css('margin-top', marginTop);
			}
			
			$img.fadeIn();
		});
	}

	$(node).append(div);
};