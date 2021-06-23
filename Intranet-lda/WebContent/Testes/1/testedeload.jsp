<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="metodos.Util"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="load.js" type="text/javascript"></script>
<link href="load.css" type="text/css" rel="stylesheet">
</head>
 <body>

	  <div id="conteudo">
	    <!-- -aqui vai todo o conteudo do site -->
	    <iframe name="principal" height="100%" width="100%" frameborder="0"  src="escala.jsp"></iframe>
      </div>
	  <!-- chamada da funcao que ira criar o elemento div para o loader -->
	  <!-- esta chamada pode ser a ultima linha dentro do body -->

      <script>loading();</script>	  
	</body>
</html>