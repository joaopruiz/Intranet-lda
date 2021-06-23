function loading()
{
    //criando um novo elemento div
    x = document.createElement("div");
   //atribuindo o id ao novo elemento
   x.id = "loader";
   //adicionando conteudo formatado pelo CSS na div loader 
   x.innerHTML   =  "<div id='info' class='info'>";
   x.innerHTML +=  "<p>Carregando…</p></div>";
   // nova div ira aparecer depois da div conteudo
   conteudoDiv = document.getElementById("conteudo");
   //inserindo a div loader dentro do body e apos a div conteudo
   document.body.insertBefore(x, conteudoDiv);
}

//função aguarda a pagina carregar para alterar
//propriedade display do elem. fazendo sumir
window.onload = function(){
    //obtendo as propriedades do elemento div conteudo
    obj2 = document.getElementById("conteudo");
    //exibindo a div conteudo (display none no CSS) 
    obj2.style.display = "block";
   //obtendo as propriedades do elemento div loader
   obj = document.getElementById("loader");
   //removendo o conteudo da div loader
    obj.innerHTML = "";
   //ocultando a div loader apos o carregamento da pagina
   obj.style.display = "none";  
}