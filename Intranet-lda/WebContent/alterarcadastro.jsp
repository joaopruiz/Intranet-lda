<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<%
	//if(session.getAttribute("usuario")== null){
		//System.out.println("deusfsf");
	//}else{
		//System.out.print("não");
	//}
%>
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
      erro = "\nO LOGIN deve ser informado.";}

   if (form.senha.value == ""){
      erro += "\nA SENHA deve ser informada.";}

   if (form.senha2.value == ""){
	      erro += "\nA senha de confirmação deve ser informada.";}
   
   if (form.nomecp.value == ""){
	      erro += "\nO nome deve ser informado.";}

   if (form.cpf.value == ""){
	      erro += "\nO CPF deve ser informado.";}

   if (form.admissao.value == ""){
	      erro += "\nA data de admissão deve ser informada.";}
   
   if (form.cargahoraria.value == ""){
	      erro += "\nA carga horária deve ser informada.";}

   if (form.numero_sala.value == ""){
	      erro += "\nO número da sala deve ser informado.";}

   if (form.ramal.value == ""){
	      erro += "\nO ramal deve ser informado.";}

   if (form.email.value == ""){
	      erro += "\nO e-mail deve ser informado.";}

   if (form.cel1.value == ""){
	      erro += "\nO celular 1 deve ser informado.";}
   
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
	if ((event.keyCode<48)||(event.keyCode>57)){
		event.returnValue = false;
	} else {
		event.returnValue = true;
	}
separador = '-';
conjunto1 = 5;
if (campo.value.length == conjunto1){
campo.value = campo.value + separador;}
}

