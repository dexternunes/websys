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

<!--[if lt IE 9]>
            <script src="../assets/js/ie8-responsive-file-warning.js"></script>
            <![endif]-->

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
              <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
            <![endif]-->

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
					<button type="button" class="btn btn-primary confirma_reserva">Confirmar</button>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- footer content -->
	<!-- /footer content -->
	<div id="CalenderModalNew" class="modal fade" tabindex="-1"
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
				<div class="modal-body">
					<div id="testmodal2" style="padding: 5px 20px;">					
							<div class="form-group">
								<label class="col-sm-3 control-label">Solicitante</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
								<form:hidden path="solicitante"/>
									<input type="text" value="${solicitante.nome}" id="title" 
 										Class="form-control col-md-7 col-xs-12" />
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
						<button type="submit" class="btn btn-primary antosubmit">Confirmar
					</button>
					</div>
				</div>
				</form:form>
			</div>
		</div>
	</div>
<!-- 	<div id="CalenderModalEdit" class="modal fade" tabindex="1" -->
<!-- 		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<button type="button" class="close" data-dismiss="modal" -->
<!-- 						aria-hidden="true">×</button> -->
<!-- 					<h4 class="modal-title" id="myModalLabel2">Editar reserva</h4> -->
<!-- 				</div> -->
<%-- 				<form:form id="antoform2" class="form-horizontal calender" commandName="reserva" --%>
<%-- 					action="${pageContext.request.contextPath}/reserva/salvar"> --%>
<!-- 				<div class="modal-body"> -->
<!-- 					<div id="testmodal2" style="padding: 5px 20px;"> -->
<!-- 							<label class="col-sm-3 control-label">Solicitante</label> -->
<!-- 								<div class="col-md-6 col-sm-6 col-xs-12"> -->
<%-- 								<form:hidden path="solicitante"/> --%>
<%--  								<input type="text" value="${solicitante.nome}" id="title2" --%>
<!--   										Class="form-control col-md-7 col-xs-12" readonly="true" /> -->
<!-- 								</div> -->
<!-- 							<div class="clearfix"></div> -->
<!-- 							<div class="form-group"> -->
<!-- 								<label class="col-sm-3 control-label">Grupo</label> -->
<!-- 								<div class="col-md-6 col-sm-6 col-xs-12"> -->
<%-- 									<form:select path="grupo" multiple="false" --%>
<%-- 										cssClass="select2_single form-control"> --%>
<%--  										<form:options items="${grupos}" itemValue="id" itemLabel="descricao"/> --%>
<%-- 									</form:select> --%>
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div class="clearfix"></div> -->
<!-- 							<div class="form-group"> -->
<!-- 								<label class="col-sm-3 control-label">Início(Data/Hora)</label> -->
<!-- 								<div class="col-md-6 xdisplay_inputx form-group has-feedback"> -->
<%-- 									<form:input id="data_inicio_reserva2" path="inicioReserva" --%>
<%-- 										class="form-control has-feedback-left data_reserva2" --%>
<%-- 										style="z-index: 9999 !important;" type="text" --%>
<%-- 										data-inputmask="'mask' : '9999/99/99 99:99'" --%>
<%-- 										aria-describedby="inputSuccess2Status4" --%>
<%-- 										placeholder="Data/Hora"></form:input> <span --%>
<!-- 										class="fa fa-calendar-o form-control-feedback left" -->
<!-- 										aria-hidden="true"></span> <span id="inputSuccess2Status4" -->
<!-- 										class="sr-only"></span> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div class="clearfix"></div> -->
<!-- 							<div class="form-group"> -->
<!-- 								<label class="col-sm-3 control-label">Fim</label> -->
<!-- 								<div class="col-md-6 xdisplay_inputx form-group has-feedback"> -->
<%-- 									<form:input id="data_fim_reserva2" path="fimReserva" --%>
<%-- 										class="form-control has-feedback-left data_reserva2" --%>
<%-- 										style="z-index: 9999 !important;" type="text" --%>
<%-- 										data-inputmask="'mask' : '9999/99/99 99:99'" --%>
<%-- 										aria-describedby="inputSuccess2Status4" --%>
<%-- 										placeholder="Data/Hora"></form:input> <span --%>
<!-- 										class="fa fa-calendar-o form-control-feedback left" -->
<!-- 										aria-hidden="true"></span> <span id="inputSuccess2Status4" -->
<!-- 										class="sr-only"></span> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div class="clearfix"></div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="modal-footer"> -->
<!-- 				<div class="form-actions"> -->
<!-- 					<button type="button" id="remove" class="btn btn-default">Excluir</button> -->
<!-- 					<button type="button" class="btn btn-default antoclose2" -->
<!-- 						data-dismiss="modal">Fechar</button> -->
<!-- 					<button type="submit" class="btn btn-primary antosubmit2">Confirmar -->
<!-- 					</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<%-- 				</form:form> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<div id="fc_create" data-toggle="modal" data-target="#CalenderModalNew"></div>
	<div id="fc_edit" data-toggle="modal" data-target="#CalenderModalEdit"></div>
	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/js/calendar/fullcalendar.min.js"></script>


	<!-- 	<!-- daterangepicker -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/moment.min2.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/datepicker/daterangepicker.js"></script>

	<script>
		var reservasJSON = [];
		var novasreservasJSON = new Array([ "titulo", ], [ "inicio", ], ["fim", ], [ "tododia", ]);
		var novasreservasJSON_index = 0;

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
				//esse alert estourava toda vez que eu logava no sistema. Por isso comentei.
				//alert("error");
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

													$('#data_inicio_reserva').daterangepicker({
																		singleDatePicker : true,
																		timePicker : true,
																		timePickerIncrement : 15,
																		timePicker12Hour : false,
																		format : 'YYYY/MM/DD hh:mm',
																		calender_style : "picker_4",
																		parentEl : '#CalenderModalNew',
																		startDate : moment(start).format("YYYY/MM/DD")+ "06:00"
																	});

													$('#data_fim_reserva').daterangepicker({
																		singleDatePicker : true,
																		timePicker : true,
																		timePickerIncrement : 15,
																		timePicker12Hour : false,
																		format : 'YYYY/MM/DD hh:mm',
																		calender_style : "picker_4",
																		parentEl : '#CalenderModalNew',
																	});

													$("#data_inicio_reserva").val(moment(start).format("YYYY/MM/DD")+ "06:00");
													$('#fc_create').click();

													$(".antosubmit").on("click",function() {

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
																				//if(hora_fim && hora_inicio)
																				allDay = false;
																				/*else
																					allDay=true;*/
																			} else {
																				if (hora_fim
																						&& hora_inicio)
																					allDay = false;
																				else
																					allDay = true;
																			}

																			calendar.fullCalendar('renderEvent',
																							{
																								title : title,
																								start : inicio,
																								end : fim,
																								allDay : allDay
																							},
																							true // make the event "stick"
																					);

																			novasreservasJSON[0][novasreservasJSON_index] = title;
																			novasreservasJSON[1][novasreservasJSON_index] = inicio;
																			novasreservasJSON[2][novasreservasJSON_index] = fim;
																			novasreservasJSON[3][novasreservasJSON_index] = allDay;

																			novasreservasJSON_index++;
																		}

