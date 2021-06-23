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

   if (form.senha2.value == "")
	      erro += "\nA senha de confirmação deve ser digitada!";
   
   if (form.nomecp.value == "")
	      erro += "\nO nome dever ser digitado!";

   if (form.numero_sala.value == "")
	      erro += "\nO número da sala deve ser digitado!";

   if (form.ramal.value == "")
	      erro += "\nO ramal deve ser digitado!";
   
   if (form.email.value == "")
	      erro += "\nO e-mail deve ser digitado!";

   if (form.telcasa.value == "")
	      erro += "\nO telefone de casa deve ser digitado!";
   
   if (form.cel1.value == "")
	      erro += "\nO celular 1 deve ser digitado!";
   
   if (form.cel2.value == "")
	      erro += "\nO celular 2 deve ser digitado!";

   if (form.matricula.value == "")
	      erro += "\nA Matricula deve ser digitada!";
   
   if (form.cargahoraria.value == "")
	      erro += "\nA Carga horária deve ser digitada!";
   
   if (erro != "") {
      alert(erro);
      return false;
   }

   return true;
}
</script>
<script>
function ajustar_data(input){
	if ((event.keyCode<48)||(event.keyCode>57)){
		event.returnValue = false;
	} else {
		event.returnValue = true;
	}
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
						<h1 class="left"><a href="#"></a></h1>
						<div class="post_date right"></div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body">
						
						<h1>BEM VINDO A PÁGINA DE ADMINISTRAÇÃO</h1>
						<p></p>
						<p>MODULO - USUÁRIOS - INSERIR</p>
						
						<form name="folhapdf" method="POST" id="searchform" action="folhapontopdf.jsp" target="new">
						<!--<form method="get" id="searchform" action="#">-->
							<div>
							<table class="search">
							<tr>
								<td><h1 class="sysmsg">
								<%String msg2 = (String) request.getParameter("msgit");
								if (msg2 != null)
	   									out.print(msg2);
								%></h1>
								</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>Hora de Entrada:</td>
							</tr>
							<tr>
								<td><input type="text" value="<%String he1 = (String) request.getParameter("he1"); if (he1  != null){	out.print(he1);}%>" name="he1" size="20"/></td>
								<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>Hora de Saida:</td>
							</tr>
							<tr>
								<td><input type="text" value="<%String hs1 = (String) request.getParameter("hs1"); if (hs1  != null){	out.print(hs1);}%>" name="hs1" size="20"/></td>
								<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>Hora de Entrada:</td>
							</tr>
							<tr>
								<td><input type="text" value="<%String he2 = (String) request.getParameter("he2"); if (he2  != null){	out.print(he2);}%>" name="he2" size="20"/></td>
								<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>Hora de Saida:</td>
							</tr>
							<tr>
								<td><input type="text" value="<%String hs2 = (String) request.getParameter("hs2"); if (hs2  != null){	out.print(hs2);}%>" name="hs2" size="20"/></td>
								<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
							<div>
							<table class="search">
							<tr>
								<td>Frequência Integral:</td>
							</tr>
							<tr>
								<td>SIM<input type="radio" value="1" name="fi" CHECKED size="20" /></td>
								<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
								<td>NÃO<input type="radio" value="0" name="fi" size="20"/></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>Dias do mês:</td>
							</tr>
							<tr>
								<td>
								<select  name="dias">
								<option selected value="28">28</option>
								<option selected value="29">29</option>
								<option selected value="30">30</option>
								<option selected value="31">31</option>
								</select>
								</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td style="padding-left: 10px"><input type="image" src="img/bts/entrar2.gif" /></td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>
								&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							</table>
						</div>
					
						</form>
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
						<form name="loginForm2" method="POST" id="searchform" action="index.jsp">
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
							<%=(Menu.imprimeMenuPrincipal())%>
						</ul>
					</div>
					<div class="box_bottom"></div>
				</div>

				
								
				

				
						<%String id_funcao = (String) session.getAttribute("id_funcao");
							int fu=0;
							if(id_funcao!=null){
								fu = Integer.parseInt(id_funcao);
							}
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