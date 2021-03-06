<%--
  ~ Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    request.getSession().invalidate();
    String queryString = request.getQueryString();
    Map<String, String> idpAuthenticatorMapping = null;
    if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {
        idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);
    }

    String errorMessage = "Authentication Failed! Please Retry";
    String authenticationFailed = "false";

    if (Boolean.parseBoolean(request.getParameter(Constants.AUTH_FAILURE))) {
        authenticationFailed = "true";

        if (request.getParameter(Constants.AUTH_FAILURE_MSG) != null) {
            errorMessage = request.getParameter(Constants.AUTH_FAILURE_MSG);

            if (errorMessage.equalsIgnoreCase("authentication.fail.message")) {
                errorMessage = "Authentication Failed! Please Retry";
            } else if (errorMessage.equalsIgnoreCase("unable.send.code")) {
                errorMessage = "Unable to send code to your email address";
            } else if (errorMessage.equalsIgnoreCase("code.mismatch")) {
                errorMessage = "The code entered is incorrect. Authentication Failed!";
            } else if (errorMessage.equalsIgnoreCase("emailotp.disable")) {
                errorMessage = "Enable the Email OTP in your Profile. Cannot proceed further without Email OTP authentication.";
            } else if (errorMessage.equalsIgnoreCase("directly.send.otp.disable")) {
                errorMessage = "User not found in the directory. Cannot proceed further without Email OTP authentication.";
            } else if (errorMessage.equalsIgnoreCase("user.account.locked")) {
                errorMessage = "User account is locked. Please retry later.";
                String unlockTime = request.getParameter("unlockTime");
                if (unlockTime != null) {
                    errorMessage = String.format("User account is locked. Please retry after %s minutes.", unlockTime);
                }
            }
        }
    }
%>

<html>
    <head>
      <!-- header -->
      <%
          File headerFile = new File(getServletContext().getRealPath("extensions/header.jsp"));
          if (headerFile.exists()) {
      %>
      <jsp:include page="extensions/header.jsp" />
      <% } else { %>
      <jsp:include page="includes/header.jsp" />
      <% } %>

      <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
      <![endif]-->
    </head>

    <body class="login-portal layout email-otp-portal-layout">
      <main class="center-segment">
        <div class="ui container medium center aligned middle aligned">
          <!-- product-title -->
          <%
              File productTitleFile = new File(getServletContext().getRealPath("extensions/product-title.jsp"));
              if (productTitleFile.exists()) {
          %>
          <jsp:include page="extensions/product-title.jsp" />
          <% } else { %>
          <jsp:include page="includes/product-title.jsp" />
          <% } %>

          <div class="ui segment">
            <!-- page content -->
            <h2>Failed Authentication with EmailOTP</h2>
            <div class="ui divider hidden"></div>
              <%
                if ("true".equals(authenticationFailed)) {
              %>
            <div class="ui negative message" id="failed-msg"><%=Encode.forHtmlContent(errorMessage)%></div>
            <% } %>
          </div>
        </div>
      </main>

      <!-- product-footer -->
      <%
        File productFooterFile = new File(getServletContext().getRealPath("extensions/product-footer.jsp"));
        if (productFooterFile.exists()) {
      %>
      <jsp:include page="extensions/product-footer.jsp" />
      <% } else { %>
      <jsp:include page="includes/product-footer.jsp" />
      <% } %>

      <!-- footer -->
      <%
        File footerFile = new File(getServletContext().getRealPath("extensions/footer.jsp"));
        if (footerFile.exists()) {
      %>
      <jsp:include page="extensions/footer.jsp" />
      <% } else { %>
      <jsp:include page="includes/footer.jsp" />
      <% } %>
    </body>
</html>
