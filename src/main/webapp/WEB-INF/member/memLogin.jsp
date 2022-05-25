<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page session="false" %> 서버의 부담을 줄이기 위해 세션을 끊어주기 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memLogin.jsp</title>
   	<%@ include file="/include/bs4.jsp" %>
    <script>
    	'use strict';
    	function fCheck() {
    		let mid = document.getElementById("mid").value;
    		let pwd = document.getElementById("pwd").value;
			
    		if(mid == "") {
    			alert("아이디를 입력하세요");
    			myForm.mid.focus();
    		}
    		else if(pwd == "") {
    			alert("비밀번호를 입력하세요");
    			myForm.pwd.focus();
    		}
    		else {
	    		myForm.submit();
    		}
		}
    	//아이디찾기
    	function idFind() {
      		let url = "${ctp}/memIdFind.mem";
   			window.open(url, "nWin", "width=700px,height=350px, left=500px, top=200px, resizable = no, scrollbars = no");
    	}
    	//비밀번호찾기
    	function pwdFind() {
    		let mid = document.getElementById("mid").value;
      		let url = "${ctp}/memPwdFind.mem";
      		let winX = 700;
            let winY = 450;
            let x = (window.screen.width/2) - (winX/2);
            let y = (window.screen.height/2) - (winY/2)
   			window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
    	}
    </script>
    <style>
	  	.headerJoin {
	  		font-size: 60px;
	        color: black;
	        font-weight: bolder;
	        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
	  	}
	</style>
</head>
<body>
<%@ include file="/include/nav2.jsp" %>
<p><br/><p>
<div class="container" style="margin-bottom:100px">
		<div class="container p-3">
			<div class="w3-row-padding w3-padding-16">
				<div class="w3-third w3-margin-bottom"></div>
				<div class="w3-third w3-margin-bottom">
				<h2 class="headerJoin text-center">LOGIN</h2><p><br></p>
					<form name="myForm" method="post" action="${ctp}/memLoginOk.mem">
						<div class="form-group">
					      <label for="mid">ID :</label>
					      <input type="text" class="form-control" id="mid" value="${mid}" placeholder="아이디를 입력하세요." name="mid" required autofocus>
					    </div>
						<div class="form-group" >
					      <label for="pwd">Password :</label>
					      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required>
					    </div>
						<div class="row" style="font-size:12px">
							<span class="col"><input type="checkbox" name="idCheck" checked />&nbsp;아이디 저장</span>
							<span class="col"><a href="javascript:idFind()">아이디 찾기</a> / <a href="javascript:pwdFind()">비밀번호 찾기</a></span>
						</div><p><br></p>
					    <div class="form-group text-center">
						<button type="submit" class="w3-btn w3-black" onclick="fCheck()">로그인</button> &nbsp;&nbsp;		
						<button type="button" class="w3-btn w3-black" onclick="location.href='${ctp}/termsOfService.mem';">회원가입</button>
						</div>
						<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
					</form>
				</div>
				<div class="w3-third w3-margin-bottom"></div>
			</div>
		</div>
	</div>
<p><br/><p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>