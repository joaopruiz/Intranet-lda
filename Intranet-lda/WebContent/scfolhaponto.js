function Preenche(){
	var a = document.formulario.dt1.value;
	var b = document.formulario.dt2.value;
	var c = document.formulario.dt3.value;
	var d = document.formulario.dt4.value;
	
	/*if(document.formulario.he1.value == ""){
		document.formulario.he1.value = a;
	}
	if(document.formulario.hs1.value == ""){
		document.formulario.hs1.value = b;
	}
	if(document.formulario.he2.value == ""){
		document.formulario.he2.value = c;		 
	}
	if(document.formulario.hs2.value == ""){
		document.formulario.hs2.value = d;
	}*/
	
	var nomeCampo =""; 
	var lenCampo = "";
	var controle = "";
	
			
			var i=0;
			for (i=0; i<document.formulario.elements.length; i++){
				if (document.formulario.elements[i].name == "he1"){
					if(document.formulario.elements[i].value == ""){
						document.formulario.elements[i].value = a;
					}
				}
				if (document.formulario.elements[i].name == "hs1"){
					if(document.formulario.elements[i].value == ""){
						document.formulario.elements[i].value = b;
					}
				}
				if (document.formulario.elements[i].name == "he2"){
					if(document.formulario.elements[i].value == ""){
						document.formulario.elements[i].value = c;
					}
				}
				if (document.formulario.elements[i].name == "hs2"){
					if(document.formulario.elements[i].value == ""){
						document.formulario.elements[i].value = d;
					}
				}
			}
			
}
