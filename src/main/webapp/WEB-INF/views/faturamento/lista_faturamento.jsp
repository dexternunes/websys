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
						<h2>Faturar</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<!-- id="example" para ordenar e filtrar -->
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

						<a type="button" class="btn btn-primary">Faturar</a>
					</div>
				</div>
			</div>
		</form:form>
		
		<!-- Cropping modal -->
        <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form class="avatar-form" action="crop.php" enctype="multipart/form-data" method="post">
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal" type="button">&times;</button>
                            <h4 class="modal-title" id="avatar-modal-label">Change Avatar</h4>
                        </div>
                        <div class="modal-body">
                            <div class="avatar-body">

                                <!-- Upload image and data -->
                                <div class="avatar-upload">
                                    <input class="avatar-src" name="avatar_src" type="hidden">
                                    <input class="avatar-data" name="avatar_data" type="hidden">
                                    <label for="avatarInput">Local upload</label>
                                    <input class="avatar-input" id="avatarInput" name="avatar_file" type="file">
                                </div>

                                <!-- Crop and preview -->
                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="avatar-wrapper"></div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="avatar-preview preview-lg"></div>
                                        <div class="avatar-preview preview-md"></div>
                                        <div class="avatar-preview preview-sm"></div>
                                    </div>
                                </div>

                                <div class="row avatar-btns">
                                    <div class="col-md-9">
                                        <div class="btn-group">
                                            <button class="btn btn-primary" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees">Rotate Left</button>
                                            <button class="btn btn-primary" data-method="rotate" data-option="-15" type="button">-15deg</button>
                                            <button class="btn btn-primary" data-method="rotate" data-option="-30" type="button">-30deg</button>
                                            <button class="btn btn-primary" data-method="rotate" data-option="-45" type="button">-45deg</button>
                                        </div>
                                        <div class="btn-group">
                                            <button class="btn btn-primary" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees">Rotate Right</button>
                                            <button class="btn btn-primary" data-method="rotate" data-option="15" type="button">15deg</button>
                                            <button class="btn btn-primary" data-method="rotate" data-option="30" type="button">30deg</button>
                                            <button class="btn btn-primary" data-method="rotate" data-option="45" type="button">45deg</button>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <button class="btn btn-primary btn-block avatar-save" type="submit">Done</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- <div class="modal-footer">
          <button class="btn btn-default" data-dismiss="modal" type="button">Close</button>
        </div> -->
                    </form>
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
