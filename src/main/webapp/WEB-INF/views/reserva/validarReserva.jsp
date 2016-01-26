<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>PRIME SHARE CLUB</title>

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
	<section class="main_content">
	<div class="page-title">
		<div class="title_left">
			<h3>Validação de reservas</h3>
		</div>
	</div>
	<div class="clearfix"></div>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
			
				<c:if test="${message != '' && message != null}">
					<div>
						<div class="alert">${message}</div>
					</div>
				</c:if>
				
				<c:if test="${message == '' || message == null}">
			
					<form:form cssClass="form-horizontal"
								action="${pageContext.request.contextPath}/reserva/validar/salvar"
								commandName="reservaValidacao" method="POST">
								
						<form:hidden path="uid" />
						<form:hidden path="aprovado" />
								
						<div class="x_title">
							<h2>Validação de reservas</h2>
							<div class="clearfix"></div>
						</div>
						<div class="wizar_content">
							<br />
							<label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"></label>
							<div class="form-group">
								<div class="col-md-6 col-sm-6 col-xs-12">
									Eu ${reservaValidacao.terceiro.nome},  
									<input type="radio" value="true" checked="checked" id="optionsRadios1" name="optionsRadios"> aprovo
									<input type="radio" value="false" id="optionsRadios2" name="optionsRadios"> reprovo
									a reserva a seguir
								</div>
							</div>
						</div>
						<div class="wizar_content">
							<br />
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="first-name">Motivo
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:textarea path="motivo"
										cssClass="form-control col-md-7 col-xs-12"
										placeholder="Preencha o motivo" />
								</div>
							</div>
						</div>
						<div class="x_title">
							<h2>Dados da solicitação</h2>
							<div class="clearfix"></div>
						</div>
						<div class="wizar_content">
							<br />
	
							<form:hidden path="id" />
		
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="first-name">Embarcação
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="reserva.grupo.produtos[0].descricao"
										cssClass="form-control col-md-7 col-xs-12" readonly="true"/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="first-name">Solicitante
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="reserva.solicitante.nome"
										cssClass="form-control col-md-7 col-xs-12" readonly="true" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Data/Hora inicio</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="reserva.inicioReserva"
										cssClass="form-control col-md-7 col-xs-12" readonly="true" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">Data/Hora Fim</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="reserva.fimReserva"
										cssClass="form-control col-md-7 col-xs-12" readonly="true" />
								</div>
							</div>
		
							<div style="clear: both"></div>
							<br />
							<br />
							<div class="form-actions">
								<button id="confirmar" type="button" class="btn btn-primary">Confirmar</button>
							</div>
						</div>
					</form:form>
				</c:if>
			</div>

		</div>
	</div>
	
	<script type="text/javascript">
	
	
		$("#confirmar").click(
				function(){
					if($('input[name=optionsRadios]:checked').val() == "true"){
						$("#aprovado").val(true);
						$("form").submit();
					}
					else{
						$("#aprovado").val(false);
						if($('#motivo').val() == "")
							alert("Informe um motivo!");
						else
							$("form").submit();
					}
				});

	
	</script>
	
</section>	
</body>

</html>