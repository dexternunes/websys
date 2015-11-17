<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>

	<head>
	
		<title>Login</title>
		
	    <style type="text/css">
		
	      body {
	        padding-top: 20px;
	        padding-bottom: 20px;
	        background-color: #f5f5f5;
	      }
	      
	      header {
	      	padding-bottom: 0px !important;
	      }
	
	      .form-signin {
	        max-width: 300px;
	        padding: 19px 29px 29px;
	        margin: 0 auto 20px;
	        background-color: #fff;
	        border: 1px solid #e5e5e5;
	        -webkit-border-radius: 5px;
	           -moz-border-radius: 5px;
	                border-radius: 5px;
	        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
	           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
	                box-shadow: 0 1px 2px rgba(0,0,0,.05);
	      }
	      .form-signin .form-signin-heading,
	      .form-signin .checkbox {
	        margin-bottom: 10px;
	      }
	      .form-signin input[type="text"],
	      .form-signin input[type="password"] {
	        font-size: 16px;
	        height: auto;
	        margin-bottom: 15px;
	        padding: 7px 9px;
	      }
	
	    </style>
		
	</head>

  	<body>
    
	    <c:if test="${message != '' && message != null}">
		    <div class="alert alert-error">  	
				${message}
			</div>
	    </c:if>
	    
	    <form:form cssClass="form-signin" action="${pageContext.request.contextPath}/auth/login" commandName="user" method="post"> 
	    
	    	<h2 class="form-signin-heading">
				Seja Bem Vindo
			</h2>
	    
	        <input type="text" autofocus="autofocus" class="input-block-level" placeholder="Nome de Usuário" id="login" name="login">
	        
	        <input type="password" class="input-block-level" placeholder="Senha de Acesso" id="senha" name="senha" >
	        
	        <button class="btn btn-large btn-primary" type="submit">Entrar</button>
				
		</form:form>
		
  	</body>
  	
</html>