<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<link rel="icon" 
      type="image/png" 
      href="http://example.com/myicon.png">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Prime Share Club</title>

<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/css/timepicker.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/fonts/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/animate.min.css"
	rel="stylesheet">

<!-- Custom styling plus plugins -->
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/icheck/flat/green.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/css/calendar/fullcalendar.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/calendar/fullcalendar.print.css"
	rel="stylesheet" media="print">

<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</head>
<body>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h3>Calendário</h3>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<div class="alert alert-warning alert-dismissible fade in"
						role="alert" id="possuiReserva" style="display:none !important">
						Não é possível solicitar uma reserva.<br> Você possui reservas em aberto, ou a embarcação está em manutenção.
					</div>
					<div class="clearfix"></div>
					<br>
					<div id='calendar'></div>
					<div class="clearfix"></div>
					<div>
						<label>[S] -> Solicitação. [R] -> Reserva. [E] -> Em uso. [C] -> Cancelada. [F] -> Finalizada.</label>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="CalenderModal" class="CalenderModal modal fade" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">x</button>
					<h4 class="modal-title" id="myModalLabel">Nova reserva</h4>
				</div>
				<form:form id="antoform2" class="form-horizontal calender"
					role="form" commandName="reserva"
					action="${pageContext.request.contextPath}/reserva/salvar">

					
					<div class="modal-body">

					<form:hidden path="id" id="id" />
					<form:hidden path="allDay" id="allDay" />
					<input type="hidden" value="${user.nome}" id="nome_terceiro" />
					<input type="hidden" value="${user.idTerceiro}" id="idTerceiro" />
					<input type="hidden" value="${permiteReserva}" id="permiteReserva" />
					<input type="hidden" value="${admin}" id="admin" />
					<input type="hidden" value="${marinheiro}" id="marinheiro" />
							<div class="form-group">
								<label class="col-sm-3 control-label">Solicitante</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<select id="title" name="title" class="select2 form-control">
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Grupo</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<select id="grupo" name="grupo" class="select2 form-control">
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group" id="divinicioReserva">
								<label class="col-sm-3 control-label">Início(Data/Hora)</label>
								<div class="col-md-6 xdisplay_inputx form-group has-feedback">
									<form:input id="data_inicio_reserva" path="inicioReserva"
										class="form-control has-feedback-left data_reserva input-hora"
										style="z-index: 9999 !important;" type="text"
										data-inputmask="'mask' : '99/99/9999 99:99'"
										aria-describedby="inputSuccess2Status4"
										placeholder="Data/Hora" readonly="true"></form:input>
									<span class="fa fa-calendar-o form-control-feedback left"
										aria-hidden="true"></span> <span id="inputSuccess2Status4"
										class="sr-only"></span>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group" id="divfimReserva">
								<label class="col-sm-3 control-label">Fim(Data/Hora)</label>
								<div class="col-md-6 xdisplay_inputx form-group has-feedback">
									<form:input id="data_fim_reserva" path="fimReserva"
										class="form-control has-feedback-left data_reserva input-hora"
										style="z-index: 9999 !important;" type="text"
										data-inputmask="'mask' : '99/99/9999 99:99'"
										aria-describedby="inputSuccess2Status4"
										placeholder="Data/Hora" readonly="true"></form:input>
									<span class="fa fa-calendar-o form-control-feedback left"
										aria-hidden="true"></span> <span id="inputSuccess2Status4"
										class="sr-only"></span>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Utiliza
									Marinheiro </label>
								<form:checkbox style="margin-left:10px; margin-top:10px;"
									id="utilizaMarinheiro" path="utilizaMarinheiro" />
							</div>
							<div class="clearfix"></div>
							<div class="form-group" id="div_status" style="display: none !important;">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Status</label>
								<form:select path="status" multiple="false" id="status" cssClass="select2_multiple" >
									<form:options items="${listaReservaStatus}" itemValue="code" itemLabel="descricao"></form:options>
								</form:select>
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Observações
								</label>
								<form:textarea rows="5" path="obs" id="obs" />
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
							<input type="hidden" value="${pageContext.request.contextPath}/reservaEvento/" id="caminhoEvento"/>
								<button type="button" class="btn" id="btnEventoInicio"
									data-dismiss="modal" style="display: none !important">Evento
									Início</button>
								<button type="button" class="btn" id="btnEventoFim"
									data-dismiss="modal" style="display: none !important">Evento
									Fim</button>
							</div>
							<div class="clearfix"></div>
					</div>
					<div class="modal-footer">
						<div class="form-actions">
							<button type="button" class="btn btn-default exclui_reserva"
								data-dismiss="modal" style="display: none !important">Excluir</button>
							<button type="button" class="btn btn-default cancela_reserva"
								data-dismiss="modal" style="display: none !important">Cancelar</button>
							<button type="button" class="btn btn-default finaliza_reserva"
								data-dismiss="modal" style="display: none !important">Finalizar</button>
							<button type="button" class="btn btn-default antoclose"
								data-dismiss="modal">Fechar</button>
							<button type="button" class="btn btn-primary antosubmit">Confirmar
							</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>

	<div id="reserva_evento" data-toggle="modal"
		data-target="#CalenderModal"></div>
	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>

	<div class="modal fade" id="messageModal">
		<div class="modal-dialog">
			<div id="exibeMensagem">
				<button type="button" class="close" data-dismiss="modal" id="fechaModal"
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

	<div id="confirm" class="modal fade">
		<div class="modal-dialog">
			<div class="alert alert-warning alert-dismissible fade in">
				<div class="modal-body" id="mesagemCancelaExclui"><span>Esta operação está sujeita a cobrança. Deseja prosseguir?</span></div>
				<div class="clearfix"></div>
				<div class="modal-footer">
					<button type="button" data-dismiss="modal" class="btn btn-primary"
						id="cancela_exclui">Sim</button>
					<button type="button" data-dismiss="modal" class="btn btn-primary">Não</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal" id="loading" style="display: none;">
	    <div class="loading_visivel">
	        <div class="circulo"></div>
	    </div>
    </div>

	<script
		src="${pageContext.request.contextPath}/resources/js/calendar/fullcalendar.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/calendar/lang-all.js"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/moment.min2.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/datepicker/daterangepicker.js"></script>

	<script>
	
	$(document).ajaxStart(function () {
        $('#loading').modal('show');
    });
	
	$(document).ajaxStop(function(){
		$('#loading').modal('hide');
	});	
	
	var reservasJSON = [];

	$.ajax({
		url : "${pageContext.request.contextPath}/reserva/api/get",
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		type : 'GET',
		async : false,
		success : function(data) {
			reservasJSON = data.reservas;
		},
		error : function(request, status, error) {
			alert(error);
		}
	});
		
	var gruposJSON = [];
	
	$.ajax({
		url: "${pageContext.request.contextPath}/reserva/api/getGruposSolicitante/0",
		dataType:"json",
		contentType:"application/json; charset=utf-8",
		type:"GET",
		async:false,
		success:function(data){
			gruposJSON = data;
		},
		error:function(request, status, error){
			alert('1:' + error);
		}
	});
	
	var solicitantesGrupoJSON = [];
	
	$.ajax({
		url: "${pageContext.request.contextPath}/reserva/api/getSolicitanteGrupo",
		dataType:"json",
		contentType:"application/json; charset=utf-8",
		type:"GET",
		async:false,
		success:function(data){
			solicitantesGrupoJSON = data;
		},
		error:function(request, status, error){
			alert(error);
		}
	});
	
	$(document).ready(function(){
		$('.input-hora').mouseover(function(){
			$('.input-hora').css('cursor', 'pointer');
		}) ;
	});
	
	$(window).load(function() {
		
		$('#confirm').modal('hide');
		$('#cancela_exclui').click('');

	var seleciona;	

	if ($('#admin').val() == 1) {
			seleciona = true;
		}
	else{
		if ($('#permiteReserva').val() != 1) {
			seleciona = false;
			$('#possuiReserva').show();
		} else {
			seleciona = true;
			$('#possuiReserva').hide();
		}
	}

	var calendar = $('#calendar').fullCalendar({
		header : {
			left : 'prev,next today',
			center : 'title',
			right : 'month,agendaWeek,agendaDay'
		},
		selectable : seleciona,
		selectHelper : true,
		eventLimit : true,
		timezone : 'local',
		lang : 'pt-br',
		select : function(start, end, allDay) {
			if (moment().diff(start, 'days') > 0) {
				$('#calendar').fullCalendar('unselect');
				return false;
			} else {
				ReservaEvento(start, end);
			}
		},
		eventClick : function(calEvent, jsEvent, view) {
			ReservaEvento(calEvent.start, calEvent.end, calEvent);
		},
		eventAfterRender : function(event, element, view) {
			element.css('background-color', event.grupo.color);
		},
		editable : false,
		events : reservasJSON,
		});
	});
	
	$('#title').on('change', function(){
		$.ajax({
			url: "${pageContext.request.contextPath}/reserva/api/getGruposSolicitante/"+$('#title').val(),
			dataType:"json",
			contentType:"application/json; charset=utf-8",
			type:"GET",
			async:false,
			success:function(data){
				gruposJSON = data;
				
				$('#grupo').html('');
					var html_grupo = '';
				
					for (var i = 0; i < gruposJSON.length; i++) {
						html_grupo += '<option value="' + gruposJSON[i].id + '">' + gruposJSON[i].descricao + '</option>';
					}
				
					$('#grupo').html(html_grupo);	

			},
			error:function(request, status, error){
				alert(error);
			}
			});
		});

		function ReservaEvento(start, end, calEvent) {

			$('#data_inicio_reserva').val('');
			$('#data_fim_reserva').val('');
			$('#divinicioReserva').show();
			$('#divfimReserva').show();
			$('.exclui_reserva').hide();
			$('cancela_reserva').hide();
			$('#utilizaMarinheiro').attr("disabled", true);
			$('#obs').attr("disabled", true);
			$('#btnEventoInicio').hide();
			$('#btnEventoFim').hide();
			
			var locale = {
					applyLabel : 'Ok',
					cancelLabel : 'Cancelar',
					daysOfWeek : [ 'Dom', 'Seg', 'Ter', 'Qua',
							'Qui', 'Sex', 'Sab' ],
					monthNames : [ 'Janeiro', 'Fevereiro', 'Março',
							'Abril', 'Maio', 'Junho', 'Julho',
							'Agosto', 'Setembro', 'Outubro',
							'Novembro', 'Dezembro' ]
				};

			var idReserva;

			if(calEvent){
				idReserva = calEvent._id;
			}
			else{
				idReserva = 0;
			}
			
			var reservaJSON = '';
			
			$.ajax({
				url : "${pageContext.request.contextPath}/reserva/api/get/"+idReserva+'?dataReserva=' + getStringFromDate(start._d),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				type : 'GET',
				async : false,
				success : function(data) {
					reservaJSON = data;
				},
				error : function(request, status, error) {
					alert(error);
				}
			});
			
			if($('#admin').val() == 1){

				$('#title').html('');
				var html_title = '<option value=0>  </option>';

				for (var i = 0; i < solicitantesGrupoJSON.length; i++) {
					html_title += '<option value="' + solicitantesGrupoJSON[i].id + '">' + solicitantesGrupoJSON[i].nome + '</option>';
				}
				
				$('#title').html(html_title);
				$('#title').attr('disabled', false);
			}else{
				$('#title').html('<option value="' + reservaJSON.title + '">'+ reservaJSON.title+'</option>');
				$('#title').attr('disabled', true);
			}
				
			$('#id').val(reservaJSON.id);
			$('#utilizaMarinheiro').prop("checked", reservaJSON.utilizaMarinheiro);
			$('#obs').val(reservaJSON.obs);

			if(calEvent){
				$('#myModalLabel').text('Editar Reserva');
				$('#data_inicio_reserva').val(reservaJSON.startStr);
				$('#data_fim_reserva').val(reservaJSON.endStr);
				$('#data_inicio_reserva').attr("disabled", true);
				$('#data_fim_reserva').attr("disabled", true);
				$('#id').attr("disabled", true);
				$('#utilizaMarinheiro').attr("disabled", true);
				$('#obs').attr("disabled", true);
				$('#grupo').attr("disabled", true);
				$('#grupo').html('');
				$('#grupo').html('<option value="' + reservaJSON.grupo.id + '">'+ reservaJSON.grupo.descricao+'</option>');
				$('.exclui_reserva').hide();
				$(".antosubmit").hide();

				if((reservaJSON.terceiro.id == $('#idTerceiro').val() || $('#admin').val() == 1) && reservaJSON.tipoEvento == '[S] '){
						$('#utilizaMarinheiro').attr("disabled", false);
						$('#obs').attr("disabled", false);
						$('.exclui_reserva').show();
						$(".antosubmit").show();
						$('.exclui_reserva').click(
								function() {
									$.ajax({
										url : "${pageContext.request.contextPath}/reserva/api/remove",
										type : "POST",
										contentType : "application/json; charset=utf-8",
										data : JSON.stringify(calEvent._id),
										async : false,
										cache : false,
										processData : false,
										success : function() {
											document.location.reload();
										},
										error : function(error) {
											alert('erro:' + error);
										}
									});
						});
				}
				
				if((reservaJSON.terceiro.id == $('#idTerceiro').val() || $('#admin').val() == 1) && reservaJSON.tipoEvento == '[R] '){
					$('.cancela_reserva').show();
					$('.cancela_reserva').click(
							function() {
								$.ajax({
									url : "${pageContext.request.contextPath}/reserva/api/cancela",
									type : "POST",
									contentType : "application/json; charset=utf-8",
									data : JSON.stringify(calEvent._id),
									async : false,
									cache : false,
									processData : false,
									success : function() {
										document.location.reload();
									},
									error : function(error) {
										alert('erro:' + error);
									}
								});												
					});
				}

				var dataAtual = new Date();
				
				if (($('#admin').val() == 1 || $('#marinheiro').val() == 1) && reservaJSON.tipoEvento == '[R] ' && getDateFromString(reservaJSON.startStr).getDate() == dataAtual.getDate()) {
					
						$('#btnEventoInicio').click(function() {
							document.location.href = $('#caminhoEvento').val() + reservaJSON.eventoInicio.id;
							});
						$('#btnEventoInicio').show();
				}
				
				if(($('#admin').val() == 1 || $('#marinheiro').val() == 1) && reservaJSON.tipoEvento == '[E] ' && getDateFromString(reservaJSON.endStr).getDate() == dataAtual.getDate()){

						$('#btnEventoFim').click(function() {
							document.location.href = $('#caminhoEvento').val() + reservaJSON.eventoFim.id;
							});
						$('#btnEventoFim').show();
				}
			}
			else{
				$(".antosubmit").show();
				$('#id').val('');
				$('#utilizaMarinheiro').prop("checked", false);
				$('#obs').val('');
				$('#data_inicio_reserva').attr("disabled", false);
				$('#data_fim_reserva').attr("disabled", false);
				$('#id').attr("disabled", false);
				$('#utilizaMarinheiro').attr("disabled", false);
				$('#obs').attr("disabled", false);
				$('#grupo').attr("disabled", false);
				$('#grupo').html('');
				var html_grupo = '';

				for (var i = 0; i < gruposJSON.length; i++) {
					html_grupo += '<option value="' + gruposJSON[i].id + '">' + gruposJSON[i].descricao + '</option>';
				}
				
				$('#grupo').html(html_grupo);				
				
				if ($('#permiteReserva').val() == 1 || $('#admin').val()) {
					$('#data_inicio_reserva').daterangepicker(
							{
								timePicker : true,
								timePickerIncrement : 15,
								timePicker12Hour : false,
								format : 'DD/MM/YYYY HH:mm',
								timezone : 'local',
								calender_style : "picker_4",
								parentEl : '#CalenderModal',
								startDate : getDateFromString(reservaJSON.startStr),
								minDate: getDateFromString(reservaJSON.startStr),
								singleDatePicker : true,
								locale : locale
							});
					$('#data_inicio_reserva').on('apply.daterangepicker', function(ev, picker) {
						
						$('#data_fim_reserva').daterangepicker({
							singleDatePicker : true,
							timePicker : true,
							timePickerIncrement : 15,
							timePicker12Hour : false,
							format : 'DD/MM/YYYY HH:mm',
							timezone : 'local',
							calender_style : "picker_4",
							parentEl : '#CalenderModal',
							startDate : getDateFromString($('#data_inicio_reserva').val()).addHours(1),
							minDate: getDateFromString($('#data_inicio_reserva').val()).addHours(1),
							locale : locale
						});
					});
				}
			}

			$('#reserva_evento').click();

			$(".antosubmit").on("click", function() {
				var title = $("#title").val();
				
				categoryClass = $("#event_type").val();
				
				if (title) {
					var reservaDTO = {
							id : null,
							title : null,
							terceiro : {id : null},
							start : null,
							end : null,
							utilizaMarinheiro : null,
							obs : null,
							status : null,
							eventoInicio : {id : null},
							eventoFim : {id : null},
							grupo : {id : null}
					};
					
					if (calEvent) {
						reservaDTO.id = calEvent.id;
						reservaDTO.title = calEvent.title;
						reservaDTO.terceiro.id = calEvent.terceiro.id;
						reservaDTO.start = calEvent.start;
						reservaDTO.end = calEvent.end;
						reservaDTO.utilizaMarinheiro = $('#utilizaMarinheiro').prop('checked');
						reservaDTO.obs = $('#obs').val();;
						reservaDTO.status = calEvent.status;
						reservaDTO.eventoInicio.id = calEvent.eventoInicio.id;
						reservaDTO.eventoFim.id = calEvent.eventoFim.id;
						reservaDTO.grupo.id = calEvent.grupo.id;
					} else {
						reservaDTO.id = null;
						reservaDTO.title = $('#title').val();
						reservaDTO.terceiro.id = parseInt($('#idTerceiro').val());
						reservaDTO.start = getDateFromString($('#data_inicio_reserva').val());
						reservaDTO.end = getDateFromString($('#data_fim_reserva').val());
						reservaDTO.utilizaMarinheiro = $('#utilizaMarinheiro').prop('checked');
						reservaDTO.obs = $('#obs').val();
						reservaDTO.status = null;
						reservaDTO.eventoInicio = null;
						reservaDTO.eventoFim = null;
						reservaDTO.grupo.id = parseInt($('#grupo').val());
					}
					
					SalvarReserva(reservaDTO);					
				}
				
				$('#calendar').fullCalendar('unselect');

				$('.antoclose').click();
			});
		}

		function getDateFromString(strdata) {
			return new Date(strdata.substring(3, 5) + "/"
					+ strdata.substring(0, 2) + "/"
					+ strdata.substring(6, 10)
					+ strdata.substring(10, 16));
		}

		function getStringFromDate(date){
			var dia = date.getDate()+1;
			var mes = date.getMonth() + 1;
			
			if(dia < 10){
				dia = '0' + dia;
			}

			if(mes < 10){
				mes = '0' + mes;
			}

			return dia + '/' + mes + '/' + date.getFullYear();
		}
		
		function SalvarReserva(reservaDTO){
				$.ajax({
					async : false,
					url : '${pageContext.request.contextPath}/reserva/api/salvar',
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					type : 'POST',
					data : JSON.stringify(reservaDTO),
					success : function(data) {
						retorno = data;

						$("#my-modal").modal('hide');
						$('#exibeMensagem').removeClass();
						$('#errors span').text(retorno.mensagem);
						$('#messageModal').modal('show');
						
						if(retorno.id == 0){							
							$('#exibeMensagem').addClass('alert alert-success alert-dismissible fade in');
							$('#messageModal').find("#fechaModal").hide();
							
							function reload(){
								document.location.reload();
							}
							setTimeout(reload, 2000);
						}
						
						if(retorno.id == 1){
							$('#messageModal').find("#fechaModal").show();
							$('#exibeMensagem').addClass('alert alert-warning alert-dismissible fade in');
						}
						
						if(retorno.id == 2){
							$('#messageModal').find("#fechaModal").show();
							$('#exibeMensagem').addClass('alert alert-danger alert-dismissible fade in');
						}
					},
					error : function(request, status, error) {
						$("#my-modal").modal('hide');
						$('#messageModal').find("#fechaModal").show();
						$('#exibeMensagem').removeClass();
						$('#exibeMensagem').addClass('alert alert-danger alert-dismissible fade in');
						$('#errors span').text('Ocorreu um erro!');
						$('#messageModal').modal('show');
					}
				});				
		}
	</script>
</body>
</html>
