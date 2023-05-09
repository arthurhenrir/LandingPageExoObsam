<!DOCTYPE html>
<html>


<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="org.exoplatform.portal.branding.BrandingService"%>
<%@ page import="java.util.*" %>
<%@ page import="org.exoplatform.container.PortalContainer"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<portlet:defineObjects />
<%
	String contextPath = request.getContextPath();
 	
  ResourceBundle resource = portletConfig.getResourceBundle(request.getLocale());

	String yourOtherJSP= getInitParameter("your-other-jsp");

	PortalContainer portalContainer = PortalContainer.getCurrentInstance(session.getServletContext());
	BrandingService brandingService = portalContainer.getComponentInstanceOfType(BrandingService.class);
	String companyName = brandingService.getCompanyName();
	String logo = "";
	if (brandingService.getLogo() != null) {
		byte[] logoData = brandingService.getLogo().getData();
		byte[] encodedLogoData = Base64.getEncoder().encode(logoData);
		logo = "data:image/png;base64," + new String(encodedLogoData, "UTF-8");
	}


	%>

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="<%=contextPath%>/skin/Stylesheet.css"/>
  <link href="https://fonts.googleapis.com/css2?family=Abhaya+Libre:wght@400;700&display=swap" rel="stylesheet">
  <title>Coopere Obsam</title>

  <meta property="og:title" content="Coopere" />
  <meta property="og:description" content="Comunidade de Práticas em Saúde Mental" />
  <meta property="og:url" content="https://coopere.obsam.unb.br/portal/dw" />
  <meta property="og:title" content="Coopere" />
  <meta property="og:description" content="Comunidade de Práticas em Saúde Mental" />
  <meta property="og:url" content="https://coopere.obsam.unb.br/portal/dw" />
  <meta property="og:image" content="https://coopere.obsam.unb.br/welcome-page-obsam/skin/imgs/logo-thumb-coopere.png" />

  <link href="<%=contextPath%>/skin/imgs/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>

<body>
  <!--Navbar-->
  <div class="navbar">
      <img class="logo" src="\welcome-page-obsam\skin\imgs\LogoSDS\logo.png"/>
      <img src="" />
      <a class="button">Home</a>
      <a class="button">Coopere</a>
      <a class="button">Quem somos</a>
      <a class="button">Notícias</a>
      <a class="button">Login</a>
      <img class="faleConosco" src="\welcome-page-obsam\skin\imgs\Botão1.png"/>
      <img class="socialLogo" src="\welcome-page-obsam\skin\imgs\Botão2.png"/>
      <img class="socialLogo" src="\welcome-page-obsam\skin\imgs\Botão3.png"/>
  </div>

  <!--Banner Coopere-->
  <div class="containerBanner">
      <img src="\welcome-page-obsam\skin\imgs\banner.png"/>
  </div>
  <div class="containerBody">
    <div class="containerIntro">
        <div class="introText">
            <p>
                A Coopere é comunidade de práticas em saúde mental desenvolvida para fortalecer e compartilhar vivências  e conhecimentos com foco na Rede de Atenção Psicossocial. 
                <br/><br/>
                Se você tem interesse em conhecer experiências, acessar conteúdo e participar de ciclos de debate sobre diferentes temas do campo saúde mental, esse é o seu lugar.
                <br/>Seja bem-vinde à Coopere!
                <br/><br/>
                Conecte,<br/>
                Compartilhe,<br/>
                Coopere!
            </p>
            <a class="button">Sobre a Coopere</a>
        </div>
        <div class="introVideo">
            <iframe src="https://www.youtube.com/embed/EtZUpmcDR4M"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen>
            </iframe>
            <a class="button">Login</a>
        </div>
    </div>
    <div class="divisor"></div>

    <div class="containerLogin">
        <div class="login">
            <div class="loginBox">
                <img src="\welcome-page-obsam\skin\imgs\LogoSDS\logoCoopere.jpg"/>
                <input  tabindex="1" id="username" name="username" type="text" value="" placeholder="Nome de Usuário ou Email">
                <input  tabindex="2"  type="password" id="password" name="password" placeholder="Senha">
                <label class="checkbox-container">
                    <input type="checkbox" name="rememberme" id="rememberme" value="true" checked="true">
                    <span class="checkmark"></span>
                    <p>Continuar conectado</p>
                </label>
                <button>Conectar</button>
                <p>Ainda não tem Cadastro?</p>
                <a href="">Clique aqui</a>
                <p>Não Consegue acessar sua conta?</p>
                <a href="">Clique aqui</a>
            </div>
        </div>
        <div class="loginVideo">
            <h1>Seja Coopere</h1>
            <p>Para seu primeiro acesso, acompanhe o tutorial de cadastro</p>
            <iframe 
                src="https://www.youtube.com/embed/G9mpEdcU93U" 
                title="Como fazer login na Coopere?" 
                frameborder="0" 
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
                allowfullscreen>
            </iframe>
        </div>            
    </div>
    <div class="divisor"></div>
    <!--Seção de noticias-->
    <div class="containerNoticias">
      <div class="noticias">
          <h1>Notícias</h1>
          <img src="\welcome-page-obsam\skin\imgs\Template laranja.png" />
          <a class="button">Saiba Mais</a>
      </div>
      <div class="noticiasText">
          <p>Indicadores em Saúde mental (ISM) - desafios para implementação</p>
          <p>O Ciclo Coopere está chegando!</p>
          <p>Conheça o Manual da Coopere</p>
          <p>Problemas na Coopere, com quem falar?</p>
          <a class="button">Leia todas</a>
      </div>            
  </div>
  <div class="divisor"></div>

  
    <div class="">
        <h1>Sobre a Coopere</h1>
        <p>A comunidade de práticas Coopere integra o projeto 
            "Saúde Mental: Ferramentas para contribuir com a otimização 
            dos processos de trabalho dos Centros de Atenção Psicossocial” 
            desenvolvido pela Sala de Situação de Saúde da Faculdade de Ciências 
            da Saúde da Universidade de Brasília com apoio do Ministério da Saúde. 
            O projeto teve início em maio de 2021 com o término previsto para junho de 2023.
        </p>
    </div>
    <!--CÓDIGO DOS RETANGULOS-->
    <div class="containerRetangulo">
      <div class="retangulo">
        <h1>CoP</h1>
        <p>A meta 01 do projeto Coopere é a criação da comunidade de práticas virtual
           que tem por objetivos ser um espaço de troca de experiências e conhecimentos
            para o fortalecimento da RAPS e também contribuir para a gestão de equipes 
            e dinamizar os processos de trabalho. 
        </p>
        <a class="button">Acesse a CoP</a>
      </div>
      <div class="retangulo">
        <h1>Painel</h1>
        <p>
          A meta 02 do projeto Coopere engloba o desenvolvimento de soluções tecnológicas
          para os processos de trabalho na vigilância de saúde mental como a criação de
          dashboards para a análise de dados como subsídio à tomada de decisões.
        </p>
        <a class="button">Em Breve</a>
      </div>
    </div>

