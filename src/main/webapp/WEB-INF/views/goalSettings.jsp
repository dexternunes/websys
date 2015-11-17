<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

	<div class="modal fade" id="goalSettings" tabindex="-1" role="dialog" aria-labelledby="goalSettings" aria-hidden="true" style="min-width: 300px;">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header modal-default ">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button">x</button>
					<h4 id="myModalLabel1">Cadastro de Metas</h4>
				</div>
				<div class="modal-body">
		
					<div class="menu-slider-custom-bootstrap scorecards-goals-settings-menu row-fluid">
						
						<div class="bs-docs-sidebar hidden-print" role="complementary">
							<ul class="nav bs-docs-sidenav">
		
								<li class="active"><a id="scorecards-settings" href="#scorecards-settings">Indicadores</a>
									<ul class="nav">
										<li class="VF"><a data-scorecard-goal="VF" href="#">Valor Faturado</a></li>
										<li class="QF"><a data-scorecard-goal="QF" href="#">Quantidade Faturada</a></li>
										<li class="VFC"><a data-scorecard-goal="VFC" href="#">Valor Faturado por Categoria</a></li>
										<li class="QFC" ><a data-scorecard-goal="QFC" href="#">Quantidade Faturada por Categoria</a></li>
										<li class="TC"><a data-scorecard-goal="TC" href="#">Taxa de Conversão</a></li>
										<li class="MG"><a data-scorecard-goal="MG" href="#">Margem</a></li>
										<li class="MG_P"><a data-scorecard-goal="MG_P" href="#">Margem %</a></li>
										<li class="VFV"><a data-scorecard-goal="VFV" href="#">Valor Faturado a Vista</a></li>
										<li class="VFP"><a data-scorecard-goal="VFP" href="#">Valor Faturado a Prazo</a></li>
										<li class="FV_P"><a data-scorecard-goal="FV_P" href="#">% Faturado a Vista</a></li>
										<li class="FP_P"><a data-scorecard-goal="FP_P" href="#">% Fatura à Prazo</a></li>
									</ul>
								</li>
		
							</ul>
						</div>
						<a class="back-to-top pull-right" href="#top" style="display: none;">Voltar</a>
						
						
						<h4 class="pull-right">Selecione um indicador...</h4>
						<div class="scorecard-goal-settings-values">
							
							<form id="baseFormGoalSettingsValues" role="form" style="display: none; overflow: auto;">
								
								<div class="form-group col-md-4">
									<label>Diário</label>
									<input data-goal-period="DIARIA" type="text" class="form-control" placeholder="...">
								</div>
			
								<div class="form-group col-md-4">
									<label>Semanal</label>
									<input data-goal-period="SEMANAL" type="text" class="form-control" placeholder="...">
								</div>
								
								<div class="form-group col-md-4">
									<label>Mensal</label>
									<input data-goal-period="MENSAL" type="text" class="form-control" placeholder="...">
								</div>
								
								<div class="form-group col-md-4">
									<label>Trimestral</label>
									<input data-goal-period="TRIMESTRAL" type="text" class="form-control" placeholder="...">
								</div>
								
								<div class="form-group col-md-4">
									<label>Semestral</label>
									<input data-goal-period="SEMESTRAL" type="text" class="form-control" placeholder="...">
								</div>
								
								<div class="form-group col-md-4">
									<label>Anual</label>
									<input data-goal-period="ANUAL" type="text" class="form-control" placeholder="...">
								</div>
								
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button aria-hidden="true" data-clear-meta-values="true" onclick="javascript: Dashboard.events.goalModal.clearValues();" class="btn">Limpar</button>
					<button aria-hidden="true" data-dismiss="modal" class="btn btn-primary">Salvar e Fechar</button>
				</div>
			
			</div>
		
		</div>
		
	</div>
	
	
	<script>
		$('#goalSettings').on('show.bs.modal', function () {
			
			if(Dashboard.getToConfigureMetas().length == 0)
			{
				Dashboard.warnWindow('notice', 'Hmmm... Não encontramos nenhuma meta para configurar :(');
				return false;
			}
			
			$('.scorecards-goals-settings-menu > div > ul > li > ul > li').hide();
			
			var notHide = '.' + Dashboard.getToConfigureMetas().join(',.');
			var showList = $('.scorecards-goals-settings-menu > div > ul > li > ul').find(notHide);
			showList.show();
			
			// caso a última meta configurada seja uma por categoria,
			// fazer com que se esconda para que o usuário click novamente e recarregue as novas categorias
			// utilizadas no dashboard.
			$('a[data-categoria-id]').parent('.active').click();
			$('a[data-categoria-id]').first().parent().parent().parent('.active').click();
			
			$('.back-to-top:visible').click();
		});
				
		// iPad fix layout when keyboard is closed
		$('#goalSettings').on('hide.bs.modal', function () {
 			$(document.activeElement).blur();
		});
				
	</script>
	
</html>