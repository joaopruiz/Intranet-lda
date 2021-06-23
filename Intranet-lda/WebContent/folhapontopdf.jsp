<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean id="fppdf" class="bean.BeanFP" scope="page"/> 
<jsp:setProperty name="fppdf" property="*"/> 
<% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.awt.Color"%>
<%@page import="com.lowagie.text.Document"%>
<%@page import="com.lowagie.text.DocumentException"%>
<%@page import="com.lowagie.text.Paragraph"%>
<%@page import="com.lowagie.text.pdf.PdfPCell"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.Image"%>
<%@page import="com.lowagie.text.Chunk"%>
<%@page import="com.lowagie.text.Phrase"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
</head>
<body>
<%//String data = (String) request.getParameter("data");
String data = Util.DataHojesemHORA();
String datasis = request.getParameter("data");
Rectangle pageSize = new Rectangle(800, 300);
Document document = new Document();
ByteArrayOutputStream baos = new ByteArrayOutputStream();
PdfWriter.getInstance(document, baos);
document.open();
//aki preenche o pdf com os dados
String ad = (String)session.getAttribute("usuario");
ResultSet res = Util.retornaDadosUser(ad);
res.next();
ResultSet respage = Util.retornaFolhaponto(Util.retornaID(ad), datasis.substring(2,10));
respage.next();

