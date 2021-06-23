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
	String td = (String) request.getParameter("theDate");
	int nome = (Util.retornaID((String) session.getAttribute("usuario")));
	String mes = td.substring(2,10);
	int udia=Util.retornaUltimoDiaMes(td);
	if(Util.verificaData(td, nome)==true){
		for(int i=1;i<=udia;i++){
			if(i>=1 && i<=9){
				Util.gravaFolhaPonto("0"+i+mes, nome);
			}else{
				Util.gravaFolhaPonto(i+mes, nome);
			}
		}
	}
	
	
	session.setAttribute("datafp", td);
	pageContext.forward("folhaponto3.jsp");
%>
</body>
</html>