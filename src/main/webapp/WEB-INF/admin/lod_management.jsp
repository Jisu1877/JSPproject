<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>숙소 관리 페이지</title>
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
		location.href="lod_management.ad?pag=${pag}&pageSize="+pageSize;
	}
	
	function lodDelete(lodIdx) {
		let ans = confirm("해당 숙소를 정말 판매중지하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
   			type : "post",
   			url : "${ctp}/lodDeleteCommand",
   			data : {lodIdx : lodIdx},
   			success : function(data) {
   				if(data == "exist") {
   					alert("아직 사용되지 않은 예약내역이 있는 숙소입니다.\n모든 예약이 완료된 이후에 진행하세요.");
   					return false;
   				}
   				else if(data == "deleteOk") {
					alert("판매중지처리 완료.");
					location.reload();
				}
				else {
					alert("숙소 판매중지 처리에 실패했습니다.");
				}
   			},
			error : function() {
				alert("전송오류.");
			}
   		});
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
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    <h5><b><i class="fa-solid fa-tents"></i> Lodging management</b></h5>
  </header>
  <section>
  	<div class="w3-row">
	  	<div class="w3-col m1 l1 w3-margin-bottom"></div>
	  	<div class="w3-col m10 l10 w3-margin-bottom">
  			<h2 class="text-center"><i class="fa-solid fa-tents"></i> 숙소 관리</h2>
	  		<table class="table table-borderless">
		  		<tr>
		  			<td class="text-right" style="margin-bottom: 0px; padding-bottom: 0px">
						<select name="pageSize" id="pageSize" onchange="pageCheck()">
							<option value="5" ${pageSize == 5 ? 'selected' : '' }>5건</option>
							<option value="10" ${pageSize == 10 ? 'selected' : '' }>10건</option>
							<option value="15" ${pageSize == 15 ? 'selected' : '' }>15건</option>
							<option value="20" ${pageSize == 20 ? 'selected' : '' }>20건</option>
						</select>
				  		&nbsp;&nbsp;&nbsp;<button class="w3-btn w3-theme" onclick="location.href='${ctp}/lod_input.ad';">숙소등록</button>
		  			</td>
		  		</tr>
		  	</table>
		  	<table class="table table-hover text-center">
				<tr class="w3-lime">
					<th>번호</th>
					<th>숙소명</th>
					<th>등록일</th>
					<th>상태</th>
					<th>비고</th>
				</tr>
				<c:forEach var="vo" items="${lodList}">
					<tr>
						<td>${vo.idx}</td>
						<td>
							<a href="${ctp}/lodInfor.ad?lodIdx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.lod_name}</a>
						</td>
						<td>${fn:substring(vo.create_date, 0, 19)}</td>
						<td>
							<c:if test="${vo.del_yn == 'y'}"><font color="red">판매중지</font></c:if>
							<c:if test="${vo.del_yn == 'n'}">판매중</c:if>
						</td>
						<td>
							<c:if test="${vo.del_yn == 'n'}">
								<a class="btn btn-outline-secondary btn-sm" href="lodUpdate.ad?lodIdx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">수정</a>
		  						<a class="btn btn-outline-danger btn-sm" onclick="lodDelete(${vo.idx});">판매중지</a>
	  						</c:if>
						</td>
					</tr>
				</c:forEach>
		  	</table>
		  	<br>
		  	<!-- 블록 페이징 처리 시작 -->
			<div class="text-center">
				<ul class="pagination justify-content-center pagination-sm">
				  <c:if test="${pag > 1}">
				  	<li class="page-item"><a class="page-link text-secondary" href="lod_management.ad?pag=1&pageSize=${pageSize}">◁◁</a></li>
				  </c:if>
				  <c:if test="${curBlock > 0}">
				  	<li class="page-item"><a class="page-link text-secondary" href="lod_management.ad?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">◀</a></li>
				  </c:if>
				  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
				    <c:if test="${i <= totPage && i == pag}">
				      <li class="page-item active"><a class="page-link text-light border-secondary bg-secondary" href="lod_management.ad?pag=${i}&pageSize=${pageSize}">${i}</a></li>
				    </c:if>
				    <c:if test="${i <= totPage && i != pag}">
				      <li class="page-item"><a class="page-link text-secondary" href='lod_management.ad?pag=${i}&pageSize=${pageSize}'>${i}</a></li>
				    </c:if>
				  </c:forEach>
				  <c:if test="${curBlock < lastBlock}">
				     <li class="page-item"><a class="page-link text-secondary" href="lod_management.ad?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&pageSize=${pageSize}">▶</a></li>
				  </c:if>
				  <c:if test="${pag != totPage}">
					 <li class="page-item"><a class="page-link text-secondary" href="lod_management.ad?pag=${totPage}&pageSize=${pageSize}">▷▷</a></li>
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