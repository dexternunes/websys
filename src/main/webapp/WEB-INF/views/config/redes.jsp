<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>  
	<head>
		<title>Listagem de Integrações Multiponto</title>
	</head>
	<body>
		<div class="row">
		  	<div class="span12">
				<div class="tabbable">

					<%@ include file="menu.jsp"%>
	
					<div class="tab-content">
					
						<form:form cssClass="form-horizontal" method="post">
	
							<fieldset>
	
								<legend>
									Listagem de Integrações Multiponto
								</legend>
								
								<div class="control-group">
	
									<c:if test="${message != '' and message != null}">
										<div class="alert alert-error">${message}</div>
									</c:if>
	
								</div>
								
								<div class="control-group">
								
									<sec:authorize url="/configuracoes/redes/cadastro"> 
										<p><a class="btn btn-primary" href="<c:url value="/configuracoes/redes/cadastro" />" type="button">Criar Rede</a></p>										
									</sec:authorize>
								
											
									<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="consultatable">
										
										<thead>
											<tr>
												<th>Nome</th>
												<th>CNPJ</th>	
												<th>Nº de Pontos</th>						
											</tr>
										</thead>
										
										<tbody>
										
											<c:forEach items="${redes}" var="rede" varStatus="status">
				
												<tr>
													<td oName="id" oValue="${rede.id}">${rede.nome}</td>
													<td>${rede.documento}</td>
													<td>${fn:length(rede.pontos)}</td>
												</tr>
				
											</c:forEach>
										
										</tbody>
									</table>
								</div>
							</fieldset>
	
						</form:form>
					
					</div>
				</div>
			</div>
		</div>	
		
		<script type="text/javascript">
	
			entities = {
					
				oTable : null,
				
				currentEntityId : null,
				
				notyOpened : false,
				
				changeMenu : function () {
					
					var selection = entities.oTable.Selected();			
					
					if (selection.length > 0){
						
						entities.currentEntityId = selection[0].id;
						
						if(!entities.notyOpened){
							noty({
								text: '<strong>Escolha a opção desejada!</strong>',
								type: 'alert',
								layout: 'top',
								buttons: [
						           	{
						           		addClass: 'btn btn-primary', text: 'Cadastro Geral', onClick: function($noty) {
						           		$noty.close();
							               	document.location = "${pageContext.request.contextPath}/configuracoes/redes/cadastro/" + entities.currentEntityId;
							            }
						           	},
						           	{
						           		addClass: 'btn btn-danger', text: 'Cancel', onClick: function($noty) {
							               	$noty.close();
							            }
						           	}
						         ],
					         	callback: {
					        	    onShow: function() { entities.notyOpened = true; },
					        	    afterShow: function() {},
					        	    onClose: function() { },
					        	    afterClose: function() { entities.notyOpened = false; }
					        	  },
							});	
						}
					}
					else
						$.noty.closeAll();
				}
			};
		
			$(document).ready(function () {
				
				entities.oTable = $('#consultatable').kappDataTable({ 
					"MultiRowSelection": false,
					"trClickCallback" : entities.changeMenu,
					"sortColumn" : 0,
			        "sortOrder" : "asc"
				});		
			} );
		</script>		
	</body>
</html>
