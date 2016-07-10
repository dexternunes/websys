<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html lang="en">

<head>

<style>
#myImg {
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
}

#myImg:hover {opacity: 0.7;}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

/* Modal Content (image) */
.modal-content {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
}

/* Caption of Modal Image */
#caption {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
    text-align: center;
    color: #ccc;
    padding: 10px 0;
    height: 150px;
}

/* Add Animation */
.modal-content, #caption {
    -webkit-animation-name: zoom;
    -webkit-animation-duration: 0.6s;
    animation-name: zoom;
    animation-duration: 0.6s;
}

@-webkit-keyframes zoom {
    from {-webkit-transform:scale(0)}
    to {-webkit-transform:scale(1)}
}

@keyframes zoom {
    from {transform:scale(0)}
    to {transform:scale(1)}
}

/* The Close Button */
.close {
    position: absolute;
    top: 15px;
    right: 35px;
    color: #f1f1f1;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
}

.close:hover,
.close:focus {
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
    .modal-content {
        width: 100%;
    }
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>PRIME SHARE CLUB</title>

<!-- Bootstrap core CSS -->

<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

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
				
				<c:forEach items="${reserva.eventoInicio.imagens}" var="imagem"  varStatus="status">
					<img id="myImgSaida${status.index}" src="${imagem.url}" width="300" height="200" onclick="exibe(${status.index}, 1)">
				</c:forEach>
				<!-- The Modal -->
				<div id="myModal" class="modal">
				
				  <!-- The Close Button -->
				  <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>
				
				  <!-- Modal Content (The Image) -->
				  <img class="modal-content" id="img01">
				</div>
				
				<div class="clearfix"></div>
				<div class="x_title">
					<h3>Imagens da Chegada.</h3>
					<div class="clearfix"></div>
				</div>
				<c:forEach items="${reserva.eventoFim.imagens}" var="imagem"  varStatus="status">
					<img id="myImgChegada${status.index}" src="${imagem.url}" width="300" height="200" onclick="exibe(${status.index}, 0)">
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="modal fade" id="imagemModal">
		<div class="modal-dialog" style="">
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
	
	<script>
		
		function exibe(idx, saida){
			
			var img = "";
			
			if(saida)
				img = document.getElementById('myImgSaida'+idx);
			else
				img = document.getElementById('myImgChegada'+idx);
			
			modal.style.display = "block";
		    modalImg.src = img.src;
		    modalImg.alt = img.alt;
		    captionText.innerHTML = img.alt;
		}
		
		var modal = document.getElementById('myModal');
		
		var modalImg = document.getElementById("img01");
		var captionText = document.getElementById("caption");
		
		var span = document.getElementsByClassName("close")[0];
		
		span.onclick = function() {
		    modal.style.display = "none";
		}
	</script>
</body>
</html>