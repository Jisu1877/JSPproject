<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>회원 관리 페이지</title>
<%@ include file="/include/bs4.jsp" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
	a {
		text-decoration: none;	
	}
	a:hover {
		color : black;
	}
</style>
<script type="text/javascript">
	'use strict';
	function pageCheck() {
		let pageSize = $("#pageSize").val();
		location.href="mem_management.ad?pag=${pag}&pageSize="+pageSize;
	}
	
	function memDelete(idx) {
		let ans = confirm("해당 회원을 탈퇴처리 하시겠습니까?");
		
		if(!ans) {
			return false;
		}
		else {
			$('input[name="idx"]').val(idx);
			$('form[name="deleteForm"]').submit();
		}
	}
</script>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <span class="w3-bar-item w3-right w3-white"><a href="${ctp}/">Home</a></span>
</div>

<%@ include file="/include/admin_sidebarMenu.jsp" %>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px; margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    <h5><b><i class="fa fa-users fa-fw"></i> Member management</b></h5>
  </header>
  <section>
  	<div class="w3-row">
	  	<div class="w3-col m2 l2 w3-margin-bottom"></div>
		  	<div class="w3-col m8 l8 w3-margin-bottom">
			  	<div>
			  		<h2 class="text-center">회원 관리</h2>
			  		<table class="table table-borderless">
						<tr>
							<td>
								<div style="font-size:0.9em; color:grey; margin-top:0px"><i class="fa-solid fa-circle-exclamation"></i>회원 아이디를 클릭하면 상세정보 조회가 가능합니다.</div>
							</td>
							<td class="text-right">
								<select name="pageSize" id="pageSize" onchange="pageCheck()">
									<option value="5" ${pageSize == 5 ? 'selected' : '' }>5건</option>
									<option value="10" ${pageSize == 10 ? 'selected' : '' }>10건</option>
									<option value="15" ${pageSize == 15 ? 'selected' : '' }>15건</option>
									<option value="20" ${pageSize == 20 ? 'selected' : '' }>20건</option>
								</select>
							</td>
						</tr>
					</table>
			  		<table class="table table-hover text-center">
			  			<tr class="w3-amber">
			  				<th>번호</th>
			  				<th>아이디</th>
			  				<th>성명</th>
			  				<th>활동유무</th>
			  				<th>비고</th>
			  			</tr>
			  			<c:forEach var="vo" items="${memList}" varStatus="st">
			  				<tr>
			  					<td>${vo.idx}</td>
			  					<td>
			  						<a href="${ctp}/memInfor.ad?idx=${vo.idx}&applyDiff=${vo.applyDiff}&pag=${pag}&pageSize=${pageSize}">${vo.mid}</a>
			  					</td>
			  					<td>${vo.name}</td>
			  					<td>
			  						<c:if test="${vo.del_yn == 'n'}">
			  							활동중
			  						</c:if> 
			  						<c:if test="${vo.del_yn == 'y'}">
			  							<font color="red">탈퇴</font><br>
										<%--  경과일 : <font color="blue"> ${vo.applyDiff}일</font><br>
										<c:if test="${vo.applyDiff > 30}">
											<button type="button" class="btn w3-black btn-sm" onclick="javascript:userDelCheck(${vo.idx})">탈퇴처리</button>
										</c:if> --%>
			  						</c:if> 
			  					</td>
			  					<td>
			  						<c:if test="${vo.del_yn == 'n'}">
				  						<a class="btn btn-secondary btn-sm" href="memUpdate.ad?idx=${vo.idx}&applyDiff=${vo.applyDiff}&pag=${pag}&pageSize=${pageSize}">수정</a>
				  						<a class="btn btn-danger btn-sm" onclick="memDelete(${vo.idx});">탈퇴</a>
			  						</c:if> 
			  					</td>
			  				</tr>
			  			</c:forEach>
			  		</table>
			  	</div>
			  	<br>
			  	<!-- 블록 페이징 처리 시작 -->
				<div class="text-center">
					<ul class="pagination justify-content-center pagination-sm">
					  <c:if test="${pag > 1}">
					  	<li class="page-item"><a class="page-link text-secondary" href="mem_management.ad?pag=1&pageSize=${pageSize}">◁◁</a></li>
					  </c:if>
					  <c:if test="${curBlock > 0}">
					  	<li class="page-item"><a class="page-link text-secondary" href="mem_management.ad?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">◀</a></li>
					  </c:if>
					  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
					    <c:if test="${i <= totPage && i == pag}">
					      <li class="page-item active"><a class="page-link text-light border-secondary bg-secondary" href="mem_management.ad?pag=${i}&pageSize=${pageSize}">${i}</a></li>
					    </c:if>
					    <c:if test="${i <= totPage && i != pag}">
					      <li class="page-item"><a class="page-link text-secondary" href='mem_management.ad?pag=${i}&pageSize=${pageSize}'>${i}</a></li>
					    </c:if>
					  </c:forEach>
					  <c:if test="${curBlock < lastBlock}">
					     <li class="page-item"><a class="page-link text-secondary" href="mem_management.ad?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&pageSize=${pageSize}">▶</a></li>
					  </c:if>
					  <c:if test="${pag != totPage}">
						 <li class="page-item"><a class="page-link text-secondary" href="mem_management.ad?pag=${totPage}&pageSize=${pageSize}">▷▷</a></li>
					  </c:if>
					 </ul>
				</div>
				<!-- 블록 페이징 처리 끝 -->
		  	</div>
	  	<div class="w3-col m2 l2 w3-margin-bottom"></div>
	 </div>
  </section>
	<div style="display:none;">
	<form name="deleteForm" action="memDelete.ad" method="POST">
		<input type="hidden" name="idx" value="">
		<input type="hidden" name="pag" value="${pag}">
		<input type="hidden" name="pageSize" value="${pageSize}">
	 </form>
	</div>
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey text-center">
    <p>Copyright © The Fantastic Lodging. All Rights reserved.</p>
    <p>Happiness & Rest & Peace</p>
  </footer>

  <!-- End page content -->
</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>

</body>
</html>