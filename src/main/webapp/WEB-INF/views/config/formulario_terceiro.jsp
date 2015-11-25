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
                                    <h2>Terceiro</small></h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
	
								<form:form cssClass="form-horizontal"
									action="${pageContext.request.contextPath}/configuracoes/terceiros/cadastro/salvar"
									commandName="terceiro" method="post">
			
										<form:hidden path="id" />
										
										<div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Nome <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	<form:input path="nome" cssClass="form-control col-md-7 col-xs-12" placeholder="Preencha o nome do terceiro." />
                                            </div>
                                        </div>
                                        
										<div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Documento <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	<form:input path="documento" cssClass="form-control col-md-7 col-xs-12" placeholder="Preencha o nome do terceiro." />
                                            </div>
                                        </div>
                                        
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" >Endereços <i class="fa fa-plus-square add_endereco" onclick="AddEndereco();"></i>
                                            </label>
                                            
                                            <input type="hidden" id="nEnderecos" value="${fn:length(terceiro.enderecos)}" />
                                            
                                            <c:forEach items="${terceiro.enderecos}" var="endereco" varStatus="status_endereco">
		
												<div class="col-md-6 col-sm-6 col-xs-12">			
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[${status_endereco.index}]" placeholder="rua do Zé" />
													<form:errors cssClass="native-error" path="enderecos[${status_endereco.index}]" />
												</div>
												<br>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[${status_endereco.index}]" placeholder="9999" />
													<form:errors cssClass="native-error" path="enderecos[${status_endereco.index}]" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[${status_endereco.index}]" placeholder="bairro da maria" />
													<form:errors cssClass="native-error" path="enderecos[${status_endereco.index}]" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[${status_endereco.index}]" placeholder="joaocity" />
													<form:errors cssClass="native-error" path="enderecos[${status_endereco.index}]" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[${status_endereco.index}]" placeholder="gervazio" />
													<form:errors cssClass="native-error" path="enderecos[${status_endereco.index}]" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[${status_endereco.index}]" placeholder="brasil" />
													<form:errors cssClass="native-error" path="enderecos[${status_endereco.index}]" />
												</div>		
											</c:forEach>
											
											<c:if test="${fn:length(terceiro.enderecos) == 0}">
												<div class="col-md-6 col-sm-6 col-xs-12">			
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[0].endereco" placeholder="rua do Zé" />
													<form:errors cssClass="native-error" path="enderecos[0].endereco" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[0].numero" placeholder="9999" />
													<form:errors cssClass="native-error" path="enderecos[0].numero" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[0].bairro" placeholder="bairro da maria" />
													<form:errors cssClass="native-error" path="enderecos[0].bairro" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[0].cidade" placeholder="joaocity" />
													<form:errors cssClass="native-error" path="enderecos[0].cidade" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[0].estado" placeholder="gervazio" />
													<form:errors cssClass="native-error" path="enderecos[0].estado" />
												</div>
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="enderecos[0].pais" placeholder="brasil" />
													<form:errors cssClass="native-error" path="enderecos[0].pais" />
												</div>		
											</c:if>
                                        </div>
										
										<div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Emails</label>						
											
											<input type="hidden" id="nEmails" value="${fn:length(terceiro.emails)}" />
												
											<c:forEach items="${terceiro.emails}" var="email" varStatus="status">
		
												<div class="col-md-6 col-sm-6 col-xs-12">
			
													<form:input cssClass="form-control col-md-7 col-xs-12" path="emails[${status.index}]" placeholder="exemplo@exemplo.com.br" />
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
												<div class="col-md-6 col-sm-6 col-xs-12">
													<form:input cssClass="form-control col-md-7 col-xs-12" path="emails[0]" placeholder="exemplo@exemplo.com.br" />
													<a id="add${status.index}" class="btn" onclick="config.newEmail();"><i class="icon-plus"></i></a>
												</div>
											</c:if>
											
										</div>
										
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
		
		<script type="text/javascript">
			function AddEndereco(){
				//$('#add_endereco').show();
				alert('Blá!');
			}
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