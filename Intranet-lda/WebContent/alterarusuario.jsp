<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<jsp:useBean id="altera" class="bean.Bean" scope="page"/> 
<jsp:setProperty name="altera" property="*"/>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
</head>
<body>
<%if(session.getAttribute("usuario") == null){
	pageContext.forward("cadLogin2.jsp");
}


	if(!Autentica.validaNome(altera)){
		pageContext.forward("usuariosmaster.jsp?msgexc=Nome de Login inválido, use somente letras e números sem espaços vazios...");
	}else{
			if(!Autentica.validaSenha(altera)){
				pageContext.forward("usuariosmaster.jsp?msgexc=Senha inválida, use somente letras e números sem espaços vazios...");
			}else{
				if(altera.getSenha2().equals(altera.getSenha())){
					
					if(!Util.verificaDataAdmissao(altera.getAdmissao())){
						pageContext.forward("usuariosmaster.jsp?msgexc==Data de admissão incorreta...");
					}else{
						String cpf = altera.getCpf();
						String cpf2 = "";
						int x=1;
						for(int i=0;i<cpf.length();i++){
							if(cpf.substring(i, x).equals(".") || cpf.substring(i, x).equals("-")){
							}else{
								cpf2+=(cpf.substring(i, x));
							}
							x++;
						}
						//System.out.println(cpf2);
						if(Util.VerificaCPF(cpf2)==true){
							if(Util.alteraLogin(altera)==true){
								pageContext.forward("usuariosmaster.jsp?msgexc=Usuário alterado com sucesso.");
							}else{
								pageContext.forward("usuariosmaster.jsp?msgexc=Erro na gravação.....");
							}	
						}else{
							pageContext.forward("usuariosmaster.jsp?msgexc=CPF invalido...");
						}
					}	
				}else{
					pageContext.forward("usuariosmaster.jsp?msgexc=Senhas não conferem...tente novamente...");
				}
			}
	}
%>
</body>
</html>