<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%response.setHeader("Cache-Control", "no-cache");
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
function Dadosjp(form) {
   var erro = "";

   if (form.nome.value == ""){
      erro = "O login deve ser digitado!";}

   if (form.senha.value == ""){
      erro += "\nA senha deve ser digitada!";}

   if (form.senha2.value == ""){
	      erro += "\nA senha de confirmação deve ser digitada!";}
   
   if (form.nomecp.value == ""){
	      erro += "\nO nome dever ser digitado!";}

   if (form.cpf.value == ""){
	      erro += "\nO CPF dever ser digitado!";}

   if (form.admissao.value == ""){
	      erro += "\nA data de admissão dever ser digitada!";}

   if (erro != "") {
      alert(erro);
      return false;
   }else{
	   return true; 
   }   
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
<script>
function Mascara (formato, keypress, objeto){
campo = eval (objeto);

// cep
if (formato=='cep'){
separador = '-';
conjunto1 = 5;
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
<script>
function enviar(acao)
{
	if (acao == "apagar") {
		 if (confirm('Tem certeza que deseja apagar este patrimonio?')){ 
			 document.loginForm.action = "apagarequip.jsp";
			 document.loginForm.submit();
		   } 
	}

	if (acao == "alterar") {
		document.loginForm.action = "patrimonio.jsp";
		document.loginForm.submit();
	}

	if (acao == "novo") {
		document.loginForm.action = "patrimonionovo.jsp";
		document.loginForm.submit();
	}
	if (acao == "voltar") {
		document.loginForm.action = "estoqueconsumo.jsp";
		document.loginForm.submit();
	}
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
						<h1 class="left">CONTROLE DE ESTOQUE - SETOR INFORMÁTICA<a href="#"></a></h1>
						<div class="post_date right"></div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body">
						
						
						<p></p>
						
						<form name="loginForm" method="POST" action="materialnovoalterar.jsp" >
						<!--<form method="get" id="searchform" action="#">-->
						<%String qt="";
							//String[] loginarray = request.getParameterValues("chkExclusao");
							qt=(String)request.getParameter("patrimonio");
							
							String[] dadosuser=new String[10];
							if(qt!=null && qt!="" && qt!="0"){
								dadosuser = Util.selectEquipsConsumoaltera(qt);
							}
							if(dadosuser[0]=="" || dadosuser[0]==null){
								pageContext.forward("estoqueconsumo.jsp?interno=Material não encontrado...");
							}
							%>
					
								
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
								<td><b>Código Material:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%=qt %>" name="cod_matconsumoinfo" size="20" readonly="readonly"/></td>
								<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
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
								<td><b>Descrição:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%=dadosuser[0] %>" name="descricao" size="80" /></td>
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
								<td><b>Quantidade:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%=dadosuser[1] %>" name="quantidade" size="50" onKeyPress="ajustar_data(this)"/></td>
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
								<td><b>Valor:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%=dadosuser[2] %>" name="valor"  size='50' onKeyPress="ajustar_data(this)"/></td>
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
								<td style="padding-left: 10px"><input type="image" src="img/bts/salvar2.gif" /></td>
								<td><input type="button" name='voltar' value='VOLTAR' onClick='enviar(this.name)'></td>
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
								<%String msg2 = (String) request.getParameter("msgit");
								if (msg2 != null)
	   									out.print(msg2);
								%>
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
						<form name="loginForm2" method="POST"  action="index.jsp" onSubmit="return validaDados(this);">
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