Font  titulo = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.BOLD);
titulo.setSize(22);
Font  titulo1 = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.NORMAL);
titulo1.setSize(8);
Font  texto = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.NORMAL);
texto.setSize(10);
Font  texto2 = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.BOLD);
texto2.setSize(10);
Font  textonegrito = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.BOLD);
textonegrito.setSize(8);
Font  rodape = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.BOLD);
rodape.setSize(8);
Font red = FontFactory.getFont(FontFactory.HELVETICA, Font.DEFAULTSIZE, Font.BOLD, new Color(0xFF, 0x00, 0x00));

	
	//Image imagem = Image.getInstance("C:/Arquivos de programas/Apache Software Foundation/Tomcat 6.0/webapps/ROOT/img/brasao.jpg");
	//aki fica o path da imagem
	Image imagem = Image.getInstance("http://localhost:8082/Intranet-lda/img/brasao.jpg");
	imagem.scalePercent(70);
	imagem.setAlignment(Element.ALIGN_CENTER);
	Paragraph pr = new Paragraph("SERVIÇO PÚBLICO FEDERAL");
	pr.setAlignment(Element.ALIGN_CENTER);
	Paragraph pr1 = new Paragraph("MJ - DEPARTAMENTO DE POLÍCIA FEDERAL");
	pr1.setAlignment(Element.ALIGN_CENTER);
	Paragraph pr2 = new Paragraph("SR/PR - DIVISÃO DE POLÍCIA FEDERAL EM LONDRINA");
	pr2.setAlignment(Element.ALIGN_CENTER);
	
	Chunk ck = new Chunk(imagem, 0, -5);

	PdfPTable tabelatt = new PdfPTable(2);
	PdfPTable tabelaint = new PdfPTable(1);
	PdfPCell celula1 = new PdfPCell(pr);
	celula1.setColspan(2);
	PdfPCell celula2 = new PdfPCell(pr1);
	celula2.setColspan(2);
	PdfPCell celula3 = new PdfPCell(pr2);
	celula3.setColspan(2);
	PdfPCell celula4 = new PdfPCell(imagem);
	PdfPCell celula5 = new PdfPCell(tabelaint);
	celula4.setHorizontalAlignment(Element.ALIGN_CENTER);
	celula3.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula2.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula1.setHorizontalAlignment(Element.ALIGN_LEFT);
	
	celula1.setBorderColor(Color.WHITE);
	celula2.setBorderColor(Color.WHITE);
	celula3.setBorderColor(Color.WHITE);
	celula4.setBorderColor(Color.WHITE);
	celula5.setBorderColor(Color.WHITE);
	
	tabelatt.addCell(celula4);
	tabelaint.addCell(celula1);
	tabelaint.addCell(celula2);
	tabelaint.addCell(celula3);
	tabelatt.addCell(celula5);
	
	
	tabelatt.setWidthPercentage(100);
	float[] widths2 = {1f, 1f};
	widths2[0] = 40f;
	widths2[1] = 100f;
	
	tabelatt.setWidths(widths2);
	
	//document.add(tabelatt);
	document.add(imagem);
	document.add(pr);
	document.add(pr1);
	document.add(pr2);
	Phrase fase = new Phrase();
	fase.add(ck);
	//fase.add(tabelatt);
	
	
	Paragraph ptb=new Paragraph(fase);
	ptb.setAlignment(Element.ALIGN_CENTER);
	//document.add(ptb);

	document.add(new Paragraph(" "));
	document.add(new Paragraph(" "));
	Paragraph para = new Paragraph(new Chunk("FOLHA DE PONTO", titulo));
	para.setAlignment(Element.ALIGN_CENTER);
	document.add(para);
	document.add(new Paragraph(" "));
	
	
	
	Paragraph pr10 = new Paragraph("Servidor: ", texto);
	pr10.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr10a = new Paragraph(res.getString("nomecp"), texto2);
	pr10a.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr11 = new Paragraph("Matrícula: ", texto);
	pr11.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr12 = new Paragraph("Cargo: ", texto);
	pr12.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr13 = new Paragraph("Carga Horária: ", texto);
	pr13.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr14 = new Paragraph("Lotação: ", texto);
	pr14.setAlignment(Element.ALIGN_LEFT);
	String ma ="";
	if(Integer.toString(res.getInt("matricula")).equals("0")){}else{ma = (Integer.toString(res.getInt("matricula")));}
	Paragraph pr11a = new Paragraph(ma, texto2);
	pr11a.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr12a = new Paragraph(Util.Cargo(res.getInt("codigo_tbusuarios")), texto2);
	pr12a.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr13a = new Paragraph(res.getInt("cargahoraria")+"h", texto2);
	pr13a.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr14a = new Paragraph(Util.selectLotacaoDescricao(res.getInt("lotacao")), texto2);
	pr14a.setAlignment(Element.ALIGN_LEFT);
	String rj = "";
	if((respage.getBoolean("frequenciaint"))==true){
		rj="SIM";
	}else{
		rj="NÃO";
	}
	Paragraph pr15 = new Paragraph("Freq. Integral: ", texto);
	pr15.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr15a = new Paragraph(rj, texto2);
	pr15a.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr16 = new Paragraph("Mês: ", texto);
	pr16.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr17 = new Paragraph("Ano: ", texto);
	pr17.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr16a = new Paragraph(Util.retornaMes(Integer.parseInt(datasis.substring(3,5))), texto2);
	pr16a.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr17a = new Paragraph(datasis.substring(6,10), texto2);
	pr17a.setAlignment(Element.ALIGN_LEFT);
	Paragraph pr50 = new Paragraph(" ", texto2);
	pr50.setAlignment(Element.ALIGN_LEFT);
	
	
	PdfPTable tabelam = new PdfPTable(6);
	PdfPCell celula11 = new PdfPCell(pr10);
	PdfPCell celula11a = new PdfPCell(pr10a);
	PdfPCell celula21 = new PdfPCell(pr11);
	PdfPCell celula21a = new PdfPCell(pr11a);
	PdfPCell celula50 = new PdfPCell(pr50);
	PdfPCell celula51 = new PdfPCell(pr50);
	
	celula21a.setColspan(6);
	
	PdfPCell celula31 = new PdfPCell(pr12);
	PdfPCell celula22 = new PdfPCell(pr13);
	PdfPCell celula23 = new PdfPCell(pr14);
	PdfPCell celula31a = new PdfPCell(pr12a);
	PdfPCell celula22a = new PdfPCell(pr13a);
	PdfPCell celula23a = new PdfPCell(pr14a);
	celula23a.setColspan(6);
	PdfPCell celula24 = new PdfPCell(pr15);
	PdfPCell celula24a = new PdfPCell(pr15a);
	PdfPCell celula25 = new PdfPCell(pr16);
	PdfPCell celula26 = new PdfPCell(pr17);
	PdfPCell celula25a = new PdfPCell(pr16a);
	PdfPCell celula26a= new PdfPCell(pr17a);
	celula26a.setColspan(6);
	
	celula11.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula21.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula31.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula22.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula23.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula24.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula25.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula26.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula11a.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula21a.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula31a.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula22a.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula23a.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula24a.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula25a.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula26a.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula50.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula51.setHorizontalAlignment(Element.ALIGN_LEFT);
	
	celula11.setBorderColor(Color.WHITE);
	celula21.setBorderColor(Color.WHITE);
	celula31.setBorderColor(Color.WHITE);
	celula22.setBorderColor(Color.WHITE);
	celula23.setBorderColor(Color.WHITE);
	celula24.setBorderColor(Color.WHITE);
	celula25.setBorderColor(Color.WHITE);
	celula26.setBorderColor(Color.WHITE);
	celula11a.setBorderColor(Color.WHITE);
	celula21a.setBorderColor(Color.WHITE);
	celula31a.setBorderColor(Color.WHITE);
	celula22a.setBorderColor(Color.WHITE);
	celula23a.setBorderColor(Color.WHITE);
	celula24a.setBorderColor(Color.WHITE);
	celula25a.setBorderColor(Color.WHITE);
	celula26a.setBorderColor(Color.WHITE);
	celula50.setBorderColor(Color.WHITE);
	celula51.setBorderColor(Color.WHITE);
	
	tabelam.addCell(celula11);
	tabelam.addCell(celula11a);
	
	tabelam.addCell(celula50);
	tabelam.addCell(celula51);
	tabelam.addCell(celula21);
	tabelam.addCell(celula21a);
	
	tabelam.addCell(celula31);
	tabelam.addCell(celula31a);
	tabelam.addCell(celula22);
	tabelam.addCell(celula22a);
	tabelam.addCell(celula23);
	tabelam.addCell(celula23a);
	tabelam.addCell(celula24);
	tabelam.addCell(celula24a);
	tabelam.addCell(celula25);
	tabelam.addCell(celula25a);
	tabelam.addCell(celula26);
	tabelam.addCell(celula26a);
	
	float[] widths = {1f, 1f, 1f, 1f, 1f, 1f, 1f, 1f, 1f, 1f};
	float[] widthst = {1f, 1f, 1f, 1f, 1f, 1f};
	widthst[0] = 110f;
	widthst[1] = 200f;
	widthst[2] = 120f;
	widthst[3] = 150f;
	widthst[4] = 100f;
	widthst[5] = 200f;
	tabelam.setWidths(widthst);
	tabelam.setWidthPercentage(100);
	
	document.add(tabelam);
	
	
	String dto=data.substring(3,5);
	//System.out.println("tnocdarp: "+dto);
	int diadomes=Integer.parseInt(dto);
	String mes=Util.retornaMes(diadomes);
	
	//Paragraph para1 = new Paragraph(new Chunk(mes+" / "+data.substring(6,10), titulo1));
	//para1.setAlignment(Element.ALIGN_CENTER);
	//document.add(para1);
	//document.add(new Paragraph(" "));
	
	
	//inicio da tabela
	
	PdfPTable table = new PdfPTable(10);
	
	//PdfPCell cell1 = new PdfPCell(new Paragraph("SOBREAVISOS"));
	//cell1.setColspan(9);
	//cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
	//table.addCell(cell1);
	
	PdfPCell celldatat = new PdfPCell(new Paragraph("Dia", titulo1));
	//celldatat.setColspan(8);
	//celldatat.setExtraParagraphSpace(30);
	table.addCell(celldatat);
	
	PdfPCell cellpl1 = new PdfPCell(new Paragraph("Hora de Entrada", titulo1));
	//cellpl1.setColspan(9);
	table.addCell(cellpl1);
	
	PdfPCell cellpl2 = new PdfPCell(new Paragraph("Hora de Saida", titulo1));
	//cellpl1.setColspan(9);
	table.addCell(cellpl2);
	
	PdfPCell cellag1 = new PdfPCell(new Paragraph("Hora de Entrada", titulo1));
	//cellpl1.setColspan(9);
	table.addCell(cellag1);
	
	PdfPCell cellag2 = new PdfPCell(new Paragraph("Hora de Saida", titulo1));
	//cellpl1.setColspan(9);
	table.addCell(cellag2);
	
	PdfPCell cellepf = new PdfPCell(new Paragraph("Rubrica do Servidor", titulo1));
	//cellpl1.setColspan(9);
	table.addCell(cellepf);
	
	PdfPCell celldpf = new PdfPCell(new Paragraph("Ocorrência", titulo1));
	//cellpl1.setColspan(9);
	table.addCell(celldpf);
	
	PdfPCell cellpap = new PdfPCell(new Paragraph("Abono do Chefe Imediato", titulo1));
	//cellpl1.setColspan(9);
	table.addCell(cellpap);
	
	PdfPCell cellper = new PdfPCell(new Paragraph("Hs. Trabalhadas", titulo1));
	//cellper.setColspan(9);
	table.addCell(cellper);
	
	PdfPCell cellper1 = new PdfPCell(new Paragraph("Hs. Extras", titulo1));
	cellper1.setColspan(10);
	table.addCell(cellper1);
	
	//variáveis axiliares
	PdfPCell c1;
	PdfPCell c2;
	PdfPCell c3;
	PdfPCell c4;
	PdfPCell c5;
	PdfPCell c6;
	PdfPCell c7; 
	PdfPCell c8;
	PdfPCell c9;
	PdfPCell c10;
	
	//inicio do acesso da tabela
	respage = Util.retornaFolhaponto(Util.retornaID(ad), datasis.substring(2,10));
	int i=0;
	if( respage.next() ){
		do
		{ 
		//System.out.println("entrou");
		
		String he1=respage.getString("he1");
		String hs1=respage.getString("hs1");
		String he2=respage.getString("he2");
		String hs2=respage.getString("hs2");
		String ocorrencia=respage.getString("ocorrencia");
		
		//String auxdia=Util.retornaDiadaSemana(data);
	//	if(auxdia.equals("DOM") || auxdia.equals("SAB")){
		
		
			i++;
			String auxi=Integer.toString(i);
			c1 = new PdfPCell(new Paragraph(auxi, textonegrito));
			table.addCell(c1);
			
			c2 = new PdfPCell(new Paragraph(he1, textonegrito));
			table.addCell(c2);
			
			c3= new PdfPCell(new Paragraph(hs1, textonegrito));
			table.addCell(c3);
			
			c4 = new PdfPCell(new Paragraph(he2, textonegrito));
			table.addCell(c4);
			
			c5 = new PdfPCell(new Paragraph(hs2, textonegrito));
			table.addCell(c5);
			
			c6 = new PdfPCell(new Paragraph("", textonegrito));
			table.addCell(c6);
			
			c7 = new PdfPCell(new Paragraph(ocorrencia, textonegrito));
			table.addCell(c7);
			
			c8= new PdfPCell(new Paragraph("", textonegrito));
			table.addCell(c8);
			
			c9 = new PdfPCell(new Paragraph("", textonegrito));
			table.addCell(c9);
			
			c10 = new PdfPCell(new Paragraph("", textonegrito));
			table.addCell(c10);
			
			
		//}else{
			
			
		//}
	
		}while(respage.next());
	}	
	Paragraph p1 = new Paragraph("Data: "+data+"", texto);
	Paragraph p2 = new Paragraph("Assinatura do Servidor:.............................................................................................", texto);
	Paragraph p3 = new Paragraph("Visto do Chefe Imediato:............................................................................................", texto);
	Paragraph p4 = new Paragraph("4-Os agentes de sobreavisos auxiliarão o N. de custódia nos dias de visita a presos.", texto);
	Paragraph p5 = new Paragraph("5-Os escalados para o sobreaviso que saírem emn viagem, devem indicar o seu substituto.", texto);
	Paragraph p6 = new Paragraph("Obs: Qualquer alteração na escala deverá ocorrer com anuência do Chefe da DPF/LDA/PR.", texto);
	Paragraph p7 = new Paragraph("A Escala de Delegados inicia às 07:30 hs.", texto);
	
	
	
	//ps.setBorderColor(new Color(255, 0, 0));
	//ps.setColspan(9);
	//table.addCell(ps);
	PdfPCell cell3 = new PdfPCell(new Paragraph("cell test2"));
	//cell.setBackgroundColor(new Color(0xC0, 0xC0, 0xC0));
	cell3.setColspan(9);
	//table.addCell(cell3);
	widths[0] = 50f;
	widths[1] = 100f;
	widths[2] = 100f;
	widths[3] = 100f;
	widths[4] = 100f;
	widths[5] = 100f;
	widths[6] = 100f;
	widths[7] = 100f;
	widths[8] = 100f;
	widths[9] = 100f;
	
	table.setWidths(widths);
	table.setWidthPercentage(100); 
	document.add(table);

	document.add(p1);
	document.add(p2);
	document.add(p3);
	//document.add(p4);
	//document.add(p5);
	//document.add(p6);
	//document.add(p7);
	//document.add(new Paragraph(" "));
	//document.add(new Paragraph(" "));
	Paragraph rodape1 = new Paragraph("DPF EVARISTO KUCEKI", rodape);
	rodape1.setAlignment(Element.ALIGN_CENTER);
	Paragraph rodape2 = new Paragraph("Chefe da DPF/LDA/PR", rodape);
	rodape2.setAlignment(Element.ALIGN_CENTER);
	//document.add(rodape1);
	//document.add(rodape2);
	
document.setPageSize(PageSize.A4);
document.close();
response.setContentType("application/pdf");
response.setContentLength(baos.size());
ServletOutputStream jp = response.getOutputStream();
baos.writeTo(jp);
jp.flush(); %>
</body>
</html>