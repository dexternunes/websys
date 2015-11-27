<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>

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

	<title>Autentica��o do Usu�rio</title>
</head>

<body>

	<div class="alert alert-info">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<h4>Aguarde!</h4>
		Estamos realizando a autentica��o do usu�rio.
	</div>

	<form name="login_form" id="login_form" action="${pageContext.request.contextPath}/j_spring_security_check" method="post"> 
		<input type="hidden" id="j_username" name="j_username" value="${j_username}"> 
		<input type="hidden" id="j_password" name="j_password" value="${j_password}">
	</form>

	<script type="text/javascript">
		$('#login_form').submit();
	</script>

</body>

</html>