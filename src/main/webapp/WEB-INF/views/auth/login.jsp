<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>

<title>Prime Share</title>

<link href="../resources/css/bootstrap.min.css" rel="stylesheet">

<link href="../resources/fonts/css/font-awesome.min.css"
	rel="stylesheet">
<link href="../resources/css/animate.min.css" rel="stylesheet">

<!-- Custom styling plus plugins -->
<link href="../resources/css/custom.css" rel="stylesheet">
<link href="../resources/css/icheck/flat/green.css" rel="stylesheet">


<script src="../resources/js/jquery.min.js"></script>
    <!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
</head>

<body style="background:#F7F7F7;">

	<c:if test="${message != '' && message != null}">
		<div class="alert alert-error">${message}</div>
	</c:if>

	<form:form cssClass="form-signin"
		action="${pageContext.request.contextPath}/auth/login"
		commandName="user" method="post">

		<div class="">
			<a class="hiddenanchor" id="toregister"></a> <a class="hiddenanchor"
				id="tologin"></a>

			<div id="wrapper">
				<div id="login" class="animate form">
					<section class="login_content">
						<h1>Prime Share</h1>
						<div>

							<input type="text" autofocus="autofocus" class="form-control"
								placeholder="Nome de Usuário" id="loginl" name="login">
						</div>
						<div>
							<input type="password" class="form-control"
								placeholder="Senha de Acesso" id="senha" name="senha">
						</div>
						<div>
							<button class="btn btn-default submit" type="submit">Entrar</button>
						</div>

						<div class="clearfix"></div>
						<div class="separator">
					</section>
					<!-- content -->
				</div>
			</div>
		</div>

	</form:form>

</body>

</html>