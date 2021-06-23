<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Intranet DPF</title>
<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
 <script>  
        function retornar() {  
            history.go(-1);  
       }  
 </script>  
</head>
<body>
	<center><a href="fotosdp.jsp" ><font color="white">Voltar...</font></a></center> 
	<p>&nbsp;&nbsp;</p> 
	<%String end = request.getParameter("foto"); %>
   	<center><img src="<%=end%>"  border="0"></center>
	<p>&nbsp;&nbsp;</p>
	<center><a href="fotosdp.jsp" ><font color="white">Voltar...</font></a></center> 
</body>
</html>