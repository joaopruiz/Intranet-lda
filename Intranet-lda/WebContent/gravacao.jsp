<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<jsp:useBean id="grava" class="bean.Bean" scope="page"/> 
<jsp:setProperty name="grava" property="*"/>
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
<%if(session.getAttribute("usuario") == null){
	pageContext.forward("cadLogin2.jsp");
}


	if(!Autentica.validaNome(grava)){
		pageContext.forward("usuarios.jsp?msg1=Nome de Login inv�lido, use somente letras e n�meros sem espa�os vazios...");
	}else{
		if(!Autentica.autenticaNome(grava)){
			if(!Autentica.validaSenha(grava)){
				pageContext.forward("usuarios.jsp?msg1=Senha inv�lida, use somente letras e n�meros sem espa�os vazios...");
			}else{
				if(grava.getSenha2().equals(grava.getSenha())){
					if(!Util.verificaDataAdmissao(grava.getAdmissao())){
						pageContext.forward("usuarios.jsp?msg1=Data de admiss�o incorreta...");
					}else{
						String cpf = grava.getCpf();
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
							if(!Util.VerificaCPFBanco(grava.getCpf())){
								if(grava.getMatricula().equals("") || grava.getMatricula().equals(null)){
									if(Util.gravaNovoUsuario(grava)==true){
										pageContext.forward("usuariosmaster.jsp?msgexc=Novo usu�rio adicionado com sucesso.");
									}else{
										pageContext.forward("usuarios.jsp?msg1=Erro na grava��o.....");
									}
								}else{
									if(!Util.VerificaMatriculaBanco(grava.getMatricula())){
										if(Util.gravaNovoUsuario(grava)==true){
											pageContext.forward("usuariosmaster.jsp?msgexc=Novo usu�rio adicionado com sucesso.");
										}else{
											pageContext.forward("usuarios.jsp?msg1=Erro na grava��o.....");
										}
									}else{
										pageContext.forward("usuarios.jsp?msg1=Esta matr�cula perten�e a outro servidor...");
									}
								}
									
							}else{
								pageContext.forward("usuarios.jsp?msg1=Este CPF perten�e a outro servidor...");
							}
						}else{
							pageContext.forward("usuarios.jsp?msg1=CPF invalido...");
						}
					}
				}else{
					pageContext.forward("usuarios.jsp?msg1=Senhas n�o conferem...tente novamente...");
				}
			}
		}else{
			pageContext.forward("usuarios.jsp?msg1=Usuario j� existe, tente outro nome...");
		}
	}
%>
</body>
</html>