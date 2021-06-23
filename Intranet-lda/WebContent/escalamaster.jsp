<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<%if(session.getAttribute("usuario")==null){
	pageContext.forward("cadLogin2.jsp");
} %>
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
<%String dt=Util.DataHojesemHORA(); %>
<SCRIPT type="text/javascript" src="Cal/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script>
function enviar(acao)
{
	if (acao == "theDate") {
		document.formulario.action = "escalamaster.jsp";
		document.formulario.submit();
	}
}
function gravacao(form){
	form.action = "gravacaoescala.jsp";
	form.submit();
}
</script>
<script type="text/javascript">
function Teste(){
	//alert("oi");
	//document.formulario.action = "escalaview.jsp";
	//document.formulario.submit();
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
						<h1 class="left">GERENCIAR ESCALA DE SOBREAVISOS<a href="#"></a></h1>
						<div class="post_date right"></div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body">
						
						
						<p></p>
						<!--  <center><p><img src="img/escudo.jpg" /></p></center>-->
						<div>
							<table class="search">
							<tr>
								<td><h1 class="sysmsg">
								<%String msg2 = (String) request.getParameter("msgit");
								if (msg2 != null)
	   									out.print(msg2);
								%></h1>
								</td>
								<td>
									<FORM>
									<p align="Right"><INPUT TYPE="Button" VALUE="VOLTAR" onClick="parent.location='index.jsp'">
									</p>
									</FORM>
								</td>
							</tr>
							</table>
						</div>
						<FORM NAME=formulario method=Post>
						<div>
							<table class="search">
							<tr>
									<td>
									<center> </center>
									</td>
									</tr>
									<tr>
									<td>
									<center><input type="text" value="<%String theDate = (String) request.getParameter("theDate"); if (theDate != null){	out.print(theDate);}else{out.print("Escolha a data:");}%>" readonly name="theDate" onchange="enviar(this.name)"></center>
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
						<div>
							<table class="search">
							<tr>
								<td>
								<%Util.Verificadiaescala(escala);%>
								</td>
							</tr>
							</table>
						</div>
						</form>
						<%=Util.imprimeEscalaAltera2(escala)%>
						<div>
							<table class="search">
							<tr>
								<td>
								<FORM>
								<p align="Right"><INPUT TYPE="Button" VALUE="VOLTAR" onClick="parent.location='index.jsp'">
								</p>
								</FORM>
								</td>
							</tr>
							<tr>
								
							</tr>
							</table>
						</div>
						
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
<script>
//alert("ei");
//inputField,format,buttonObj,displayTime,timeInput
displayCalendar(document.formulario.theDate,'dd/mm/yyyy',document.formulario.theDate);
</script>
</body>
</html>
