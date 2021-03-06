<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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

<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
<!--[if IE]><link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico""/><![endif]-->

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
<%-- <script
	src="${pageContext.request.contextPath}/resources/js/nprogress.js"></script>
 --%>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	
<!--  Validador para CPF/CNPJ -->
<script src="${pageContext.request.contextPath}/resources/js/validadoc.js"></script>	


<!-- input mask -->
    <script src="${pageContext.request.contextPath}/resources/js/input_mask/jquery.inputmask.js"></script>
    
<!-- mask money -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery.maskMoney.js"></script>

<%-- <!-- gauge js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/gauge/gauge.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/gauge/gauge_demo.js"></script>
 --%><!-- chart js -->
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
	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jcarousellite.js"></script>

<!-- select2 -->
<link href="${pageContext.request.contextPath}/resources/css/select/select2.min.css" rel="stylesheet">
        <!-- select2 -->
        <script src="${pageContext.request.contextPath}/resources/js/select/select2.full.js"></script>
    
<style>

#carosel{background:#a45; width:556px; height: 400px !important;}
#carosel img{width:150px; padding:5px; border:1px solid #ccc; margin:0 5px;}


${css}
.ranges{
    width: initial !important;
    float: initial !important;
 }

.minuteselect{
	margin-right: 5px  !important;
}

.select2-selection__clear {
	/* CLEAR DO SELECT */
	display: none !important;
}

.calendar-date{
	float: left !important;}

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


<!-- <script>
	NProgress.start();
</script>
 -->
<style type="text/css">

.circulo {
    background-color: rgba(0,0,0,0);
    border: 5px solid rgba(0,183,229,0.9);
    opacity: .9;
    border-top: 5px solid rgba(0,0,0,0);
    border-left: 5px solid rgba(0,0,0,0);
    border-radius: 50px;
    box-shadow: 0 0 35px #2187e7;
    width: 50px;
    height: 50px;
    margin: 0 auto;
    -moz-animation: spin .5s infinite linear;
    -webkit-animation: spin .5s infinite linear;
    animation: spin .5s infinite linear;
}

/*circulo*/
@keyframes spin {
    0% {
        transform: rotate(0deg);
    }

    100% {
        transform: rotate(360deg);
    }
}

@keyframes spinoff {
    0% {
        transform: rotate(0deg);
    }

    100% {
        transform: rotate(-360deg);
    }
}

@-webkit-keyframes spin {
    0% {
        -webkit-transform: rotate(0deg);
    }

    100% {
        -webkit-transform: rotate(360deg);
    }
}

@-webkit-keyframes spinoff {
    0% {
        -webkit-transform: rotate(0deg);
    }

    100% {
        -webkit-transform: rotate(-360deg);
    }
}

@-moz-keyframes spin {
    0% {
        -moz-transform: rotate(0deg);
    }

    100% {
        -moz-transform: rotate(360deg);
    }
}

@-moz-keyframes spinoff {
    0% {
        -moz-transform: rotate(0deg);
    }

    100% {
        -moz-transform: rotate(-360deg);
    }
}
/*--*/

.calendar-time{
	float:left !important;
	border-color: #b94a48 !important;
}

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
    }),
    $(".select2_single").select2({
        placeholder: "Select a state",
        allowClear: true
    });
    $(".select2_group").select2({});
    $(".select2_multiple").select2({
        placeholder: "With Max Selection limit 4",
        allowClear: true
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
						<a href="<c:url value="/home" />" class="site_title"><img
							src="${pageContext.request.contextPath}/resources/images/prime_icon.svg" /></a>
					</div>
					<div class="clearfix"></div>
					<!-- menu prile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<c:if test="${user.imagemURL == null || user.imagemURL == ''}"> 
								<img src="${pageContext.request.contextPath}/resources/images/user.png" alt="..." class="img-circle profile_img">
							</c:if>
							<c:if test="${user.imagemURL != null && user.imagemURL != ''}"> 
								<img src="${user.imagemURL}" alt="..." class="img-circle profile_img">
							</c:if>
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
									<li><a><i class="fa fa-home"></i> Reservas <span
											class="fa fa-chevron-down"></span></a>
										<ul class="nav child_menu" style="display: none">
											<li><a href="<c:url value="/home" />">Calendário</a></li>
										</ul></li>
								</sec:authorize>
								<c:if test="${user.role != 'ROLE_COTISTA' && user.role != 'ROLE_MARINHEIRO'}">
									<li><a><i class="fa fa-edit"></i>Cadastros<span class="fa fa-chevron-down"></span></a>
										<ul class="nav child_menu" style="display: none">
											<sec:authorize url="/terceiro/cadastro">
												<li><a href="<c:url value="/terceiro/" />">Cadastros</a></li>
											</sec:authorize>
											<sec:authorize url="/usuarios/cadastro">
												<li><a href="<c:url value="/usuarios/" />">Usuários</a></li>
											</sec:authorize>	
											<sec:authorize url="/produtos">
												<li><a href="<c:url value="/produtos/" />">Embarcações</a></li>
											</sec:authorize>
											<sec:authorize url="/grupo">
												<li><a href="<c:url value="/grupo/" />">Grupo</a></li>
											</sec:authorize>
											<sec:authorize url="/manutencao">
												<li><a href="<c:url value="/manutencao/" />">Manutenção</a></li>
											</sec:authorize>
										</ul>
									</li>
								</c:if>
								<!-- Relatorios -->
								<sec:authorize url="/relatorios/">
									<li><a><i class="fa fa-bar-chart-o"></i>Relatorios<span
											class="fa fa-chevron-down"></span></a>
										<ul class="nav child_menu" style="display: none">
											<li><a href="<c:url value="/faturamento/historico/" />">Relatório Manutenção/Horas</a></li>
										</ul></li>
								</sec:authorize>
								
								<!-- Faturamento -->
								<sec:authorize url="/faturamento/">
									<li><a><i class="fa fa-usd"></i>Faturar<span
											class="fa fa-chevron-down"></span></a>
										<ul class="nav child_menu" style="display: none">
											<li><a href="<c:url value="/faturamento/" />">Faturar</a></li>
										</ul></li>
								</sec:authorize>
							</ul>
						</div>
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
							<li class="">
								<a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
									<c:if test="${user.imagemURL == null || user.imagemURL == ''}"> 
										<img src="${pageContext.request.contextPath}/resources/images/user.png" alt=""/>${user.nome} <span class=" fa fa-angle-down"></span>
									</c:if>
									<c:if test="${user.imagemURL != null && user.imagemURL != ''}"> 
										<img src="${user.imagemURL}" alt=""/>${user.nome} <span class=" fa fa-angle-down"></span>
									</c:if>
								</a>
								<ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
									<li><a href="<c:url value="/usuarios/alterarSenha/${user.idUser}" />">Perfil</a></li>
									<li><a href="<c:url value="/terceiro/perfil/${user.idTerceiro}" />">Cadastro</a></li>
									<li><a href="<c:url value="/auth/logout" />"><i class="fa fa-sign-out pull-right"></i>Sair</a></li>
								</ul>
							</li>
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

	<script>
        $(document).ready(function () {
            $(":input").inputmask();
        });
    </script>

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
