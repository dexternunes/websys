$(document).ready(function () {

	rede.currentEmp = parseInt($('#nemp').val() - 1);	
	rede.currentNome = $('#nNome').val();
	rede.currentNomeItem = $('#nNomeItem').val();
});

rede = {
	
	currentNome: null,
	
	currentNomeItem: null,
		
	currentEmp : null,		
	
	addEmpresa : function () {
		
		if($('#tempEmp\\.id').val() == '')
			return;
		
		this.currentEmp++;			
		
		var copy = '<div class="controls">'+
						'<input id="'+this.currentNome+''+this.currentEmp+'.id" name="'+this.currentNome+'['+this.currentEmp+'].id" type="hidden" value="'+$('#tempEmp\\.id').val()+'">'+
						'<input id="'+this.currentNome+''+this.currentEmp+'.nome" name="'+this.currentNome+'['+this.currentEmp+'].nome" class="span3 '+this.currentNomeItem+'" readonly="readonly" type="text" value="'+$('#tempEmp\\.nome').val()+'"> '+
						'<button type="button" id="del'+this.currentEmp+'" class="btn" onclick="rede.removeEmpresa('+this.currentEmp+');"><i class="icon-minus"></i></button>'+
					'</div>';

		$("#"+this.currentNome).append(copy);		
		
		$('#tempEmp\\.id').val("");
		$('#tempEmp\\.nome').val("");		
		
		project.applyMasks();
	},	
	
	removeEmpresa : function (idx) {
				
		var cNome = this.currentNome;
		
		$("#"+cNome).find('.controls').get(idx + 1).remove();		
		
		this.currentEmp--;
		
		var re1 = new RegExp(cNome+"\\[[0-9]+\\]", 'gi');
		var re2 = new RegExp(cNome+"[0-9]+", 'gi');
		
		$("#"+cNome).find('.controls').each(function(index, value){

			if(index <= idx)
				return;
			
			copy = $(value).html();
			copy = copy.replace(re1, cNome+'[' + (index - 1) + ']');
			copy = copy.replace(re2, cNome+ (index - 1));
			copy = copy.replace(/del[0-9]+/gi, 'del' + (index - 1));
			copy = copy.replace(/removeEmpresa\([0-9]+\)/gi, 'removeEmpresa(' + (index - 1) + ')');
			
			$(value).html(copy);
		});		
	},
	
	validarForm : function () {
		
		if($('#tempEmp\\.id').val() != ""){
			
			$("#modalEmpAlert").modal();
			
			return false;
		}
		
		return true;
	},
	
	ignoreEmpAndContinue : function () {
		$('#tempEmp\\.id').val("");
		$('#rede').submit();
	}
};