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
<link type="text/css" rel="stylesheet" href="Cal/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"></LINK>
<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
<!--[if lte IE 7]><link rel="stylesheet" type="text/css" href="ie_fixes.css" media="screen" /><![endif]-->
</head>
<body>
<SCRIPT type="text/javascript" src="Cal/dhtmlgoodies_calendar/calendario.js?random=20060118"></script>
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

   if (erro != "") {
      alert(erro);
      return false;
   }

   return true;
}
</script>
<script>
function validaCampos(form) {

   var erro = "";

   if (form.titulo.value == "")
      erro = "O Título deve ser digitado!";

   if (form.expira.value == "")
      erro += "\nA data de expiração deve ser preenchida!";

   if (form.descricao.value == "")
	      erro += "\nA descrição da notícia deve ser digitada!";

   if (erro != "") {
      alert(erro);
      return false;
   }

   return true;
}
</script>
<script>
function enviar(acao)
{
	if (acao == "expira") {
		document.formulario.action = "noticiasaltera.jsp";
		document.formulario.submit();
	}
}
</script>
<script>
function noticia(acao){
	if(acao == "paragrafo"){
		document.loginForm.descricao.value+="&nbsp;&nbsp;&nbsp;&nbsp;";
	}
	if(acao == "quebra"){
		document.loginForm.descricao.value+="<br><br>";
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
						<h1 class="left">NOTÍCIAS<a href="#"></a></h1>
						<div class="post_date right"></div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body">
						
			
						<p></p>
						<p>MODULO - NOTÍCIAS - POSTAR</p>
						<div>
							<table class="search">
							<tr>
								<td><h1 class="sysmsg">
								<% String msgit = (String) request.getParameter("msgit");
								if (msgit != null){
	   									out.print(msgit);
	   							}%></h1>
								</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
						<form name="loginForm" method="POST" id="searchform" action="gravacaonoticias.jsp" onSubmit="return validaCampos(this);">
						<!--<form method="get" id="searchform" action="#">-->
						<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>		
						<div>
							<table class="search">
							<tr>
								<td>Título da Notícia:</td>
							</tr>
							<tr>
								<td><INPUT TYPE="text"  NAME='titulo' VALUE="" size="80"></td>
							</tr>
							</table>
						</div>
						
						<div>
							<table class="search">
							<tr>
								<td><INPUT TYPE="HIDDEN"  NAME='data' VALUE="<%String a="";
								a=Util.DataHoje();
								out.print(a); %>"></td>
								<td><INPUT TYPE="HIDDEN" NAME='nome' VALUE="<% String cargo1 = (String) session.getAttribute("iduser");
								if (cargo1 != null){
	   									out.print(cargo1);
	   							}%>"></td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>Escolha a data de expiração.
								</td>
							</tr>
							<tr>
								<td>
								<INPUT TYPE="text" NAME='expira' VALUE="" readonly="readonly" size='30' onchange='enviar(this.name)'>
								</td>
							</tr>
							</table>
						</div>	
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
									<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td><center><input type="button" name="paragrafo" value="Parágrafo" onclick="noticia(this.name)"></center></td>
								<td><center><input type="button" name="quebra" value="Quebra de linha" onclick="noticia(this.name)"></center></td>
							</tr>
							</table>
						</div>	
						<div>
							<table class="search">
							<tr>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>		
														
						<div>
							<table class="search">
							<tr>
								<td>Descricão da Notícia:</td>
							</tr>
							<tr>
								<td>
								<textarea NAME=descricao COLS=61 ROWS=20></textarea>
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
								<td style="padding-left: 10px"><input type="image" src="img/bts/salvar2.gif" /></td>
							</tr>
							<tr>
								
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
						<form name="loginForm2" method="POST" id="searchform" action="index.jsp" onSubmit="return validaDados(this);">
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
<script>
displayCalendar(document.loginForm.expira,'dd/mm/yyyy',document.loginForm.expira);
</script>
</body>
</html>