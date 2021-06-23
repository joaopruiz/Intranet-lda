<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<jsp:useBean id="fantim" class="bean.Bean" scope="page"/> 
<jsp:setProperty name="fantim" property="*"/> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Login</title>
</head>
<body> 

<%
	if(fantim.getNome().equals(null)){
		session.setAttribute("usuario", null);
		session.setAttribute("id_funcao", null);
		session.setAttribute("cargo	", null);
		session.setAttribute("funcao", null);
		session.setAttribute("iduser", null);
		session.setAttribute("userequip", null);
		pageContext.forward("index.jsp?msg=É requerido autenticação!!!");
	}else{
			if(!Autentica.validaNome(fantim)){
				pageContext.forward("index.jsp?msg=Caracteres inválidos! Tente novamente.");
			}else{
				if(!Autentica.autenticaNome(fantim)){
					pageContext.forward("index.jsp?msg=Nome Inválido! Tente novamente.");
				}else{
					if(!Autentica.validaSenha(fantim)){
						pageContext.forward("index.jsp?msg=Caracteres inválidos em sua senha! Tente novamente...");
					}else{
						if (!Autentica.autenticaSenha(fantim)){
							pageContext.forward("index.jsp?msg=Sua senha não está correta...");
						}else{
							session.setAttribute("usuario", request.getParameter("nome"));
							String cargo = Autentica.Cargo(fantim);
							session.setAttribute("cargo", cargo);
							String funcao = Autentica.Funcao(fantim);
							session.setAttribute("funcao", funcao);
							String id = Autentica.id_Usuario(fantim);
							session.setAttribute("iduser", id);
							//System.out.println("login"+id);
							int fo = Autentica.validaFuncao(fantim);
							session.setAttribute("id_funcao", Integer.toString(fo));
							//if((session.getAttribute("funcao").equals("Atendente Suporte")) || (session.getAttribute("funcao").equals("Administrador e Atendente"))){
								//pageContext.forward("pagina2.jsp");
							//}else{
								//if((session.getAttribute("funcao").equals("Gerente TI"))){
									//pageContext.forward("pagina3.jsp");
								//}else{
									pageContext.forward("pagina.jsp");
								//}
							//}
							
						}
					}
				}
			}
	}

%>
</body>
</html>