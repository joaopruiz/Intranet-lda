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
						<h1 class="left">ORDEM DE SERVIÇO<a href="#"></a></h1>
						<div class="post_date right"></div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body">
						
						
						<p></p>
						<p>MODULO - ORDEM - ABRIR</p>
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
						<form name="loginForm" method="POST" id="searchform" action="gravacaoos.jsp" onSubmit="return validaDados(this);">
						<!--<form method="get" id="searchform" action="#">-->
						<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
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
								<!--  
								private Date dtabertura;
								private Date dtatribuicao;
								private Date dtfinalizacao;
								private Date dtaprovacao;
								private int codigousuarioabriu;
								private int codigotipos;
								private int codigousuarioatendente;
								private int codigostatus;
								private String descricao;-->
							
							
								<td><INPUT TYPE="HIDDEN"  NAME=dtabertura VALUE="<%String a="";
								a=Util.DataHoje();
								out.print(a); %>"></td>
								<td><INPUT TYPE="HIDDEN"  NAME=dtatribuicao VALUE="null"></td>
								<td><INPUT TYPE="HIDDEN"  NAME=dtfinalizacao VALUE="null"></td>
								<td><INPUT TYPE="HIDDEN"  NAME=dtaprovacao VALUE="null"></td>
								<td><INPUT TYPE="HIDDEN" NAME=codigousuarioabriu VALUE="<% String cargo1 = (String) session.getAttribute("iduser");
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
							<tr>
								
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>Status da Ordem de Serviço:</td>
							</tr>
							<tr>
								<td>
								<select  name="codigostatus">
								<!--<option selected value="cargo">Cargo</option>-->
								<%out.print(Util.comboboxStatusOSAbertura()); %>
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
								<td>Tipo da Ordem de Serviço:</td>
							</tr>
							<tr>
								<td>
								<select  name="codigotipos">
								<!--<option selected value="cargo">Cargo</option>-->
								<%out.print(Util.comboboxTipoOS()); %>
								</select>
								</td>
								<td><INPUT TYPE="HIDDEN" NAME=codigousuarioatendente VALUE=""></td>
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
								<td>Descrição do Problema:</td>
							</tr>
							<tr>
								<td>
								<textarea NAME=descricao COLS=60 ROWS=12></textarea>
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
						<form name="loginForm" method="POST" id="searchform" action="index.jsp" onSubmit="return validaDados(this);">
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