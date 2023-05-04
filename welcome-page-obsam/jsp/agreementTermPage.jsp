<%--

    Copyright (C) 2009 eXo Platform SAS.
    
    This is free software; you can redistribute it and/or modify it
    under the terms of the GNU Lesser General Public License as
    published by the Free Software Foundation; either version 2.1 of
    the License, or (at your option) any later version.
    
    This software is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
    Lesser General Public License for more details.
    
    You should have received a copy of the GNU Lesser General Public
    License along with this software; if not, write to the Free
    Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
    02110-1301 USA, or see the FSF site: http://www.fsf.org.

--%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="org.exoplatform.container.PortalContainer" %>
<%@ page import="org.exoplatform.services.resources.ResourceBundleService" %>
<%@ page import="org.exoplatform.portal.config.UserPortalConfigService" %>
<%@ page import="org.exoplatform.portal.resource.SkinService"%>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="org.gatein.common.text.EntityEncoder" %>
<%@ page language="java" %>
<%
    String contextPath = request.getContextPath();
    String lang = request.getLocale().getLanguage();
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");

    PortalContainer portalContainer = PortalContainer.getCurrentInstance(session.getServletContext());
    UserPortalConfigService userPortalConfigService = portalContainer.getComponentInstanceOfType(UserPortalConfigService.class);
    String skinName = userPortalConfigService.getDefaultPortalSkinName();
    SkinService skinService = portalContainer.getComponentInstanceOfType(SkinService.class);
    String cssPath = skinService.getSkin("portal/Conditions", skinName).getCSSPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<%=lang%>" lang="<%=lang%>">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
		<title>eXo Subscription Agreement</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link id="brandingSkin" rel="stylesheet" type="text/css" href="/rest/v1/platform/branding/css">
		<link href="<%=cssPath%>" rel="stylesheet" type="text/css"/>
        
    </head>


	<body>
        <br><br><br><br>
		<div class="backLight"></div>
		<div class="uiWelcomeBox" id="AccountSetup" style="width: 80%; height: 50%;">
			<div class="header">TERMO DE CONSENTIMENTO LIVRE E ESCLARECIDO <br> MODALIDADE IMAGÉTICA <br></div>
			<div class="content" id="AccountSetup" style="height: 230px;">
                    <p class="c68 c36 c97"><span class="c25"></span></p>
                    <p class="c1 c36"><span class="c21"></span></p>
                    <p class="c1">
                        <span class="c10">

                            Você está sendo convidada(o/e) a participar voluntariamente, como participante da pesquisa intitulada: Comunidade de Prática: ferramenta de indução de processo integrativo-colaborativo e de procedimentos de aprendizagem-formação-avaliação em saúde mental. Esta pesquisa tem como objetivo geral: avaliar o uso de uma plataforma de Comunidade de Prática pelos usuários cadastrados para trocar experiências, compartilhar e produzir conhecimentos, conteúdos e tecnologias relacionados ao contexto da gestão, do trabalho e do cuidado à saúde mental. 

                        </span>

                        <span class="c10">

                            A pesquisa foi avaliada e aprovada pelo Comitê de Ética em Pesquisa da Faculdade de Ciências da Saúde, da Universidade de Brasília (UnB), sob o parecer e sob a coordenação do Profº. O Dr. Jonas Brant, Professor do curso de graduação e pós-graduação em saúde coletiva, da Faculdade de Ciências da Saúde da UnB e da equipe de pesquisadores. 
                        
                        </span>
                    </p>

                    <p class="c68 c36 c97"><span class="c25"> </span></p>
                    <p class="c1 c36"><span class="c3"> Sobre a realização da pesquisa no ambiente virtual: </span></p>
                    <p class="c1">
                        <span class="c10">

                            A sua participação na pesquisa acontecerá em ambiente virtual criado para a implementação da Comunidade de Prática (CdP) em Saúde Mental, para isso você deverá ter acesso à internet e/ou dados móveis. A sua participação será efetivada após leitura sobre um conjunto de informações para orientar a sua decisão de adesão, engajamento e cadastramento na CdP. 

                        </span>

                        <span class="c10">

                            Todas as informações sobre a pesquisa estarão descritas aqui neste termo, e para participar da pesquisa será necessário ler, concordar e aceitar a participação. Este é um Termo de Consentimento Livre e Esclarecido (TCLE), imagético, ou seja, ele não é impresso, mas sim digital, destinado ao conhecimento e autorização de sua participação na pesquisa que se desenvolve a partir do cadastro efetivado para integrar a CdP Saúde mental. 

                        </span>

                        <span class="c10">

                            Sua participação não é obrigatória e consistirá em aderir livremente às atividades propostas para estabelecer trocas, interações e partilhas de conteúdo no ambiente virtual e, ainda, em responder perguntas sob a forma de questionários, utilizando para tanto o software RedCap®, no meio eletrônico de sua preferência (smartphone, computador, tablet ou outro recurso disponível) com uma duração média estimada de 20 a 40 minutos. A recusa, desistência ou suspensão da sua participação na pesquisa não acarretará prejuízo. A pesquisa não gerará despesa, assim como não será ofertada nenhuma remuneração. 
                        
                        </span>

                        <span class="c10">

                            No primeiro ano de implementação da CdP em saúde mental, além da observação participante do ambiente virtual, das trocas e interações estabelecidos entre os participantes cadastrados na plataforma virtual, está previsto a aplicação de dois formulários de questionários, com roteiro de questões, disponível para preenchimento por um período previamente definido, em momento de sua preferência, de forma assíncrona. Desta forma, o(a) participante logo após o cadastro será convidado a responder o primeiro questionário na busca de fazer uma caracterização do perfil sociodemográfico dos(as) participantes da CdP, levantamento acerca de experiência anterior e expectativas de comunidade de prática em ambiente virtual. Ao final do primeiro ano, o participante será convidado a responder um segundo questionário, com a finalidade de realizar uma análise e avaliação da experiência na CdP, precedidos da leitura e Registro da Anuência do Termo de Consentimento Livre e Esclarecido (TCLE) imagético. 

                        </span>

                        

                    </p>
                    
                    <p class="c68 c36 c97"><span class="c25"></span></p>
                    <p class="c1 c36"><span class="c3">Sobre a segurança/proteção dos dados:</span></p>
                    <p class="c1">
                        <span class="c10">

                            Os dados respondidos por você são totalmente confidenciais e sigilosos. Serão adotadas medidas de controle dos dados fornecidos pela plataforma RedCap®, realizada pelos pesquisadores: uso de pastas zipadas, códigos de identificação, controle no gerenciamento, armazenamento e transferência dos dados. Gostaríamos de destacar que para ter acesso aos dados só os pesquisadores treinados estarão autorizados para isso. Também utilizaremos de computadores próprios para essa finalidade, com proteção de senhas e códigos para que não haja nenhum extravio, ou perda ou quebra de sigilo. Nenhuma vinculação comercial será realizada, assim como não solicitamos nenhum dado bancário. Não será feita nenhuma propaganda de marca e/ou empresa. É importante que você saiba que não será necessário informar nenhum dos seus dados pessoais, como nome pessoal, número de CPF ou profissional. Seus dados e envio do convite serão feitos individualmente e de forma privativa , e nenhum convite será de maneira exposta. 

                        </span>

                        <span class="c10">

                            Nós gostaríamos de recomendar que ao aceitar em participar da pesquisa, que você guarde uma cópia do consentimento em anexo para a sua proteção, que será enviada ao seu e-mail. Também gostaríamos de informar que você poderá solicitar uma cópia do termo assinado pelo pesquisador responsável, pelo e-mail de contato: cop.obsam@gmail.com 

                        </span>

                        <span class="c10">

                            Sua participação não é obrigatória e consistirá em aderir livremente às atividades propostas para estabelecer trocas, interações e partilhas de conteúdo no ambiente virtual e, ainda, em responder perguntas sob a forma de questionários, utilizando para tanto o software RedCap®, no meio eletrônico de sua preferência (smartphone, computador, tablet ou outro recurso disponível) com uma duração média estimada de 20 a 40 minutos. A recusa, desistência ou suspensão da sua participação na pesquisa não acarretará prejuízo. A pesquisa não gerará despesa, assim como não será ofertada nenhuma remuneração. 
                        
                        </span>

                    </p>
                    
                    <p class="c68 c36 c97"><span class="c25"></span></p>
                    <p class="c1 c36"><span class="c3">Sobre a segurança/proteção dos dados:</span></p>
                    <p class="c1">
                        <span class="c10">

                            Os dados respondidos por você são totalmente confidenciais e sigilosos. Serão adotadas medidas de controle dos dados fornecidos pela plataforma RedCap®, realizada pelos pesquisadores: uso de pastas zipadas, códigos de identificação, controle no gerenciamento, armazenamento e transferência dos dados. Gostaríamos de destacar que para ter acesso aos dados só os pesquisadores treinados estarão autorizados para isso. Também utilizaremos de computadores próprios para essa finalidade, com proteção de senhas e códigos para que não haja nenhum extravio, ou perda ou quebra de sigilo. Nenhuma vinculação comercial será realizada, assim como não solicitamos nenhum dado bancário. Não será feita nenhuma propaganda de marca e/ou empresa. É importante que você saiba que não será necessário informar nenhum dos seus dados pessoais, como nome pessoal, número de CPF ou profissional. Seus dados e envio do convite serão feitos individualmente e de forma privativa , e nenhum convite será de maneira exposta. 

                        </span>

                        <span class="c10">

                            Nós gostaríamos de recomendar que ao aceitar em participar da pesquisa, que você guarde uma cópia do consentimento em anexo para a sua proteção, que será enviada ao seu e-mail. Também gostaríamos de informar que você poderá solicitar uma cópia do termo assinado pelo pesquisador responsável, pelo e-mail de contato: cop.obsam@gmail.com 

                        </span>

                    </p>

                    <p class="c68 c36 c97"><span class="c25"> 
                    </span></p>
                    <p class="c1 c36"><span class="c3">Sobre os dados a serem coletados e o seu conteúdo:</span></p>
                    <p class="c1">
                        <span class="c10">

                            É importante você ter conhecimento de que não faremos nenhum diagnóstico, ou avaliação clínica e/ou de saúde, investigação profissional, avaliação de desempenho, auditoria do serviço em que você está vinculado ou da escola/universidade que pertence. Os dados coletados em ambiente virtual e em protocolos específicos como questionários que você responder não serão analisados individualmente, portanto, não será encaminhado nenhum resultado individual. As análises serão coletivas e representarão o número total de participantes no estudo. Além disso, será mantido todo o rigor e responsabilidade na qualidade da análise dos dados, como forma de fornecer informações confiáveis à população, sendo cumprida a confiabilidade/veracidade garantida. 
 
                        </span>

                    </p>


                    <p class="c68 c36 c97"><span class="c25"> </span></p>
                    <p class="c1 c36"><span class="c3">Sobre os potenciais riscos da pesquisa:</span></p>
                    <p class="c1">
                        <span class="c10">

                            Os riscos decorrentes da participação na pesquisa podem acontecer e são relacionados à possíveis situações de constrangimento devido a temas sensíveis e conflitos de poder nas relações entre os participantes; exaustão física e mental decorrente do processo de participação na plataforma on-line e preenchimento de dados via formulário on-line. Riscos virtuais também poderão ocorrer tais como: extravio de informações, identificação do banco de e-mails, quebra ou violação da confidencialidade. 
                        </span>

                        <span class="c10">

                            Contudo, serão adotados cuidados éticos como: treinamento, preparo da equipe de pesquisa para atuarem como mediadores e intervirem de forma positiva nas situações de conflito, de forma a eliminar possíveis situações constrangimentos e de violências; utilização de uma ferramenta tecnológica dinâmica, design com letras em tamanho adequado para a leitura; utilização de pastas zipadas para fechamento dos arquivos; utilização de códigos de identificação dos dados; utilização de computadores institucionais próprios para armazenamento e proteção dos dados; utilização de plataformas de acesso digital seguro (institucional) para manipulação e discussão dos dados e conhecimento prévio da política de privacidade da Google Forms®. Ressalta-se ainda que, desde o planejamento da pesquisa são respeitados os cuidados de vigilância e proteção dos dados. 

                        </span>

                    </p>

                    <p class="c68 c36 c97"><span class="c25"></span></p>
                    <p class="c1 c36"><span class="c3">Sobre os potenciais benefícios da pesquisa: </span></p>
                    <p class="c1">
                        <span class="c10">

                            Ampliar e aprofundar o conhecimento acerca de temas que abrangem a gestão do trabalho e do cuidado em saúde mental. a partir das trocas e relatos de experiência que possam subsidiar profissionais, usuários e familiares, como instituições, movimentos sociais, fornecer informações a partir das questões investigadas para os participantes da pesquisa; fomentar aportes teóricos e evidências sobre o tema; fundamentar a produção de tecnologias de cuidado; ampliar as estratégias de gestão do trabalho e da melhoria do cuidado em saúde em saúde mental nos serviços e territórios comunitários; apoiar redes de pesquisa e formação acadêmica; fortalecer a prática profissional dos serviços de saúde. 
                        </span>

                        <span class="c10">

                            Se você aceitar participar, contribuirá no avanço da produção de conhecimento e de tecnologias para avanço da atenção psicossocial, e a partir do engajamento e mobilização dos participantes da pesquisa e usuários na CdP. Ainda, os resultados da pesquisa servirão para levantar as possíveis dificuldades e facilidades relacionadas à organização do trabalho profissional e do processo de empoderamento dos usuários e familiares em face das suas necessidades de cuidado em saúde mental. 

                        </span>

                        <span class="c10">

                            O compromisso da equipe de pesquisa é realizar uma articulação com diferentes segmentos de trabalhadores, usuários e familiares, socializar os dados junto à sociedade civil organizada, instituições de ensino e saúde, gestores das esferas governamentais e movimentos organizados da área. Os dados serão divulgados por meio de relatórios técnicos, produções educativas e científicas. 

                        </span>

                    </p>


                    <p class="c68 c36 c97"><span class="c25"> </span></p>
                    <p class="c1 c36"><span class="c3">Sobre os dados coletados:</span></p>
                    <p class="c1">
                        <span class="c10">

                            Os dados coletados serão utilizados apenas nesta pesquisa e mantidos em arquivo físico e/ou digital sob a guarda do pesquisador por um período de 5(cinco) anos após o término da pesquisa, sendo destruídos ao final deste. É importante também saber que o CEP receberá os relatórios parciais e final da pesquisa, contendo os resultados para prestação do encerramento da pesquisa, disponíveis para serem consultados. Além disso, os resultados também serão apresentados na forma de comunicação e educação em saúde através das redes sociais, além da produção de artigos e outros materiais educativos. 
                        </span>

                        <span class="c10">

                            Ressalta-se que não serão ressarcidos eventuais custos referentes a downloads e uploads, ficando sob sua responsabilidade o manejo dos arquivos. Assim não haverá eventuais ressarcimentos referentes a custos com internet ou mesmo pacote de dados.  Você terá a oportunidade de desistir da sua participação sem ter qualquer prejuízo a qualquer momento. Em caso de dano comprovadamente oriundo da pesquisa você terá direito a indenização através das vias judiciais, como dispõe o Código Civil, o Código de Processo Civil e a Resolução nº 466/2012, do Conselho Nacional de Saúde (CNS). 
                        </span>

                       

                    </p>

                    <p class="c68 c36 c97"><span class="c25"> </span></p>
                    <p class="c1 c36"><span class="c3">Sobre a confirmação da participação na pesquisa:</span></p>
                    <p class="c1">
                        <span class="c10">

                            Ao final do texto deste Termo de Consentimento Livre e Esclarecido na modalidade imagética, você encontrará duas opções referentes ao conteúdo do termo, que diz respeito a sua concordância ou discordância referente ao conteúdo apresentado, e a sua autorização e posterior participação na pesquisa, para somente após ser considerado participante e iniciar o preenchimento do termo. Peço então, que você clique na opção: estou ciente que fui informado sobre a pesquisa, e de maneira autônoma e livre, desejo participar. Informo também que você pode optar em receber uma cópia das informações que você forneceu. No termo também são disponibilizados os contatos dos pesquisadores responsáveis e também os contatos do Comitê de Ética em Pesquisa - CEP, podendo sanar as suas dúvidas sobre a sua participação agora ou a qualquer momento. Caso concorde em participar desta pesquisa, assine ao final deste termo, clique em concordo, e após preencha as informações que serão requeridas, não esquecendo de enviar ao final. 
                        </span>

                    </p>

                    <p class="c68 c36 c97"><span class="c25"> </span></p>
                    <p class="c1 c36"><span class="c3">Sobre o Comitês de Ética em Pesquisa:</span></p>
                    <p class="c1">
                        <span class="c10">

                            *Os Comitês de Ética em Pesquisa (CEP) são compostos por pessoas que trabalham para que todos os projetos de pesquisa envolvendo seres humanos sejam aprovados de acordo com as normas éticas elaboradas pelo Ministério da Saúde. A avaliação dos CEP leva em consideração os benefícios e riscos, procurando minimizá-los e buscando garantir que os participantes tenham acesso a todos os direitos assegurados pelas agências regulatórias. Assim, os CEP procuram defender a dignidade e os interesses dos participantes, incentivando sua autonomia e participação voluntária. Procure saber se este projeto foi aprovado pelo CEP desta instituição.                         </span>

                    </p>
                    
                    
			
		</div>
        <div class="bottom clearfix">
            <form name="tcForm" action="/portal/dw/google-form-register" method="post">
            <!--<form name="tcForm" action="/portal/dw/home/registration" method="post"></form>-->
                <div class="pull-left">
                    <label class="uiCheckbox">
                        <input type="checkbox" id="agreement" name="checktc" value="false" onclick="toggleState();" class="checkbox"/>
                        <span class="c3" style="text-align: justify;">Eu, declaro estar ciente do inteiro teor deste Termo de Consentimento Livre e Esclarecido (TCLE) e estou de acordo em participar do estudo proposto, sabendo que poderei desistir a qualquer momento, sem sofrer qualquer punição ou constrangimento. Fui informado sobre a guarda do TCLE.</span>
                    </label>
                </div>
                <div >
                    <input type="button" class="btn" onclick="window.open('/portal/dw/', '_self');" id="exitButton"  value="Sair">
                    &nbsp;
                    <button class="btn inactive" disabled="disabled" id="continueButton" onclick="validate();">Continuar</button>
                </div>
                

                <script type="text/javascript" src="/welcome-screens/javascript/welcomescreens.js"></script>
            </form>
        </div>
	</body>
</html>