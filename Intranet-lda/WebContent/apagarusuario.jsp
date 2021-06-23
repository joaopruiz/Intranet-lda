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
	String[] loginarray = request.getParameterValues("chkExclusao");
	//out.println(Teste.testeString(loginarray));
	if( loginarray != null ){
		Util.deleteLoginHora(loginarray);
		if(!Util.deleteLogin(loginarray)){
			pageContext.forward("usuariosmaster.jsp?msgexc=Erro!!!  O usuário não foi excluído, pois ainda possui conteúdo vinculado ao mesmo...");
		}else{
			pageContext.forward("usuariosmaster.jsp?msgexc=Usuário excluído com sucesso...");
		}
	}else{
		pageContext.forward("usuariosmaster.jsp?msgexc=Nenhum Usuário foi excluído...");
	}
%> 	
</body>
</html>