<!--CÓDIGO DOS FOTOS-->

    <div class="divisor"></div>
    <div>
        <h1>Equipe Coopere</h1>
    </div>
    <div class="membros">
      <table>
        <tr>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\jonas.jpeg" alt="Foto 1">
              <p>Jonas Lotufo Brant de Carvalho</p>
              <p>Coordenador</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\alisson.jpg" alt="Foto 2">
              <p>Alisson Fernandes Bolina</p>
              <p>Pesquisador</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\anaju.jpeg" alt="Foto 3">
              <p>Ana Julia Santos</p>
              <p>Bolsista Graduação</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\bruna.jpg" alt="Foto 4">
              <p>Bruna Paes de Oliveira</p>
              <p>Pesquisadora</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\chris.jpeg" alt="Foto 5">
              <p>Christiane Kanzler Barbosa Nunes</p>
              <p>Pesquisadora</p>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\daniel.jpeg" alt="Foto 6">
              <p>Daniel Erick Sanchez Trujillo</p>
              <p>Bolsista Graduação</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\Eduarda.jpeg" alt="Foto 7">
              <p>Eduarda Grillo Cunha</p>
              <p>Bolsista Graduação</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\Gabriel.jpeg" alt="Foto 8">
              <p>Gabriel Nazareno Halabi</p>
              <p>Bolsista Graduação</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\gleyton.jpg" alt="Foto 9">
              <p>Gleyton de Castro Lima</p>
              <p>Pesquisador</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\joao.jpg" alt="Foto 10">
              <p>João Palo Fernandes da Silva</p>
              <p>Pesquisador</p>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\joyce.jpeg" alt="Foto 11">
              <p>Joyce Miranda dos Santos</p>
              <p>Pesquisadora</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\luis.jpg" alt="Foto 12">
              <p>Luís Bruno Fidelis Fomes</p>
              <p>Bolsista de Graduação</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\Marcela.jpg" alt="Foto 13">
              <p>Marcela Lopes Santos</p>
              <p>Pesquisadora</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\mari.jpeg" alt="Foto 14">
              <p>Mariana Bernardes de Araújo</p>
              <p>Bolsista de Graduação</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\mariF.jpg" alt="Foto 15">
              <p>Mariana Ferreira Lopes</p>
              <p>Pesquisadora</p>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\mirella.jpeg" alt="Foto 11">
              <p>Mirella dos Santos Jacinto Soares</p>
              <p>Bolsista de Graduação</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\suamir.png" alt="Foto 12">
              <p>Suamir Jorge de Azevedo Campos</p>
              <p>Gestor Substituto</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\Vanessa.jpeg" alt="Foto 13">
              <p>Vanessa Torales Porto</p>
              <p>Pesquisadora</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\vitor.jpeg" alt="Foto 14">
              <p>Vitor Padilha Gonçalves</p>
              <p>Pesquisador</p>
            </div>
          </td>
          <td>
            <div class="circle">
              <img src="\welcome-page-obsam\skin\imgs\Fotos equipe\lara.jpg" alt="Foto 15">
              <p>Lara Borges Larroyed</p>
              <p>Bolsista de Graduação</p>
            </div>
          </td>
        </tr>
      </table> 

    </div> 
    <div class="underBar">
      <img class="underImg1" src="\welcome-page-obsam\skin\imgs\LogoSDS\coopImage.png"/>
      <img class="underImg2" src="\welcome-page-obsam\skin\imgs\LogoSDS\logo.png"/>
    </div>
</div>
    
</body>