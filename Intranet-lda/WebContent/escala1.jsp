<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<jsp:useBean id="util" class="metodos.Util" scope="page"/>
<%	if (session.getAttribute("usuario") != null){
		session.setAttribute("usuario", null);
	}
	if (session.getAttribute("id_funcao") != null){
		session.setAttribute("id_funcao", null);
	}
	if (session.getAttribute("cargo	") != null){
		session.setAttribute("cargo	", null);
	}
	if (session.getAttribute("funcao") != null){
		session.setAttribute("funcao", null);
	}
	if (session.getAttribute("iduser") != null){
		session.setAttribute("iduser", null);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>INTRANET DPF LONDRINA</title>
<link type="text/css" rel="stylesheet" href="Cal/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"></LINK>
<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
<script src="load.js" type="text/javascript"></script>
<link href="load.css" type="text/css" rel="stylesheet1">
</head>
<body>
<div id="conteudo">
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
<SCRIPT type="text/javascript" src="Cal/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script>
function enviar(acao)
{
	if (acao == "apagar") {
		 if (confirm('Tem certeza que quer apagar este cargo?')){ 
			 document.formulario.action = "cargosapagarcad.jsp";
			 document.formulario.submit();
		   } 
	}

	if (acao == "theDate") {
		document.formulario.action = "escalaview.jsp";
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

		<div class="right" id="main_left">

			<div id="main_left_content">
		
				<div class="post">
					
					<div class="post_title">
						<h1 class="left"><a href="#"> </a></h1>
						<div class="post_date right"> </div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body">
						<center><h1>ESCALA DE SOBREAVISOS</h1></center>
						<div>
							<table class="search">
							<tr>
								<td>
								&nbsp;&nbsp;&nbsp;
								</td>
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
						<FORM NAME=formulario method=Post>
						<div>
							<table class="search">
							<tr>
									<td>
									<center>Escolha a data: </center>
									</td>
									</tr>
									<tr>
									<td>
									<center>
									<input type="text" value="<%String theDate = (String) request.getParameter("theDate"); if (theDate != null){	out.print(theDate);}%>" readonly name="theDate" onchange="enviar(this.name)">
									</center>
									</td>
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
						<div>
							<table class="search">
							<tr>
								<td>
								&nbsp;&nbsp;&nbsp;
								</td>
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
						<div>
							<table class="search">
							<tr>
								<td>
								&nbsp;&nbsp;&nbsp;
								</td>
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
						<div>
							<table class="search">
							<tr>
								<td>
								&nbsp;&nbsp;&nbsp;
								</td>
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
						<div>
							<table class="search">
							<tr>
								<td>
								&nbsp;&nbsp;&nbsp;
								</td>
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
						<div>
							<table class="search">
							<tr>
								<td>
								&nbsp;&nbsp;&nbsp;
								</td>
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
						<div>
							<table class="search">
							<tr>
									<TD>
									<center><input type="hidden" onclick="enviar(this.name)" name="abrir" value="Nova Escala"></center>
									</TD>
									<TD>
									<center><input type="hidden" onclick="enviar(this.name)" name="mostrar" value="Vers�o para imprimir"></center>
									</td>
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
						<%String escala = Util.DataHojesemHORA(); 
						String e=(String) request.getParameter("theDate");
						if(e!=null){
							escala=e;
						}
						%>
						
						</form>
							<div>
							<table class="search">
							<tr>
								<td>
								&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							</table>
							</div>
						<%=Util.imprimeEscala(escala)%>
					</div>
					<div>
							<table class="search">
							<tr>
							<td>
							<b>ATEN��O:</b> 1-O servidor que n�o estiver gozando de folga regulamentar, dever� se apresentar em seu n�cleo correspondente, para cumprir hor�rio de trabalho.
							</td>
							</tr>
							<tr>
							<td>
							2-A escala de plant�o tem jornada de 24h de servi�o, com 72h de descanso.
							</td>
							</tr>
							<tr>
							<td>
							3-Os Plant�es ser�o respons�veis pelo N. de Cust�dia, obedecendo a O.N. 001/02.
							</td>
							</tr>
							<tr>
							<td>
							4-Os agentes de sobreavisos auxiliar�o o N. de cust�dia nos dias de visita a presos.
							</td>
							</tr>
							<tr>
							<td>
							5-Os escalados para o sobreaviso que sa�rem emn viagem, devem indicar o seu substituto.
							</td>
							</tr>
							<tr>
							<td>
							Obs: Qualquer altera��o na escala dever� ocorrer com anu�ncia do Chefe da DPF/LDA/PR.
							</td>
							</tr>
							<tr>
							<td>
							A Escala de Delegados inicia �s 07:30 hs.
							</td>
							</tr>
							<tr>
							<td>
							&nbsp;&nbsp;&nbsp;
							</td>
							</tr>
							<tr>
							<td>
							<center><b>DPF EVARISTO KUCEKI</b></center>
							</td>
							</tr>
							<tr>
							<td>
							<center><b>Chefe da DPF/LDA/PR</b></center>
							</td>
							</tr>
							<tr>
							
								<td>
								<p align="Right">
								<a href='escalapdf.jsp?data=<%=escala%>' target="new">Vers�o para Imprimir</a>
								</p>
								</td>
							</tr>
							<tr>
								
							</tr>
							</table>
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
						<!--<form method="get" id="searchform" action="#">-->
						<div>
							<table class="search">
							<tr>
								<td>Login:</td>
							</tr>
							<tr>
								<td><input type="text" value="<%String nome = (String) request.getParameter("nome"); if (nome != null){	out.print(nome);}%>" name="nome"/></td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td>Senha:</td>
							</tr>
							<tr>
								<td><input type="password" value="" name="senha"/></td>
								<td style="padding-left: 2px"><input type="image" src="img/bts/entrar2.gif" /></td>
							</tr>
							</table>
						</div>
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
displayCalendar(document.formulario.theDate,'dd/mm/yyyy',document.formulario.theDate);
</script>
</div>
<script>loading();</script>
</body>
</html>