<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fantastic Lodging</title>
    <%@ include file="/include/bs4.jsp" %>
</head>
<body class="w3-light-grey">


<%@ include file="/include/nav1.jsp" %>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/lodging.jsp" %>


<%-- <%@ include file="/include/ourHotel.jsp" %> --%>

<%-- <%@ include file="/include/contact.jsp" %> --%>




<%@ include file="/include/footer.jsp" %>
</body>
</html>