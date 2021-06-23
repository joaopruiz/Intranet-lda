<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<jsp:useBean id="util" class="metodos.Util" scope="page"/>
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
 <script>  
function retornar() {  
	history.go(-1);  
}  
</script>  
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

		<div class="right" id="ordem">

			<div id="main_left_content">
		
				<div class="post">
					
					<div class="post_title">
						<h1 class="left">ESCALA DE SOBREAVISOS<a href="#"> </a></h1>
						<div class="post_date right"> </div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body_escala">
						
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
									<center>
									<input type="text" value="<%String theDate = (String) request.getParameter("theDate"); if (theDate != null){	out.print(theDate);}else{out.print("Escolha a data:");}%>" readonly name="theDate" onchange="enviar(this.name)">
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
								<td>
								<p align="Right">
								<a href="index.jsp">Voltar...</a>
								</p>
								</td>
							</tr>
							</table>
						</div>
					<div class="post_bottom"></div>

				</div>

				
				

			</div>

		</div>

		<div class="left" id="main_right">

			<div id="sidebar">

				

				
				
								
				

				

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
</body>
</html>