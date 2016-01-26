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
<style type="text/css">
.daterangepicker {
	position: absolute !important;
	z-index: 9999 !important;
}

.timepicker {
	position: absolute !important;
	z-index: 9999 !important;
}

.ui-timepicker-container {
	position: absolute;
	overflow: hidden;
}

.ui-timepicker {
	display: block;
	height: 200px;
	text-align: center;
	list-style: none outside none;
	overflow: auto;
	overflow-x: hidden; /* IE */
	margin: 0;
	padding: 0 0 0 1px;
	position: absolute !important;
	z-index: 9999 !important;
}

.ui-timepicker-standard {
	/* .ui-widget */
	font-family: Verdana, Arial, sans-serif;
	font-size: 1.1em;
	/* .ui-widget-content */
	background-color: #FFF;
	border: 1px solid #AAA;
	color: #222;
	/* .ui-menu */
	margin: 0;
	padding: 2px;
}

.ui-timepicker-standard a {
	/* .ui-widget-content a */
	color: #222;
}

.ui-timepicker-standard .ui-state-hover {
	/* .ui-state-hover */
	background-color: #DADADA;
	border: 1px solid #999;
	font-weight: normal;
	color: #212121;
}

.ui-timepicker-standard .ui-menu-item {
	/* .ui-menu .ui-menu-item */
	/*clear: left;
    float: left;*/
	margin: 0;
	padding: 0;
	/*width: 100%;*/
}

.ui-timepicker-standard .ui-menu-item a {
	/* .ui-menu .ui-menu-item a */
	display: block;
	padding: 0.2em 0.4em;
	line-height: 1.5;
	text-decoration: none;
}

.ui-timepicker-standard .ui-menu-item a.ui-state-hover {
	/* .ui-menu .ui-menu-item a.ui-state-hover */
	font-weight: normal;
	margin: -1px -1px -1px -1px;
}

.ui-timepicker-corners, .ui-timepicker-corners .ui-corner-all {
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
}

.ui-timepicker-hidden {
	/* .ui-helper-hidden */
	display: none;
}


</style>
<!-- Bootstrap core CSS -->

<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/css/timepicker.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/fonts/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/animate.min.css"
	rel="stylesheet">

<!-- Custom styling plus plugins -->
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/icheck/flat/green.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/css/calendar/fullcalendar.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/calendar/fullcalendar.print.css"
	rel="stylesheet" media="print">

