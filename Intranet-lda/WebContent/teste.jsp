<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<html>            
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
</head>
<body>

<% 
String data="047.167.519-95";
	out.print("<div><table class='search'><tr><td><h1>");
if(!Util.VerificaCPFBanco(data)){
	out.print("data errada");
}else{
	out.print("data certa");
}
	out.print("</h1></td></tr></table></div>");
	out.print("<div><table class='search'><tr><td><h1>");
%>
</body>
</html>