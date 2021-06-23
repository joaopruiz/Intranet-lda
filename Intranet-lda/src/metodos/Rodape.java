package metodos;

public class Rodape {
	public static String imprimeRodape(){
		String html="";
		try {
			html=Util.retornaLayout("rodape");
		} catch (Exception f) {
			// TODO Auto-generated catch block
			f.printStackTrace();
			html=f.toString();
		}
		return html;
	}
}
