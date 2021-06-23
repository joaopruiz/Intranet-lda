<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<%@page import="java.sql.ResultSet"%>
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

<%String dt=Util.DataHojesemHORA(); %>
<script type="text/javascript">
function Confirma(form){
	var erro = "";

	   if (form.he1.value == " ")
	      erro = "\nA hora de entrada Padrão deve ser digitada!";

	   if (form.hs1.value == " ")
	      erro += "\nA hora de saida Padrão deve ser digitada!";

	   if (form.he2.value == " ")
		      erro = "\nA hora de entrada Padrão deve ser digitada!";

	   if (form.formulario.hs2.value == " ")
		      erro += "\nA hora de saida Padrão deve ser digitada!";
	   
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
		 if (confirm('Tem certeza que quer apagar este cargo?')){ 
			 document.formulario.action = "cargosapagarcad.jsp";
			 document.formulario.submit();
		   } 
	}

	if (acao == "mostrar") {
		document.formulario.action = "escalapdf.jsp";
		document.formulario.target = "new";
		document.formulario.submit();
	}

	if (acao == "theDate") {
		document.formulario.action = "gravacaofp.jsp";
		document.formulario.submit();
	}
}
function gravacao(form){
	form.action = "gravacaoescala.jsp";
	form.submit();
}
</script>
<script>
function Mascara (formato, keypress, objeto){
campo = eval (objeto);

// cep
if (formato=='hora'){
	if ((event.keyCode<48)||(event.keyCode>57)){
		event.returnValue = false;
	} else {
		event.returnValue = true;
	}
separador = ':';
conjunto1 = 2;
if (campo.value.length == conjunto1){
campo.value = campo.value + separador;}
}

// cpf
if (formato=='cpf'){
	separador1 = '.'; 
	separador2 = '-'; 
	conjunto1 = 3;
	conjunto2 = 7;
	conjunto3 = 11;
	if (campo.value.length == conjunto1)
	  {
	  campo.value = campo.value + separador1;
	  }
	if (campo.value.length == conjunto2)
	  {
	  campo.value = campo.value + separador1;
	  }
	if (campo.value.length == conjunto3)
	  {
	  campo.value = campo.value + separador2;
	  }
	}


// nascimento
if (formato=='nascimento'){
separador = '/'; 
conjunto1 = 2;
conjunto2 = 5;
if (campo.value.length == conjunto1)
  {
  campo.value = campo.value + separador;
  }
if (campo.value.length == conjunto2)
  {
  campo.value = campo.value + separador;
  }
}

// telefone
if (formato=='telefone'){
separador1 = '(';
separador2 = ')';
separador3 = '-';
conjunto1 = 0;
conjunto2 = 3;
conjunto3 = 8;
if (campo.value.length == conjunto1){
campo.value = campo.value + separador1;
}
if (campo.value.length == conjunto2){
campo.value = campo.value + separador2;
}
if (campo.value.length == conjunto3){
campo.value = campo.value + separador3;
}
}


}
</SCRIPT>
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
						<h1 class="left">INTRANET DPF LDA<a href="#"></a></h1>
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
								<%String msg2 = (String) request.getParameter("msgi");
								if (msg2 != null)
	   									out.print(msg2);
								%></h1>
								</td>
							</tr>
							</table>
						</div>
						<FORM NAME=formulario method=Post action = "gravacaohp.jsp" onSubmit="return Confirma(this);">
						<div>
							<table class="search">
							<tr>
							
								<td><b>Hora de Entrada Padrão</b></td>
								<td><b>Hora de Saída Padrão</b></td>
								<td><b>Hora de Entrada Padrão</b></td>
								<td><b>Hora de Saída Padrão</b></td>
							</tr>
							<tr>
							<%String ad = (String)session.getAttribute("usuario");
							String[] a = new String[4];
							a=Util.retornaHorapadrao(Util.retornaID(ad));
							%>
								<td><input type='text' name='he1' size='10' value='<%if(a[0]!=null){out.print(a[0]);} %>' maxLength='5' onkeypress="Mascara('hora', window.event.keyCode, 'document.formulario.he1');"></td>
								<td><input type='text' name='hs1' size='10' value='<%if(a[1]!=null){out.print(a[1]);} %>' maxLength='5' onkeypress="Mascara('hora', window.event.keyCode, 'document.formulario.hs1');"></td>
								<td><input type='text' name='he2' size='10' value='<%if(a[2]!=null){out.print(a[2]);} %>' maxLength='5' onkeypress="Mascara('hora', window.event.keyCode, 'document.formulario.he2');"></td>
								<td><input type='text' name='hs2' size='10' value='<%if(a[3]!=null){out.print(a[3]);} %>' maxLength='5' onkeypress="Mascara('hora', window.event.keyCode, 'document.formulario.hs2');"></td>
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
									<center><input type="submit"  name="abrir" value="SALVAR"></center>
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
								
								</td>
							</tr>
							</table>
						</div>
						
						</form>
						
						<div>
							<table class="search">
							<tr>
								<td>
								<p align="Right">
								<a href='folhaponto3.jsp'>Voltar</a>
								</p>
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
</body>
</html>
