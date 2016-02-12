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

<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<script>
	function ExibeGaleriaSaida() {
		var htmlDiv = '';

		$('#imagensSaida img').each(function() {
			if(htmlDiv == ''){
				htmlDiv = '<div class="item active"> <img src="'+$(this)[0].src+'"></div>';
			}
			else
				htmlDiv += '<div class="item"> <img src="'+$(this)[0].src+'"></div>'; 
		});
		
		$('#itens').html(htmlDiv);

		$('#imagemModal').modal('show');
	}

	function ExibeGaleriaChegada() {

		var htmlDiv = '';

		$('#imagensChegada img').each(function() {
			if(htmlDiv == ''){
				htmlDiv = '<div class="item active"> <img src="'+$(this)[0].src+'"></div>';
			}
			else
				htmlDiv += '<div class="item"> <img src="'+$(this)[0].src+'"></div>'; 
		});
		
		$('#itens').html(htmlDiv);

		$('#imagemModal').modal('show');
	}
</script>

<style >
a:link {
    color: white;
}
</style>

</head>
<body>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h3>Imagens da saída.</h3>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<div class="attachment" id="imagensSaida">
						<c:forEach items="${reserva.eventoInicio.imagens}" var="imagem">
							<div class="col-md-55">
								<div class="thumbnail">
									<div class="view view-first">
										<img src="${imagem.url}" style="width: 100%; display: block;"
											onclick="ExibeGaleriaSaida()" />
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="clearfix"></div>
				<div class="x_title">
					<h3>Imagens da Chegada.</h3>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<div class="attachment" id="imagensChegada">
						<c:forEach items="${reserva.eventoFim.imagens}" var="imagem">
							<div class="col-md-55">
								<div class="thumbnail">
									<div class="view view-first">
										<img src="${imagem.url}" style="width: 100%; display: block;"
											class="imagem" onclick="ExibeGaleriaChegada()" />
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="imagemModal">
		<div class="modal-dialog" style="width: 75% !important;">
			<div id="exibeImagem">
				<button type="button" class="close" data-dismiss="modal"
					id="fechaModal" aria-hidden="true">x</button>
				<div class="clearfix"></div>
				<div class="modal-body">
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
						<div class="carousel-inner" role="listbox" id="itens">
						</div>

						<a class="left carousel-control" href="#myCarousel" role="button"
							data-slide="prev"> <span
							class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
							<span class="sr-only">Anterior</span>
						</a> <a class="right carousel-control" href="#myCarousel"
							role="button" data-slide="next"> <span
							class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
							<span class="sr-only">Próximo</span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>