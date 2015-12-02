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
<title>Cadastro de Produto</title>

    <!-- select2 -->

        
        <script>
            $(document).ready(function () {
                $(".select2_single").select2({
                    placeholder: "Select a state",
                    allowClear: true
                });
                $(".select2_group").select2({});
                $(".select2_multiple").select2({
                    maximumSelectionLength: 4,
                    placeholder: "With Max Selection limit 4",
                    allowClear: true
                });
            });
        </script>
        <!-- /select2 -->

	<!-- Select -->
	<link href="${pageContext.request.contextPath}/resources/css/select/select2.min.css" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/resources/js/select/select2.full.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/countries.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/autocomplete/jquery.autocomplete.js"></script>
	<!-- Select -->
</head>
<body >
	<div class="left_col" role="main">
		<div class="">

			<div class="page-title">
				<div class="title_left">
					<h3>Cadastro de Produto</h3>
				</div>
			</div>
			<div class="clearfix"></div>
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="x_panel">
						<div class="x_title">
							<h2>Produto</h2>
							<div class="clearfix"></div>
						</div>
						<div class="wizar_content">
							<br />

							<form:form cssClass="form-horizontal"
								action="${pageContext.request.contextPath}/produtos/cadastro/salvar"
								commandName="produto" method="post">

								<form:hidden path="id" />


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">ID <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="id"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o id do produto." />
									</div>
								</div>
							

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Descrição <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="descricao"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha a descrição do produto." />
									</div>
								</div>
								
								
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Marca <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="marca"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha a marca do produto." />
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Modelo <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="modelo"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o modelo do produto." />
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Altura <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="altura"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha a altura do produto." />
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Largura <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="largura"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha a largura do produto." />
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Tipo do produto <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="tipoProduto"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o tipo do produto." />
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Status <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="status"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o status do produto." />
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">Select
										Custom</label>
									<div class="col-md-9 col-sm-9 col-xs-12">
										<select class="select2_single form-control" tabindex="-1">
											<option value="AK">Alaska</option>
											<option value="HI">Hawaii</option>
											<option value="CA">California</option>
											<option value="NV">Nevada</option>
											<option value="OR">Oregon</option>
											<option value="WA">Washington</option>
											<option value="AZ">Arizona</option>
											<option value="CO">Colorado</option>
											<option value="ID">Idaho</option>
											<option value="MT">Montana</option>
											<option value="NE">Nebraska</option>
											<option value="NM">New Mexico</option>
											<option value="ND">North Dakota</option>
											<option value="UT">Utah</option>
											<option value="WY">Wyoming</option>
											<option value="AR">Arkansas</option>
											<option value="IL">Illinois</option>
											<option value="IA">Iowa</option>
											<option value="KS">Kansas</option>
											<option value="KY">Kentucky</option>
											<option value="LA">Louisiana</option>
											<option value="MN">Minnesota</option>
											<option value="MS">Mississippi</option>
											<option value="MO">Missouri</option>
											<option value="OK">Oklahoma</option>
											<option value="SD">South Dakota</option>
											<option value="TX">Texas</option>
										</select>
									</div>
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