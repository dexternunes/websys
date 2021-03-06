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
<title>Cadastro de Grupo</title>
</head>
<body>
	<div class="page-title">
		<div class="title_left">
			<h3>Cadastro de Grupo</h3>
		</div>
	</div>
	<div class="clearfix"></div>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>Grupo</h2>
					<div class="clearfix"></div>
				</div>
				<div class="wizar_content">
					<br />
					
					<c:if test="${message != '' && message != null}">
						<div>
							<div class="alert alert-error">${message}</div>
						</div>
					</c:if>

					<form:form cssClass="form-horizontal"
						action="${pageContext.request.contextPath}/grupo/cadastro/salvar"
						commandName="grupo" method="POST">

						<form:hidden path="id" />

						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="first-name">Grupo <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<form:input path="descricao"
									cssClass="form-control col-md-7 col-xs-12"
									placeholder="Preencha a descri��o do grupo" />
								<form:errors cssClass="native-error" path="descricao"></form:errors>
							</div>
						</div>

						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="first-name">Produto <span class="required">*</span>
							</label>
							
							<div class="col-md-6 col-sm-6 col-xs-12">
								<c:if test="${!readonly}">
									<form:select path="produtos" multiple="false" readonly="readonly" cssClass="select2_single form-control select2_readonly">
										<form:options items="${listProdutos}" itemValue="id" itemLabel="descricao" />
									</form:select>
									<form:errors cssClass="native-error" path="produtos"></form:errors>
								</c:if>
								<c:if test="${readonly}">
									<form:input path="produtos[0].descricao" cssClass="form-control col-md-7 col-xs-12" readonly="${readonly}"/>
									<form:hidden path="produtos[0].id"/>
								</c:if>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="first-name">Cotistas <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<%-- <c:if test="${!readonly}"> --%>
									<form:select path="terceiros" multiple="true" cssClass="select2_multiple form-control">
										<form:options items="${listTerceiros}" itemValue="id" itemLabel="nome"></form:options>
									</form:select>
									<form:errors cssClass="native-error" path="terceiros"></form:errors>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="first-name">Marinheiros <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<%-- <c:if test="${!readonly}"> --%>
									<form:select path="marinheiros" multiple="true" cssClass="select2_multiple form-control">
										<form:options items="${listMarinherios}" itemValue="id" itemLabel="nome"></form:options>
									</form:select>
									<form:errors cssClass="native-error" path="marinheiros"></form:errors>
							</div>
						</div>						
														
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="first-name">Ativo </label>
							<form:checkbox style="margin-left:10px; margin-top:10px;"
								path="ativo" />
						</div>
						
						
						<div style="clear: both"></div>
						<br />
						<br />
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">Confirmar</button>
							<c:if test="${grupo.id != null && user.role != 'ROLE_COTISTA' && user.role != 'ROLE_MARINHEIRO'}">
								<button type="button" class="btn btn-danger" id="excluirGrupo">Excluir</button>
							</c:if>
						</div>

					</form:form>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	$('#excluirGrupo').click(function(){
		window.location = "${pageContext.request.contextPath}/grupo/cadastro/excluir/${grupo.id}";				
	});
</script>

</body>
</html>