<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>  
	<head>
		<title>Manutenção de Integração Multiponto</title>
		<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/rede.js"></script>
	</head>
	<body>
		<div class="row-fluid">
		  	<div class="span12">
				<div class="tabbable">

					<%@ include file="menu.jsp"%>
	
					<div class="tab-content">
	
						<form:form cssClass="form-horizontal"
							action="${pageContext.request.contextPath}/configuracoes/redes/cadastro/salvar"
							commandName="rede" method="post">
	
							<fieldset>
	
								<title>Manutenção de Integração Multiponto</title>
	
								<div class="control-group">
									<form:hidden path="id" />
									<c:if test="${message != '' and message != null}">
										<div class="alert alert-error">${message}</div>
									</c:if>
								</div>
								
								<div class="control-group">
									<label class="control-label" for="nome">Nome</label>
									<div class="controls">
										<form:input path="nome" cssClass="span3" placeholder="Preencha o nome da rede." />
										<form:errors cssClass="native-error" path="nome" />
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label" for="documento">Documento Matriz</label>
									<div class="controls">
										<form:input path="documento" cssClass="span3 cnpj" placeholder="Preencha o Documento da Matriz." />	
										<form:errors cssClass="native-error" path="documento" />
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label" for="login">Login Rede</label>
									<div class="controls">
										<form:input path="login" cssClass="span3" placeholder="Preencha o login da rede." />	
										<form:errors cssClass="native-error" path="login" />
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label" for="senha">Senha Rede</label>
									<div class="controls">
										<form:input path="senha" cssClass="span3" placeholder="Preencha a senha da rede." />	
										<form:errors cssClass="native-error" path="senha" />
									</div>
								</div>
					
								<div id="pontos" class="control-group">
								
									<label class="control-label">Pontos</label>
									
									<div class="controls">
										<input type="hidden" id="nNome" value="pontos" />
										<input type="hidden" id="nNomeItem" value="ponto" />					
										<input type="hidden" id="nemp" value="${fn:length(rede.pontos)}" /> 
										<input type="hidden" id="tempEmp.id" />
										<input type="text" class="span3" id="tempEmp.nome" autocomplete="off" placeholder="Digite o nome do ponto" /> 
										<button type="button" class="btn" disabled="disabled" id="addEmpBtn" onclick="javascript: rede.addEmpresa()"><i class="icon-plus"></i></button>
									</div>
	
									<c:forEach items="${rede.pontos}" var="ponto"
										varStatus="status">
	
										<div class="controls">
	
											<form:hidden path="pontos[${status.index}].id" />
											<form:input cssClass="span3 ponto" readonly="true" path="pontos[${status.index}].nome" />
												
											<a id="del${status.index}" class="btn"
												onclick="rede.removeEmpresa(${status.index});"><i class="icon-minus"></i></a>
											
											<ul>
												<c:forEach var="property" items="${ponto.properties}">
													<li> 
														<strong>${property.key}:</strong> ${property.value}
													</li> 
												</c:forEach>
											</ul>
											
										</div>
									</c:forEach>
									
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
		
		<div id="modalEmpAlert" class="modal hide fade">
		  	<div class="modal-header">
		    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		    	<h3>Atenção</h3>
		  	</div>
		  	<div class="modal-body">
		   		<p>Você buscou um ponto mais ainda não o adicionou à lista de pontos associados à rede. Clique no botão + ao lado do campo de pesquisa de pontos para adicioná-lo ou clique em submeter para ignorar e confirmar o cadastro.</p>
		  	</div>
		  	<div class="modal-footer">
		    	<a href="#" data-dismiss="modal" class="btn btn-primary">Voltar ao Cadastro</a>
		    	<a href="javascript: rede.ignoreEmpAndContinue();" class="btn">Submeter</a>
		  	</div>
		</div>
		
		<script type="text/javascript">
			$(function() {

				$('#tempEmp\\.nome') 
				.typeahead(
					{

						source : function(query, process) {
							
							$('#addEmpBtn').attr('disabled',true);
							
							return $
									.get(
											'${pageContext.request.contextPath}/api/ponto/getall',
											{
												query : query
											},
											function(data) {
												
												var newData = new Array();
												
												for(i = 0; i < data.length; i++){
													
													existe = false;
													
													$("#pontos").find('.controls > .ponto').each(function(index){
														
														if(data[i].nome == $(this).val())
															existe = true;
													});
													
													if(!existe){
														newData[newData.length] = data[i];
													}
												}
												
												
												$('#tempEmp\\.id').val("");
												var resultList = newData
														.map(function(item) {
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
							
							this.query = this.query.substring(0, this.query.indexOf("_"));
							
							return ~item.nome.toLowerCase()
									.indexOf(this.query.toLowerCase());
						},

						sorter : function(items) {
							var beginswith = [], caseSensitive = [], caseInsensitive = [];
							
							this.query = this.query.substring(0, this.query.indexOf("_"));
							
							while (aItem = items.shift()) {
								var item = JSON.parse(aItem);
								if (!item.nome.toLowerCase()
										.indexOf(
												this.query
														.toLowerCase()))
									beginswith.push(JSON
											.stringify(item));
								else if (~item.nome
										.indexOf(this.query))
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
							
							this.query = this.query.substring(0, this.query.indexOf("_"));
							
							var item = JSON.parse(obj);
							var query = this.query.replace(
									/[\-\[\]{}()*+?.,\\\^$|#\s]/g,
									'\\$&');
							return item.nome.replace(new RegExp(
									'(' + query + ')', 'ig'),
									function($1, match) {
										return '<strong>' + match
												+ '</strong>';
									});
						},

						updater : function(obj) {
						
							var item = JSON.parse(obj);
							
							$('#tempEmp\\.id').val(item.id);
							
							if(item.id != null && item.id != undefined)
								$('#addEmpBtn').attr('disabled',false);
							
							return item.nome;
						}
					});	
			
			});
		</script>
				
	</body>
</html>