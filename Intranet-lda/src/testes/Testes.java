package testes;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.*; 
import com.lowagie.text.pdf.PdfWriter;


public class Testes {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Date data=new Date();
		System.out.println(data);
		String a="";
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");  
		String dataHojeAsString = formato.format(data);
		a=dataHojeAsString;
		int diasemana = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);
		System.out.println(diasemana);
		System.out.println(a);
		
		  Calendar cal = Calendar.getInstance();  
		            
		   // Em que dia D. Pedro declarou a Independ�ncia?  
		            
		  int dia = 19;  
		  int mes = 12;  
		  int ano = 2008;  
		            
		  cal.set (ano, mes - 1, dia); // note que voc� precisa subtrair 1 do m�s !!!!  
		            
		  // Note que para os dias da semana, 1 = domingo, 2 = segunda, ... 7 = s�bado  
		  // O correto � usar: Calendar.SATURDAY em vez de bitolar que 7 = s�bado.  
		  System.out.println (cal.get(Calendar.DAY_OF_WEEK));  
		
		
	     // cria��o do objeto documento
	       Document document = new Document();
	       try {
	           
	           PdfWriter.getInstance(document, new FileOutputStream("C://PDF_LinhaCodigo.pdf"));
	           document.open();
	           
	           // adicionando um par�grafo ao documento
	           document.add(new Paragraph("Exemplo Gera��o de Arquivo PDF via iText - Java ttttttttt" +
	           		"tttttttttttttttttttttttttttttttttttttttttttttt" +
	           		"tttttttttttttttttttttttttttttttttttttttttttttttttttttttttt" +
	           		"tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt"));
	           document.add(new Paragraph("Novo par�grafo por JP"));
}
	       catch(DocumentException de) {
	           System.err.println(de.getMessage());
	       }
	       catch(IOException ioe) {
	           System.err.println(ioe.getMessage());
	       }
	       document.close();

	       
	       
	       
	}
	

}
