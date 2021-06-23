
<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean id="util" class="metodos.Util" scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>INTRANET DPF LONDRINA</title>
<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
<!--[if lte IE 7]><link rel="stylesheet" type="text/css" href="ie_fixes.css" media="screen" /><![endif]-->
</head>
<body>
<script>
function validaDados(form) {

   var erro = "";

   if (form.nome.value == "")
      erro = "O login deve ser digitado!";

   if (form.senha.value == "")
      erro += "\nA senha deve ser digitada!";

   if (erro != "") {
      alert(erro);
      return false;
   }

   return true;
}
</script>
<div id="layout_wrapper">
<div id="layout_edgetop"></div>

<div id="layout_container">
	<div id="navigation">
		<div id="tabs">
			<ul>
			</ul>
			<div class="clearer"></div>
		</div>
	</div>
	<div class="spacer h5"></div>
<div id="site_title">
		<h1 class="left"><a href="index.jsp"><%=Util.imprimeTitulo() %></a></h1>
		<h2 class="right">INTRANET DPF</h2>
		<div class="clearer">&nbsp;</div>
	</div>
	<div id="top_separator"></div>
	<div id="main">
		<div class="right" id="main_left">
			<div id="main_left_content">
				<div class="post">
					<div class="post_title">
						<h1 class="left"><a href="#"> </a></h1>
						<div class="post_date right"> </div>
						<div class="clearer">&nbsp;</div>
					</div>
					<div class="post_body">
						<p>&nbsp;&nbsp;</p>
						<%//metodos desativados por falta de BD %>
						<%=Util.imprimeNot�ciasPaginaIndex()%>
						<%//=Uteis.imprimeLinks() %>
					</div>

					<div class="post_bottom"></div>
				</div>
			</div>
		</div>
		<div class="left" id="main_right">

			<div id="sidebar">

				<div class="box">
					<div class="box_title">LOGIN INTRANET</div>
					<div class="box_body">
						<form name="loginForm" method="POST" id="searchform" action="cadLogin2.jsp" onSubmit="return validaDados(this);">
						<%=Login.imprimeLogin((session.getAttribute("usuario")), (session.getAttribute("cargo")), (session.getAttribute("funcao")))%><div>
							<div>
							<table class="search">
							<tr>
								<td>
								<%String msg = (String) request.getParameter("msg");
								if (msg != null)
	   									out.print(msg);
								%>
								</td>
							</tr>
							</table>
						</div>
						</div>
						</form>
					</div>
					<div class="box_bottom"></div>
				</div>

				<div class="box">
					<div class="box_title">MENU PRINCIPAL</div>
					<div class="box_body">
						<ul>
							<%=Menu.imprimeMenuPrincipal() %>
						</ul>
					</div>
					<div class="box_bottom"></div>
				</div>
						<%String id_funcao = (String) session.getAttribute("id_funcao");
							int fu=0;
							if(id_funcao!=null){
								fu = Integer.parseInt(id_funcao);
							}
							//out.print("teste JP");		
							out.print(Menu.imprimeMenu(fu));
							%>
			</div>
		</div>
		<div class="clearer">&nbsp;</div>
	</div>
	<div id="footer">
		<%=Rodape.imprimeRodape() %>
	</div>
</div>
<div id="layout_edgebottom"></div>
</div>
</body>
</html>