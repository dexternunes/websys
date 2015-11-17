<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>  
	<head>
		<title>Manuten��o de Integra��o Multiponto</title>
	</head>
	<body>
		<div class="row-fluid">
		  	<div class="span12">
				<div class="tabbable">

					<%@ include file="menu.jsp"%>
	
					<div class="tab-content">
	
						<form:form cssClass="form-horizontal"
							action="${pageContext.request.contextPath}/configuracoes/pontos/cadastro/salvar"
							commandName="ponto" method="post">
	
							<fieldset>
	
								<title>Manuten��o de Ponto de Rede</title>
	
								<div class="control-group">
									<form:hidden path="id" />
									<c:if test="${message != '' and message != null}">
										<div class="alert alert-error">${message}</div>
									</c:if>
								</div>
								
								<form:hidden path="rede.id" />
								
								<div class="control-group">
									<label class="control-label" for="nome">Nome</label>
									<div class="controls">
										<form:input path="nome" cssClass="span3" placeholder="Preencha o nome do ponto." />
										<form:errors cssClass="native-error" path="nome" />
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label" for="entidade.nome">Entidade</label>
									<div class="controls">

										<form:hidden path="entidade.id" />

										<form:input path="entidade.nome"
											readonly="${empresa.id != null}"
											autocomplete="off" cssClass="span3" 
											placeholder="Preencha o nome da entidade associada" />
											
										<form:errors cssClass="native-error" path="entidade.nome" />

									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label">Par�metros</label>
									<div class="controls">
									
										<ul>
											<c:forEach var="property" items="${ponto.properties}">
												<li> 
													<strong>${property.key}:</strong> ${property.value}
												</li> 
											</c:forEach>
										</ul>
									</div>
								</div>
	
								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Confirmar</button>									
								</div>
	
							</fieldset>
	
						</form:form>
	
					</div>
				</div>
			</div>
		</div>	
		
		<script type="text/javascript">
			$(function() {

				$('#entidade\\.nome').blur(function() {
				  	if($(this).val() == ""){
				  		$('#entidade\\.id').val("");
				  	}	
				  	if($('#entidade\\.id').val() == ""){
				  		$(this).val("");
				  	}	
				});
				
				$('#entidade\\.nome')
						.typeahead(
								{
	
									source : function(query, process) {
	
										return $
												.get(
														'${pageContext.request.contextPath}/api/entidade/getall',
														{
															query : query
														},
														function(data) {
															$(
																	'#entidade\\.id')
																	.val("");
															var resultList = data
																	.map(function(
																			item) {
																		var aItem = {
																			id : item.id,
																			nome : item.nome
																		};
																		return JSON
																				.stringify(aItem);
																	});
															return process(resultList);
														});
									},
	
									matcher : function(obj) {
										var item = JSON.parse(obj);
										return ~item.nome.toLowerCase().indexOf(
												this.query.toLowerCase());
									},
	
									sorter : function(items) {
										var beginswith = [], caseSensitive = [], caseInsensitive = [];
										while (aItem = items.shift()) {
											var item = JSON.parse(aItem);
											if (!item.nome.toLowerCase().indexOf(
													this.query.toLowerCase()))
												beginswith.push(JSON
														.stringify(item));
											else if (~item.nome.indexOf(this.query))
												caseSensitive.push(JSON
														.stringify(item));
											else
												caseInsensitive.push(JSON
														.stringify(item));
										}
										return beginswith.concat(caseSensitive,
												caseInsensitive);
									},
	
									highlighter : function(obj) {
										var item = JSON.parse(obj);
										var query = this.query.replace(
												/[\-\[\]{}()*+?.,\\\^$|#\s]/g,
												'\\$&');
										return item.nome.replace(new RegExp('('
												+ query + ')', 'ig'),
												function($1, match) {
													return '<strong>' + match
															+ '</strong>';
												});
									},
	
									updater : function(obj) {
										var item = JSON.parse(obj);
										$('#entidade\\.id').val(item.id);
										return item.nome;
									}
								}).focus();
			});
		</script>
				
	</body>
</html>