<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>  
	<head>
		<title>Cadastro de Terceiro</title>
	</head>
	<body>
		<div class="row-fluid">
		  	<div class="span12">
				<div class="tabbable">

					<%@ include file="menu.jsp"%>
	
					<div class="tab-content">
	
						<form:form cssClass="form-horizontal"
							action="${pageContext.request.contextPath}/configuracoes/terceiros/cadastro/salvar"
							commandName="terceiro" method="post">
	
							<fieldset>
	
								<title>Cadastro de Terceiro</title>
	
								<div class="control-group">
									<c:if test="${message != '' and message != null}">
										<div class="alert alert-error">${message}</div>
									</c:if>
								</div>
								
								<form:hidden path="id" />
								
								<div class="control-group">
									<label class="control-label" for="nome">Nome</label>
									<div class="controls">
										<form:input path="nome" cssClass="span3" placeholder="Preencha o nome do terceiro." />
										<form:errors cssClass="native-error" path="nome" />
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label" for="nome">Documento</label>
									<div class="controls">
										<form:input path="documento" cssClass="span3" placeholder="Preencha o documento do terceiro." />
										<form:errors cssClass="native-error" path="documento" />
									</div>
								</div>
								
								<div class="control-group" id="emails">
									<label class="control-label" for="emails">Emails</label>							
									
									<input type="hidden" id="nEmails" value="${fn:length(terceiro.emails)}" />
										
									<c:forEach items="${terceiro.emails}" var="email" varStatus="status">

										<div class="controls">
	
											<form:input cssClass="span3" path="emails[${status.index}]" placeholder="exemplo@exemplo.com.br" />
											<form:errors cssClass="native-error" path="emails[${status.index}]" />
	
											<c:if test="${status.index == 0}">
												<a id="add${status.index}" class="btn" onclick="config.newEmail();"><i class="icon-plus"></i></a>
											</c:if>
	
											<c:if
												test="${fn:length(configuracaoEmpresa.emails) - 1 == status.index and status.index > 0}">
												<a id="del${status.index}" class="btn" onclick="config.removeEmail();"><i class="icon-minus"></i></a>
											</c:if>
	
										</div>

									</c:forEach>
									
									<c:if test="${fn:length(terceiro.emails) == 0}">
										<div class="controls">
											<form:input cssClass="span3" path="emails[0]" placeholder="exemplo@exemplo.com.br" />
											<a id="add${status.index}" class="btn" onclick="config.newEmail();"><i class="icon-plus"></i></a>
										</div>
									</c:if>
									
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
			config = {
				
				currentEmail : null,
				
				newEmail : function () {
					
					this.currentEmail++;
					
					var copy = $("#emails").find('.controls').first().html();
					
					copy = copy.replace(/emails\[0\]/gi, 'emails[' + this.currentEmail + ']');
					copy = copy.replace(/emailss0/gi, 'emails' + this.currentEmail);
					
					if(this.currentEmail > 1)
						$("#emails").find('.controls > #del'+ (this.currentEmail - 1)).last().remove();
					
					$("#emails").append('<div class="controls"> ' + copy + ' <a id="del' + this.currentEmail + '" class="btn" onclick="config.removeEmail();"><i class="icon-minus"></i></a></div>');
					
					$(':input','#emails > .controls:last-child')
						.not(':button, :submit, :reset, :hidden').val('')
						.removeAttr('checked')
						.removeAttr('selected');
					
					$("#emails").find('.controls > #add0').last().remove();
				},
				
				removeEmail : function () {
					
					this.currentEmail--;
					
					$("#emails").find('.controls').last().remove();
					
					if(this.currentEmail > 0)
						$("#emails").find('.controls').last().append('<a id="del' + this.currentEmail + '" class="btn" onclick="config.removeEmail();"><i class="icon-minus"></i></a>');
					
				}
			};
		</script>
				
	</body>
</html>