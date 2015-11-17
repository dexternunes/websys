<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	
	<div class="modal fade" id="viewSettings" tabindex="-1" role="dialog" aria-hidden="true" style="min-width: 300px; display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header modal-default ">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button">x</button>
					<h4>Configuração de Logo Marca e Background</h4>
				</div>
				<div class="modal-body">
					<div class="menu-slider-custom-bootstrap row-fluid" style="overflow: auto;">
					
						<div style="padding-bottom: 1em;">
							<label>Logo:</label>
							<input type="file" id="logo_file" data-reset="false" class="col-md-12" value="">
							<span style="color: #778;font-size: 1em;">Imagem de até 380 x 718 pixels será melhor renderizada.</span>
						</div>
						
						<div>
							<label>Plano de fundo:</label>
							<input type="file" id="background_file" data-reset="false" class="col-md-12" value="">
							<span style="color: #778;font-size: 1em;">Imagem de até 1920 X 1080 pixels (FULL HD) será melhor renderizada.</span>
						</div>
						
					</div>
				</div>
				<div class="modal-footer" style="margin-top: 0;">
					<button aria-hidden="true" data-dismiss="modal" data-reset-button="viewSettings" class="btn">Cancelar</button>
					<button aria-hidden="true" data-dismiss="modal" data-save-button="viewSettings" class="btn btn-primary">Salvar</button>
				</div>
			
			</div>
		
		</div>
	</div>
	<script type="text/javascript">
	$( document ).ready(function() {
		
		function buildPreview(){
			
			var logoPreview = [];
			if(Dashboard.getLogo())
				logoPreview.push("<img src='"+ Dashboard.getLogo() +"' class='file-preview-image' alt='Logo' title='Logo'>");
			
			$('#logo_file').fileinput({'showUpload':false, browseLabel: 'Procurar &hellip;', initialPreview: logoPreview});
			
			var backgroundPreview = [];
			if(Dashboard.getBackground())
				backgroundPreview.push("<img src='"+ Dashboard.getBackground() +"' class='file-preview-image' alt='Background' title='Background'>");
			
			$('#background_file').fileinput({'showUpload':false, browseLabel: 'Procurar &hellip;', initialPreview: backgroundPreview});
			
		};
		
		buildPreview();
		
		function updateLogoAndBackground(){
			
			// Se já configurou antes, remove para usar o default do dashboard.css
			var currentStyleTag = Dashboard.getLogoAndBackgroundStyleTag();
			if(currentStyleTag != undefined)
				currentStyleTag.remove();
			
			// Pega urls configuradas na div como logo e background
			var viewSettings = $('.dashboard-container-left').css('background-image').split(', ');
			
			if(Dashboard.getLogo())
				viewSettings[0] = 'url('+ Dashboard.getLogo() +')';
			
			if(Dashboard.getBackground())
				viewSettings[1] = 'url('+ Dashboard.getBackground() + ')';
			
			viewSettings = viewSettings.join(', ');
			
			// Criar um builder de CSS
			style = document.createElement('style');
			style.type = 'text/css';
			style.innerHTML = '.dashboard-container-left { background-image: '+ viewSettings +'; }';
			document.getElementsByTagName('head')[0].appendChild(style);
			
			Dashboard.setLogoAndBackgroundStyleTag(style);
			
			$('.dashboard-container-left').fadeIn();
		}
		
		updateLogoAndBackground();
		
		// Salvar
		$('button[data-save-button=viewSettings]').bind('click', function(){
			
			Dashboard.loaderModal('Aplicando configurações selecionadas...');
			$('.dashboard-container-left').fadeOut();
			
			// Atualiza na dashboard
			var logo64 = $('#logo_file').data().fileinput.$preview.find('img').attr('src');
			Dashboard.setLogo(logo64);
			
			var background64 = $('#background_file').data().fileinput.$preview.find('img').attr('src');
			Dashboard.setBackground(background64);
			
			var fd = new FormData();    
			
			// Logo
			fd.append( 'logo', $('#logo_file')[0].files[0] );
			var logoRemove = (Dashboard.getLogo() == undefined || Dashboard.getLogo() == null);
			fd.append('logoRemove', logoRemove);
			
			// Background
			fd.append( 'background', $('#background_file')[0].files[0] );
			var backgroundRemove = (Dashboard.getBackground() == undefined || Dashboard.getBackground() == null);
			fd.append('backgroundRemove', backgroundRemove);
			
			$.ajax({
			  url: 'api/setup/saveLogoAndBackground',
			  data: fd,
			  processData: false,
			  contentType: false,
			  type: 'POST',
			  success: function(data){
			    
				console.log('foto: '+ data);
				Dashboard.warnWindow('success', 'Tudo pronto! Suas configurações já estão atualizadas...');
				
				Dashboard.events.addTimeout(updateLogoAndBackground, 500);
				Dashboard.getEditingAreaOnDashboard().find('.config-area-overlay').click();
			  },
			  error: function(request, ajaxOptions, thrownError){
				  
				  Dashboard.warnWindow('error', 'Houve um problema ao salvar as configurações no Dashboard. <br/>Detalhes: "'+ request.responseText + '" :( <br />', 10000);
				  throw thrownError;
			  }
			});
			
		});
		
		$('button[data-reset-button=viewSettings]').bind('click', function(){
			
			// reconfigura inputs
			$('#logo_file').fileinput('reset');
			$('#background_file').fileinput('reset');
		});
	
	});
	</script>
	
</html>