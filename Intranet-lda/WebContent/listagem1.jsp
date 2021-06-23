<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
%>
<%
		int qt=0;
		String[] loginarray = request.getParameterValues("chkExclusao");
		qt=Integer.parseInt(loginarray[0]);
		session.setAttribute("userequip", Integer.toString(qt));								
		pageContext.forward("listagem.jsp");
%>
</body>
</html>