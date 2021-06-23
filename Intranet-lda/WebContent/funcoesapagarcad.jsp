<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="testes.Teste"%>
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
	String[] loginarray = request.getParameterValues("codigo_funcao");
	//String as = loginarray[0];
	//System.out.println(as);
	if( loginarray != null ){
		if(!Util.deleteFuncoes(loginarray)){
			pageContext.forward("funcoesapagar.jsp?msgi=Erro!!!  Nenhuma função foi excluída...");
		}else{
			pageContext.forward("funcoesapagar.jsp?msgi=Função excluída com sucesso...");
		}
	}else{
		pageContext.forward("funcoesapagar.jsp?msgi=Nenhuma função foi excluída...");
	}
%> 	
</body>
</html>