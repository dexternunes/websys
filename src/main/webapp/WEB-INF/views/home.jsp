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
						<label>[S] -> Solicitação.</label>
						<br>
						<label>[R] -> Reserva.</label>
						<br>
						<label>[E] -> Em uso.</label>
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
									<select id="grupoExibicao" class="select2 form-control">
									</select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group" id="divDiaInteiro" style="display:none !important">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" style="float:left !important;">Dia Inteiro</label>
								<input type="checkbox" style="margin-left:10px; margin-top:10px;float:left !important;" id="diaTodo"/>
								<form:hidden path="allDay" id="allDay" />
								<div class="col-md-6 xdisplay_inputx form-group has-feedback"
									id="div_dia_inteiro" style="display:none !important">
									<input type="text" id="reserva_dia_todo" class="form-control has-feedback-left input-hora"
										style="z-index: 9999 !important;" type="text"
										data-inputmask="'mask' : '9999/99/99'"
										aria-describedby="inputSuccess2Status4"
										placeholder="Data" readonly="true"
										></input>
									<span class="fa fa-calendar-o form-control-feedback left"
										aria-hidden="true"></span> <span id="inputSuccess2Status4"
										class="sr-only"></span>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group" id="divinicioReserva">
								<label class="col-sm-3 control-label">Início(Data/Hora)</label>
								<div class="col-md-6 xdisplay_inputx form-group has-feedback">
									<form:input id="data_inicio_reserva" path="inicioReserva"
										class="form-control has-feedback-left data_reserva input-hora"
										style="z-index: 9999 !important;" type="text"
										data-inputmask="'mask' : '9999/99/99 99:99'"
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
										data-inputmask="'mask' : '9999/99/99 99:99'"
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
							<button type="submit" class="btn btn-primary antosubmit">Confirmar
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
					element.css('background-color', event.color);
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

			var data_inicio;
			var data_fim;
			
			var minDateReserva;
			
			if(calEvent){
				CarregaReserva(calEvent._id);
				retorna do ajax
// 				data_inicio = moment(calEvent.start).format("YYYY/MM/DD HH:mm");
// 				data_fim = moment(calEvent.end).format("YYYY/MM/DD HH:mm");
// 				minDateReserva = new Date(moment(calEvent.start).format("YYYY/MM/DD HH:mm"));
			}
			else{
				CarregaReserva(0);
				
				retorna do ajax que
// 				var calculoDifHoraInicio = (new Date().getMinutes() % 15);
				
// 				if(calculoDifHoraInicio == 0)
// 					data_inicio = new Date(moment().format("YYYY/MM/DD HH:mm")).addMinutes(120);
// 				else
// 					data_inicio = new Date(moment().format("YYYY/MM/DD HH:mm")).addMinutes((15 - calculoDifHoraInicio) + 120);
				
// 				data_fim = data_inicio;
				
// 				minDateReserva = data_inicio;
			}
			
			retorna do ajax
