<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<c:set var="name" value="${name}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memPwdFind</title>
    <%@ include file="/include/bs4.jsp" %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    	function sendCheck() {
			opener.window.document.myForm.mid.value = '${mid}';
			opener.window.document.myForm.pwd.focus();
			window.close();
		}
    	
    	//비밀번호 재쟁성을 위한 정보 확인
    	function pwdFind() {
    		let mid = myForm.mid.value;
    		let name = myForm.name.value;
    		let tel1 = myForm.tel1.value;
		    let tel2 = myForm.tel2.value; 
		    let tel3 = myForm.tel3.value;
		    let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
		    
		    if(mid == "") {
				alert("아이디를 입력하세요");
				myForm.name.focus();
				return false;
			}
		    else if(name == "") {
				alert("성명을 입력하세요");
				myForm.name.focus();
				return false;
			}
		    else if(tel2 == "" || tel3 == "") {
				alert("연락처를 입력하세요");
				myForm.tel2.focus();
				return false;
			}
		    document.getElementById('tel').value = tel;
		    myForm.submit();
		}
    	
    	
    /* 	window.onload = function() {
    		if ('${name}' != "") {
    			document.getElementById('demo').style.display = "block";
    		}
    	} */
    	
    </script>
</head>
<body>
<p><br/><p>
<div class="container">
	<h2 class="text-center"><b>비밀번호 찾기</b></h2>
	<br>
	<form name="myForm" method="post" action="${ctp}/memPwdFindOk.mem">
	<div class="w3-row" style="width: 450px;">
		<div class="form-group">
			<label for="mid">아이디 :</label>&nbsp;&nbsp;
			<input type="text" class="form-control" id="mid" value="${mid}" name="mid" placeholder="아이디를 입력하세요." required autofocus/>
		</div>
	      	    <label for="name">성명 :</label>
				  <div class="input-group mb-3">
				  	<input type="text" class="form-control" placeholder="성명을 입력하세요." id="name" name="name" required />
				  </div>
			</div>
			<label for="tel">연락처 :</label>
		      <div class="input-group mb-3">
			      <div class="input-group-prepend">
					      <select name="tel1" id="tel1" class="w3-select w3-border">
							    <option value="010" selected>010</option>
							    <option value="02">서울</option>
							    <option value="031">경기</option>
							    <option value="032">인천</option>
							    <option value="041">충남</option>
							    <option value="042">대전</option>
							    <option value="043">충북</option>
					        <option value="051">부산</option>
					        <option value="052">울산</option>
					        <option value="061">전북</option>
					        <option value="062">광주</option>
							  </select><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span> <span>&nbsp; &nbsp;</span>
			      </div>
			      <input type="text" name="tel2" id="tel2" size=8 maxlength=4 class="w3-border"/><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span><span>&nbsp; &nbsp;</span>
			      <input type="text" name="tel3" id="tel3" size=8 maxlength=4 class="w3-border"/>&nbsp; &nbsp;
	  		  </div> 
		<br>
		<div style="text-align: center">
			<input type="button" value="입력" onclick="pwdFind()" class="w3-button w3-yellow"/>
		</div>
		<input type="hidden" name="tel" id="tel"/>
	</form>
</div>
<p><br/><p>
</body>
</html>