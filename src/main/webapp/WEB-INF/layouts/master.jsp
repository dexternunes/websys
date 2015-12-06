<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/maps/jquery-jvectormap-2.0.1.css" />
<link
	href="${pageContext.request.contextPath}/resources/css/icheck/flat/green.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/floatexamples.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/calendar/fullcalendar.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/calendar/fullcalendar.print.css"
	rel="stylesheet" media="print">


<!-- Scripts -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/nprogress.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>



<!-- gauge js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/gauge/gauge.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/gauge/gauge_demo.js"></script>
<!-- chart js -->
<script
	src="${pageContext.request.contextPath}/resources/js/chartjs/chart.min.js"></script>
<!-- bootstrap progress js -->
<script
	src="${pageContext.request.contextPath}/resources/js/progressbar/bootstrap-progressbar.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/nicescroll/jquery.nicescroll.min.js"></script>
<!-- icheck -->
<script
	src="${pageContext.request.contextPath}/resources/js/icheck/icheck.min.js"></script>
<!-- daterangepicker -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/datepicker/daterangepicker.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/custom.js"></script>


<!-- flot js -->
<!--[if lte IE 8]><script type="text/javascript" src="js/excanvas.min.js"></script><![endif]-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.pie.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.orderBars.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.time.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/date.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.spline.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.stack.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/curvedLines.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/flot/jquery.flot.resize.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/dropzone/dropzone.js"></script>

<link
	href="${pageContext.request.contextPath}/resources/bootstrap-fileinput/css/fileinput.css"
	media="all" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/upload.css"
	media="all" rel="stylesheet" type="text/css" />

<script
	src="${pageContext.request.contextPath}/resources/bootstrap-fileinput/js/fileinput.min.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap-fileinput/js/fileinput_locale_pt-BR.js"
	type="text/javascript"></script>

<script
	src="${pageContext.request.contextPath}/resources/js/jquery.ui.widget.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.iframe-transport.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.fileupload.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.loadmask.min.js"
	type="text/javascript"></script>

<style>
#holder {
	border: 10px dashed #ccc;
	width: 300px;
	min-height: 300px;
	margin: 20px auto;
}

#holder.hover {
	border: 10px dashed #0c0;
}

#holder img {
	display: block;
	margin: 10px auto;
}

#holder p {
	margin: 10px;
	font-size: 14px;
}

progress {
	width: 100%;
}

progress:after {
	content: '%';
}

.fail {
	background: #c00;
	padding: 2px;
	color: #fff;
}

.hidden {
	display: none !important;
}
</style>


<script>
	NProgress.start();
</script>

<style type="text/css">
/*
.speech-bubble {
	margin-left: 10px;
	background-color: #FF6F6F;
	border: 1px solid #FF6F6F;
	border-radius: 10px;
	width: 35% !important;
	height: 38px !important;
	text-align: center;
	padding: 8px;
	position: absolute;
	left: 100%;
}

.speech-bubble .arrow {
	border-top: 8px solid transparent;
	border-bottom: 8px solid transparent;
	border-right: 8px solid #FF6F6F;
	border-style: solid;
	position: absolute;
	text-align:center;
}

.bottom {
	border-color: #FF6F6F transparent transparent transparent;
	border-width: 8px 8px 8px 8px;
	bottom: 30%;
	right: 100%;
	text-align:center;
}

.bottom:after {
	border-color: #FF6F6F transparent transparent transparent;
	border-style: solid;
	border-width: 7px 7px 0px 7px;
	position: absolute;
	text-align:center;
}
*/
.native-error {
	color: #b94a48;
}

.native-error-message {
	color: #b94a48;
}

input.cerror, select.cerror, textarea.cerror {
	border-color: #b94a48;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	-moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	color: #b94a48;
}

input.cerror:focus, select.cerror:focus, textarea.cerror:focus {
	border-color: #953b39;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px
		#d59392;
	-moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px #d59392;
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px #d59392;
	color: #b94a48;
}
</style>

