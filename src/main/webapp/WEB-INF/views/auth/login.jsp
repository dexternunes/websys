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

	<form:form cssClass="form-signin"
		action="${pageContext.request.contextPath}/auth/login"
		commandName="user" method="post">

		<div class="">
			<a class="hiddenanchor" id="toregister"></a> <a class="hiddenanchor"
				id="tologin"></a>

			<div id="wrapper">
				<div id="login" class="animate form">
					<section class="login_content" style="padding-top:0px">
						<h1>Sistema de Reservas</h1>
						<c:if test="${message != '' && message != null}">
							<div>
								<div class="alert alert-error">${message}</div>
							</div>
						</c:if>
						<div>
							<input type="text"  class="form-control"
								placeholder="Nome de Usuário" id="loginl" name="login" style="margin-bottom: 20px;">
						</div>
						<div>
							<input type="password" class="form-control"
								placeholder="Senha de Acesso" id="senha" name="senha" >
						</div>
						
						<div>
							<button class="btn btn-default submit" type="submit" style="margin-top:20px">Entrar</button>
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