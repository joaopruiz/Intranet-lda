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
<script>
function enviar(acao)
{
	if (acao == "apagar") {
		 if (confirm('Tem certeza que quer apagar este usuario?')){ 
			 document.formulario.action = "apagarusuario.jsp";
			 document.formulario.submit();
		   } 
	}

	if (acao == "atribuir") {
		document.formulario.action = "atualizacaoordematribuir.jsp";
		document.formulario.submit();
	}

	if (acao == "voltar") {
		document.formulario.action = "gerenteos.jsp";
		document.formulario.submit();
	}
	if (acao == "finalizar") {
		document.formulario.action = "atualizacaoordemfinalizargerente.jsp";
		document.formulario.submit();
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

		<div class="right" id="ordem">

			<div id="main_left_content">
		
				<div class="post">
					
					<div class="post_title">
						<h1 class="left">ORDENS DE SERVIÇO<a href="#"></a></h1>
						<div class="post_date right"></div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body">
						
						
						<p></p>
						<p>MODULO - ORDENS</p>
						<div>
							<table class="search">
							<tr>
								<td><h1 class="sysmsg">
								<% String msgexc = (String) request.getParameter("msgexc");
								if (msgexc != null){
	   									out.print(msgexc);
	   							}%></h1>
								</td>
							</tr>
							</table>
						</div>
						<FORM NAME=formulario method=POST>
						<%int qt=0;
						String[] loginarray = request.getParameterValues("chkExclusao");
						qt=Integer.parseInt(loginarray[0]);
						out.print(Util.ordensMasterLeitura(qt)); %>
							<INPUT TYPE="HIDDEN"  NAME=dtatribuicao VALUE="<%String a="";
								a=Util.DataHoje();
								out.print(a); %>">
							<INPUT TYPE="HIDDEN"  NAME=dtfinalizacao VALUE="<%String b="";
								b=Util.DataHoje();
								out.print(b); %>">
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
								<td>&nbsp;</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
							<div>
							<table class="search">
							<tr>
								<td>
								<center>
								Atendente:
								</center>
								</td>
							</tr>
							<tr>
								<td>
								<center>
								<select  name="codigousuarioatendente">
								<!--<option selected value="cargo">Cargo</option>-->
								<%out.print(Util.comboboxAtendentes()); %>
								</select>
								</center>
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
							<TD>
								<center>
								<input type='image' src='img/bts/atribuir.gif' onClick="enviar(this.name)" value="Atribuir Atendente a OS" name="atribuir">
								</center>
							</TD>
							</tr>
							</table>
						</div>
						</form>
					</div>
					<div class="post_bottom"></div>

				</div>

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