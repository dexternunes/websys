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
<title>Cadastro de Terceiro</title>
</head>
<body>
	<div class="row">
		<form:form cssClass="form-horizontal"
			action="${pageContext.request.contextPath}/terceiro/cadastro/salvar"
			commandName="terceiro" method="post">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h3>Cadastro de Terceiro</h3>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<div class="x_title">
							<h2>
								Terceiro
							</h2>
							<div class="clearfix"></div>
						</div>
						<form:hidden path="id" />
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="first-name">Nome <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<form:input path="nome"
									cssClass="form-control col-md-7 col-xs-12" readonly="${readonly}"/>
								<form:errors cssClass="native-error" path="nome"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="documento">Documento <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<form:input path="documento"
									cssClass="form-control col-md-7 col-xs-12"
									 readonly="${readonly}" />
									<form:errors cssClass="native-error" path="documento"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="tipos">Tipo <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<form:select path="tipos" multiple="false" disabled="${readonly}"
									cssClass="select2_multiple form-control">
									<form:options items="${listaTerceiroTipo}" itemValue="code"
										itemLabel="descricao" readonly="${readonly}"></form:options>
								</form:select>
								<form:errors cssClass="native-error" path="tipos"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="first-name">Ativo </label>
							<form:checkbox style="margin-left:10px; margin-top:10px;" disabled="${readonly}"
								path="ativo" />
						</div>

						<br /> <br />

						<div class="x_title">
							<h2>Contato</h2>
							<div class="clearfix"></div>
						</div>

						<br /> <br />

						<div class="form-group">
							<label class="control-label col-md-3 col-sm-3 col-xs-12"
								for="first-name">Email <span class="required">*</span></label>
							<div class="col-md-6 col-sm-6 col-xs-12">
								<form:input cssClass="form-control col-md-7 col-xs-12"
									path="emails"
									data-toggle="tooltip" data-placement="top" />
									<form:errors cssClass="native-error" path="emails"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<form:hidden path="contatos[0].id" />
							<label class="control-label col-md-3 col-sm-3 col-xs-12">
								Tel. Celular: </label>
							<div class="col-md-6 col-sm-6 col-xs-12"
								style="float: left; !important;">
								<form:input cssClass="form-control"
									style="float: left; width:60px; !important;"
									path="contatos[0].ddd"  data-inputmask="'mask' : '(99)'" />
								<form:errors cssClass="native-error"
									style="float: left; width:60px; !important;"
									path="contatos[0].ddd" />
								<label class="control-label"
									style="float: left; margin-left: 5px; !important"> - </label>
								<form:input cssClass="form-control"
									style="margin-left:5px; float: left; width:160px; !important;"
									path="contatos[0].telefone" data-inputmask="'mask' : '99999-9999'" />
								<form:errors cssClass="native-error"
									style="margin-left:5px; float: left; width:160px; !important;"
									path="contatos[0].telefone" />
							</div>
						</div>
						<div class="form-group">
							<form:hidden path="contatos[1].id" />
							<label class="control-label col-md-3 col-sm-3 col-xs-12">
								Tel. Residencial: </label>
							<div class="col-md-6 col-sm-6 col-xs-12"
								style="float: left; !important;">
								<form:input cssClass="form-control"
									style="float: left; width:60px; !important;"
									path="contatos[1].ddd"  data-inputmask="'mask' : '(99)'" />
								<form:errors cssClass="native-error"
									style="float: left; width:60px; !important;"
									path="contatos[1].ddd" />
								<label class="control-label"
									style="float: left; margin-left: 5px; !important"> - </label>
								<form:input cssClass="form-control"
									style="margin-left:5px; float: left; width:160px; !important;"
									path="contatos[1].telefone" data-inputmask="'mask' : '9999-9999'"/>
								<form:errors cssClass="native-error"
									style="margin-left:5px; float: left; width:160px; !important;"
									path="contatos[1].telefone" />
							</div>
						</div>
						<div class="form-group">
							<form:hidden path="contatos[2].id" />
							<label class="control-label col-md-3 col-sm-3 col-xs-12">
								Tel. Comercial: </label>
							<div class="col-md-6 col-sm-6 col-xs-12"
								style="float: left; !important;">
								<form:input cssClass="form-control"
									style="float: left; width:60px; !important;"
									path="contatos[2].ddd"  data-inputmask="'mask' : '(99)'" />
								<form:errors cssClass="native-error"
									style="float: left; width:60px; !important;"
									path="contatos[2].ddd" />
								<label class="control-label"
									style="float: left; margin-left: 5px; !important"> - </label>
								<form:input cssClass="form-control"
									style="margin-left:5px; float: left; width:160px; !important;"
									path="contatos[2].telefone"  data-inputmask="'mask' : '9999-9999'" />
								<form:errors cssClass="native-error"
									style="margin-left:5px; float: left; width:160px; !important;"
									path="contatos[2].telefone" />
							</div>
						</div>

						<br /> <br />

						<div class="x_title">
							<h2>Endereço</h2>
							<div class="clearfix"></div>
						</div>

						<br /> <br />

						<div class="form-group">
							<c:forEach items="${terceiro.enderecos}" var="endereco"
								varStatus="status_endereco">
								<form:hidden path="enderecos[${status_endereco.index}].id" />
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Rua: </label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input cssClass="form-control col-md-7 col-xs-12"
											path="enderecos[${status_endereco.index}].endereco"
											 />
										<form:errors cssClass="native-error"
											path="enderecos[${status_endereco.index}].endereco" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Número: </label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input cssClass="form-control col-md-7 col-xs-12"
											path="enderecos[${status_endereco.index}].numero"
											 />
										<form:errors cssClass="native-error"
											path="enderecos[${status_endereco.index}].numero" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Bairro: </label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input cssClass="form-control col-md-7 col-xs-12"
											path="enderecos[${status_endereco.index}].bairro"
											 />
										<form:errors cssClass="native-error"
											path="enderecos[${status_endereco.index}].bairro" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Cidade: </label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input cssClass="form-control col-md-7 col-xs-12"
											path="enderecos[${status_endereco.index}].cidade"
											 />
										<form:errors cssClass="native-error"
											path="enderecos[${status_endereco.index}].cidade" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Estado: </label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input cssClass="form-control col-md-7 col-xs-12"
											path="enderecos[${status_endereco.index}].estado"
											 />
										<form:errors cssClass="native-error"
											path="enderecos[${status_endereco.index}].estado" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Pais: </label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input cssClass="form-control col-md-7 col-xs-12"
											path="enderecos[${status_endereco.index}].pais"
											 />
										<form:errors cssClass="native-error"
											path="enderecos[${status_endereco.index}].pais" />
									</div>
								</div>

							</c:forEach>
						</div>

						<div style="clear: both"></div>
						<br /> <br />
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">Confirmar</button>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
	<script type='text/javascript'>
		function AddEndereco() {
			var cont = parseInt($('#nEnderecos').val());

			var clone = $('#fieldset_enderecos0').clone(true);

			var reg_name = new RegExp('enderecos\\[[0-9]+\\]', 'gi');
			var reg_id = new RegExp('enderecos[0-9]+', 'gi');

			var html = clone.html();
			html = html.replace(reg_id, 'enderecos' + cont);
			html = html.replace(reg_name, 'enderecos[' + cont + ']');
			clone.html(html);

			clone.find('input:text').val('');

			cont += 1;

			clone.find('legend').text('Endereço ' + cont);

			$('#dv_enderecos').append(clone);

			$('#nEnderecos').val(cont);
		}
		
		$(document).ready(function(){
			$('#documento').blur(function(){
				
				if(ValidaDocs($('#documento').val())){
				
					if($('#documento').val().length > 11){
						$('#documento').inputmask("99.999.999/9999-99");				
					}
					else{
						$('#documento').inputmask("999.999.999-99");
					}
				}
				else{
					$('#documento').focus();
					alert('CPF/CPNJ inválido');
				}
			});
			
			$('#documento').click(function(){
				$('#documento').inputmask('remove');
			});	
		});
	</script>
</body>
</html>