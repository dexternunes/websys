<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<title>Teste</title>

</head>
<body>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
		    	<div class="x_title">
					<h3>Upload de Imagens</h3>
					<div class="clearfix"></div>
				</div>
			    <div class="x_content">
			    
			    	<form:form cssClass="form-horizontal"
						action="${pageContext.request.contextPath}/reservaEvento/salvar"
						commandName="reservaEvento" method="post">
						
						
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12">Tempo do motor<span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<form:input path="hora"
									cssClass="form-control col-md-1"
									 data-inputmask="'mask' : '99999'" />
									<form:errors cssClass="native-error" path="hora"></form:errors>
							</div>
						</div>
						
						
					</form:form>
			    
		        	<form name="form-product-id" id="main-form">
						<input id="fileupload" type="file" name="fileupload" accept="image/jpeg; image/gif; image/bmp; image/png"  data-url="${pageContext.request.contextPath}/reservaEvento/upload?reservaEventoId=1&isInicio=true" multiple style="opacity: 0; filter:alpha(opacity: 0);">
					</form>	
				
					<p><div style="color:red" class="jquery_error"></div></p>
						
					<c:if test="${error != null}">
						<p><div style="color:red" class="controller_error">Error: ${error}</div></p>
					</c:if>
					
					</br> 
					<button id="btn-upload" class="btn btn-primary">Escolher Fotos</button> ou (Arraste as fotos)
					<div id="dropbox" class="upload">
						<c:choose>
				
							<c:when test="${fn:length(reservaEvento.imagens) == 0}">
								<p>Nenhuma foto cadastrada ainda, arraste ou escolha uma foto no botão acima.</p>
							</c:when>	
						
							<c:when test="${fn:length(reservaEvento.imagens) >= 5}">
								<ul class="thumbnails">
									<c:forEach var="photo" items="${reservaEvento.imagens}">
										<li class="span3">
											<a href="#" class="thumbnail">
												<img src="${photo.url}" />
											</a>
											<a class="btn btn-danger btn-small remove"  onclick="deleteImage('<c:url value="/reservaEvento/imagem/delete/${photo.id}" />')">Remover</a>
										</li>
									</c:forEach>
								</ul>
							</c:when>
						
							<c:when test="${fn:length(reservaEvento.imagens) < 5}">
								<ul class="thumbnails">
									<c:forEach var="photo" items="${reservaEvento.imagens}">
										<li class="span3">
											<a href="#" class="thumbnail">
												<img src="${photo.url}" />
											</a>
											<a class="btn btn-danger btn-small remove"  onclick="deleteImage('<c:url value="/reservaEvento/imagem/delete/${photo.id}" />')">Remover</a>
										</li>
									</c:forEach>
								</ul>
							</c:when>
					
						</c:choose>
						
						<div style="display: none;" class="progress progress-striped active">
							<div class="bar" style="width: 100%;"></div>
						</div>
				    </div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).bind('drop dragover', function(e) {
			e.preventDefault();
		});

		var $interval;
		
		function deleteImage(url){

			$("body").mask("Aguarde ...");
			$('.progress.active .bar').css('width', '0%');
			
			$.get(url,function(data) {
			}).done(function() {
				document.location="${pageContext.request.contextPath}/reservaEvento/1";
			  })
			  .fail(function() {
			    alert( "Erro ao remover a imagem" );
			  })
			  .always(function() {
				$('.progress.active .bar').css('width', '0%');
				$('.progress').hide();
			  });
		}
		
		function prepareUpload() {
			$('.progress').hide();

			$("#btn-upload").click(function() {
				$("#fileupload").trigger('click');
			});

			var upload = $('#fileupload').fileupload({
				dropZone : $('#dropbox'),
				pasteZone : $(document),
				acceptFileTypes : /(\.|\/)(gif|jpe?g|png)$/i ,
				done : function(e, data) {
					$("div.active:not(.progress)").html(data.result);
					document.location="${pageContext.request.contextPath}/reservaEvento/1";
				},
				change : function(e, data) {
					var total = data.files.length + $("a.thumbnail").length;
					if (total > 5) {
						alert("Só é possível realizar o upload de até 5 fotos.");
						upload.abort();
					}
				},
				start : function(e, data) {
					if ($("a.thumbnail").length <= 5) {
						$("body").mask("Aguarde ...");
						$(".progress").show();
						$('.progress.active .bar').css('width', '0%');
					} else {
						alert("Só é possível realizar o upload de até 5 fotos.");
						upload.abort();
					}
				},
				always : function(e) {
					$("body").unmask();
					$('.progress').hide();
				},
				progressall : function(e, data) {
					var progress = parseInt(data.loaded / data.total * 100, 10);
					$('.progress.active .bar').css('width', progress + '%');
				} 
			}); 
		}

		$(document).ready(function () {
			prepareUpload();
		});
		
		
	</script>					
</body>
</html>