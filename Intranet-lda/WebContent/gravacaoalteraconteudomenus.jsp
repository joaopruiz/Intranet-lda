<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<jsp:useBean id="menubean" class="bean.BeanMenu" scope="page"/> 
<jsp:setProperty name="menubean" property="*"/>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
</head>
<body>
<%if(session.getAttribute("usuario") == null){
	pageContext.forward("cadLogin2.jsp");
}
	if(Util.alteraMenus(menubean)==true){
		pageContext.forward("alteracaoconteudo.jsp?msgit=Erro na grava??o.....");
	}else{
		pageContext.forward("alteracaoconteudo.jsp?msgit=Conte?do alterado com sucesso...");
	}			
%>
</body>
</html>