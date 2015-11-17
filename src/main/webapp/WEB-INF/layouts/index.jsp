<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <title><decorator:title /></title>
    
	<meta name="viewport" content="width=device-width" />
    
    <!-- CSS START -->
    
    <!-- Message -->
    <link rel="stylesheet" href="resources/lib/toastmessage/css/jquery.toastmessage.css">
    
    <!-- Bootstrap -->
    <link rel="stylesheet" href="resources/lib/bootstrap-3.1.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/lib/bootstrap-3.1.1/css/bootstrap-theme.min.css">
     
    <!-- File Upload -->
    <link rel="stylesheet" href="resources/css/fileinput.min.css">
    
    <!-- Line e Bar -->
    <link rel="stylesheet" href="resources/lib/morris/morris.min.css">
    
    <!-- Dashboard -->
    <link rel="stylesheet" href="resources/lib/font-awesome-4.1.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="resources/css/dashboard.css">
    <link rel="stylesheet" href="resources/css/dashboard-2.css">
    
    <!-- CSS END -->
    
    <!-- MINIMAL JS START -->
    
    <!-- jQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
	
	<!-- Bootstrap -->
	<script type="text/javascript" src="resources/lib/bootstrap-3.1.1/js/bootstrap.min.js"></script>
    
    <!--  Dashboard Plugin -->
    <script src="resources/js/jquery.websys.js"></script>
    <script src="resources/js/jquery.websys.sidebarmenu.js"></script>
    <script src="resources/js/jquery.websys.component.js"></script>
    <script src="resources/js/jquery.websys.area.js"></script>
    
    <script src="resources/js/dashboard.async.loader.js"></script>
    
    <!-- REMOVER DEPOIS DE TESTES -->
   	<!-- Slim scroll -->    
    <script src="resources/js/jquery.slimscroll.min.js"></script>
    
    <!-- MINIMAL JS END -->
    
    <decorator:head/>
</head>

<style>

</style>

<script>

console.time("initialize dashboard init");

DASHBOARD_PERIOD = '<%= request.getParameter("periodo") == null ? "DIARIA" : request.getParameter("periodo")  %>';
LOADING = true;

$( document ).ready(function() {
	
	// Modal - load dos componentes da dashboard
	//Dashboard.loaderModal();
	
	//alert('width: '+ window.innerWidth);
	
});

</script>

