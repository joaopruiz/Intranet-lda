<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="metodos.Menu"%>
<%@page import="metodos.Util"%>
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
<SCRIPT TYPE="text/javascript" LANGUAGE="javascript">

<!-- PreLoad Wait - Script -->
<!-- This script and more from http://www.rainbow.arch.scriptmania.com 

function waitPreloadPage() { //DOM
if (document.getElementById){
document.getElementById('prepage').style.visibility='hidden';
}else{
if (document.layers){ //NS4
document.prepage.visibility = 'hidden';
}
else { //IE4
document.all.prepage.style.visibility = 'hidden';
}
}
}
// End -->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>INTRANET DPF LONDRINA</title>
<link type="text/css" rel="stylesheet" href="Cal/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"></LINK>
<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
<!--[if lte IE 7]><link rel="stylesheet" type="text/css" href="ie_fixes.css" media="screen" /><![endif]-->
</head>

<body onLoad="waitPreloadPage();">
<DIV id="prepage" style="position:absolute; font-family:arial; font-size:16; left:0px; top:0px; background-color:white; layer-background-color:white; height:100%; width:100%;"> 
<TABLE width=100%><TR><TD><B>Carregando...</B></TD></TR></TABLE>
</DIV>
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

		<h1 class="left"><a href="index.jsp">DELEGACIA DA POLÍCIA FEDERAL DE LONDRINA</a></h1>
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
									<center><input type="hidden" onclick="enviar(this.name)" name="mostrar" value="Versão para imprimir"></center>
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
							<b>ATENÇÃO:</b> 1-O servidor que não estiver gozando de folga regulamentar, deverá se apresentar em seu núcleo correspondente, para cumprir horário de trabalho.
							</td>
							</tr>
							<tr>
							<td>
							2-A escala de plantão tem jornada de 24h de serviço, com 72h de descanso.
							</td>
							</tr>
							<tr>
							<td>
							3-Os Plantões serão responsáveis pelo N. de Custódia, obedecendo a O.N. 001/02.
							</td>
							</tr>
							<tr>
							<td>
							4-Os agentes de sobreavisos auxiliarão o N. de custódia nos dias de visita a presos.
							</td>
							</tr>
							<tr>
							<td>
							5-Os escalados para o sobreaviso que saírem emn viagem, devem indicar o seu substituto.
							</td>
							</tr>
							<tr>
							<td>
							Obs: Qualquer alteração na escala deverá ocorrer com anuência do Chefe da DPF/LDA/PR.
							</td>
							</tr>
							<tr>
							<td>
							A Escala de Delegados inicia às 07:30 hs.
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
								<a href='escalapdf.jsp?data=<%=escala%>' target="new">Versão para Imprimir</a>
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
							<%String id_funcao = (String) session.getAttribute("id_funcao");
							int fu=0;
							if(id_funcao!=null){
								fu = Integer.parseInt(id_funcao);
							}
							out.print(Menu.imprimeMenu(fu));
							%>
						</ul>
					</div>
					<div class="box_bottom"></div>
				</div>

				
								
				

				<div class="box">
					<div class="box_title">Caixa de texto</div>
					<div class="box_body p10">
						Não implementado
					</div>
					<div class="box_bottom"></div>
				</div>

			</div>
		</div>

		<div class="clearer">&nbsp;</div>

	</div>

	<div id="footer">

		<div class="left">&#169; 2008 Delegacia da Policia Federal de Londrina</div>

		<div class="right">Joao Paulo Ruiz</div>

		<div class="clearer">&nbsp;</div>
	
	</div>

</div>
<div id="layout_edgebottom"></div>
</div>
<script>
displayCalendar(document.formulario.theDate,'dd/mm/yyyy',document.formulario.theDate);
</script>
</body>
</html>