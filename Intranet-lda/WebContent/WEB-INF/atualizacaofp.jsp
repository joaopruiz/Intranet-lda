<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%	if(session.getAttribute("usuario") == null){
		pageContext.forward("cadLogin2.jsp");
	}
boolean flag=true;
BeanFP bean = new BeanFP();

String [] data = request.getParameterValues("data");
String [] he1 = request.getParameterValues("he1");
String [] hs1 = request.getParameterValues("hs1");
String [] he2 = request.getParameterValues("he2");
String [] hs2 = request.getParameterValues("hs2");
String [] oc = request.getParameterValues("oc");

for(int i=0;i<data.length;i++){
	bean.setData(data[i]);
	bean.setHe1(he1[i]);
	bean.setHe2(he2[i]);
	bean.setHs1(hs1[i]);
	bean.setHs2(hs2[i]);
	bean.setOc(oc[i]);
	if(Util.atualizaFolhaPonto2(bean)==true){
		flag=false;
		System.out.println(flag);
	}
}

if(flag==false){
	pageContext.forward("folhaponto3.jsp?msgi=Erro na gravação...");
}else{
	pageContext.forward("folhaponto3.jsp?msgi=Dados salvos com sucesso.");
}


/*if(Util.atualizaFolhaPonto(id.getData_31(), id.getHe1_31(), id.getHs1_31(), id.getHe2_31(), id.getHs2_31(), id.getOc_31(), id.isFrequenciaint(), (Util.retornaID((String) session.getAttribute("usuario"))))==true){
	pageContext.forward("folhaponto3.jsp?msgi=Dados salvos com sucesso.");
}else{
	pageContext.forward("folhaponto3.jsp?msgi=Erro na gravação..do dia "+id.getData_31()+"...");
}*/		
%>
</body>
</html>