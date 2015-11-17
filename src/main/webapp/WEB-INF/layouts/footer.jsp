<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<footer>
	
	<div class="navbar navbar-default navbar-fixed-bottom dashboard-bottom-bar" role="navigation">
      <div class="container-fluid">

		<!-- Menu -->
        <div class="navbar-collapse collapse col-sm-4 col-md-3" style="height: 1px;">
          <ul class="nav navbar-nav navbar-left">
          	
          	<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-bars fa-13 white"></i></a>
              <ul class="dropdown-menu">
				<li class="dropdown-header">Navegação</li>
				<li><a href="home">Início</a></li>
				<li><a href="home?periodo=DIARIA">Diário</a></li>
				<li><a href="home?periodo=SEMANAL">Semanal</a></li>
				<li><a href="home?periodo=MENSAL">Mensal</a></li>
				<li><a href="home?periodo=TRIMESTRAL">Trimestral</a></li>
				<li><a href="home?periodo=SEMESTRAL">Semestral</a></li>
				<li><a href="home?periodo=ANUAL">Anual</a></li>
				<li class="divider"></li>
				<li class="dropdown-header">Administração</li>
				<li><a href="setup">Configurações</a></li>
              </ul>
            </li>
            
          </ul>
       </div>
        
        <!-- Clock -->
        <div class="navbar-collapse collapse col-sm-4 col-md-3" style="height: 1px;">
          <ul class="nav navbar-nav navbar-left">
          	<li class="dropdown">
              <a href="" class="bottom-bar-clock" data-component-name="dashboard-clock"> <i class="fa fa-clock-o fa-13 white">&nbsp;00:00:00</i></a>
            </li>
          </ul>
        </div>
        
        <!-- RSS -->
        <div class="navbar-collapse col-sm-4 col-md-3 col-md-offset-6 visible-desktop" style="height: 1px;">
          <ul class="nav navbar-nav navbar-left">
          	<li class="">
              	<a href="#" class="bottom-bar-clock" data-component-name="dashboard-rss">
              		<i class="fa fa-rss fa-13 white">&nbsp;</i>
            		<span class="white">Carregando RSS...</span>
				</a>
            </li>
          </ul>
        </div>
        
        <!-- Enterprise Description -->
        <div class="navbar-header navbar-right">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">
          	<span class="white" style="font-weight: bold;">System</span>
			<span class="white">| DASHBOARD</span>
          </a>
        </div>
      </div>
    </div>
	
</footer>