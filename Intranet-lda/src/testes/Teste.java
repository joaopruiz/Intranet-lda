package testes;
public class Teste {
	public static String testeString(String[] i){
		System.out.println("m�todo invocado");
		String a="";
		for(int n=0;n<i.length;n++){
			System.out.println(i[n]);
			a+=" espa�o "+i[n];
		}
		System.out.println(a);
		return a;
	}
}
