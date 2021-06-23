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
<script type="text/javascript" src="scfolhaponto.js"></script>
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
<%String dt=Util.DataHojesemHORA(); %>
<script>
function enviar(acao)
{
	if (acao == "apagar") {
		 if (confirm('Tem certeza que quer apagar este cargo?')){ 
			 document.formulario.action = "cargosapagarcad.jsp";
			 document.formulario.submit();
		   } 
	}

	if (acao == "salvar") {
		document.formulario.action = "atualizacaofp.jsp";
		document.formulario.target="";
		document.formulario.submit();
	}

	if (acao == "imprimir") {
		document.formulario.action = "atualizacaofppdf.jsp";
		document.formulario.target="new";
		document.formulario.submit();
	}
	
	if (acao == "imprimir2") {
		document.formulario.action = "atualizacaofppdf2.jsp";
		document.formulario.target="new";
		document.formulario.submit();
	}
}
function horaPadrao(){
	document.formulario.action = "horapadrao.jsp";
	document.formulario.target="";
	document.formulario.submit();
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
						<h1 class="left">FOLHA DE PONTO<a href="#"></a></h1>
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
						<FORM NAME=formulario method=Post>
					
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
						<%String escala = Util.DataHojesemHORA(); 
						String e=(String) session.getAttribute("datafp");
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
						<div>
							<table class="search">
							<tr>
							<%String ad = (String)session.getAttribute("usuario");
							ResultSet res = Util.retornaDadosUser(ad);
							res.next(); %>
								<td>
								Servidor: <b><%=res.getString("nomecp")%></b>
								</td>
								<td>
								Matricula: <b><%if(res.getString("matricula").equals("0")){}else{out.print(res.getString("matricula"));}%></b>
								</td>
							</tr>
							<tr>
							<td>Cargo: <b><%=Util.Cargo(res.getInt("codigo_tbusuarios")) %></b>
							</td>
							<td>Carga Horária: <b><%=res.getInt("cargahoraria") %>h</b>
							</td>
							<td>
							Lotação: <b><%=Util.selectLotacaoDescricao(res.getInt("lotacao")) %></b>
							</td>
							</tr>
							<tr>
							<td>
							Freq. Integral:
							<%String auxdt= e.substring(2,10);
							String rl[][] = Util.retornaDATASFP(Util.retornaID(ad), auxdt);
							if(rl[0][5].equals("true")){
								out.print("<b>SIM<input type='radio' value='true' name='frequenciaint' CHECKED size='20' />"+
										"NÃO<input type='radio' value='false' name='frequenciaint' size='20'/></b></td><td>");
							}else{
								out.print("<b>SIM<input type='radio' value='true' name='frequenciaint' size='20' />"+
								"NÃO<input type='radio' value='false' name='frequenciaint' CHECKED size='20'/></b></td><td>");
							}
							%> 
							
							<%String dt1 = (String) session.getAttribute("datafp");
							int dt2= Integer.parseInt(((String) session.getAttribute("datafp")).substring(3,5));%>
							Mês: <b><%=Util.retornaMes(dt2)%></b>
							</td>
							<td>
							Ano: <b><%=((String) session.getAttribute("datafp")).substring(6,10) %></b>
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
								<center><input type='button'  onClick='horaPadrao()'  value='HORA PADRÃO' name='hora' border=0></center>
								</td>
								<td>
								<center><input type='button'  onClick='Preenche()' value='PREENCHER COM HORA PADRÃO' name='preencher' border=0></center>
								</td>
								<td>
								<center><input type='hidden'  onClick='Limpar()' value='LIMPAR' name='limpar' border=0></center>
								</td>
								<td>
								<center><input type="reset" value="LIMPAR"></center>
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
								<td><b>Dia</b></td>
								<td><b>Hora de Entrada</b></td>
								<td><b>Hora de Saída</b></td>
								<td><b>Hora de Entrada</b></td>
								<td><b>Hora de Saída</b></td>
								<td><b>Ocorrência</b></td>
								
							</tr>
							<tr>
							<%String[] a = new String[4];
							a=Util.retornaHorapadrao(Util.retornaID(ad));
							%>
							<td><input type='hidden' name='dt1' value='<%if(a[0]==null){out.print("Cadastre");}else{out.print(a[0]);} %>'>
							<input type='hidden' name='dt2' value='<%if(a[1]==null){out.print("as");}else{out.print(a[1]);} %>'>
							<input type='hidden' name='dt3' value='<%if(a[2]==null){out.print("horas ");}else{out.print(a[2]);} %>'>
							<input type='hidden' name='dt4' value='<%if(a[3]==null){out.print("Padrão");}else{out.print(a[3]);} %>'>
							</td>
							</tr>
							
							<%String aux=dt1;
							String aux2 = aux.substring(2,10);
							int g=0;
							int udia = Util.retornaUltimoDiaMes(aux);
							for(int i=1;i<=udia;i++){
								g=i-1;
								if(rl[g][4].equals("null")){
									rl[g][4]="";
								}
								if(rl[g][0].equals("null")){
									rl[g][0]="";
								}
								if(rl[g][1].equals("null")){
									rl[g][1]="";
								}
								if(rl[g][1].equals("null")){
									rl[g][1]="";
								}
								if(rl[g][2].equals("null")){
									rl[g][2]="";
								}
								if(i>=1 && i<=9){
									out.print("<tr><td><b>0"+i+"</b></td>"+
									"<td><input type='hidden' name='data' value='0"+i+""+aux2+"'>"+
									"<input type='text' name='he1' size='10' value='"+rl[g][0]+"' maxLength='18'></td>"+
									"<td><input type='text' name='hs1' size='10' value='"+rl[g][1]+"' maxLength='18'></td>"+
									"<td><input type='text' name='he2' size='10' value='"+rl[g][2]+"' maxLength='18'></td>"+
									"<td><input type='text' name='hs2' size='10' value='"+rl[g][3]+"' maxLength='18'></td>"+
									"<td><input type='text' name='oc' size='15' value='"+rl[g][4]+"' maxLength='18'></td></tr>");
								}else{
									out.print("<tr><td><b>"+i+"</b></td>"+
									"<td><input type='hidden' name='data' value='"+i+""+aux2+"'>"+
									"<input type='text' name='he1' size='10' value='"+rl[g][0]+"' maxLength='18'></td>"+
									"<td><input type='text' name='hs1' size='10' value='"+rl[g][1]+"' maxLength='18'></td>"+
									"<td><input type='text' name='he2' size='10' value='"+rl[g][2]+"' maxLength='18'></td>"+
									"<td><input type='text' name='hs2' size='10' value='"+rl[g][3]+"' maxLength='18'></td>"+
									"<td><input type='text' name='oc' size='15' value='"+rl[g][4]+"' maxLength='18'></td></tr>");
								}
							}
							%>
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
								Data: <b><%=dt1 %></b>
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
								<b>OBS: </b>Os Feriados necessitam ser preenchidos manualmente.
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
							<br><br><center><input  type='button'  onClick='enviar(this.name)' value='SALVAR' name='salvar'></center>
								</TD>
								<TD>
							<br><br><center><input type='button'  onClick='enviar(this.name)' value='IMPRIMIR EM RETRATO' name='imprimir'></center>
							<input type='hidden'   value='<%=dt1 %>' name='data'>
							</TD>
								<TD>
							<br><br><center><input type='button'  onClick='enviar(this.name)' value='IMPRIMIR EM PAISAGEM' name='imprimir2'></center>
							<input type='hidden'   value='<%=dt1 %>' name='data'>
							</TD>
							<TD>
							<br><br><center><input type='hidden'  onClick='enviar(this.name)' value='NOVO' name='novo'></center>
							</TD>
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
						</form>
						<div>
							<table class="search">
							<tr>
								<td>
								<p align="Right">
								<a href='folhaponto.jsp'>Voltar</a>
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
