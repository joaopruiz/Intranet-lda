package testes;

public class Cpf {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String cpf = "047.167.519-96";
		String a=cpf.substring(0,3);
		String b=cpf.substring(4,7);
		String c=cpf.substring(8,11);
		String d=cpf.substring(12,14);
		System.out.println(a+b+c+d);

		String cvc="04716751996";
		String aa=cvc.substring(0,3);
		String bb=cvc.substring(3,6);
		String cc=cvc.substring(6,9);
		String dd=cvc.substring(9,11);
		System.out.println(aa+"."+bb+"."+cc+"-"+dd);
	}

}
