<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<jsp:useBean id="id" class="bean.BeanFP" scope="page"/> 
<jsp:setProperty name="id" property="*"/>
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
<%	if(session.getAttribute("usuario") == null){
		pageContext.forward("cadLogin2.jsp");
	}
	String td = (String) session.getAttribute("datafp");
	int nome = (Util.retornaID((String) session.getAttribute("usuario")));
	String[] a = new String[4];
	a[0]=id.getHe1();
	a[1]=id.getHs1();
	a[2]=id.getHe2();
	a[3]=id.getHs2();
	Util.gravaHoraPadrao(a, nome);
	Util.atualizaHoraPadrao(a, nome);
	
	//session.setAttribute("datafp", td);
	pageContext.forward("folhaponto3.jsp");
%>
</body>
</html>