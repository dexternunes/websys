<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>A Faturar:</title>
</head>
<body>
	<div class="row">
		<form:form cssClass="form-horizontal" method="post">


			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>Manutenções</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<!-- id="example" para ordenar e filtrar -->
						<table id="example2"
							class="table table-striped responsive-utilities jambo_table ">
							<thead>
								<tr class="headings">
									<th></th>
									<th>Data</th>
									<th>Descrição</th>
									<th>Valor</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${manutencaoList}" var="manutencoes"
									varStatus="status">
									<tr class="even pointer">
										<td class="a-center " oName="id" oValue="${manutencoes.id}">
											<input type="checkbox" name="mCheckBox"
											value="${manutencoes.id}" class="tableflat">
										</td>
										<td class=" "><fmt:formatDate value="${manutencoes.inicioManutencao}"  pattern="dd/MM/yyyy"/></td>
										<td class=" ">${manutencoes.obs}</td>
										<td class=" ">R$ ${manutencoes.valor}</td>
									</tr>
								</c:forEach>
							</tbody>

						</table>
					</div>
					<div class="x_title">
						<h2>Horas Motor</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<table id="example"
							class="table table-striped responsive-utilities jambo_table ">
							<thead>
								<tr class="headings">
									<th></th>
									<th>Data</th>
									<th>Usuário</th>
									<th>Horas Motor</th>
									<th>Evento Inicio</th>
									<th>Evento Fim</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${reservaList}" var="reservas"
									varStatus="status">
									<tr class="even pointer">
										<td class="a-center " oName="id" oValue="${reservas.id}">
											<input type="checkbox" name="hCheckBox" class="tableflat"
											value="${reservas.id}">
										</td>
										<td class=" "><fmt:formatDate value="${reservas.inicioReserva}"  pattern="dd/MM/yyyy"/></td>
										<td class=" ">${reservas.solicitante.nome}</td>
										<td class=" ">${reservas.horaMotorTotal}Horas</td>
										<td class=" "><fmt:formatDate value="${reservas.eventoInicio.horaRegistro}"  pattern="dd/MM/yyyy HH:mm"/></td>
										<td class=" "><fmt:formatDate value="${reservas.eventoFim.horaRegistro}"  pattern="dd/MM/yyyy HH:mm"/></td>
									</tr>
								</c:forEach>
							</tbody>

						</table>
					</div>


					<div class="control-group">

						<%-- <a type="button" class="btn btn-primary"
							href="${pageContext.request.contextPath}/faturamento/">Voltar</a> --%>
						<div id="fc_edit" data-toggle="modal">
							<a type="button" id="faturar" class="btn btn-primary">Calcular</a>
						</div>
					</div>


				</div>
			</div>
		</form:form>

		<!-- Cropping modal -->
		<div class="modal fade" id="my-modal" aria-hidden="true"
			aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<!--  <form class="avatar-form" action="" enctype="multipart/form-data" method="post"> -->
					<div class="modal-header">
						<button class="close" data-dismiss="modal" type="button">&times;</button>
						<h4 class="modal-title" id="avatar-modal-label">Resumo de
							faturamento</h4>
					</div>
					<div class="modal-body">
						<div class="avatar-body">
							<div class="">
								<div class="x_panel">
									<div class="x_title">
										<h2>Valor Total de Manuteção:</h2>
										<h2 id="valorTotal"></h2>
										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<table class="table table-hover">
											<thead>
												<tr>
													<th>Nome Cotista</th>
													<th>Horas</th>
													<th>Valor</th>
												</tr>
											</thead>
											<tbody id="tBody">

											</tbody>
										</table>

									</div>
								</div>
							</div>


							<div class="row avatar-btns">
								<div class="col-md-9"></div>
								<div class="col-md-3">
									<c:if test="${user.role == 'ROLE_ADMIN'}">
										<button id="faturarModal"
											class="btn btn-primary btn-block avatar-save" type="submit">Faturar</button>
									</c:if>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" data-dismiss="modal" type="button">Cancelar</button>
					</div>
					<!--  </form> -->
				</div>
			</div>
		</div>
		<!-- /.modal -->


		<!-- Alert Modal -->
		<div class="modal fade" id="messageModal">
			<div class="modal-dialog">
				<div class="modal-content alert-warning">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">x</button>
					<div class="clearfix"></div>
					<div class="modal-body">
						<!-- The messages container -->
						<div id="errors">
							<span></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Info Modal -->
		<div class="modal fade" id="messageModalInfo">
			<div class="modal-dialog" >
				<div class="modal-content info-warning" style="background-color: rgba(52, 152, 219, 0.88)">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">x</button>
					<div class="clearfix"></div>
					<div class="modal-body">
						<!-- The messages container -->
						<div id="info">
							<span><font color="#E9EDEF"></font></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/js/datatables/js/jquery.dataTables.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/datatables/tools/js/dataTables.tableTools.js"></script>
	<script type="text/javascript">
	
	(function ($) {
	      $.each(['show', 'hide'], function (i, ev) {
	        var el = $.fn[ev];
	        $.fn[ev] = function () {
	          this.trigger(ev);
	          return el.apply(this, arguments);
	        };
	      });
	    })(jQuery);
	
		$(document)
				.ready(
						function() {

							
							 
							$('#messageModalInfo').on('hide', function() {
								location.reload();
							});

							
							$('input.tableflat').iCheck({
								checkboxClass : 'icheckbox_flat-green',
								radioClass : 'iradio_flat-green'
							});

							$("#faturar")
									.click(
											function() {
												
												
												var retorno = createArrayIds();
												var objeto = JSON.stringify(retorno);
												
												if (retorno.idsHoraMotor.length > 0) {
												
													$
															.ajax({
																async : true,
																url : '${pageContext.request.contextPath}/faturamento/api/faturar',
																dataType : "json",
																contentType : "application/json; charset=utf-8",
																type : 'POST',
																data : objeto,
																success : function(
																		data) {
																	retorno = data;
																	popularTabela(data);
																	$("#my-modal").modal('show');
																},
																error : function(
																		request,
																		status,
																		error) {
																	$('#errors span').text('Ocorreu um erro. Favor reportar com o codigo de erro:77');
																	$('#messageModal').modal('show');
																}
															});
												} else {
													return false;

												}

											});

							function popularTabela(data) {
								$("#valorTotal").text(
										"R$" + data.valorTotalString);

								var html = "";
								var i;

								for (i = 0; i < data.faturamentoRateioLista.length; i++) {

									html = html + "<tr>";
									html = html
											+ "<td>"
											+ data.faturamentoRateioLista[i].terceiro.nome
											+ "</td>";
									html = html
											+ "<td>"
											+ data.faturamentoRateioLista[i].horas
											+ "</td>";
									html = html
											+ "<td> R$ "
											+ data.faturamentoRateioLista[i].valorStr
											+ "</td>";
								}
								html = html + "</tr>";

								$("#tBody").html(html);

							}

							function createArrayIds() {
								var idsManutencao = [];
								var idsHoraMotor = [];
								var dto = [];

								var json = {};

								var faturamentoDTO = {
									idsManutencao : null,
									idsHoraMotor : null
								};

								var m = 0;
								var h = 0;

								//Pegar Ids Manutencao
								$("input:checkbox[name=mCheckBox]:checked")
										.each(
												function() {
													idsManutencao
															.push(parseInt($(
																	this).val()));
													m++;
												});

								faturamentoDTO.idsManutencao = idsManutencao;

								//Pegar Ids Hora motor
								$("input:checkbox[name=hCheckBox]:checked")
										.each(
												function() {
													idsHoraMotor
															.push(parseInt($(
																	this).val()));
													h++;
												});
								faturamentoDTO.idsHoraMotor = idsHoraMotor;

								//Obrigatorio ter ao menos uma hora motor selecionada
								if (h == 0) {

									$('#errors span').text('Favor selecionar ao menos uma hora motor.');
									$('#messageModal').modal('show');
								}

								dto.push(faturamentoDTO);
								json.faturamentoDTO = dto;
								return faturamentoDTO;

							}

							$("#faturarModal").click(function() {
												$
														.ajax({
															async : true,
															url : '${pageContext.request.contextPath}/faturamento/api/salvar',
															dataType : "json",
															contentType : "application/json; charset=utf-8",
															type : 'POST',
															data : JSON
																	.stringify(createArrayIds()),
															success : function(
																	data) {
																retorno = data;

																$("#my-modal").modal('hide');
																
																if(retorno == "Faturado com sucesso."){
																	$('#info span font').text(retorno);
																	$('#messageModalInfo').modal('show');

																	
																}else{
																	$('#errors span').text(retorno);
																	$('#messageModal').modal('show');
																}
															},
															error : function(
																	request,
																	status,
																	error) {

																$("#my-modal").modal('hide');
																$('#errors span').text('Ocorreu um erro. Favor reportar com o codigo de erro:88');
																$('#messageModal').modal('show');
															}
														});

											});

						});

		var asInitVals = new Array();
		$(document).ready(
				function() {
					var oTable = $('#example').dataTable({
						"oLanguage" : {
							"sSearch" : "Procurar em todas as colunas:"
						},
						"aoColumnDefs" : [ {
							'bSortable' : false,
							'aTargets' : [ 0 ]
						} //disables sorting for column one
						],
						'iDisplayLength' : 12,
						"sPaginationType" : "full_numbers"
					});
					$("tfoot input").keyup(
							function() {
								/* Filter on the column based on the index of this element's parent <th> */
								oTable.fnFilter(this.value, $("tfoot th")
										.index($(this).parent()));
							});
					$("tfoot input").each(function(i) {
						asInitVals[i] = this.value;
					});
					$("tfoot input").focus(function() {
						if (this.className == "search_init") {
							this.className = "";
							this.value = "";
						}
					});
					$("tfoot input").blur(
							function(i) {
								if (this.value == "") {
									this.className = "search_init";
									this.value = asInitVals[$("tfoot input")
											.index(this)];
								}
							});

					$("#opa").click(
							function() {
								//alert("s");
								$('input:checkbox').not(this).prop('checked',
										this.checked);
							});

					$("#checkAllMotor").click(
							function() {
								$('input:checkbox').not(this).prop('checked',
										this.checked);
							});
				});
	</script>
</body>
</html>
