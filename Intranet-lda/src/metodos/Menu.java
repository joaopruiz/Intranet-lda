package metodos;

import java.util.ArrayList;
import java.util.Iterator;

import bean.BeanConteudo;

public class Menu {
	public static String imprimeMenuPrincipal(){
		String html="";
			try {
				html=Util.retornaMenu(0);
				ArrayList<BeanConteudo> conteudo = Util.retornaConteudoArrayList();
				Iterator i = conteudo.iterator();
				String print="";
				while (i.hasNext()) {
					BeanConteudo conte1 = (BeanConteudo) i.next();
					print="<li><a href='conteudo.jsp?id="+conte1.getId()+"'>"+conte1.getDescricao()+"</a></li>";
					html+=print;
				} 
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		return html;
	}
	public static String imprimeMenu(int fu){
		String html="";
		String a="";
		String b="<div class='box'><div class='box_title'>MENU</div><div class='box_body p10'><ul>";
		String c="</ul></div><div class='box_bottom'></div></div>";
		String d="<div class='box'><p><img src='img/fotos/dpf.jpg' HEIGHT='100%' WIDTH='100%' border='0'></p></div>";
		String e="<div class='box'><p><img src='img/fotos/cti.jpg' HEIGHT='100%' WIDTH='100%' border='0'></p></div>";
		if (fu == 0){
			a=(d+e);
		}
		//"Administrador Intranet"
		if (fu == 1){
			try {
				html=Util.retornaMenu(1);
			} catch (Exception f) {
				// TODO Auto-generated catch block
				f.printStackTrace();
				html=f.toString();
			}
			a=b+(html)+c+d+e;
		}
		//"Atendente Suporte"
		if (fu == 2){
			try {
				html=Util.retornaMenu(2);
			} catch (Exception f) {
				// TODO Auto-generated catch block
				f.printStackTrace();
				html=f.toString();
			}
			a=b+(html)+c+d+e;
		}
		//"Administrador e Atendente"
		if (fu == 3){
			try {
				html=Util.retornaMenu(3);
			} catch (Exception f) {
				// TODO Auto-generated catch block
				f.printStackTrace();
				html=f.toString();
			}
			a=b+(html)+c+d+e;
		}
		//"Usuario"
		if (fu == 4){
			try {
				html=Util.retornaMenu(4);
			} catch (Exception f) {
				// TODO Auto-generated catch block
				f.printStackTrace();
				html=f.toString();
			}
			a=b+(html)+c;
		}
		//"Usuario Notícia"
		if (fu == 8){
			try {
				html=Util.retornaMenu(8);
			} catch (Exception f) {
				// TODO Auto-generated catch block
				f.printStackTrace();
				html=f.toString();
			}
			a=b+(html)+c+d+e;
		}
		//"Gerente TI"
		if (fu == 9){
			try {
				html=Util.retornaMenu(9);
			} catch (Exception f) {
				// TODO Auto-generated catch block
				f.printStackTrace();
				html=f.toString();
			}
			a=b+(html)+c+d+e;
		}
		//"Escala ADM"
		if (fu == 10){
			try {
				html=Util.retornaMenu(10);
			} catch (Exception f) {
				// TODO Auto-generated catch block
				f.printStackTrace();
				html=f.toString();
			}
			a=b+(html)+c+d+e;
		}
		//"Delegado Chefe"
		if (fu == 11){
			try {
				html=Util.retornaMenu(11);
			} catch (Exception f) {
				// TODO Auto-generated catch block
				f.printStackTrace();
				html=f.toString();
			}
			a=b+(html)+c+d+e;
		}
		return a;
	}
	
}