<body class="dashboard-background">


	<div class="row affix-row sm-sidebar-navigator">
	    <div class="col-sm-3 col-md-2 affix-sidebar">
			<div class="sidebar-nav">
			  <div class="navbar navbar-default" role="navigation">
			    <div class="navbar-header">
			      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-navbar-collapse">
				      <span class="sr-only">Toggle navigation</span>
				      <span class="icon-bar"></span>
				      <span class="icon-bar"></span>
				      <span class="icon-bar"></span>
			      </button>
			      <span class="navbar-brand"><img src="resources/images/logo_dashboard.png"/></span>
			    </div>
			    <div class="navbar-collapse collapse sidebar-navbar-collapse">
			      <ul class="nav navbar-nav" id="sidenav01">
			        <li class="active">
			          <a href="#" data-toggle="collapse" data-target="#toggleDemo0" data-parent="#sidenav01" class="collapsed">
			          <h4> Menu </h4>
			          </a>
			        </li>
			        <li><a href="home"><span class="glyphicon glyphicon-home"></span>&nbsp;Ir para o início</a></li>
   			        <li><a href="setup"><span class="glyphicon glyphicon-cog"></span>&nbsp;Configurar Dashboard</a></li>
			        <li>
			        	<a data-component-name="dashboard-clock">
			        		<i class="fa fa-clock-o">&nbsp;00:00:00</i>
	        			</a>
			        </li>
			        <li>
			        	<a data-component-name="dashboard-rss"><i class="fa fa-rss"></i>
            				<span>&nbsp;Carregando RSS...</span>
           				</a>
					</li>
			      </ul>
			      </div>
			    </div>
			  </div>
		</div>
	</div>



	<div id="loading-period" >
		<div id="loading-period-img"></div>
	</div>

	<!-- MODAL DAS METAS -->
	<jsp:include page="../views/goalSettings.jsp"></jsp:include>
	
	<!-- MODAL BACKGROUND E LOGO -->
	<jsp:include page="../views/viewSettings.jsp"></jsp:include>
	
	<!-- FIXED SIDEBAR FOR TOOLS -->
	<div data-offset-top="360" data-spy="affix" class="sidebar-nav affix" style="opacity: 0;">

	    <div id="sidebar-menu" class="nav-collapse subnav-collapse collapse">
	    
	        <ul id="ui-search" class="nav nav-header">
		        <li class="sidebar-search">
	                <div class="input-group custom-search-form">
	                    <input type="text" class="form-control sidebar-search" placeholder="Pesquisar...">
	                    <span class="input-group-btn">
	                    <button class="btn btn-default" type="button">
	                        <i class="fa fa-search"></i>
	                    </button>
	                </span>
	                </div>
	            </li>
            </ul>
            
            <a href="#" class="nav-header dashboard-save-button"><i class="fa fa-save"></i>Salvar Dashboard</a>
	    	
	        <a href="#" class="nav-header active" onclick="javascript: Dashboard.request.resetDashboard();"><i class="fa fa-dashboard"></i>Reconfigurar Dashboard</a>
	        
        	<a href="#accounts-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-wrench"></i>Configuração<span class="fa arrow"></span></a>
	        <ul id="accounts-menu" class="nav nav-list collapse">
	            <li><a data-toggle="modal" data-backdrop="true" data-target="#goalSettings"><i class="fa fa-tasks"></i> Cadastro de Metas</a></li>
	            <li><a data-toggle="modal" data-backdrop="true" data-target="#viewSettings"><i class="fa fa-photo"></i> Background/Logomarca</a></li>
	            <li><a href="javascript: Dashboard.configureRss();"><i class="fa fa-rss"></i> RSS</a></li>
	        </ul> 
	        
	        <a class="nav-header active-area" style="display: none;"></a>
	        
	        <a id="components" href="#components-list" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-cogs"></i>Componentes<span class="fa arrow"></span></a>
	        <ul id="components-list" class="nav nav-list collapse">
	            <li class="component-semaphore"><a><i class="fa fa-dot-circle-o"></i> Semáforo</a></li>
	            <li class="component-gage"><a><i class="fa fa-dashboard"></i> Velocímetro</a></li> 
	            <li class="component-chartbar"><a><i class="fa fa-bar-chart-o"></i> Gráfico de Barras</a></li>
	            <li class="component-chartline"><a><i class="fa fa-bars"></i> Gráfico de Linhas</a></li>
	            <!-- <li class="component-chartpie"><a><i class="fa fa-circle-o"></i> Gráfico de Pizza</a></li> -->
	            <li class="component-ranking"><a><i class="fa fa-tasks"></i> Ranking</a></li>
	            <li class="component-list"><a><i class="fa fa-list"></i> Lista</a></li>
	            <li class="component-map"><a><i class="fa fa-map-marker" style="width: 14px; text-align: center;"></i> Mapa</a></li>
	            <li class="component-mosaic"><a><i class="fa fa-th"></i> Mosaico</a></li>
	        </ul>     

	        <a id="scorecards" href="#scorecards-list" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-sliders"></i>Indicadores<span class="fa arrow"></span></a>
	        <ul id="scorecards-list" class="nav nav-list collapse">
	            <li class="VF component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> Vlr Faturado</a></li>
	            <li class="QF component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> Qtd Faturada</a></li>
	            <li class="VFC open-category-modal component-semaphore component-gage component-chartbar component-chartline component-chartpie"><a> Vlr Faturado por Categoria</a></li>
	            <li class="QFC open-category-modal component-semaphore component-gage component-chartbar component-chartline component-chartpie"><a> Qtd Faturada por Categoria</a></li>
<!-- 	            <li class="QA component-list"><a> Quantidade de Atendimentos</a></li> -->
	            <li class="QV component-list"><a> Quantidade de Vendas</a></li>
