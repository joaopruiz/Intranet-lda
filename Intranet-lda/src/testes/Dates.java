package testes;

import java.util.Calendar;

public class Dates {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
	
		String data = "16/02/2009";
		 Calendar cal = Calendar.getInstance();     
		  int dia = Integer.parseInt(data.substring(0,2));  
		  int mes = Integer.parseInt(data.substring(3,5)); 
		  int ano = Integer.parseInt(data.substring(6,10)); 
		//  System.out.println(dia+" / "+mes+" / "+ano);          
		  cal.set (ano, mes - 1, dia); // note que você precisa subtrair 1 do mês !!!!  
		
		  int j = cal.getActualMaximum(Calendar.DAY_OF_MONTH); 
	}

}
