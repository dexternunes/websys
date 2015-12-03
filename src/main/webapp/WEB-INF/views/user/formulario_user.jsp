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
	<div class="left_col" role="main">
		<div class="">

			<div class="page-title">
				<div class="title_left">
					<h3>Cadastro de Usuário</h3>
				</div>
			</div>
			<div class="clearfix"></div>
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="x_panel">
						<div class="x_title">
							<h2>Usuário</h2>
							<div class="clearfix"></div>
						</div>
						<div class="wizar_content">
							<br />

							<form:form cssClass="form-horizontal"
								action="${pageContext.request.contextPath}/usuarios/cadastro/salvar"
								commandName="usuario" method="post">

								<form:hidden path="id" />


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Login <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="login"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o login do usuário." />
									</div>
								</div>
								

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Senha <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="senha"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha a senha do usuário." />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Nome <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="nome"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o nome do usuário." />
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Terceiro <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="terceiro.id"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Selecione o terceiro." />
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Role <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:select path="role" multiple="false" class="select2_single form-control" tabindex="-1">
											<form:options items="${listaUserRole}" itemValue="code"
												itemLabel="role"></form:options>
										</form:select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Ativo 
									</label><form:checkbox style="margin-left:10px; margin-top:10px;" path="ativo"/>
								</div>

							
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Excluído
									</label><form:checkbox style="margin-left:10px; margin-top:10px;" path="excluido"/>
								</div>


								<div style="clear: both"></div>
								<br />
								<br />
								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Confirmar</button>
								</div>

							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type='text/javascript'>

		function Required() {

		}
	</script>
</body>
</html>