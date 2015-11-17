<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
	<title><spring:message code="appDefaultTitle" /></title>
</head>

<script type="text/javascript">

	DASHBOARD_SETUP = false;

</script>


<style>

</style>


<body>

	<div class="row-fluid dashboard-container-left"></div>
	
	<div class="period-controls pull-right">
		<ul>
			<li><a class="selected-control" data-action="play" ><i class="fa fa-play" title="Iniciar"></i></a></li>
			<li><a data-action="pause"> <i class="fa fa-pause" title="Pausar"></i></a></li>
		</ul>
	</div>
	
	<div class="period col-md-8 pull-right">
		<ul>
			<li><a data-period="DIARIA" >Diária</a></li>
			<li><a data-period="SEMANAL" >Semanal</a></li>
			<li><a data-period="MENSAL" >Mensal</a></li>
			<li><a data-period="TRIMESTRAL" >Trimestral</a></li>
			<li><a data-period="SEMESTRAL" >Semestral</a></li>
			<li><a data-period="ANUAL" >Anual</a></li>
		</ul>
	</div>

	<div class="dashboard-main-container col-md-9 pull-right">
	
	<div class="col-md-4 dashboard-parent-left">
	
        <div class="col-md-12 square-up empty">
            <div class="panel panel-default">
                <div class="panel-body">
				</div>
            </div>
            
            <div class="config-area-overlay">
				<i class="fa fa fa-cogs"></i>
				<span class="area-description">Área 1</span>
				<span class="close-edition">Finalizar Edição</span>
			</div>
        </div>
	
		<div class="col-md-12 square-down empty">
            <div class="panel panel-default">
                <div class="panel-body">
				</div>
            </div>
            
            <div class="config-area-overlay">
				<i class="fa fa fa-cogs"></i>
				<span class="area-description">Área 2</span>
				<span class="close-edition">Finalizar Edição</span>
			</div>
        </div>
        
	</div>

	<div class="col-md-8 dashboard-parent-right">

		<div class="col-md-12 rectangle-up empty" style="height: 23%;">
		
			<div class="panel panel-default">
                <div class="panel-body">
                
                </div>
	        </div>
            
            <div class="config-area-overlay">
				<i class="fa fa fa-cogs"></i>
				<span class="area-description">Área 3</span>
				<span class="close-edition">Finalizar Edição</span>
			</div>
        </div>
		
		<div class="col-md-12 rectangle-down empty" style="height: 27%;">
            <div class="panel panel-default">
                <div class="panel-body">
				</div>
            </div>
            
            <div class="config-area-overlay">
				<i class="fa fa fa-cogs"></i>
				<span class="area-description">Área 4</span>
				<span class="close-edition">Finalizar Edição</span>
			</div>
        </div>
		
		
        <div class="col-md-6 square-left empty">
            <div class="panel panel-default">
                <div class="panel-body">
				</div>
            </div>
            
            <div class="config-area-overlay">
				<i class="fa fa fa-cogs"></i>
				<span class="area-description">Área 5</span>
				<span class="close-edition">Finalizar Edição</span>
			</div>
        </div>
		
		<div class="col-md-6 square-right empty">
            <div class="panel panel-default">
            	<div class="panel-body">
				</div>
            </div>
            
            <div class="config-area-overlay">
				<i class="fa fa fa-cogs"></i>
				<span class="area-description">Área 6</span>
				<span class="close-edition">Finalizar Edição</span>
			</div>
        </div>
	
	</div>
	
	</div>

</body>
</html>