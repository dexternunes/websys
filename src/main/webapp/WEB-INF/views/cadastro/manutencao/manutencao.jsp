<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>Manuten��es Cadastradas</title>
</head>
<body>
	<div class="row">
		<form:form cssClass="form-horizontal" method="post">


			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>Manuten��es Cadastradas</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<div class="control-group">
							<a type="button" class="btn btn-primary"
								href="${pageContext.request.contextPath}/manutencao/cadastro">Cadastrar
								Manuten��o</a>
						</div>
						<div class="control-group">
							<table id="entities"
								class="table table-striped responsive-utilities jambo_table">
								<thead>
									<tr>
										<th>Produto</th>
										<th>Descr��o da manute��o</th>
										<th>Data in�cio</th>
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
											<td oName="id" oValue="${manutencoes.id}">${manutencao.produto}</td>
											<td>${manutencoes.obs}</td>
											<td>${manutencoes.inicioManutencao}</td>
											<td>${manutencoes.fimManutencao}</td>
											<td>${manutencoes.valor}</td>
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
        </script>
</body>
</html>
