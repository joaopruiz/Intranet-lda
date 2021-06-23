<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	session.setAttribute("usuario", null);
	session.setAttribute("id_funcao", null);
	session.setAttribute("cargo	", null);
	session.setAttribute("funcao", null);
	session.setAttribute("iduser", null);
	session.setAttribute("userequip", null);
	pageContext.forward("index.jsp?msg=LOGOUT COM SUCESSO...");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
</head>
<body>

</body>
</html>