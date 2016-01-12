<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>A Faturar:</title>
</head>
<body>
	<div class="row">
		<form:form cssClass="form-horizontal" method="post">


			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>Manutenções</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<!-- id="example" para ordenar e filtrar -->
                        <table id="example2" class="table table-striped responsive-utilities jambo_table ">
                            <thead>
                                <tr class="headings">
                                    <th>
                                        <input type="checkbox" id="check-all" class="tableflat">
                                    </th>
                                    <th>Data </th>
                                    <th>Descrição </th>
                                    <th>Valor </th>
                                </tr>
                            </thead>

                            <tbody>
                            	<c:forEach items="${manutencaoList}" var="manutencoes" varStatus="status">
	                                 <tr class="even pointer">
	                                     <td class="a-center "  oName="id" oValue="${manutencoes.id}">
	                                         <input type="checkbox" class="tableflat">
	                                     </td>
	                                     <td class=" ">${manutencoes.inicioManutencao}</td>
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
                        <table id="example" class="table table-striped responsive-utilities jambo_table ">
                            <thead>
                                <tr class="headings">
                                    <th>
                                        <input type="checkbox" id="check-all" class="tableflat">
                                    </th>
                                    <th>Data </th>
                                    <th>Descrição </th>
                                    <th>Valor </th>
                                </tr>
                            </thead>

                            <tbody>
                            	<c:forEach items="${manutencaoList}" var="manutencoes" varStatus="status">
	                                 <tr class="even pointer">
	                                     <td class="a-center "  oName="id" oValue="${manutencoes.id}">
	                                         <input type="checkbox" class="tableflat">
	                                     </td>
	                                     <td class=" ">${manutencoes.inicioManutencao}</td>
	                                     <td class=" ">${manutencoes.obs}</td>
	                                     <td class=" ">R$ ${manutencoes.valor} </td>
	                                 </tr>
                            	</c:forEach>
							</tbody>

                        </table>
                    </div>
                    
								
					<div class="control-group">
						
						<a type="button" class="btn btn-primary"
							href="${pageContext.request.contextPath}/faturamento/">Voltar</a>
						<div id="fc_edit" data-toggle="modal" data-target="#my-modal">
							<a type="button" id="faturar" class="btn btn-primary">Faturar</a>
						</div>
					</div>
					
					
				</div>
			</div>
		</form:form>
		
		<!-- Cropping modal -->
        <div class="modal fade" id="my-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                   <!--  <form class="avatar-form" action="" enctype="multipart/form-data" method="post"> -->
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal" type="button">&times;</button>
                            <h4 class="modal-title" id="avatar-modal-label">Resumo de faturamento</h4>
                        </div>
                        <div class="modal-body">
                            <div class="avatar-body">
		 						<div class="">
		                            <div class="x_panel">
		                                <div class="x_title">
		                                    <h2>Faturar</h2>
											<div class="clearfix"></div>
		                                </div>
		                                <div class="x_content">
		                                    <table class="table table-hover">
		                                        <thead>
		                                            <tr>
		                                                <th>Nome Cotista</th>
		                                                <th>Valor Manuteção</th>
		                                                <th>Valor Horas Motor</th>
		                                            </tr>
		                                        </thead>
		                                        <tbody>
					                            	<c:forEach items="${terceiroList}" var="terceiro" varStatus="status">
						                                 <tr >
						                                     <td >${terceiro.nome}</td>
						                                     <td>aaaaa</td>
						                                     <td >bbbbb </td>
						                                 </tr>
					                            	</c:forEach>
												</tbody>
		                                    </table>
		
		                                </div>
		                            </div>
		                        </div>
		                                

                                <div class="row avatar-btns">
                                    <div class="col-md-9">

                                    </div>
                                    <div class="col-md-3">
                                        <button  class="btn btn-primary btn-block avatar-save" type="submit">Faturar</button>
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
                
 
                
                $( "#faturar" ).click(function() {
                	//passar parametros para controler Faturamento
                	//que vai passar para o fat business que por sua vez vai fazer o calculo 
                	
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
