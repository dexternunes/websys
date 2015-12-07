<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Prime Share Club</title>
<style type="text/css">
.daterangepicker {
	position: absolute !important;
	z-index: 9999 !important;
}

.timepicker {
	position: absolute !important;
	z-index: 9999 !important;
}

.ui-timepicker-container {
	position: absolute;
	overflow: hidden;
}

.ui-timepicker {
	display: block;
	height: 200px;
	text-align: center;
	list-style: none outside none;
	overflow: auto;
	overflow-x: hidden; /* IE */
	margin: 0;
	padding: 0 0 0 1px;
	position: absolute !important;
	z-index: 9999 !important;
}

.ui-timepicker-standard {
	/* .ui-widget */
	font-family: Verdana, Arial, sans-serif;
	font-size: 1.1em;
	/* .ui-widget-content */
	background-color: #FFF;
	border: 1px solid #AAA;
	color: #222;
	/* .ui-menu */
	margin: 0;
	padding: 2px;
}

.ui-timepicker-standard a {
	/* .ui-widget-content a */
	color: #222;
}

.ui-timepicker-standard .ui-state-hover {
	/* .ui-state-hover */
	background-color: #DADADA;
	border: 1px solid #999;
	font-weight: normal;
	color: #212121;
}

.ui-timepicker-standard .ui-menu-item {
	/* .ui-menu .ui-menu-item */
	/*clear: left;
    float: left;*/
	margin: 0;
	padding: 0;
	/*width: 100%;*/
}

.ui-timepicker-standard .ui-menu-item a {
	/* .ui-menu .ui-menu-item a */
	display: block;
	padding: 0.2em 0.4em;
	line-height: 1.5;
	text-decoration: none;
}

.ui-timepicker-standard .ui-menu-item a.ui-state-hover {
	/* .ui-menu .ui-menu-item a.ui-state-hover */
	font-weight: normal;
	margin: -1px -1px -1px -1px;
}

.ui-timepicker-corners, .ui-timepicker-corners .ui-corner-all {
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
}

