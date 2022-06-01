<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지</title>
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
		text-decoration: none;	
	}
</style>
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
    <h5><b><i class="fa fa-dashboard"></i> Dashboard</b></h5>
  </header>

  <div class="w3-row-padding w3-margin-bottom">
    <div class="w3-quarter">
    	<a href="${ctp}/lod_management.ad">
	      <div class="w3-container w3-lime w3-padding-16">
	        <div class="w3-left w3-text-white"><i class="fa-solid fa-tents w3-xxxlarge"></i></div>
	        <div class="w3-right  w3-text-white">
	          <h3>${lodCnt}</h3>
	        </div>
	        <div class="w3-clear"></div>
	        <h4 class="w3-text-white">Lodging</h4>
	      </div>
	    </a>
    </div>
    <div class="w3-quarter">
    	<a href="${ctp}/">
	      <div class="w3-container w3-blue w3-padding-16">
	        <div class="w3-left"><i class="fa-solid fa-calendar-check w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h3>${resCnt}</h3>
	        </div>
	        <div class="w3-clear"></div>
	        <h4>Reservation</h4>
	      </div>
	    </a>
    </div>
    <div class="w3-quarter">
    	<a href="${ctp}/">
	      <div class="w3-container w3-teal w3-padding-16">
	        <div class="w3-left"><i class="fa-solid fa-file-pen w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h3>${revCnt}</h3>
	        </div>
	        <div class="w3-clear"></div>
	        <h4>Review</h4>
	      </div>
	    </a>
    </div>
    <div class="w3-quarter">
    	<a href="${ctp}/mem_management.ad">
	      <div class="w3-container w3-orange w3-text-white w3-padding-16">
	        <div class="w3-left"><i class="fa fa-users w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h3>${memCnt}</h3>
	        </div>
	        <div class="w3-clear"></div>
	        <h4>Member</h4>
	      </div>
	    </a>
    </div>
  </div>

  <div class="w3-panel">
    <div class="w3-row-padding" style="margin:0 -16px">
      <div class="w3-third">
        <h5><strong>신규회원</strong></h5>
        <table class="table">
        	<tr class="w3-amber">
        		<td class="text-center">번호</td>
        		<td class="text-center">아이디</td>
        		<td class="text-center">가입일</td>
        	</tr>
	        <c:forEach var="memVo" items="${memList}" begin="1" end="5" step="1">
	        	<tr>
	        		<td class="text-center">${memVo.idx}</td>
	        		<td class="text-center">${memVo.mid}</td>
	        		<td class="text-center">${fn:substring(memVo.create_date,0,19)}</td>
	        	</tr>
	        </c:forEach>
        </table>
      </div>
      <div class="w3-twothird">
        <h5><strong>최신 예약현황</strong></h5>
        <table class="w3-table w3-striped w3-white">
          <tr class="w3-blue" style="height: 47px;">
          	<td style="padding-top: 13px;">고객번호</td>
          	<td style="padding-top: 13px;">숙소명</td>
          	<td style="padding-top: 13px;">결제금액</td>
          	<td style="padding-top: 13px;">상태</td>
          </tr>
          <c:forEach var="resVo" items="${resList}" begin="1" end="6" step="1">
          	<tr>
	          	<td class="text-center">${resVo.mem_idx}</td>
	          	<td>${resVo.lodVo.lod_name}</td>
	          	<td><fmt:formatNumber value="${resVo.payment_price}"/>원</td>
	          	<td>
	          		<c:if test="${resVo.state == '예약'}"><font color="red">${resVo.state}</font></c:if>
       				<c:if test="${resVo.state == '사용완료' || resVo.state == '확정완료'}">${resVo.state}</c:if>
       				<c:if test="${resVo.state == '예약취소'}"><font color="gray">${resVo.state}</font></c:if>
       				<c:if test="${resVo.state == '사용중'}"><font color="blue">${resVo.state}</font></c:if>
	          	</td>
          	</tr>
          </c:forEach>
        </table>
      </div>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5 style="font-size: 25px;">BEST Lodging</h5>
    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
      <tr>
        <td>분류</td>
        <td>숙소명</td>
        <td>주소</td>
        <td>예약된 횟수</td>
      </tr>
     <c:forEach var="bestlod" items="${BestlodList}">
     	<tr>
     		<td>
     			<c:if test="${bestlod.detail_category_code == 300}">최고의 전망</c:if>
     			<c:if test="${bestlod.detail_category_code == 301}">디자인</c:if>
     			<c:if test="${bestlod.detail_category_code == 302}">해변근처</c:if>
     			<c:if test="${bestlod.detail_category_code == 303}">캠핑장</c:if>
     			<c:if test="${bestlod.detail_category_code == 304}">돔하우스</c:if>
     			<c:if test="${bestlod.detail_category_code == 305}">동굴</c:if>
     			<c:if test="${bestlod.detail_category_code == 306}">서핑</c:if>
     			<c:if test="${bestlod.detail_category_code == 307}">호숫가</c:if>
     			<c:if test="${bestlod.detail_category_code == 308}">한적한 시골</c:if>
     			<c:if test="${bestlod.detail_category_code == 309}">열대지역</c:if>
     			<c:if test="${bestlod.detail_category_code == 310}">멋진 수영장</c:if>
     			<c:if test="${bestlod.detail_category_code == 311}">캐슬</c:if>
     			<c:if test="${bestlod.detail_category_code == 312}">북극</c:if>
     		</td>
     		<td>${bestlod.lod_name}</td>
     		<td>${bestlod.address}</td>
     		<td>${bestlod.cnt}</td>
     	</tr>
     </c:forEach>
    </table><br>
    <button class="w3-button w3-dark-grey" onclick="location.href='${ctp}/lod_input.ad?pag=1&pageSize=10';">숙소 등록하러가기  <i class="fa fa-arrow-right"></i></button>
  </div>
  <hr>

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
