<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.*"   
     import="java.util.*"   
     import="org.apache.commons.fileupload.*"  
     import="conexao.Util"
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
<%String a="";
String b="";
String c="";%>
<% 
       boolean isMultipart = FileUpload.isMultipartContent(request);  
       if (isMultipart) {  
          // Create a new file upload handler  
         DiskFileUpload upload = new DiskFileUpload();  
           
         // Set upload parameters  
         upload.setSizeMax(50*1024*1024); //50Mb  
         upload.setRepositoryPath("c:/Temp");  
           
         // Parse the request  
         List items = upload.parseRequest(request);  
         
         Iterator it = items.iterator();  
         while (it.hasNext()) {  
            FileItem fitem = (FileItem) it.next();  
            if (!fitem.isFormField()) {  
        
        //byte[] data=fitem.get();
        //Util.gravaNovoArquivo(data[0]);
   		a =(fitem.getName())+" - "+(fitem.getSize())+" bytes";
   		//pageContext.forward("subir.jsp?arquivo="+a);
    	//c=items.
    	b=fitem.getName();
            }  
         }
      }  
   %>  
 <br>
 <%=a %>
 <br><br>
 <img src="<%=b %>">
 <br>
</body>
</html>