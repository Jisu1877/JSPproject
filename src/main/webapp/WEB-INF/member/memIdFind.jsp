<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memIdFind</title>
    <%@ include file="/include/bs4.jsp" %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    	function sendCheck() {
			opener.window.document.myForm.mid.value = '${mid}';
			opener.window.document.myForm.pwd.focus();
			window.close();
		}
    	
    	function replaceAt (input, index, character){
		     return input.substr(0, index) + character + input.substr(index+character.length);
		}
    	
    	//아이디 찾기
    	function idFind() {
    		let name = myForm.name.value;
    		let tel1 = myForm.tel1.value;
		    let tel2 = myForm.tel2.value; 
		    let tel3 = myForm.tel3.value;
		    let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
		    
		    if(name == "") {
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
    	
    	window.onload = function() {
    		const flag = '${flag}';
    		if (flag == 'true') {
    			document.getElementById('demo').style.display = "block";
    		}
    	}
    </script>
</head>
<body>
<p><br/><p>
<div class="container">
	<h2 class="text-center mb-3"><strong>아이디 찾기</strong></h2>
	<form name="myForm" method="post" action="${ctp}/memIdFindOk.mem">
		<div class="form-group">
			<div class="w3-row" style="width: 450px;">
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
		</div>
		<div id="demo" style="display:none">
			<c:choose>
			<c:when test="${empty mid}">
				<br>
				<p><b><font color="red"><i class="fa-solid fa-circle-exclamation"></i> 아이디 찾기 실패</font> 
				<br><i class="fa-solid fa-quote-left"></i> 입력하신 내용과 일치하는 회원을 찾지 못했습니다. <i class="fa-solid fa-quote-right"></i></b></p>
			</c:when>
			<c:otherwise>
				<br>
				<p><b><i class="fa-solid fa-lightbulb"></i> 회원님의 아이디는 '<font color="blue">${mid}'</font>입니다.</b></p>
			</c:otherwise>
			</c:choose>
		</div>
		<div style="text-align:center; margin-top:30px;">
			<c:if test="${flag != 'true'}">
	      		<input type="button" value="아이디 찾기" onclick="idFind()" class="w3-button w3-yellow"/>&nbsp; &nbsp;
			</c:if>
			<input type="button" value="창닫기" onclick="sendCheck()" class="w3-button w3-black"/>
      	</div>
      	<input type="hidden" name="tel" id="tel"/>
	</form>
</div>
<p><br/><p>
</body>
</html>