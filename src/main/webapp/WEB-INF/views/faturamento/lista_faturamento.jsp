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
	                                         <input type="checkbox" name="mCheckBox" value="${manutencoes.id}" class="tableflat">
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
                                    </th>
                                    <th>Data </th>
                                    <th>Usuário </th>
                                    <th>Horas Motor </th>
                                </tr>
                            </thead>

                            <tbody>
                            	<c:forEach items="${reservaList}" var="reservas" varStatus="status">
	                                 <tr class="even pointer">
	                                     <td class="a-center "  oName="id" oValue="${reservas.id}">
	                                         <input type="checkbox" class="tableflat" value="${reservas.id}">
	                                     </td>
	                                     <td class=" ">${reservas.inicioReserva}</td>
	                                     <td class=" ">${reservas.solicitante.nome}</td>
	                                     <td class=" ">${reservas.horaMotorTotal} Horas</td>
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
		                                    <h2>Valor Total de Manuteção:</h2>    <h2 id="valorTotal"></h2>
											<div class="clearfix"></div>
		                                </div>
		                                <div class="x_content">
		                                    <table class="table table-hover">
		                                        <thead>
		                                            <tr>
		                                                <th>Nome Cotista</th>
		                                                <th>Horas</th>
		                                                <th>Valor</th>
		                                            </tr>
		                                        </thead>
		                                        <tbody id="tBody">

												</tbody>
		                                    </table>
		
		                                </div>
		                            </div>
		                        </div>
		                                

                                <div class="row avatar-btns">
                                    <div class="col-md-9">

                                    </div>
                                    <div class="col-md-3">
                                        <button  id="faturarModal" class="btn btn-primary btn-block avatar-save" type="submit">Faturar</button>
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
                	
                	
                	//TODO: Validar se selecionou Horas Motor pois eh obrigatorio

					var retorno = [];
                	
                	
                	$.ajax({
                		async : true,
                		url : '${pageContext.request.contextPath}/faturamento/api/faturar',
                		dataType : "json",
                		contentType : "application/json; charset=utf-8",
                		type : 'POST',
                		data : createArrayIds(),
                		success : function(data) {
                			retorno = data;
							popularTabela(data);
                		},
                		error : function(request, status, error) {
                			alert("Ocorreu um erro. Favor reportar com o codigo de erro:77");
                		}
                	});
                	
                });
                
        		function popularTabela(data){
        			$("#valorTotal").text("R$"+data.valorTotalString);
        			
        			var html ="";
        			var i;
        			
        			for (i = 0; i < data.faturamentoRateioLista.length; i++) { 

            			html = html + "<tr>";
        			    //text += cars[i] + "<br>";
        			    html = html + "<td>" + data.faturamentoRateioLista[i].terceiro.nome + "</td>";
        			    html = html + "<td>" + data.faturamentoRateioLista[i].horas + "</td>";
        			    html = html + "<td> R$ " + data.faturamentoRateioLista[i].valorStr + "</td>";
        			}
        			 html = html + "</tr>";
        			
        			$("#tBody").html(html);
        			
        		}
        		
        		function createArrayIds(){
        			var stringIds = "[";
                	var i = 0;
		            $("input:checkbox[name=mCheckBox]:checked").each(function(){

		            	stringIds = stringIds + $(this).val()+",";
		            	i++;
		            	
		            });
	                
	 				if(i == 0){
	 					alert("nenhum selecionado.. colocar uma modal de alerta");
	 					return false;
	 					
	 				}
	 				
		            stringIds = stringIds.substring(0, stringIds.length-1);
		            stringIds = stringIds + "]";

        			return stringIds;
        			
        		}
        		
        		$( "#faturarModal" ).click(function() {
                	$.ajax({
                		async : true,
                		url : '${pageContext.request.contextPath}/faturamento/api/salvar',
                		dataType : "json",
                		contentType : "application/json; charset=utf-8",
                		type : 'POST',
                		data : createArrayIds(),
                		success : function(data) {
                			retorno = data;
                			//Tratar para exibir uma modal de sucesso ou erro
                			//Tratar exibicao de data na tabela
                			//Adicionar reserva manual
                			//Adicionar reserva no calculo
                			//Conferir valor calculo
                		},
                		error : function(request, status, error) {
                			alert("Ocorreu um erro. Favor reportar com o codigo de erro:88");
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
                
                
        		$("#opa").click(function(){
        			alert("s");
        		    $('input:checkbox').not(this).prop('checked', this.checked);
        		});
        		
        		$("#checkAllMotor").click(function(){
        		    $('input:checkbox').not(this).prop('checked', this.checked);
        		});
            });
        </script>
</body>
</html>
