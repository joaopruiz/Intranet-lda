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
<%	if(session.getAttribute("usuario") == null){
		pageContext.forward("cadLogin2.jsp");
	}
	String dt = request.getParameter("data");
	
	boolean flag=true;
	BeanFP bean = new BeanFP();
	int id = 0;
	id = Util.retornaID((String)session.getAttribute("usuario"));
	String [] data = request.getParameterValues("data");
	String [] he1 = request.getParameterValues("he1");
	String [] hs1 = request.getParameterValues("hs1");
	String [] he2 = request.getParameterValues("he2");
	String [] hs2 = request.getParameterValues("hs2");
	String [] oc = request.getParameterValues("oc");
	String frequenciaint = ((String)request.getParameter("frequenciaint"));
	//System.out.println(he1.length);
	for(int i=0;i<he1.length;i++){
		//System.out.println(i);
		//System.out.println(he1[i]);
		if(data[i]!=null){bean.setData(data[i]);}
		if(he1[i]!=null){bean.setHe1(he1[i]);}
		if(he2[i]!=null){bean.setHe2(he2[i]);}
		if(hs1[i]!=null){bean.setHs1(hs1[i]);}
		if(hs2[i]!=null){bean.setHs2(hs2[i]);}
		if(oc[i]!=null){bean.setOc(oc[i]);}
		bean.setId(id);
		bean.setFrequenciaint(Boolean.parseBoolean(frequenciaint));
		if(Util.atualizaFolhaPonto2(bean)==false){
			flag=false;
			//System.out.println(flag);
		}
	}

	if(flag==false){
		pageContext.forward("folhaponto3.jsp?msgi=Erro na gravação...");
	}else{
		pageContext.forward("folhapontopdf2.jsp?data="+dt);
	}
%>
</body>
</html>