<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

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
						Voce possui uma reserva em aberto. Somente poderá cadastrar uma
						nova reserva após a finalização da atual.</div>
					<div class="clearfix"></div>
					<br>
					<div id='calendar'></div>
					<div class="clearfix"></div>
					<div>
						<label>[S] -> Solicitação. [R] -> Reserva. [E] -> Em uso.</label>
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
									<form:hidden path="solicitante" />
									<input type="text" value="${user.nome}" id="title"
										readonly="true" class="form-control col-md-7 col-xs-12" />
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
			<div
				class="modal-content alert ui-pnotify-container alert-warning ui-pnotify-shadow">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">x</button>
				<div class="clearfix"></div>
				<div class="modal-body">
					<!-- The messages container -->
					<div id="errors"></div>
				</div>
			</div>
		</div>
	</div>
	
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

	<script
		src="${pageContext.request.contextPath}/resources/js/calendar/fullcalendar.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/calendar/lang-all.js"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/moment.min2.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/datepicker/daterangepicker.js"></script>

	<script>
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
				//esse alert estourava toda vez que eu logava no sistema. Por isso comentei.
				alert(error);
			}
		});
		
		var gruposJSON = [];
		
		$.ajax({
			url: "${pageContext.request.contextPath}/reserva/api/getGruposSolicitante",
			dataType:"json",
			contentType:"application/json; charset=utf-8",
			type:"GET",
			async:false,
			success:function(data){
				gruposJSON = data;
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
			
		$('#diaTodo').click(function(){
			if($('#diaTodo').is(':checked')){
				$('#div_dia_inteiro').show();
				$('#divinicioReserva').hide();
				$('#divfimReserva').hide();
			}
			else{
				$('#div_dia_inteiro').hide();
				$('#divinicioReserva').show();
				$('#divfimReserva').show();
			}
		});
		
		var seleciona;
		var edita;			
			
		if ($('#admin').val() == 1) {
				edita = true;
				seleciona = true;
			}
		else{
			if ($('#permiteReserva').val() != 1) {
				edita = true;
				seleciona = false;
				$('#possuiReserva').show();
			} else {
				edita = false;
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
				editable : edita,
				events : reservasJSON,
			});
		});

		function ReservaEvento(start, end, calEvent) {

			$('#data_inicio_reserva').val('');
			$('#data_fim_reserva').val('');
			$('#diaTodo').attr('checked', false);
			$('#reserva_dia_todo').val('');
			$('#div_dia_inteiro').hide();
			$('#reserva_dia_todo').attr("disabled", false);
			$('#divinicioReserva').show();
			$('#divfimReserva').show();
			$('.exclui_reserva').hide();

			var idReserva;

			if(calEvent){
				idReserva = calEvent._id;
			}
			else{
				idReserva = 0;
			}
			
			var reservaJSON = '';

			$.ajax({
				url : "${pageContext.request.contextPath}/reserva/api/get/"+idReserva+'?dataReserva='+start.format('DD/MM/YYYY'),
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
			
			if ($('#admin').val() == 1) {
				$('#div_status').show();
			}
			
			$('#data_inicio_reserva').val(reservaJSON.startStr);
			$('#data_fim_reserva').val(reservaJSON.endStr);
			$('#title').val(reservaJSON.title);
			$('#id').val(reservaJSON.id);
			$('#utilizaMarinheiro').prop("checked", reservaJSON.utilizaMarinheiro);
			$('#obs').val(reservaJSON.obs);
			$('#title').val($('#nome_terceiro').val());

			if(calEvent){
				$('#myModalLabel').text('Editar Reserva');
				if(reservaJSON.terceiro.id == $('#idTerceiro').val()){
					$('#data_inicio_reserva').attr("disabled", true);
					$('#data_fim_reserva').attr("disabled", true);
					$('#id').attr("disabled", false);
					$('#utilizaMarinheiro').attr("disabled", false);
					$('#obs').attr("disabled", false);
					$('#grupo').attr("disabled", true);
					$('#grupo').html('');
					$('#grupo').html('<option value="' + reservaJSON.grupo.id + '">'+ reservaJSON.grupo.descricao+'</option>');
					$('.exclui_reserva').show();
					$(".antosubmit").show();
					$('.exclui_reserva').click(
							function() {
								$.ajax({
										url : "${pageContext.request.contextPath}/reserva/api/validaExclusao/"+ reservaJSON.id,
										dataType : "json",
										contentType : "application/json; charset=utf-8",
										type : 'GET',
										async : false,
										success : function(data) {
											$.ajax({
												url : "${pageContext.request.contextPath}/reserva/api/remove",
												type : "POST",
												contentType : "application/json; charset=utf-8",
												data : JSON.stringify(calEvent._id),
												async : false,
												cache : false,
												processData : false,
												success : function(resposeJsonObject) {
													$('#calendar').fullCalendar('removeEvents',	calEvent.id);
													document.location.reload();
												},
												error : function(error) {
													alert('erro:' + error);
												}
											});
										},
										error : function(request, status, error) {
											alert("error" + error);
										}
						});
					});
				}
				else {
					$('#data_inicio_reserva').attr("disabled", true);
					$('#data_fim_reserva').attr("disabled", true);
					$('#id').attr("disabled", true);
					$('#utilizaMarinheiro').attr("disabled", true);
					$('#obs').attr("disabled", true);
					$('#grupo').attr("disabled", true);
					$('.exclui_reserva').hide();
					$(".antosubmit").hide();
				}

				$('#myModalLabel').text('Editar Reserva');
				$('#grupoExibicao').html('');
				$('#grupoExibicao').html('<option value="' + calEvent.grupo.id + '">'+ calEvent.grupo.descricao + '</option>');

				if ($('#admin').val() == 1 || $('#marinheiro').val() == 1) {
					if (reservaJSON.eventoInicio != null	&& reservaJSON.eventoInicio.hora == null && reservaJSON.eventoFim != null && reservaJSON.eventoFim.hora == null) {
						$('#btnEventoInicio').click(function() {
							document.location.href = $('#caminhoEvento').val() + reservaJSON.eventoInicio.id;
							});
						$('#btnEventoInicio').show();
					}

					if (reservaJSON.eventoFim != null && reservaJSON.eventoFim.hora == null && reservaJSON.eventoInicio != null && reservaJSON.eventoInicio.hora != null) {
						$('#btnEventoFim').click(function() {
							document.location.href = $('#caminhoEvento').val() + reservaJSON.eventoFim.id;
							});
						$('#btnEventoFim').show();
					}
				}
			}
			else{
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
				$('.exclui_reserva').show();
				$(".antosubmit").show();
			}
			
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
							startDate : reservaJSON.startStr,
							minDate: reservaJSON.startStr,
							singleDatePicker : true,
							locale : {
								applyLabel : 'Ok',
								cancelLabel : 'Cancelar',
								daysOfWeek : [ 'Dom', 'Seg', 'Ter', 'Qua',
										'Qui', 'Sex', 'Sab' ],
								monthNames : [ 'Janeiro', 'Fevereiro', 'Março',
										'Abril', 'Maio', 'Junho', 'Julho',
										'Agosto', 'Setembro', 'Outubro',
										'Novembro', 'Dezembro' ]
							}
						});
				$('#data_inicio_reserva').on('apply.daterangepicker', function(ev, picker) {
					
// 					var minDateReserva = new Date($('#data_inicio_reserva').val()).toLocaleString();
// 					alert(Date.parse($('#data_inicio_reserva').val(), "DD/MM/YYYY HH:mm"));
//  					minDateReserva.setTime(Date.parse($('#data_inicio_reserva').val()));
// 					minDateReserva.addHours(1);
					
					$('#data_fim_reserva').daterangepicker({
						singleDatePicker : true,
						timePicker : true,
						timePickerIncrement : 15,
						timePicker12Hour : false,
						format : 'DD/MM/YYYY HH:mm',
						timezone : 'local',
						calender_style : "picker_4",
						parentEl : '#CalenderModal',
						startDate : $('#data_inicio_reserva').val(),
						minDate: $('#data_inicio_reserva').val(),
						locale : {
							applyLabel : 'Ok',
							cancelLabel : 'Cancelar',
							daysOfWeek : [ 'Dom', 'Seg', 'Ter', 'Qua',
									'Qui', 'Sex', 'Sab' ],
							monthNames : [ 'Janeiro', 'Fevereiro', 'Março',
									'Abril', 'Maio', 'Junho', 'Julho',
									'Agosto', 'Setembro', 'Outubro',
									'Novembro', 'Dezembro' ]
						}
					});
				});
			}

			$('#reserva_evento').click();

			$(".antosubmit").on("click", function() {
				var title = $("#title").val();
				
				alert($('#utilizaMarinheiro').val());
				
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

				categoryClass = $("#event_type").val();
				
				if (title) {
					if (calEvent) {
						reservaDTO.id = calEvent._id;
						reservaDTO.title = calEvent._title;
						reservaDTO.terceiro.id = calEvent._idTerceiro;
						reservaDTO.start = calEvent._start;
						reservaDTO.end = calEvent._end;
						reservaDTO.utilizaMarinheiro = calEvent._utilizaMarinheiro;
						reservaDTO.obs = calEvent._obs;
						reservaDTO.status = calEvent._status;
						reservaDTO.eventoInicio.id = calEvent._eventoInicio.id;
						reservaDTO.eventoFim.id = calEvent._eventoFim.id;
						reservaDTO.grupo.id = calEvent._grupo;
						
						$.ajax({
							async : true,
							url : '${pageContext.request.contextPath}/reserva/api/salvar',
							dataType : "json",
							contentType : "application/json; charset=utf-8",
							type : 'POST',
							data : JSON.stringify(reservaDTO),
							success : function(data) {
								retorno = data;
								
								alert(data);

								$("#my-modal").modal('hide');
								
								if(retorno == "Faturado com sucesso."){
									$('#info span font').text(retorno);
									$('#messageModalInfo').modal('show');								
								}else{
									$('#errors span').text(retorno);
									$('#messageModal').modal('show');
								}
							},
							error : function(request, status, error) {
								alert(error);
								$("#my-modal").modal('hide');
								$('#errors span').text('Ocorreu um erro. Favor reportar com o codigo de erro:88');
								$('#messageModal').modal('show');
							}
						});
						
						$('#calendar').fullCalendar('updateEvent', calEvent);
					} else {
						reservaDTO.id = null;
						reservaDTO.title = $('#title').val();
						reservaDTO.terceiro.id = parseInt($('#idTerceiro').val());
						reservaDTO.start = Date.parse($('#data_inicio_reserva').val());
						reservaDTO.end = Date.parse($('#data_fim_reserva').val());
						reservaDTO.utilizaMarinheiro = false;
						reservaDTO.obs = $('#obs').val();
						reservaDTO.status = null;
						reservaDTO.eventoInicio = null;
						reservaDTO.eventoFim = null;
						reservaDTO.grupo.id = parseInt($('#grupo').val());
						
						$.ajax({
							async : true,
							url : '${pageContext.request.contextPath}/reserva/api/salvar',
							dataType : "json",
							contentType : "application/json; charset=utf-8",
							type : 'POST',
							data : JSON.stringify(reservaDTO),
							success : function(data) {
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
							error : function(request, status, error) {
								$("#my-modal").modal('hide');
								$('#errors span').text('Ocorreu um erro. Favor reportar com o codigo de erro:88');
								$('#messageModal').modal('show');
							}
						});
						
						$('#calendar').fullCalendar('renderEvent', {
							title : title,
							start : inicio,
							end : fim,
						}, true);
					}
				}
				
				$('#calendar').fullCalendar('unselect');

				$('.antoclose').click();

			});
		}
	</script>
</body>
</html>