// 			var dataAllDay = new Date(moment().format("YYYY/MM/DD")).addDays(2);

			if ($('#admin').val() == 1) {
				$('#div_status').show();
			}
			
			if (calEvent) {
				
				if (calEvent.allDay) {
					$('#divDiaInteiro').show();
					$('#diaTodo').hide();
					$('#div_dia_inteiro').show();
					$('#reserva_dia_todo').val(moment(calEvent.start).format("YYYY/MM/DD"));
					$('#reserva_dia_todo').attr("disabled", true);
					$('#divinicioReserva').hide();
					$('#divfimReserva').hide();
					$('#reserva_dia_todo').daterangepicker({
						format : 'YYYY/MM/DD',
						calender_style : "picker_4",
						parentEl : '#CalenderModal',
						startDate : dataAllDay,
						minDate: dataAllDay,
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
				} else {
					$('#divDiaInteiro').hide();
					$('#diaTodo').hide();
					$('#divinicioReserva').show();
					$('#divfimReserva').show();
				}

				var reservaJSON = [];

				reservasJSON.forEach(function(obj) {
					if ((obj.id == calEvent._id) && (obj.idTerceiro == $('#idTerceiro').val() || $('#admin').val() == 1)) {
						reservaJSON[0] = obj;
					}
				});
				
				if(reservaJSON[0] != null){
					$('#data_inicio_reserva').attr("disabled", false);
					$('#data_fim_reserva').attr("disabled", false);
					$('#id').attr("disabled", false);
					$('#utilizaMarinheiro').attr("disabled", false);
					$('#obs').attr("disabled", false);
					$('#grupoExibicao').attr("disabled", true);
					$('#grupoExibicao').html('');
					$('#grupoExibicao').html('<option value="' + reservaJSON[0].grupo.id + '">'+ reservaJSON[0].grupo.descricao+'</option>');
					$('.exclui_reserva').show();
					$(".antosubmit").show();
					
					$('#data_inicio_reserva').daterangepicker(
							{
								timePicker : true,
								timePickerIncrement : 15,
								timePicker12Hour : false,
								format : 'YYYY/MM/DD HH:mm',
								timezone : 'local',
								calender_style : "picker_4",
								parentEl : '#CalenderModal',
								startDate : data_inicio,
								minDate: minDateReserva,
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
						minDateReserva = picker.startDate.format('YYYY-MM-DD');
						$('#data_fim_reserva').daterangepicker({
							singleDatePicker : true,
							timePicker : true,
							timePickerIncrement : 15,
							timePicker12Hour : false,
							format : 'YYYY/MM/DD HH:mm',
							timezone : 'local',
							calender_style : "picker_4",
							parentEl : '#CalenderModal',
							startDate : minDateReserva,
							minDate: minDateReserva,
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
						$('#data_fim_reserva').on('apply.daterangepicker', function(ev, picker){
							var inicio = moment(new Date(moment($('#data_inicio_reserva').val()).format("YYYY/MM/DD")));
							var hoje = moment(new Date(moment().format("YYYY/MM/DD")));
							
							if((moment(inicio).diff(hoje, 'days')) < 7){
								alert('Reservas com mais de um dia, deverão ser feitas com 7 dias de antecedência!');
								return false;
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
					$('#grupoExibicao').attr("disabled", true);
					$('.exclui_reserva').hide();
					$(".antosubmit").hide();
				}

				$('#myModalLabel').text('Editar Reserva');
				$('#title').val(calEvent.title);
// 				$('#data_inicio_reserva').val(data_inicio);
// 				$('#data_fim_reserva').val(data_fim);
				$('#id').val(calEvent.id);
				$('#utilizaMarinheiro').prop("checked", calEvent.utilizaMarinheiro);
				$('#obs').val(calEvent.obs);
				$('#grupoExibicao').html('');
				$('#grupoExibicao').html('<option value="' + calEvent.grupo.id + '">'+ calEvent.grupo.descricao + '</option>');

				$('.exclui_reserva').click(
						function() {
							$.ajax({
									url : "${pageContext.request.contextPath}/reserva/validaExclusao/"+ reservaJSON[0].id,
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
									error : function(request,
											status, error) {
										//esse alert estourava toda vez que eu logava no sistema. Por isso comentei.
										//alert("error" + error);
									}
								});
				});

				if ($('#admin').val() == 1 || $('#marinheiro').val() == 1) {
					if (reservaJSON[0].eventoInicio != null	&& reservaJSON[0].eventoInicio.hora == null && reservaJSON[0].eventoFim != null && reservaJSON[0].eventoFim.hora == null) {
						$('#btnEventoInicio').click(function() {
							document.location.href = $('#caminhoEvento').val() + reservaJSON[0].eventoInicio.id;
							});
						$('#btnEventoInicio').show();
					}

					if (reservaJSON[0].eventoFim != null && reservaJSON[0].eventoFim.hora == null && reservaJSON[0].eventoInicio != null && reservaJSON[0].eventoInicio.hora != null) {
						$('#btnEventoFim').click(function() {
							document.location.href = $('#caminhoEvento').val() + reservaJSON.eventoFim.id;
							});
						$('#btnEventoFim').show();
					}
				}
			} else {

				$('#myModalLabel').text('Editar Reserva');
				$('#title').val($('#nome_terceiro').val());
				$('#diaTodo').show();
				$('#reserva_dia_todo').daterangepicker({
					format : 'YYYY/MM/DD',
					calender_style : "picker_4",
					parentEl : '#CalenderModal',
					startDate : dataAllDay,
					minDate: dataAllDay,
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

				if ($('#diaTodo').is(':checked')) {
					allDay = true;
					$('#allDay').val($('#diaTodo').val());
				} else {
					allDay = false;
				}
				
				$('#divDiaInteiro').show();

// 				$('#data_inicio_reserva').val(data_inicio);
				$('#id').val('');
				$('#utilizaMarinheiro').prop("checked", false);
				$('#obs').val('');
				$('#data_inicio_reserva').attr("disabled", false);
				$('#data_fim_reserva').attr("disabled", false);
				$('#id').attr("disabled", false);
				$('#utilizaMarinheiro').attr("disabled", false);
				$('#obs').attr("disabled", false);
				$('#grupoExibicao').attr("disabled", false);
				$('#grupoExibicao').html('');
				var html_grupo = '';

				for (var i = 0; i < gruposJSON.length; i++) {
					html_grupo += '<option value="' + gruposJSON[i].id + '">' + gruposJSON[i].descricao + '</option>';
				}
				$('#grupoExibicao').html(html_grupo);
				$('.exclui_reserva').show();
				$(".antosubmit").show();
			}

			if ($('#permiteReserva').val() == 1 || $('#admin').val() == 1) {
				$('#data_inicio_reserva').daterangepicker(
						{
							timePicker : true,
							timePickerIncrement : 15,
							timePicker12Hour : false,
							format : 'YYYY/MM/DD HH:mm',
							timezone : 'local',
							calender_style : "picker_4",
							parentEl : '#CalenderModal',
							startDate : data_inicio,
							minDate: minDateReserva,
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
					
					minDateReserva = new Date(moment($('#data_inicio_reserva').val()).format('YYYY/MM/DD HH:mm')).addHours(1);

					$('#data_fim_reserva').daterangepicker({
						singleDatePicker : true,
						timePicker : true,
						timePickerIncrement : 15,
						timePicker12Hour : false,
						format : 'YYYY/MM/DD HH:mm',
						timezone : 'local',
						calender_style : "picker_4",
						parentEl : '#CalenderModal',
						startDate : minDateReserva,
						minDate: minDateReserva,
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
					
// 					var selectHoraFim = $(".hourselect ,#data_fim_reserva")[1];
// 					selectHoraFim.options.each(function(){alert($(this));});
					
					$('#data_fim_reserva').on('apply.daterangepicker', function(ev, picker){
						var inicio = new Date(moment($('#data_inicio_reserva').val()).format("YYYY/MM/DD HH:mm"));
						var fim = new Date(moment($('#data_fim_reserva').val()).format("YYYY/MM/DD HH:mm"));
						var hoje = new Date(moment().format("YYYY/MM/DD"));
						
						if(fim.getDate() != inicio.getDate()){
							if((moment(inicio).format("YYYY/MM/DD").diff(hoje, 'days')) < 7){
								alert('Reservas com mais de um dia, deverão ser feitas com 7 dias de antecedência!');
								return false;
							}
						}
					});
				});
				}

			$('#reserva_evento').click();

			$(".antosubmit").on("click", function() {
				var title = $("#title").val();

				categoryClass = $("#event_type").val();
				
				if (title) {
					if ($('#diaTodo').is(':checked')) {
						$('#data_inicio_reserva').val($('#reserva_dia_todo').val() + ' 06:00' );
						$('#data_fim_reserva').val($('#reserva_dia_todo').val() + ' 20:00' );
						$('#allDay').val($('#diaTodo').val());
					}

					if (calEvent) {
						if (calEvent.allDay) {
							$('#data_inicio_reserva').val(moment(calEvent.start).format("YYYY/MM/DD") + ' 06:00' );
							$('#data_fim_reserva').val(moment(calEvent.start).format("YYYY/MM/DD") + ' 20:00' );
							$('#allDay').val($('#diaTodo').val());
						}
						$('#calendar').fullCalendar('updateEvent', calEvent);
					} else {
						$('#calendar').fullCalendar('renderEvent', {
							title : title,
							start : inicio,
							end : fim,
							allDay : allDay,
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
