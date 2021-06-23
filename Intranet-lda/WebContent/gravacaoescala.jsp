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
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
</head>
<body>
<%
	if(session.getAttribute("usuario") == null){
		pageContext.forward("cadLogin2.jsp");
	}
	boolean flag=true;
	BeanEscala bean = new BeanEscala();
	String [] data = request.getParameterValues("data");
	String [] pla1 = request.getParameterValues("pla1");
	String [] pla2 = request.getParameterValues("pla2");
	String [] apf1 = request.getParameterValues("apf1");
	String [] apf2 = request.getParameterValues("apf2");
	String [] epf = request.getParameterValues("epf");
	String [] ppf = request.getParameterValues("ppf");
	String [] dpf = request.getParameterValues("dpf");
	String [] pcf = request.getParameterValues("pcf");
	for(int i=0;i<data.length;i++){
		bean.setData(data[i]);
		bean.setPlantonista1(Integer.parseInt(pla1[i]));
		bean.setPlantonista2(Integer.parseInt(pla2[i]));
		bean.setAgente1(Integer.parseInt(apf1[i]));
		bean.setAgente2(Integer.parseInt(apf2[i]));
		bean.setPapiloscopista(Integer.parseInt(ppf[i]));
		bean.setEscrivao(Integer.parseInt(epf[i]));
		bean.setDelegado(Integer.parseInt(dpf[i]));
		bean.setPerito(Integer.parseInt(pcf[i]));
		if(!Util.gravaNovaEscala2(bean)){
			flag=false;
		}
	}
	
	if(flag==false){
		pageContext.forward("escalamaster.jsp?msgit=Escala alterada com sucesso mas com algumas observações.      * Não é possível alterar escalas anteriores a data atual...");
	}else{
		pageContext.forward("escalamaster.jsp?msgit=Escala alterada com sucesso.");
	}
%>
</body>
</html>