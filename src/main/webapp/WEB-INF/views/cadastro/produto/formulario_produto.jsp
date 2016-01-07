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
							<h2>Produto</h2>
							<div class="clearfix"></div>
						</div>
						<div class="wizar_content">
							<br />

							<form:form cssClass="form-horizontal" id="target"
								action="${pageContext.request.contextPath}/produtos/cadastro/salvar"
								commandName="produto" method="post">

								<form:hidden path="id" />

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Descri��o <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="descricao"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha a descri��o do produto." />
										<form:errors cssClass="native-error" path="descricao"></form:errors>
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
										<form:errors cssClass="native-error" path="marca"></form:errors>
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
										<form:errors cssClass="native-error" path="modelo"></form:errors>
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Altura <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="altura"
											cssClass="form-control col-md-7 col-xs-12 onlyNumbers"
											placeholder="Preencha a altura do produto."
											id="altura" />
										<form:errors cssClass="native-error" path="altura"></form:errors>
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Largura <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="largura"
											cssClass="form-control col-md-7 col-xs-12 onlyNumbers"
											id="largura"
											placeholder="Preencha a largura do produto." />
										<form:errors cssClass="native-error" path="largura"></form:errors>
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Comprimento <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="comprimento"
											cssClass="form-control col-md-7 col-xs-12 onlyNumbers"
											id="comprimento"
											placeholder="Preencha o comprimento do produto." />
										<form:errors cssClass="native-error" path="comprimento"></form:errors>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Tipo <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:select path="tipoProduto" multiple="false" class="select2_single form-control" tabindex="-1">
											<form:options items="${listaProdutoTipo}" itemValue="code"
												itemLabel="descricao"></form:options>
										</form:select>
										<form:errors cssClass="native-error" path="tipoProduto"></form:errors>
									</div>
								</div>


								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Status <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:select path="status" multiple="false" class="select2_single form-control" tabindex="-1">
											<form:options items="${listaProdutoStatus}" itemValue="code"
												itemLabel="descricao"></form:options>
										</form:select>
										<form:errors cssClass="native-error" path="status"></form:errors>
									</div>
								</div>

								 

								<div style="clear: both"></div>
								<br />
								<br />
								<div class="form-actions">
									<button id="confirmar" type="submit" class="btn btn-primary">Confirmar</button>
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
	
	<script type="text/javascript">
		$(document).ready(function() {

			$("#altura").val(decimal($("#altura").val()));
			$("#largura").val(decimal($("#largura").val()));
			$("#comprimento").val(decimal($("#comprimento").val()));
			
			$("#altura").maskMoney({ allowNegative: true, thousands:'.', decimal:',', affixesStay: false});
			$("#largura").maskMoney({ allowNegative: true, thousands:'.', decimal:',', affixesStay: false});
			$("#comprimento").maskMoney({ allowNegative: true, thousands:'.', decimal:',', affixesStay: false});
	
		
			
			$( "#confirmar" ).click(function() {
				var valor = $("#altura").val().replace(".", "");
				valor = valor.replace(",",".");
				  $("#altura").val(valor); 
				  
					valor = $("#largura").val().replace(".", "");
					valor = valor.replace(",",".");
					  $("#largura").val(valor); 
					  
						valor = $("#comprimento").val().replace(".", "");
						valor = valor.replace(",",".");
						  $("#comprimento").val(valor); 
				  
				  $( "#target" ).submit();
				});
			
			
	
		});
		
		function decimal(decimal){
			return decimal.replace(".", ",");
		}
		

	</script>
</body>
</html>