<!-- 	            <li class="TC component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> Taxa de Conversão</a></li> -->
	            <li class="PA component-list"><a> Peças por Atendimento</a></li>
	            <li class="TM component-list"><a> Ticket Médio</a></li>
	            <li class="CMV component-list"><a> Custo da Mercadoria Vendida</a></li>
	            <li class="MG component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> Margem</a></li>
	            <li class="MG_P component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> Margem %</a></li>
	            <li class="QE component-list"><a> Qtd Estoque</a></li>
	            <li class="QEC component-list"><a> Qtd Estoque a Preço de Custo</a></li>
	            <li class="QEV component-list"><a> Qtd Estoque a Preço de Venda </a></li>
	            <li class="VFV component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> Vlr Faturado a Vista</a></li>
	            <li class="VFP component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> Vlr Faturado a Prazo</a></li>
	            <li class="FV_P component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> % Faturado a Vista</a></li>
	            <li class="FP_P component-semaphore component-gage component-chartbar component-chartline component-chartpie component-list"><a> % Faturado a Prazo</a></li>
	            <li class="RR open-av-modal ranking-regiao component-ranking component-map"><a> Ranking de Região</a></li>
	            <li class="RL open-av-modal ranking-lojas component-ranking"><a> Ranking de Lojas</a></li>
	            <li class="RV open-av-modal ranking-vendedores component-ranking"><a> Ranking de Vendedores</a></li>
	            <li class="RP ranking-produtos component-ranking component-mosaic"><a> Ranking de Produtos</a></li>
	        </ul>
	        
	        <!-- 
	        <a href="#chart" class="nav-header collapsed" data-toggle="collapse"><i class="icon-bar-chart"></i>Charts &amp; graphs<span class="fa arrow"></span></a>
	        <ul id="chart" class="nav nav-list collapse">
	            <li><a href="charts.html"><i class="icon-picture"></i> Basic Charts</a></li>  
	            <li><a href="graphs.html"><i class="icon-signal"></i> Advanced Charts</a></li>   
	        </ul>                         


	        <a href="maps.html" class="nav-header"><i class="icon-map-marker"></i>Maps</a>

	        <a href="gallery.html" class="nav-header"><i class="icon-camera"></i>Gallery</a>
	         -->

	    </div>

	</div>

	<!-- DASHBOARD BODY -->
	<div class="row-fluid">
		<decorator:body/>
	</div>
	
	<!-- DASHBOARD LOADER -->
	<div class="modal js-loading-bar">
	 <div class="modal-dialog">
	   <div class="modal-content">
	     <div class="modal-body">
	       <h4>Carregando Dashboard...</h4>
	       <div class="progress progress-popup">
	        <div class="progress-bar"></div>
	       </div>
	     </div>
	   </div>
	 </div>
	</div>
	
	<!-- GENERIC MODAL -->
	<jsp:include page="../views/genericModal.jsp"></jsp:include>
	
	<jsp:include page="footer.jsp"></jsp:include>
	
	
	<!-- Mostrar modal na inicialização -->
	<script>
    	$('.js-loading-bar').modal({backdrop: 'static', show: false});
    
	    window.$initLoaderModal = $('.js-loading-bar'),
	    window.$initLoaderModalbar = $initLoaderModal.find('.progress-bar');
	
	  	$initLoaderModal.modal('show');
	  	$initLoaderModalbar.addClass('animate');
    </script>
	
	
    <!-- COMPATIBILITY -->
    <script src="resources/js/jquery.compatibility.js"></script>
	
    <!-- jQuery UI -->
    <script src="resources/js/jquery-ui-1.10.4.min.js"></script>
    <script src="resources/js/jquery.ba-resize.js"></script>
    
    <!-- Mobile touch events -->
    <script src="resources/js/jquery.ui.touch-punch.min.js"></script>
    
    <!-- Masks -->
    <script src="resources/js/jquery.mask.min.js"></script>
	
	<!-- File input upload -->
 	<script src="resources/js/fileinput.min.js"></script>
 	
 	<!-- Message -->
    <script src="resources/lib/toastmessage/js/jquery.toastmessage.js"></script>

	<!-- Necessário para os gráficos -->
    <script src="resources/lib/justgage/raphael.2.1.2.min.js"></script> 
    
    <!-- Velocimetro -->
    <script src="resources/lib/justgage/justgage.min.js"></script>
    
    <!-- Map -->
    <script src="http://maps.google.com/maps/api/js?sensor=true&libraries=geometry&v=3.7"></script>
    <script src="resources/js/maplace-0.1.3.min.js"></script>
    
	<!-- Line e Bar -->
    <script src="resources/lib/morris/morris.custom.min.js"></script>
    
    <!-- Semaphore -->
    <script src="resources/js/semaphore.js"></script>
    
    <!-- Lista/Ranking -->
    <script src="resources/js/lista.js"></script>
    
    <script src="resources/js/objects.js"></script>
    
    <!-- Pizza -->
    <script src="resources/lib/flot/jquery.flot.js"></script>
    <script src="resources/lib/flot/jquery.flot.pie.js"></script>
    <script src="resources/lib/flot/jquery.flot.resize.js"></script>
	
</body>
</html>
