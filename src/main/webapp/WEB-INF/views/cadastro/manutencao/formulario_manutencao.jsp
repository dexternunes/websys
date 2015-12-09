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
<title>Cadastro de Manutenção</title>

</head>
<body >
	<div class="" role="main">
		<div class="">

			</div>
			<div class="clearfix"></div>
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="x_panel">
						<div class="x_title">
							<h2>Manutenção</h2>
							<div class="clearfix"></div>
						</div>
						<div class="wizar_content">
							<br />

							<form:form cssClass="form-horizontal"
								action="${pageContext.request.contextPath}/manutencao/cadastro/salvar"
								commandName="manutencao" method="post">

								<form:hidden path="id" />


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="tipos">Produto <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:select path="produto" multiple="false" cssClass="select2_multiple form-control">
											<form:options items="${listaProdutos}" itemValue="id"
												itemLabel="descricao"></form:options>
										</form:select>
									</div>
									<form:errors cssClass="native-error" path="produto"></form:errors>
								</div>

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Descrição <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="obs"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha a descrição da manutenção." />
										<form:errors cssClass="native-error" path="obs"></form:errors>
									</div>
								</div>
								

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Data/Hora início <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="inicioManutencao"
											cssClass="form-control col-md-7 col-xs-12"
											data-inputmask="'mask' : '99/99/9999 99:99:99'"
											placeholder="Preencha a data de início." />
										<form:errors cssClass="native-error" path="inicioManutencao"></form:errors>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Data/Hora final <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="fimManutencao"
											cssClass="form-control col-md-7 col-xs-12"
											data-inputmask="'mask' : '99/99/9999 99:99:99'"
											placeholder="Preencha a data/hora final." />
										<form:errors cssClass="native-error" path="fimManutencao"></form:errors>
									</div>
								</div>
								

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Valor <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="valor"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o valor." />
										<form:errors cssClass="native-error" path="valor"></form:errors>
									</div>
								</div>
								


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Status <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:select path="status" multiple="false" class="select2_single form-control" tabindex="-1">
											<form:options items="${listaManutencaoStatus}" itemValue="code"
												itemLabel="descricao"></form:options>
										</form:select>
										<form:errors cssClass="native-error" path="status"></form:errors>
									</div>
								</div>

								 

								<div style="clear: both"></div>
								<br />
								<br />
								<div class="form-actions">
									<button type="submit" class="btn btn-primary">Confirmar</button>
								</div>
								
								<div class="control-group">
									<a type="button" class="btn btn-primary"
										href="${pageContext.request.contextPath}/manutencao/">Voltar</a>
								</div>

							</form:form>
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