<!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
<script type="text/javascript">
$(document).ready(function() {

    $(".onlyNumbers").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl+A, Command+A
            (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || 
             // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
    
    $(document).ready(function () {
        $(".select2_single").select2({
            placeholder: "Select a state",
            allowClear: true
        });
        $(".select2_group").select2({});
        $(".select2_multiple").select2({
            maximumSelectionLength: 4,
            placeholder: "With Max Selection limit 4",
            allowClear: true
        });
    });
});



</script>
</head>
<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.html" class="site_title"><img
							src="${pageContext.request.contextPath}/resources/images/prime_icon.svg" /></a>
					</div>
					<div class="clearfix"></div>
					<!-- menu prile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<img
								src="${pageContext.request.contextPath}/resources/images/user.png"
								alt="..." class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Bem vindo,</span>
							<h2>${user.nome}</h2>
						</div>
					</div>
					<br />
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<div>&nbsp</div>
							<ul class="nav side-menu">
								<sec:authorize url="/home">
									<li><a><i class="fa fa-home"></i> Home <span
											class="fa fa-chevron-down"></span></a>
										<ul class="nav child_menu" style="display: none">
											<li><a href="<c:url value="/home" />">Home</a></li>
											<%-- 											<li><a href="<c:url value="/agenda/agenda" />">Agenda</a> --%>
											<!-- 											</li> -->
											<li><a href="<c:url value="/relatorios/manutencao" />">Relatório
													de Manutenção</a></li>
										</ul></li>
								</sec:authorize>
								<sec:authorize url="/configuracoes/">
									<li><a><i class="fa fa-edit"></i>Cadastros<span
											class="fa fa-chevron-down"></span></a>
										<ul class="nav child_menu" style="display: none">
											<li><a href="<c:url value="/terceiro/" />">Terceiro</a></li>
											<li><a href="<c:url value="/usuarios/" />">Usuarios</a>
											</li>
											<li><a href="<c:url value="/produtos/" />">Produtos</a>
											</li>
											<li><a href="<c:url value="/grupo/" />">Grupo</a></li>
										</ul></li>
								</sec:authorize>
							</ul>
						</div>
					</div>
					<div class="sidebar-footer hidden-small">
						<a data-toggle="tooltip" data-placement="top" title="Settings">
							<span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="FullScreen">
							<span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Lock"> <span
							class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Logout">
							<span class="glyphicon glyphicon-off" aria-hidden="true"></span>
						</a>
					</div>
				</div>
			</div>
			<div class="top_nav">
				<div class="nav_menu">
					<nav class="" role="navigation">
						<div class="nav toggle">
							<a id="menu_toggle"><i class="fa fa-bars"></i></a>
						</div>
						<ul class="nav navbar-nav navbar-right">
							<li class=""><a href="javascript:;"
								class="user-profile dropdown-toggle" data-toggle="dropdown"
								aria-expanded="false"> <img
									src="${pageContext.request.contextPath}/resources/images/user.png"
									alt="">${user.nome} <span class=" fa fa-angle-down"></span>
							</a>
								<ul
									class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
									<li><a href="javascript:;">Perfil</a></li>
									<li><a href="<c:url value="/auth/logout" />"><i
											class="fa fa-sign-out pull-right"></i>Sair</a></li>
								</ul></li>
						</ul>
					</nav>
				</div>
			</div>
			<div class="right_col" role="main">
				<decorator:body />
			</div>
		</div>
	</div>
	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('.native-error')
									.each(
											function(index) {
												var fieldName = '#'
														+ this.id.replace(".errors", "").replace(/\./g,'\\.');
												$(fieldName).attr('title',this.innerHTML);
												$(fieldName).addClass("cerror red-tooltip");
												/*$(
														'<div class="speech-bubble col-md-3 col-sm-3 col-xs-12"><div class="arrow bottom"></div>'
																+ this.innerHTML
																+ '</div>')
														.insertAfter(
																$('.native-error'));*/
											});
						});
	</script>

</body>
</html>
