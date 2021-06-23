<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>DELETE</title>
</head>
<body>
<%	if(session.getAttribute("usuario") == null){
		pageContext.forward("cadLogin2.jsp");
	}
%>
<% 
	int qt=0;
	String[] loginarray = request.getParameterValues("codigo_cargo");
	//String as = loginarray[0];
	//System.out.println(as);
	if( loginarray != null ){
		if(!Util.deleteCargos(loginarray)){
			pageContext.forward("cargosmaster.jsp?msgi=Erro!!!  Este cargo não pode ser excluido, pois é utilizado por algum(s) usuário(s)...");
		}else{
			pageContext.forward("cargosmaster.jsp?msgi=Cargo excluído com sucesso...");
		}
	}else{
		pageContext.forward("cargosmaster.jsp?msgi=Nenhum cargo foi excluído...");
	}
%> 	
</body>
</html>