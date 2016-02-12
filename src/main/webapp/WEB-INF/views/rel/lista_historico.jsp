<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>Rela�rio de faturamento</title>
</head>
<body>
	<div class="row">
		<form:form cssClass="form-horizontal" method="post">


			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>Manuten��es</h2>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<!-- id="example" para ordenar e filtrar -->
                        <table id="example2" class="table table-striped responsive-utilities jambo_table ">
                            <thead>
                                <tr class="headings">
                                    <th>
                                        
                                    </th>
                                    <th>Data </th>
                                    <th>Descri��o </th>
                                    <th>Valor </th>
                                </tr>
                            </thead>

                            <tbody>
                            	<c:forEach items="${manutencaoList}" var="manutencoes" varStatus="status">
	                                 <tr class="even pointer">
	                                     <td class="a-center "  oName="id" oValue="${manutencoes.id}">
	                                        
	                                     </td>
	                                     <td class=" "><fmt:formatDate value="${manutencoes.inicioManutencao}"  pattern="dd/MM/yyyy"/></td>
	                                     <td class=" ">${manutencoes.obs}</td>
	                                     <td class=" ">R$ ${manutencoes.valor} </td>
	                                 </tr>
                            	</c:forEach>
							</tbody>

                        </table>
                    </div>
                    <div class="x_title">
						<h2>Horas Motor</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<table id="example"
							class="table table-striped responsive-utilities jambo_table ">
							<thead>
								<tr class="headings">
									<th></th>
									<th>Data</th>
									<th>Usu�rio</th>
									<th>Horas Motor</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${reservaList}" var="reservas"
									varStatus="status">
									<tr class="even pointer showInfo">
										<td class="a-center " oName="id" oValue="${reservas.id}">
											
										</td>
										<td class=" "><fmt:formatDate value="${reservas.inicioReserva}"  pattern="dd/MM/yyyy"/></td>
										<td class=" ">${reservas.solicitante.nome}</td>
										<td class=" ">${reservas.horaMotorTotal}Horas</td>
									</tr>
								</c:forEach>
							</tbody>

						</table>
					</div>
					<div class="control-group">
						<a type="button" class="btn btn-primary"
							href="${pageContext.request.contextPath}/faturamento/historico/">Voltar</a>
					</div>
				</div>
			</div>
		</form:form>
		
		<!-- Cropping modal -->
		<div class="modal fade" id="my-modal" aria-hidden="true"
			aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<!--  <form class="avatar-form" action="" enctype="multipart/form-data" method="post"> -->
					<div class="modal-header">
						<button class="close" data-dismiss="modal" type="button">&times;</button>
						<h4 class="modal-title" id="avatar-modal-label">Detalhamento de reserva.</h4>
					</div>
					<div class="modal-body">
						<div class="avatar-body">
							<div class="">
								<div class="x_panel">
									<div class="">
										Usu�rio: XXXX<br>
										Data: XXXX<br>
										Hora do motor no in�cio: XXXX<br>
										Hora do motor no fim: XXXX<br>
										
									</div>
								</div>
							</div>

						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" data-dismiss="modal" type="button">Cancelar</button>
					</div>
					<!--  </form> -->
				</div>
			</div>
		</div>
		<!-- /.modal -->
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
                

				$(".showInfo")
						.click(
								function() {
									alert("asd");
									$.ajax({
										url: "${pageContext.request.contextPath}/faturamento/api/detalhar/2",
										dataType:"json",
										contentType:"application/json; charset=utf-8",
										type:"GET",
										async:false,
										success:function(data){
											alert("1");
											gruposJSON = data;
										},
										error:function(request, status, error){
											alert('2:' + error);
										}
									});
								});
            });

            var asInitVals = new Array();
            $(document).ready(function () {
                var oTable = $('#example').dataTable({
                    "oLanguage": {
                        "sSearch": "Procurar em todas as colunas:"
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
