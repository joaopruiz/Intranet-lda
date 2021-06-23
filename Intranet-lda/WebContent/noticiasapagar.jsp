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
	int i=0;
	String[] loginarray = request.getParameterValues("chkExclusao");
	i=Integer.parseInt(loginarray[0]);
	if( loginarray != null ){
		if(!Util.deletaNoticias(loginarray)){
			pageContext.forward("noticiasmaster.jsp?msgit=Erro!!!  Nenhuma notícia foi excluída...");
		}else{
			pageContext.forward("noticiasmaster.jsp?msgit=Notícia excluída com sucesso...");
		}
	}else{
		pageContext.forward("noticiasmaster.jsp?msgit=Nenhuma notícia foi excluída...");
	}
%> 	
</body>
</html>