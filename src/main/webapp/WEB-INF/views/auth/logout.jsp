<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	// Invalidate current HTTP session. Will call JAAS LoginModule logout() method
	request.getSession().invalidate();

	// Redirect the user to the secure web page. Since the user is now logged out the
	// authentication form will be shown
	response.sendRedirect(request.getContextPath() + "/");
%>