// cpf
if (formato=='cpf'){
	if ((event.keyCode<48)||(event.keyCode>57)){
		event.returnValue = false;
	} else {
		event.returnValue = true;
	}
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
	if ((event.keyCode<48)||(event.keyCode>57)){
		event.returnValue = false;
	} else {
		event.returnValue = true;
	}
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
	if ((event.keyCode<48)||(event.keyCode>57)){
		event.returnValue = false;
	} else {
		event.returnValue = true;
	}
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

		<div class="right" id="main_left">

			<div id="main_left_content">
		
				<div class="post">
					
					<div class="post_title">
						<h1 class="left">MODULO - CADASTRO - ALTERAR<a href="#"></a></h1>
						<div class="post_date right"></div>
						<div class="clearer">&nbsp;</div>
					</div>

					<div class="post_body">
						
						<p></p>
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
						<form name="loginForm" method="POST" action="alterarcadastro2.jsp" onSubmit="return Dadosjp(this);">
						<!--<form method="get" id="searchform" action="#">-->
							<%int qt=0;
							String as = (String) session.getAttribute("usuario");
							qt=(Util.retornaID(as));
							String[] dadosuser;
							dadosuser = Util.selectTudoLogin(qt);
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
								<td><b>Matricula:</b></td>
							</tr>
							<tr>
								<td><input type="hidden" value="<%if(dadosuser[13].equals(null) || dadosuser[13].equals("0")){out.print("");}else{out.print(dadosuser[13]);} %>" name="matricula" size="20"/><%if(dadosuser[13].equals(null) || dadosuser[13].equals("0")){out.print("");}else{out.print(dadosuser[13]);} %></td>
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
								<td><b>Login:</b></td>
							</tr>
							<tr>
								<td><INPUT TYPE="hidden" NAME="nome" VALUE="<%=(dadosuser[0])%>" size="50"><%=(dadosuser[0])%></td>
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
								<td><b>Senha:</b></td>
							</tr>
							<tr>
								<td><input type="password" value="<%out.print(dadosuser[1]);%>" name="senha" size="50"/></td>
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
								<td><b>Redigite a senha:</b></td>
								
							</tr>
							<tr>
								<td><input type="password" value="<%out.print(dadosuser[1]);%>" name="senha2"/></td>
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
								<td><b>Nome completo:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%=(dadosuser[3])%>" name="nomecp" size="70"/></td>
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
								<td><b>Situação:</b></td>
							</tr>
							<tr>
							<%if(dadosuser[16].equals("true")){
								out.print("<td>Ativo<input type='radio' name='situacao' value='TRUE' CHECKED></td>"+
										"<td>Inativo<input type='radio' name='situacao' value='FALSE'></td>");
							}else{
								out.print("<td>Ativo<input type='radio' name='situacao' value='TRUE'></td>"+
								"<td>Inativo<input type='radio' name='situacao' value='FALSE' CHECKED></td>");
							}
								%>
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
								<td><b>CPF:</b></td>
							</tr>
							<tr>
								<td><input type="hidden" onkeypress="Mascara('cpf', window.event.keyCode, 'document.loginForm.cpf');" maxLength=14 size=14 name="cpf" value="<%=dadosuser[22]%>" /><%=dadosuser[22]%></td>
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
								<td><b>Data de admissão:</b></td>
							</tr>
							<tr>
								<td><input type="hidden" maxLength=10 size=10 name="admissao" value="<%out.print(dadosuser[15]);%>" onkeypress="Mascara('nascimento', window.event.keyCode, 'document.loginForm.admissao');"  /><%out.print(dadosuser[15]);%></td>
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
								<td><b>Classe:</b></td>
							</tr>
							<tr>
								<td>
								<select  name="classe">
								<!--<option selected value="cargo">Cargo</option>-->
								<%=Util.comboboxClassealtera(Integer.parseInt(dadosuser[17])) %>
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
								<td><b>Sexo:</b></td>
							</tr>
							<tr>
							<% if(dadosuser[18].equals("true")){
								out.print("<td>Masculino<input type='radio' name='sexo' value='TRUE' CHECKED></td>"+
								"<td>Feminino<input type='radio' name='sexo' value='FALSE'></td>");
							}else{
								out.print("<td>Masculino<input type='radio' name='sexo' value='TRUE' ></td>"+
								"<td>Feminino<input type='radio' name='sexo' value='FALSE' CHECKED></td>");
							}
								%>
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
								<!--<td><b>Banco:</b></td>-->
							</tr>
							<tr>
								<td><input type="hidden" value="<%out.print(dadosuser[19]);%>" name="banco" size="40" /></td>
								<!--  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;</td>-->
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<!--<td><b>Agência:</b></td>-->
							</tr>
							<tr>
								<td><input type="hidden" value="<%out.print(dadosuser[20]);%>" name="agencia" size="20" maxlength="20" onKeyPress="ajustar_data(this)"/></td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<!--<td><b>Conta:</b></td>-->
							</tr>
							<tr>
								<td><input type="hidden" value="<%out.print(dadosuser[21]);%>" name="conta" size="20" maxlength="20" onKeyPress="ajustar_data(this)"/></td>
							</tr>
							</table>
						</div>
						<div>
							<table class="search">
							<tr>
								<td><b>Cargo:</b></td>
							</tr>
							<tr>
								
								<td>
								<select  name="codigo_tbusuarios">
								<!--<option selected value="cargo">Cargo</option>-->
								<%out.print(Util.selectCargoAlterarCadastro(dadosuser[2])); %>
								<%out.print(Util.selectCargoAlterarLogin(dadosuser[2])); %>
								</select>
								</td>
								<TD><INPUT TYPE=HIDDEN NAME=id VALUE="<%out.print(qt);%>"></TD>
								
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
								<td><b>Lotação:</b></td>
							</tr>
							<tr>
								<td>
								<select  name="lotacao">
								<!--<option selected value="cargo">Cargo</option>-->
								<%out.print(Util.selectLotacaoAlterarCadastro(dadosuser[7])); %>
								<%out.print(Util.selectLotacaoAlterarLogin(dadosuser[7])); %>
								</select>
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
								<td><b>Carga horaria:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%out.print(dadosuser[14]);%>" name="cargahoraria" size="10" onKeyPress="ajustar_data(this)"/></td>
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
								<td><b>Número da Sala:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%out.print(dadosuser[6]);%>" name="numero_sala" size="50" onKeyPress="ajustar_data(this)"/></td>
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
								<td><b>Número RAMAL:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%out.print(dadosuser[8]);%>" name="ramal" size="20" onKeyPress="ajustar_data(this)" maxLength=4/></td>
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
								<td><b>E-Mail:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%out.print(dadosuser[9]);%>" name="email" size="50"/></td>
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
								<td><b>Telefone Casa:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%if(dadosuser[10].equals(null) || dadosuser[10].equals("0")){out.print("");}else{out.print(dadosuser[10]);} %>" name="telcasa"   onkeypress="Mascara('telefone', window.event.keyCode, 'document.loginForm.telcasa');" maxLength=13 size=12/></td>
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
								<td><b>Celular 1:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%out.print(dadosuser[11]);%>" name="cel1" onkeypress="Mascara('telefone', window.event.keyCode, 'document.loginForm.cel1');" maxLength=13 size=12/></td>
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
								<td><b>Celular 2:</b></td>
							</tr>
							<tr>
								<td><input type="text" value="<%if(dadosuser[12].equals(null) || dadosuser[12].equals("0")){out.print("");}else{out.print(dadosuser[12]);} %>" name="cel2" onkeypress="Mascara('telefone', window.event.keyCode, 'document.loginForm.cel2');" maxLength=13 size=12/></td>
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

</body>
</html>