<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = (String) request.getAttribute("msg");
	String url = (String) request.getAttribute("url");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>message.jsp</title>
    <script>
    	'use strict';
    	
    	let msg = '<%=msg%>';
    	let url = '<%=url%>';
    	let val = '${val}';
    	
    	if(msg == "idCheckNo") msg = "중복된 아이디입니다. 다시 회원가입을 진행해주세요.";
    	else if(msg == "telCheckNo") msg = "중복된 연락처입니다. 다시 회원가입을 진행해주세요.";
    	else if(msg == "memJoinOk") msg = "회원가입이 완료되었습니다.";
    	else if(msg == "memJoinNo") msg = "회원가입에 실패했습니다.";
    	else if(msg == "loginNo") msg = "로그인에 실패했습니다.";
    	else if(msg == "loginOk") msg = "${sMid}"+"님 환영합니다.";
    	else if(msg == "memLogOutOk") msg = val+"님 로그아웃되었습니다.";
    	
    	
    	alert(msg);
    	if(url != "") location.href = url;
    </script>
</head>
<body>
</body>
</html>