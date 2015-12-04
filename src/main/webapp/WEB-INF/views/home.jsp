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
						<form id="antoform" class="form-horizontal calender" role="form">
							<div class="form-group">
								<label class="col-sm-3 control-label">Título</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="title" name="title">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Descrição</label>
								<div class="col-sm-9">
									<textarea class="form-control" style="height: 55px;" id="descr"
										name="descr"></textarea>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default antoclose"
						data-dismiss="modal">Fechar</button>
					<button type="button" class="btn btn-primary antosubmit">Salvar
						</button>
				</div>
			</div>
		</div>
	</div>
	<div id="CalenderModalEdit" class="modal fade" tabindex="-1"
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
					<button type="button" class="btn btn-primary antosubmit2">Salvar
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

	<script>
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
			});
		});
	</script>
</body>

</html>