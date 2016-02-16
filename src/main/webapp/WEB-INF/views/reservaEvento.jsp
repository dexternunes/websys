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
					<h3>Registro de Embarcação</h3>
					<div class="clearfix"></div>
				</div>
			    <div class="x_content">
			    
			    	<c:if test="${message != '' && message != null}">
						<div>
							<div class="alert alert-error">${message}</div>
						</div>
					</c:if>
			    
			    	<form:form cssClass="form-horizontal"
						action="${pageContext.request.contextPath}/reservaEvento/salvar?submit=true"
						commandName="reservaEvento" method="post">
						
						
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12">Tempo do motor<span class="required">*</span></label>
							<form:hidden path="id"/>
							<div class="col-md-2 col-sm-2">
								<form:input path="hora" cssClass="form-control col-md-2"/>
								<form:errors cssClass="native-error" path="hora"></form:errors>
							</div>
						</div>
						
						
					</form:form>
			    
		        	<form name="form-product-id" id="main-form">
						<input id="fileupload" type="file" name="fileupload" accept="image/jpeg;image/gif;image/bmp;image/png"  data-url="${pageContext.request.contextPath}/reservaEvento/upload?reservaEventoId=${reservaEvento.id}&isInicio=true" multiple style="opacity: 0; filter:alpha(opacity: 0);">
					</form>	
				
					<p><div style="color:red" class="jquery_error"></div></p>
					
					</br> 
					<button id="btn-upload" class="btn btn-primary">Escolher Fotos</button> ou (Arraste as fotos)
					<div id="dropbox" class="upload">
						<p>Arraste e solte aqui.</p>
						<div style="display: none;" class="progress progress-striped active">
							<div class="bar" style="width: 100%;"></div>
						</div>
				    </div>
				    
				    <div class="attachment">
						<c:forEach var="photo" items="${reservaEvento.imagens}">
							<div class="col-md-55">
								<div class="thumbnail">
									<div class="view view-first">
										<img src="${photo.url}" style="width: 100%; display: block;"/>
										<div class="mask">
                                            <div class="tools tools-bottom">
                                                <a onclick="deleteImage('<c:url value="/reservaEvento/imagem/delete/${photo.id}?reservaEventoId=${reservaEvento.id}" />')"><i class="fa fa-times"></i></a>
                                            </div>
                                        </div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				    
				    <div style="clear: both"></div>
					<br />
					<div class="form-actions">
						<button type="button" onclick="javascript:submit()" class="btn btn-primary">Salvar</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
		function submit(){
			$("#reservaEvento").submit();
		}
	
		$(document).bind('drop dragover', function(e) {
			e.preventDefault();
		});

		var $interval;
		
		function deleteImage(url){

			$("body").mask("Aguarde ...");
			$('.progress.active .bar').css('width', '0%');
			
			$.get(url,function(data) {
			}).done(function() {
				window.location = "${pageContext.request.contextPath}/reservaEvento/${reservaEvento.id}";
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
				acceptFileTypes : /(\.|\/)(gif|jpg|jpeg|png)$/i ,
				done : function(e, data) {
					$("div.active:not(.progress)").html(data.result);
					window.location = "${pageContext.request.contextPath}/reservaEvento/${reservaEvento.id}";
				},
				change : function(e, data) {

				},
				start : function(e, data) {
					$("body").mask("Aguarde ...");
					$(".progress").show();
					$('.progress.active .bar').css('width', '0%');
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
		
		$('#hora').inputmask('99999',{placeholder:'0', numericInput:true});
		$('#minuto').inputmask('99',{placeholder:'0', numericInput:true});
		$('#segundo').inputmask('99',{placeholder:'0', numericInput:true});
		
	</script>					
</body>
</html>