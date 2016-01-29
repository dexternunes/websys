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
<title>Cadastro de Usuário</title>
</head>
<body>
	<div role="main">
		<div class="clearfix"></div>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="row">
				<form:form cssClass="form-horizontal"
									action="${pageContext.request.contextPath}/usuarios/cadastro/salvar"
									commandName="usuario" method="post" enctype="multipart/form-data">
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="x_panel">
							<div class="x_title">
								<h2>Usuário</h2>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<br />
	
		
								<c:if test="${message != '' && message != null}">
									<div>
										<div class="alert alert-error">${message}</div>
									</div>
								</c:if>
							
								<form:hidden path="id" />

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="login">Login <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="login"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o login do usuário." readonly="${readonly}" />
										<form:errors cssClass="native-error" path="login"></form:errors>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="senha">Senha <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:password path="senha"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha a senha do usuário." />
										<form:errors cssClass="native-error" path="senha"></form:errors>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="confirmarSenha">Confirmar Senha <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:password path="confirmarSenha"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Confirme a senha do usuário." />
										<form:errors cssClass="native-error" path="senha"></form:errors>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="terceiro">Terceiro <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:select path="terceiro" multiple="false" cssClass="select2_multiple form-control" disabled="${readonly}">
											<form:options items="${listaTerceiros}" itemValue="id"
												itemLabel="nome"></form:options>
										</form:select>
									</div>
									<form:errors cssClass="native-error" path="terceiro"></form:errors>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="role">Role <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:select path="role" multiple="false" class="select2_single form-control" tabindex="-1" disabled="${readonly}">
											<form:options items="${listaUserRole}" itemValue="role"
												itemLabel="role"></form:options>
										</form:select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="ativo">Ativo 
									</label><form:checkbox style="margin-left:10px; margin-top:10px;" path="ativo" disabled="${readonly}"/>
								</div>

								<form:hidden style="margin-left:10px; margin-top:10px;" path="excluido"/>
								
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="ativo">Foto do usuário 
									</label>
									
									<form:hidden style="margin-left:10px; margin-top:10px;" path="image"/>
								
										<input id="fileupload" type="file" name="fileupload"  >
									
									<p><div style="color:red" class="jquery_error"></div></p>
										
									<c:if test="${error != null}">
										<p><div style="color:red" class="controller_error">Error: ${error}</div></p>
									</c:if>
									
									</br>  
								</div>
								
								<div style="clear: both"></div>
								<br />
								<br />
								<div class="form-actions">
									<button type="button" onclick="javascript:submitFormulario();" class="btn btn-primary">Confirmar</button>
								</div>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<script type='text/javascript'>

	function submitFormulario() {
		$("#terceiro").attr("disabled", false);
		$("#role").attr("disabled", false);
		$("#ativo").attr("disabled", false);
		$("#usuario").submit();
	}
	
	

	$(document).ready(function () {		
	});
	
	</script>
</body>
</html>