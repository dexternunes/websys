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
	<div class="right_col" role="main">
		<div class="">

			<div class="page-title">
				<div class="title_left">
					<h3>Cadastro de Terceiro</h3>
				</div>
			</div>
			<div class="clearfix"></div>
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="x_panel">
						<div class="x_title">
							<h2>Terceiro</h2>
							<div class="clearfix"></div>
						</div>
						<div class="wizar_content">
							<br />

							<form:form cssClass="form-horizontal"
								action="${pageContext.request.contextPath}/configuracoes/terceiros/cadastro/salvar"
								commandName="terceiro" method="post">

								<form:hidden path="id" />

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Nome <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="nome"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o nome do terceiro." />
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Documento <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="documento"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o nome do terceiro." />
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Tipo <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:select path="tipos" multiple="true">
											<form:options items="${listaTerceiroTipo}"
												itemValue="descricao" itemLabel="descricao"></form:options>
										</form:select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Ativo 
									</label><form:checkbox style="margin-left:10px; margin-top:10px;" path="ativo"/>
								</div>

								<br />
								<br />

								<div class="x_title">
									<h2>Contato</h2>
									<div class="clearfix"></div>
								</div>

								<br />
								<br />

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12"
										for="first-name">Email <span class="required">*</span></label>
									<input type="hidden" id="nEmails"
										value="${fn:length(terceiro.emails)}" />

									<c:forEach items="${terceiro.emails}" var="email"
										varStatus="status">

										<div class="col-md-6 col-sm-6 col-xs-12">

											<form:input cssClass="form-control col-md-7 col-xs-12"
												path="emails[${status.index}]"
												placeholder="exemplo@exemplo.com.br" />
											<form:errors cssClass="native-error"
												path="emails[${status.index}]" />

											<c:if test="${status.index == 0}">
												<a id="add${status.index}" class="btn"
													onclick="config.newEmail();"><i class="icon-plus"></i></a>
											</c:if>

											<c:if
												test="${fn:length(configuracaoEmpresa.emails) - 1 == status.index and status.index > 0}">
												<a id="del${status.index}" class="btn"
													onclick="config.removeEmail();"><i class="icon-minus"></i></a>
											</c:if>
										</div>

									</c:forEach>

									<c:if test="${fn:length(terceiro.emails) == 0}">
										<div class="col-md-6 col-sm-6 col-xs-12">
											<form:input cssClass="form-control col-md-7 col-xs-12"
												path="emails[0]" placeholder="exemplo@exemplo.com.br" />
											<a id="add${status.index}" class="btn"
												onclick="config.newEmail();"><i class="icon-plus"></i></a>
										</div>
									</c:if>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Tel. Celular: </label>
									<div class="col-md-6 col-sm-6 col-xs-12"
										style="float: left; !important;">
										<form:input cssClass="form-control"
											style="float: left; width:60px; !important;"
											path="contatos[0].ddd" placeholder="DDD" />
										<form:errors cssClass="native-error"
											style="float: left; width:60px; !important;"
											path="contatos[0].ddd" />
										<label class="control-label"
											style="float: left; margin-left: 5px; !important"> -
										</label>
										<form:input cssClass="form-control"
											style="margin-left:5px; float: left; width:160px; !important;"
											path="contatos[0].telefone" placeholder="000000000" />
										<form:errors cssClass="native-error"
											style="margin-left:5px; float: left; width:160px; !important;"
											path="contatos[0].telefone" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Tel. Residencial: </label>
									<div class="col-md-6 col-sm-6 col-xs-12"
										style="float: left; !important;">
										<form:input cssClass="form-control"
											style="float: left; width:60px; !important;"
											path="contatos[1].ddd" placeholder="DDD" />
										<form:errors cssClass="native-error"
											style="float: left; width:60px; !important;"
											path="contatos[1].ddd" />
										<label class="control-label"
											style="float: left; margin-left: 5px; !important"> -
										</label>
										<form:input cssClass="form-control"
											style="margin-left:5px; float: left; width:160px; !important;"
											path="contatos[1].telefone" placeholder="000000000" />
										<form:errors cssClass="native-error"
											style="margin-left:5px; float: left; width:160px; !important;"
											path="contatos[1].telefone" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										Tel. Comercial: </label>
									<div class="col-md-6 col-sm-6 col-xs-12"
										style="float: left; !important;">
										<form:input cssClass="form-control"
											style="float: left; width:60px; !important;"
											path="contatos[2].ddd" placeholder="DDD" />
										<form:errors cssClass="native-error"
											style="float: left; width:60px; !important;"
											path="contatos[2].ddd" />
										<label class="control-label"
											style="float: left; margin-left: 5px; !important"> -
										</label>
										<form:input cssClass="form-control"
											style="margin-left:5px; float: left; width:160px; !important;"
											path="contatos[2].telefone" placeholder="000000000" />
										<form:errors cssClass="native-error"
											style="margin-left:5px; float: left; width:160px; !important;"
											path="contatos[2].telefone" />
									</div>
								</div>

								<br />
								<br />

								<div class="x_title">
									<h2>Endereço</h2>
									<div class="clearfix"></div>
								</div>

								<br />
								<br />

								<div class="form_group">
									<c:forEach items="${terceiro.enderecos}" var="endereco"
										varStatus="status_endereco">
										<form:hidden path="enderecos[${status_endereco.index}].id" />
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">
												Rua: </label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<form:input cssClass="form-control col-md-7 col-xs-12"
													path="enderecos[${status_endereco.index}].endereco"
													placeholder="rua do Zé" />
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
													placeholder="rua do Zé" />
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
													placeholder="bairro da maria" />
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
													placeholder="joaocity" />
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
													placeholder="gervazio" />
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
													placeholder="brasil" />
												<form:errors cssClass="native-error"
													path="enderecos[${status_endereco.index}].pais" />
											</div>
										</div>

									</c:forEach>
								</div>
								<!--
								<div class="form-group" id="dv_enderecos">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">Endereços
										<!-- 
										<i style="cursor: pointer !important;"
										class="fa fa-plus-square add_endereco"
										onclick="AddEndereco();"></i>
									</label> 
									<input type="hidden" id="nEnderecos"
									value="${fn:length(terceiro.enderecos)}" />
									-->
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

		function Required() {

		}
	</script>
</body>
</html>