<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>


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
								commandName="manutencao" method="post" id="form1">

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
										<form:errors cssClass="native-error" path="produto"></form:errors>
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
										for="first-name">Valor <span class="required">*</span>
									</label>
									<div class="col-md-6 col-sm-6 col-xs-12">
										<form:input path="valor"
											cssClass="form-control col-md-7 col-xs-12"
											placeholder="Preencha o valor."
											id="inputValor" 
											data-thousands="." data-decimal="," data-prefix="R$ "/>
											
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

								 
								<div class="form-group">
									<label class="col-sm-3 control-label">Data</label>
									<div class="col-md-4 xdisplay_inputx form-group has-feedback">
										<form:input path="inicioManutencao" id="data_inicio_reserva" class="form-control has-feedback-left data_reserva"
											style="z-index: 9999 !important;" type="text" 
											aria-describedby="inputSuccess2Status4" placeholder="Data" ></form:input>
											<form:errors cssClass="native-error" path="inicioManutencao"></form:errors>
										<span class="fa fa-calendar-o form-control-feedback left"
											aria-hidden="true"></span> <span id="inputSuccess2Status4"
											class="sr-only"></span>
									</div>
									
								</div>
								
								<!-- 
								<div class="form-group">
									<label class="col-sm-3 control-label">Data fim</label>
									<div class="col-md-4 xdisplay_inputx form-group has-feedback">
										<form:input path="fimManutencao" id="data_fim_reserva" class="form-control has-feedback-left data_reserva"
											style="z-index: 9999 !important;" type="text"
											aria-describedby="inputSuccess2Status4" placeholder="Data" ></form:input>
										<form:errors cssClass="native-error" path="fimManutencao"></form:errors>
										<span class="fa fa-calendar-o form-control-feedback left"
											aria-hidden="true"></span> <span id="inputSuccess2Status4"
											class="sr-only"></span>
									</div>
									
								</div>
								 -->
						

								<div style="clear: both"></div>
								<br />
								<br /> 
								<div class="form-actions">
									<button id="confirmar" type="submit" class="btn btn-primary">Confirmar</button>
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
	<script type="text/javascript">
		$(document).ready(function() {
			var valorVirgula = $("#inputValor").val();
			valorVirgula = valorVirgula.replace(".",",");

			$("#inputValor").val(valorVirgula);
	
			$("#inputValor").maskMoney({ allowNegative: true, thousands:'.', decimal:',', affixesStay: false});
			

			$( "#confirmar" ).click(function() {
				var valor = $("#inputValor").val().replace(".", "");
				valor = valor.replace(",",".");
				  $("#inputValor").val(valor); 
				  $( "#target" ).submit();
				});
			
			
			$('#data_fim_reserva').daterangepicker({
				singleDatePicker : true,
			    timePickerIncrement: 15,
				timePicker: true,
				timePicker12Hour: false,
				timePicker24Hour: true,
				format : 'DD/MM/YYYY HH:mm',
				calender_style : "picker_4",
				locale: {
			          cancelLabel: 'Cancelar',
				      applyLabel: 'Ok'
			      }
			}, function(start, end, label) {
			  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
			});
			
			$('#data_inicio_reserva').daterangepicker({
				singleDatePicker : true,
			    timePickerIncrement: 15,
				timePicker: true,
				timePicker12Hour: false,
				timePicker24Hour: true,
				format : 'DD/MM/YYYY HH:mm',
				calender_style : "picker_4",
				locale: {
			          cancelLabel: 'Cancelar',
				      applyLabel: 'Ok'
			      }
			}, function(start, end, label) {
			  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
			});
			
			function formatMyDate(date) {
				//var date = new Date($('#data_inicio_reserva').val());
				var day = complet(date.getDate());
				var month = complet(date.getMonth());
				var year = complet(date.getFullYear());
				var hour = complet(date.getHours());
				var min = complet(date.getMinutes());

				return day + '/' + month + '/' + year + ' ' + hour +':'+min;              
			}

			if($('#data_inicio_reserva').val() != ""){
				$('#data_inicio_reserva').val(formatMyDate($('#data_inicio_reserva').val()));
				$('#data_fim_reserva').val(formatMyDate($('#data_fim_reserva').val()));	
				var dateIni = new Date($('#data_inicio_reserva').val());
				var dateFim = new Date($('#data_fim_reserva').val());
				$('#data_fim_reserva').daterangepicker({
					singleDatePicker : true,
				    timePickerIncrement: 15,
					timePicker: true,
					timePicker12Hour: false,
					timePicker24Hour: true,
					format : 'DD/MM/YYYY HH:mm',
					startDate: dateFim,
					calender_style : "picker_4",
					locale: {
				          cancelLabel: 'Cancelar',
					      applyLabel: 'Ok'
				      }
				}, function(start, end, label) {
				  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
				});
				
				$('#data_inicio_reserva').daterangepicker({
					singleDatePicker : true,
				    timePickerIncrement: 15,
					timePicker: true,
					timePicker12Hour: false,
					timePicker24Hour: true,
					format : 'DD/MM/YYYY HH:mm',
					startDate: dateIni,
					calender_style : "picker_4",
					locale: {
				          cancelLabel: 'Cancelar',
					      applyLabel: 'Ok'
				      }
				}, function(start, end, label) {
				  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
				});
				
				
			}
			
			function complet(value){
				if(value < 10)
					return "0" + value;
				else
					return value;
			} 
		
			
	
		});
	</script>
</body>
</html>