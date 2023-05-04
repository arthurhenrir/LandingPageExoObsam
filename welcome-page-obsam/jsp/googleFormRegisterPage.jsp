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
		<div class="uiWelcomeBox" id="AccountSetup" style="width: 80%; overflow-y: hidden;">
			<div class="header">PREENCHA O FORMULÁRIO ABAIXO</div>
			<div class="content" id="AccountSetup" style="overflow-y: hidden;height: 305px;padding: 0" >
                <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSd0eQSbiK-EehlOOggJd1f_sYiz2_JOo2t9Hjlh7fY2eB4qSg/viewform?embedded=true" width="100%" height="100%" frameborder="0" marginheight="0" marginwidth="0">Carregando…</iframe>
            </div>
        <div class="bottom clearfix" style="text-align: ;center">
            <form name="tcForm" action="/portal/dw/home/registration" method="post">
                <div>
                    <label class="uiCheckbox">
                        <input type="checkbox" id="agreement" name="checktc" value="false" onclick="toggleState();" class="checkbox"/>
                        <span class="c3" style="text-align: justify">Eu, confirmo que o formulário acima foi devidamente preenchido e enviado.</span>
                    </label>
                </div>
                <br>
                <div>
                    <input type="button" class="btn" onclick="window.open('/portal/dw/', '_self');" id="exitButton"  value="Sair">
                    &nbsp;
                    <button class="btn inactive" disabled="disabled" id="continueButton" onclick="validate();">Continuar</button>

                </div>
                
    
                <script type="text/javascript" src="/welcome-screens/javascript/welcomescreens.js"></script>
            </form>
        </div>
	</body>
</html>