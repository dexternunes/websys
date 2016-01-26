<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
	<title>Histórico:</title>
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
<body>
	<div class="row">
		<form:form cssClass="form-horizontal" method="post">


			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>histórico</h2>
						<div class="clearfix"></div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="tipos">Grupo </label>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<select id="grupoSelect"  class="select2_multiple form-control">
								<c:forEach items="${listaGrupos}" var="grupo" varStatus="status">
									<option value="${grupo.id}">${grupo.descricao}</option>
								</c:forEach>
								
							</select>
						</div>
					</div>
					<div class="control-group">
						<a type="button" id="proximo" class="btn btn-primary">Próximo</a>
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
                
                $( "#proximo" ).attr("href", "${pageContext.request.contextPath}/faturamento/historico/grupo/"+$( "#grupoSelect" ).val());


                $( "#grupoSelect" ).change(function() {
                	$( "#proximo" ).attr("href", "${pageContext.request.contextPath}/faturamento/historico/grupo/"+$( "#grupoSelect" ).val());
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