.ui-timepicker-hidden {
	/* .ui-helper-hidden */
	display: none;
}
</style>
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
				<div class="modal-body">
					<div id="testmodal" style="padding: 5px 20px;">
						<div class="form-group">
							<label class="col-sm-3 control-label">Solicitante</label>
							${user.nome}
						</div>
						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Início</label>
							<div class="col-md-4 xdisplay_inputx form-group has-feedback">
								<input id="data_reserva1" class="form-control has-feedback-left"
									style="z-index: 9999 !important;" type="text"
									aria-describedby="inputSuccess2Status4" placeholder="Data"></input>
								<span class="fa fa-calendar-o form-control-feedback left"
									aria-hidden="true"></span> <span id="inputSuccess2Status4"
									class="sr-only"></span>
							</div>
							<div class="col-md-4 xdisplay_inputx form-group has-feedback">
								<input id="hora_reserva1"
									class="form-control has-feedback-left timepicker"
									style="z-index: 9999 !important;" type="text"
									aria-describedby="inputSuccess2Status4" placeholder="Hora"></input>
								<span class="fa fa-calendar-o form-control-feedback left"
									aria-hidden="true"></span> <span id="inputSuccess2Status4"
									class="sr-only"></span>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Fim</label>
							<div class="col-md-4 xdisplay_inputx form-group has-feedback">
								<input id="data_reserva2" class="form-control has-feedback-left"
									style="z-index: 9999 !important;" type="text"
									aria-describedby="inputSuccess2Status4" placeholder="Data"></input>
								<span class="fa fa-calendar-o form-control-feedback left"
									aria-hidden="true"></span> <span id="inputSuccess2Status4"
									class="sr-only"></span>
							</div>
							<div class="col-md-4 xdisplay_inputx form-group has-feedback">
								<input id="hora_reserva2"
									class="form-control has-feedback-left timepicker"
									style="z-index: 9999 !important;" type="text"
									aria-describedby="inputSuccess2Status4" placeholder="Hora"></input>
								<span class="fa fa-calendar-o form-control-feedback left"
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
						<button type="submit" class="btn btn-primary antosubmit">Confirmar</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="CalenderModalEdit" class="modal fade" tabindex="1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel2">Editar reserva</h4>
				</div>
				<div class="modal-body">
					<div id="testmodal2" style="padding: 5px 20px;">
						<form id="antoform2" class="form-horizontal calender" role="form">
							<div class="form-group">
								<label class="col-sm-3 control-label">Título</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="title2"
										name="title2">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Descrição</label>
								<div class="col-sm-9">
									<textarea class="form-control" style="height: 55px;"
										id="descr2" name="descr"></textarea>
								</div>
							</div>

						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default antoclose2"
						data-dismiss="modal">Fechar</button>
					<button type="button" class="btn btn-primary antosubmit2">Confirmar
					</button>
				</div>
			</div>
		</div>
	</div>
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


	<!-- daterangepicker -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/moment.min2.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/datepicker/daterangepicker.js"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/datepicker/timepicker.js"></script>

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

			var date = new Date();
			var d = date.getDate();
			var m = date.getMonth();
			var y = date.getFullYear();
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
				select : function(start, end, allDay) {
					$('#fc_create').click();

					started = start;
					ended = end;

					$(".antosubmit").on("click", function() {
						var title = $("#title").val();
						if (end) {
							ended = end;
						}
						categoryClass = $("#event_type").val();

						if (title) {
							calendar.fullCalendar('renderEvent', {
								title : title,
								start : started,
								end : end,
								allDay : allDay
							}, true // make the event "stick"
							);
						}
						$('#title').val('');
						calendar.fullCalendar('unselect');

						$('.antoclose').click();

						return false;
					});
				},
				eventClick : function(calEvent, jsEvent, view) {
					//alert(calEvent.title, jsEvent, view);

					$('#fc_edit').click();
					$('#title2').val(calEvent.title);
					categoryClass = $("#event_type").val();

					$(".antosubmit2").on("click", function() {
						calEvent.title = $("#title2").val();

						calendar.fullCalendar('updateEvent', calEvent);
						$('.antoclose2').click();
					});
					calendar.fullCalendar('unselect');
				},
				editable : true,
				events : reservasJSON
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#data_reserva1').daterangepicker({
				singleDatePicker : true,
				format : 'DD/MM/YYYY',
				calender_style : "picker_4"
			}, function(start, end, label) {
				console.log(start.toISOString(), end.toISOString(), label);
			}),
			$('#data_reserva2').daterangepicker({
				singleDatePicker : true,
				format : 'DD/MM/YYYY',
				calender_style : "picker_4"
			}, function(start, end, label) {
				console.log(start.toISOString(), end.toISOString(), label);
			}),

			$('#hora_reserva').timepicker();
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			// initialize both timepickers at once
			$('input.timepicker').timepicker({
				timeFormat : 'hh:mm p',
				// year, month, day and seconds are not important
				minTime : new Date(0, 0, 0, 8, 0, 0),
				maxTime : new Date(0, 0, 0, 15, 0, 0),
				// time entries start being generated at 6AM but the plugin 
				// shows only those within the [minTime, maxTime] interval
				startHour : 6,
				// the value of the first item in the dropdown, when the input
				// field is empty. This overrides the startHour and startMinute 
				// options
				startTime : new Date(0, 0, 0, 8, 20, 0),
				// items in the dropdown are separated by at interval minutes
				interval : 10,
				change : function(time) {
					var element = $(this), text, color;
					var timepicker = element.timepicker();

					color = '#' + (~~(Math.random() * 16777215)).toString(16);
					element.css({
						'background' : color
					});
				}
			});
		});
	</script>
</body>
</html>