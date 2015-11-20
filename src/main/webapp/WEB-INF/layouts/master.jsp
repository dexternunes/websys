											 <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <title><decorator:title /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">		
   
	<link rel="stylesheet" type="text/css" href="http://static.scsul.com.br/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="http://static.scsul.com.br/css/bootstrap-responsive.css">
	<link rel="stylesheet" type="text/css" href="http://static.scsul.com.br/css/project.css" />
	<link rel="stylesheet" type="text/css" href="http://static.scsul.com.br/css/DT_bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="http://static.scsul.com.br/css/datepicker.css" />
	
	<script type="text/javascript" src="http://static.scsul.com.br/js/jquery-1.10.1.min.js"></script>
	<script type="text/javascript" src="http://static.scsul.com.br/js/bootstrap.min.js"></script>	
	<script type="text/javascript" src="http://static.scsul.com.br/js/project.js"></script>	
	
	<script type="text/javascript" src="http://static.scsul.com.br/js/jquery.maskedinput.min.js"></script>
	<script type="text/javascript" src="http://static.scsul.com.br/js/jquery.maskMoney.min.js"></script>
		
	<script type="text/javascript" src="http://static.scsul.com.br/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="http://static.scsul.com.br/js/DT_bootstrap.js"></script>
	<script type="text/javascript" src="http://static.scsul.com.br/js/kapp.dataTables.js"></script>
	
	<script type="text/javascript" src="http://static.scsul.com.br/js/noty/jquery.noty.js"></script>
	<script type="text/javascript" src="http://static.scsul.com.br/js/noty/top.js"></script>	
	<script type="text/javascript" src="http://static.scsul.com.br/js/noty/topCenter.js"></script>	
	<script type="text/javascript" src="http://static.scsul.com.br/js/noty/default.js"></script>
	<script type="text/javascript" src="http://static.scsul.com.br/js/bootstrap-datepicker.js"></script>
	
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  <script src="http://static.scsul.com.br/js/html5shiv.js"></script>
	<![endif]-->
    
    <decorator:head/>
</head>

<body>

	<header>
		<div class="navbar navbar-fixed-top">
	      	<div class="navbar-inner">
	        	<div class="container">
		          	<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
		            	<span class="icon-bar"></span>
		            	<span class="icon-bar"></span>
		            	<span class="icon-bar"></span>
		          	</button>
		          	
		          	<a href="<c:url value="/home/" />" ><i class="">LOGO MINI</i></a>
		          	
		          	<div class="nav-collapse collapse">
		            	
		            	<ul class="nav nav-top-menu">  
		            	    
		            		<sec:authorize url="/home">    	
				             	<li class="">
				                	<a href="<c:url value="/home" />">Home</a>
				              	</li>
			              	</sec:authorize>     
			              	
		            		<sec:authorize url="/configuracoes/">    	
				             	<li class="">
				                	<a href="<c:url value="/configuracoes/" />">Configura��es</a>
				              	</li>
			              	</sec:authorize>
			              	 
		            	</ul>
		            	
		            	<ul class="nav nav-top-menu pull-right">
		            	
		            		<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
		            			<li class="divider-vertical"></li>	
								<li class="visible-desktop">							
									<a href="#"><i class="icon-user"></i>  &nbsp; <span class="text-success">${currentLoggedUser.nome}</span></a>								
								</li>	
			              	</sec:authorize>
			              	
					    	<sec:authorize access="isAuthenticated()">
					    	
					    		<!-- #################### LOGOUT -->
					   			
					   			<li class="divider-vertical visible-desktop"></li>
									    	
					   			<li class="visible-desktop">					   			
					   				<a href="<c:url value="/j_spring_security_logout" />" title="Sair do Sistema"><i class="icon-off"></i></a>					   			
					   			</li>
				   				
					   			<li class="hidden-desktop">					   			
					   				<a href="<c:url value="/j_spring_security_logout" />" title="Sair do Sistema">Sair do Sistema</a>					   			
					   			</li>
					   			
					   			<!-- #################### LOGOUT -->
					   			
					   		
				   				<li class="divider-vertical visible-desktop"></li>
					   			   
					   		</sec:authorize>	
                    	</ul>
		          	</div>
		        </div>
	      	</div>
	    </div>
	</header>

	<div class="container master">
		<decorator:body/>
	</div>
	
</body>
</html>
