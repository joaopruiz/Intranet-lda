<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
</head>
<body>
<%

	Document document = new Document();
	try {
	    
		PdfWriter.getInstance(document, response.getOutputStream());
	    document.open();
	    
	    // adicionando um parágrafo ao documento
	    document.add(new Paragraph("Exemplo Geração de Arquivo PDF via iText - Java ttttttttt" +
	    		"tttttttttttttttttttttttttttttttttttttttttttttt" +
	    		"tttttttttttttttttttttttttttttttttttttttttttttttttttttttttt" +
	    		"tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt"));
	    document.add(new Paragraph("Novo parágrafo por JP"));
	}
	catch(DocumentException de) {
	    System.err.println(de.getMessage());
	    out.print("erro: "+de);
	}
	catch(IOException ioe) {
	    System.err.println(ioe.getMessage());
	    out.print("erro: "+ioe);
	}
	document.close();

%>
</body>
</html>