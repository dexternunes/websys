<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>Manutenções Cadastradas</title>
</head>
<body>
	<div class="row">
		<form:form cssClass="form-horizontal" method="post">


			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>Manutenções Cadastradas</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<div class="control-group">
							<a type="button" class="btn btn-primary"
								href="${pageContext.request.contextPath}/manutencao/cadastro">Cadastrar
								Manutenção</a>
						</div>
						<div class="control-group">
							<table id="entities"
								class="table table-striped responsive-utilities jambo_table">
								<thead>
									<tr>
										<th>Produto</th>
										<th>Descrção da manuteção</th>
										<th>Data início</th>
										<th>Data fim</th>
										<th>Valor</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${manutencaoList}" var="manutencoes"
										varStatus="status">

										<tr onclick="document.location.href='<c:url value="/manutencao/cadastro/${manutencoes.id }"/>';"
										style="cursor: pointer; !important;">
											<td oName="id" oValue="${manutencoes.id}">${manutencoes.produto.descricao}</td>
											<td>${manutencoes.obs}</td>
											<td class="tdDate">${manutencoes.inicioManutencao}</td>
											<td class="tdDate">${manutencoes.fimManutencao}</td>
											<td class="tdValor">${manutencoes.valor}</td>
											<td>${manutencoes.status}</td>
										</tr>

									</c:forEach>

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/js/datatables/js/jquery.dataTables.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/datatables/tools/js/dataTables.tableTools.js"></script>
	<script type="text/javascript">
	
			$(document).ready(function () {
                $('input.tableflat').iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
                
                $('.tdDate').iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
                
                $( ".tdDate" ).each(function( index ) {
                	$( this ).text(formatMyDate($(this).text()));
                });
                

                $( ".tdValor" ).each(function( index ) {
                	var valor = $( this ).text();
                	valor = valor.replace(".", ",");
                	var moeda = "R$ ";
                	valor = moeda.concat(valor);
                	$( this ).text(valor);
                });
            });

            var asInitVals = new Array();
            $(document).ready(function () {
                var oTable = $('#example').dataTable({
                    "oLanguage": {
                        "sSearch": "Search all columns:"
                    },
                    "aoColumnDefs": [
                        {
                            'bSortable': false,
                            'aTargets': [0]
                        } //disables sorting for column one
            ],
                    'iDisplayLength': 12,
                    "sPaginationType": "full_numbers"
                });
                $("tfoot input").keyup(function () {
                    /* Filter on the column based on the index of this element's parent <th> */
                    oTable.fnFilter(this.value, $("tfoot th").index($(this).parent()));
                });
                $("tfoot input").each(function (i) {
                    asInitVals[i] = this.value;
                });
                $("tfoot input").focus(function () {
                    if (this.className == "search_init") {
                        this.className = "";
                        this.value = "";
                    }
                });
                $("tfoot input").blur(function (i) {
                    if (this.value == "") {
                        this.className = "search_init";
                        this.value = asInitVals[$("tfoot input").index(this)];
                    }
                });
            });
            
            
			function formatMyDate(data) {
				var date = new Date(data);
				var day = complet(date.getDate());
				var month = complet(date.getMonth()) + 1;
				var year = complet(date.getFullYear());
				var hour = complet(date.getHours());
				var min = complet(date.getMinutes());

				return day + '/' + month + '/' + year + ' ' + hour +':'+min;              
			}


	
			
			function complet(value){
				if(value < 10)
					return "0" + value;
				else
					return value;
			} 
	
        </script>
</body>
</html>
