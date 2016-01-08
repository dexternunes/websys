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

<style type="text/css">
body {
	background-color: #1c3c6a;
	background-image:
		url("${pageContext.request.contextPath}/resources/images/background_login.jpg");
	background-repeat: no-repeat;
	background-position: center top;
}
</style>
</head>
<body>
	<div class="">
		<a class="hiddenanchor" id="toregister"></a> <a class="hiddenanchor"
			id="tologin"></a>

		<div id="wrapper">
			<div id="login" class="animate form">
				<section class="login_content">
					<form:form action="${pageContext.request.contextPath}/usuarios/recuperarsenha/submitnova"
						commandName="definirNovaSenhaDTO" method="post">
						<h1>
							<img
								src="${pageContext.request.contextPath}/resources/images/prime_login.png"
								width="98" height="130" />
						</h1>
						
						<form:hidden path="idUser" />
						<form:hidden path="uid" />
						
						<c:if test="${message != '' && message != null}">
							<div>
								<div class="alert alert-error">${message}</div>
							</div>
						</c:if>
						<c:if test="${messageOk != '' && messageOk != null}">
							<div>
								<div class="alert alert-info">${messageOk}</div>
							</div>
						</c:if>
						<div>
							<input type="password" class="form-control" placeholder="Nova Senha"
								id="senha" name="senha" style="margin-bottom: 20px;">
						</div>
						<div>
							<input type="password" class="form-control" placeholder="Repetir Senha"
								id="repetirSenha" name="repetirSenha">
						</div>
						<div>
							<a id="confirmar" class="btn btn-default submit">Confirmar</a>
						</div>
						<div class="clearfix"></div>
						<div class="separator">

							<div class="clearfix"></div>
							<br />
							<div>
								<h1>
									<i style="font-size: 26px;"></i> PRIME SHARE CLUB
								</h1>

								<p>©2015 All Rights Reserved.</p>
							</div>
						</div>
					</form:form>
					<!-- form -->
				</section>
				<!-- content -->
			</div>
		</div>
	</div>
<script type="text/javascript">
		$(document).ready(function() {
	
			$( "#confirmar" ).click(function() {
				$('form').submit();
			});
			
			$( '#senha' ).keypress(function (e) {
				  if (e.which == 13) {
					  $('form').submit();
				    return false;    //<---- Add this line
				  }
			});

	
			
		});
	</script>
</body>

</html>