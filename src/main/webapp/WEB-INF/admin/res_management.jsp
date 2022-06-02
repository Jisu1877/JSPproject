<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>예약 관리 페이지</title>
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
<script>
	'use strict';
	function pageCheck() {
		let pageSize = $("#pageSize").val();
		location.href="res_management.ad?pag=${pag}&pageSize="+pageSize;
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
<div class="w3-main" style="margin-left:280px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px; margin-left: 20px;">
    <h5><b><i class="fa-solid fa-calendar-check"></i> Reservation management</b></h5>
  </header>
  <section>
  	<div class="w3-row">
	  	<div class="w3-col m1 l1 w3-margin-bottom"></div>
	  	<div class="w3-col m10 l10 w3-margin-bottom">
  			<h2 class="text-center"><i class="fa-solid fa-calendar-check"></i> 예약 관리</h2>
	  		<table class="table table-borderless">
		  		<tr>
		  			<td class="text-right" style="margin-bottom: 0px; padding-bottom: 0px">
						<select name="pageSize" id="pageSize" onchange="pageCheck()">
							<option value="5" ${pageSize == 5 ? 'selected' : '' }>5건</option>
							<option value="10" ${pageSize == 10 ? 'selected' : '' }>10건</option>
							<option value="15" ${pageSize == 15 ? 'selected' : '' }>15건</option>
							<option value="20" ${pageSize == 20 ? 'selected' : '' }>20건</option>
						</select>
		  			</td>
		  		</tr>
		  	</table>
		  	<table class="table table-hover text-center w3-white">
				<tr class="w3-blue">
					<th>예약번호</th>
					<th>숙소번호</th>
					<th>회원아이디</th>
					<th>체크인</th>
					<th>체크아웃</th>
					<th>예약일</th>
					<th>상태</th>
					<th>비고</th>
				</tr>
				<c:forEach var="res" items="${resList}">
					<tr>
						<td>${res.idx}</td>
						<td>
							${res.lod_idx}
						</td>
						<td>${res.memVo.mid}</td>
						<td>
							<font color="green"><b>${res.check_in}</b></font>
						</td>
						<td>
							<font color="rgb(2, 105, 2)"><b>${res.check_out}</b></font>
						</td>
						<td>
							${fn:substring(res.create_date,0,11)}
						</td>
						<td>
							<c:if test="${res.state == '예약'}"><font color="red">${res.state}</font></c:if>
	        				<c:if test="${res.state == '사용완료' || res.state == '확정완료'}">${res.state}</c:if>
	        				<c:if test="${res.state == '예약취소'}"><font color="gray">${res.state}</font></c:if>
	        				<c:if test="${res.state == '사용중'}"><font color="blue">${res.state}</font></c:if>
						</td>
						<td>
							<a href="adResInfor.ad?memIdx=${res.mem_idx}&lodIdx=${res.lod_idx}&checkIn=${res.check_in}&checkOut=${res.check_out}&pag=${pag}&pageSize=${pageSize}" class="btn btn-outline-dark btn-sm">조회</a>
						</td>
					</tr>
				</c:forEach>
		  	</table>
		  	<br>
		  	<!-- 블록 페이징 처리 시작 -->
			<div class="text-center">
				<ul class="pagination justify-content-center pagination-sm">
				  <c:if test="${pag > 1}">
				  	<li class="page-item"><a class="page-link text-secondary" href="res_management.ad?pag=1&pageSize=${pageSize}">◁◁</a></li>
				  </c:if>
				  <c:if test="${curBlock > 0}">
				  	<li class="page-item"><a class="page-link text-secondary" href="res_management.ad?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">◀</a></li>
				  </c:if>
				  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
				    <c:if test="${i <= totPage && i == pag}">
				      <li class="page-item active"><a class="page-link text-light border-secondary bg-secondary" href="res_management.ad?pag=${i}&pageSize=${pageSize}">${i}</a></li>
				    </c:if>
				    <c:if test="${i <= totPage && i != pag}">
				      <li class="page-item"><a class="page-link text-secondary" href='res_management.ad?pag=${i}&pageSize=${pageSize}'>${i}</a></li>
				    </c:if>
				  </c:forEach>
				  <c:if test="${curBlock < lastBlock}">
				     <li class="page-item"><a class="page-link text-secondary" href="res_management.ad?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&pageSize=${pageSize}">▶</a></li>
				  </c:if>
				  <c:if test="${pag != totPage}">
					 <li class="page-item"><a class="page-link text-secondary" href="res_management.ad?pag=${totPage}&pageSize=${pageSize}">▷▷</a></li>
				  </c:if>
				 </ul>
			</div>
			<!-- 블록 페이징 처리 끝 -->
	  	</div>
	  	<div class="w3-col m1 l1 w3-margin-bottom"></div>
	 </div>
  </section>
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