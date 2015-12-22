<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
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
					<h3>Reservas</h3>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<div id='calendar'></div>
					<div class="clearfix"></div>
					<br>
					<button type="button" class="btn btn-primary confirma_reserva">Confirmar</button>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- footer content -->
	<!-- /footer content -->
	<div id="CalenderModal" class="modal fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">Nova reserva</h4>
				</div>
				<form:form id="antoform2" class="form-horizontal calender" role="form" commandName="reserva"
					action="${pageContext.request.contextPath}/reserva/salvar">
					<form:hidden path="id"/>
				<div class="modal-body">
					<div id="testmodal2" style="padding: 5px 20px;">					
							<div class="form-group">
								<label class="col-sm-3 control-label">Solicitante</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
								<form:hidden path="solicitante"/>
									<input type="text" value="${reserva.solicitante.nome}" id="title" readonly="true"
 										class="form-control col-md-7 col-xs-12" />
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Grupo</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:select path="grupo" multiple="false"
									cssClass="select2_multiple form-control">
									<form:options items="${listaReservaGrupos}" itemValue="id"
										itemLabel="descricao"></form:options>
								</form:select>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Início(Data/Hora)</label>
								<div class="col-md-6 xdisplay_inputx form-group has-feedback">
									<form:input id="data_inicio_reserva" path="inicioReserva"
										class="form-control has-feedback-left data_reserva"
										style="z-index: 9999 !important;" type="text"
										data-inputmask="'mask' : '9999/99/99 99:99'"
										aria-describedby="inputSuccess2Status4"
										placeholder="Data/Hora"></form:input> <span
										class="fa fa-calendar-o form-control-feedback left"
										aria-hidden="true"></span> <span id="inputSuccess2Status4"
										class="sr-only"></span>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Fim(Data/Hora)</label>
								<div class="col-md-6 xdisplay_inputx form-group has-feedback">
									<form:input id="data_fim_reserva" path="fimReserva"
										class="form-control has-feedback-left data_reserva"
										style="z-index: 9999 !important;" type="text"
										data-inputmask="'mask' : '9999/99/99 99:99'"
										aria-describedby="inputSuccess2Status4"
										placeholder="Data/Hora"></form:input> <span
										class="fa fa-calendar-o form-control-feedback left"
										aria-hidden="true"></span> <span id="inputSuccess2Status4"
										class="sr-only"></span>
								</div>
							</div>
							<div class="clearfix"></div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="form-actions">
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
	<div id="reserva_evento" data-toggle="modal" data-target="#CalenderModal"></div>
	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>

	<script src="${pageContext.request.contextPath}/resources/js/calendar/fullcalendar.min.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/moment.min2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/datepicker/daterangepicker.js"></script>

	<script>
		var reservasJSON = [];

		$.ajax({
			url : "${pageContext.request.contextPath}/reserva/get",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			type : 'GET',
			async : false,
			success : function(data) {
				reservasJSON = data.reservas;
			},
			error : function(request, status, error) {
				alert("error");
			}
		});

		$(window).load(function() {
							var started;
							var categoryClass;

							var calendar = $('#calendar').fullCalendar({
												header : {
													left : 'prev,next today',
													center : 'title',
													right : 'month,agendaWeek,agendaDay'
												},
												selectable : true,
												selectHelper : true,
												eventLimit : true,
												select : function(start, end,allDay) {
													ReservaEvento(start,end);
												},
												eventClick : function(calEvent,jsEvent, view) {
													alert(calEvent.id);
													ReservaEvento(calEvent.start, calEvent.end, calEvent);
												},
												editable : false,
												events : reservasJSON
											});
						});
	</script>
	<script type="text/javascript">
		
		
		function ReservaEvento(start, end, calEvent) {
			$('#data_inicio_reserva').val('');
			$('#data_fim_reserva').val('');
			
			var data_inicio;
			var data_fim;

			if (calEvent) {
				data_inicio = moment(start).format("YYYY/MM/DD HH:mm");
				data_fim = moment(end).format("YYYY/MM/DD HH:mm");
				$('#data_inicio_reserva').val(data_inicio);
				$('#data_fim_reserva').val(data_fim);
				
			} else {
				data_inicio = moment(start).format("YYYY/MM/DD " + "06:00");
				data_fim = data_inicio;
				$('#data_inicio_reserva').val(data_inicio);
			}

			$('#data_inicio_reserva').daterangepicker({
				singleDatePicker : true,
				timePicker : true,
				timePickerIncrement : 15,
				timePicker12Hour : false,
				format : 'YYYY/MM/DD HH:mm',
				calender_style : "picker_4",
				parentEl : '#CalenderModal',
				startDate : data_inicio
			});

			$('#data_fim_reserva').daterangepicker({
				singleDatePicker : true,
				timePicker : true,
				timePickerIncrement : 15,
				timePicker12Hour : false,
				format : 'YYYY/MM/DD HH:mm',
				calender_style : "picker_4",
				parentEl : '#CalenderModal',
				startDate : data_fim
			});

			$('#reserva_evento').click();

			$(".antosubmit").on("click", function() {

				var title = $("#title").val();

				categoryClass = $("#event_type").val();

				if (title) {
					var inicio = new Date($('#data_inicio_reserva').val());
					var fim = new Date($('#data_fim_reserva').val());

					var hora_fim = fim.getHours();
					var hora_inicio = inicio.getHours();
					var dia_fim = fim.getDate();
					var dia_inicio = inicio.getDate();

					if (dia_fim > dia_inicio) {
						allDay = false;
					} else {
						if (hora_fim && hora_inicio)
							allDay = false;
						else
							allDay = true;
					}

					if (calEvent) {
						var reserva_edit = {
								id : calEvent.id,
								title : title,
								start : inicio,
								end : fim,
								allDay : allDay,
								url : " "
							};

							$.ajax({
								url : "${pageContext.request.contextPath}/reserva/api/salvar_edit",
								type : "POST",
								contentType : "application/json; charset=utf-8",
								data : JSON.stringify(reserva_edit), //Stringified Json Object
								async : false, //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
								cache : false, //This will force requested pages not to be cached by the browser  
								processData : false, //To avoid making query String instead of JSON
								success : function(resposeJsonObject) {
									calendar.fullCalendar('updateEvent', calEvent);

									$('.antoclose').click();
								},
								error : function(error) {
									return false;
								}
							});											
					}
					else {
						calendar.fullCalendar('renderEvent', {
							title : title,
							start : inicio,
							end : fim,
							allDay : allDay
						}, true);
						$('#antoform2').submit();
					}
				}

				calendar.fullCalendar('unselect');

				$('.antoclose').click();

			});
		}
	</script>
</body>
</html>