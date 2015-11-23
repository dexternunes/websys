<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>

	<title><decorator:title default="System" /></title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="../resources/fonts/css/font-awesome.min.css"
		rel="stylesheet">
	<link href="../resources/css/animate.min.css" rel="stylesheet">
	<link href="../resources/css/custom.css" rel="stylesheet">
	<link href="../resources/css/icheck/flat/green.css" rel="stylesheet">
	<script src="../resources/js/jquery.min.js"></script>

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://static.scsul.com.br/js/html5shiv.js"></script>
    <![endif]-->

<decorator:head />

</head>

<body style="background:#F7F7F7">

	<div class="container">
		<div class="row">
			<div class="span12">
				<decorator:body />
			</div>
		</div>
	</div>

</body>
</html>