// 																		$('#title').val('');
// 																		$('#data_inicio_reserva').val('');
// 																		$('#data_fim_reserva').val('');
// 																		$('#hora_inicio_reserva').val('');
// 																		$('#hora_fim_reserva').val('');

																		calendar.fullCalendar('unselect');

																		$('.antoclose').click();

																	});
												},
												eventClick : function(calEvent,jsEvent, view) {

													$('#data_inicio_reserva2').daterangepicker(
																	{
																		singleDatePicker : true,
																		timePicker : true,
																		timePickerIncrement : 15,
																		timePicker12Hour : false,
																		format : 'YYYY/MM/DD hh:mm',
																		calender_style : "picker_4",
																		parentEl : '#CalenderModalEdit',
																		startDate : moment(calEvent.start).format("YYYY/MM/DD hh:mm")
																	},
																	function(start,end,label) {
																		console.log(start.toISOString(),end.toISOString(),label);
																	});

													$('#data_fim_reserva2').daterangepicker(
																	{
																		singleDatePicker : true,
																		timePicker : true,
																		timePickerIncrement : 15,
																		timePicker12Hour : false,
																		format : 'YYYY/MM/DD hh:mm',
																		calender_style : "picker_4",
																		parentEl : '#CalenderModalEdit',
																		startDate : moment(calEvent.end).format("YYYY/MM/DD hh:mm")
																	},
																	function(start,end,label) {
																		console.log(start.toISOString(),end.toISOString(),label);
																	});

													$("#data_inicio_reserva2").val(moment(calEvent.start).format("YYYY/MM/DD hh:mm"));
													$("#data_fim_reserva2").val(moment(calEvent.end).format("YYYY/MM/DD hh:mm"));

													$('#remove').click(function() {
																		calendar.fullCalendar('removeEvents',calEvent._id);
																		$('.antoclose2').click();
																	});

													$('#fc_edit').click();
													$('#title2').val(calEvent.title);
													categoryClass = $("#event_type").val();

													$(".antosubmit2").on("click", function() {

																		var inicio2 = new Date($("#data_inicio_reserva2").val());
																		var fim2 = new Date($("#data_fim_reserva2").val());

																		var hora_fim2 = fim2.getHours();
																		var hora_inicio2 = inicio2.getHours();
																		var dia_fim2 = fim2.getDate();
																		var dia_inicio2 = inicio2.getDate();
																		var allDay2 = false;

																		if (dia_fim2 > dia_inicio2) {
																			//if(hora_fim && hora_inicio)
																			allDay2 = false;
																			/*else
																				allDay=true;*/
																		} else {
																			if (hora_fim2
																					&& hora_inicio2)
																				allDay2 = false;
																			else
																				allDay2 = true;
																		}

																		calEvent.title = $("#title2").val();
																		calEvent.start = inicio2;
																		calEvent.end = fim2;
																		calEvent.allDay = allDay2;
																		
																		calendar.fullCalendar('updateEvent',calEvent);

// 																		$('#title2').val('');
// 																		$('#data_inicio_reserva2').val('');
// 																		$('#data_fim_reserva2').val('');
// 																		$('#hora_inicio_reserva2').val('');
// 																		$('#hora_fim_reserva2').val('');

																		$('.antoclose2').click();
																	});
													calendar.fullCalendar('unselect');
												},
												editable : false,
												events : reservasJSON
											});
						});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.confirma_reserva').click(function() {
				var reserva1 = {
					title : "teste",
					start : "2015-12-15 09:00:00",
					end : "2015-12-15 09:00:00",
					allDay : "false",
					url : "google.com.br"
				};

				$.ajax({
					url : "${pageContext.request.contextPath}/reserva/post2",
					type : "POST",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(reserva1), //Stringified Json Object
					async : false, //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
					cache : false, //This will force requested pages not to be cached by the browser  
					processData : false, //To avoid making query String instead of JSON
					success : function(resposeJsonObject) {
						alert('foi' + resposeJsonObject);
					},
					error : function(error) {
						alert('erro:' + error);
					}
				});
			});
		});
	</script>
</body>
</html>
