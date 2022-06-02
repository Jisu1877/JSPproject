<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약내역 상세조회</title>
    <%@ include file="/include/bs4.jsp" %>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
	<script type="text/javascript">
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
		
		function resCancel(lodIdx,memIdx,checkIn,checkOut) {
			let ans = confirm("해당 예약을 취소하시겠습니까?");
			if(!ans) return false;
			
			let query = {
				lodIdx : lodIdx,
				memIdx : memIdx,
				checkIn : checkIn,
				checkOut : checkOut,
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/resCancel.res",
				data : query,
				success : function(data) {
					if(data == "cancelOk") {
						alert("예약취소가 완료되었습니다.");
						location.reload();
					}
					else {
						alert("예약 취소 처리 실패.");

					}
				},
				error : function () {
					alert("전송실패");
				}
			});
		}
		
	</script>
	<style>
		html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
		}
		.title {
			font-weight: bold;
			background-color: rgb(147, 177, 232);
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
<div class="w3-main" style="margin-left:300px; margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    <h5><b><i class="fa-solid fa-calendar-check"></i> Reservation management</b></h5>
  </header>
  <section>
  	<!-- Page Container -->
	<div class="w3-container w3-content" style="max-width:1400px;">    
	  <!-- The Grid -->
	  <div class="w3-row">
	    <!-- Left Column -->
      	<h2 class="text-center"><span>&nbsp;<i class="fa-solid fa-calendar-check"></i> &nbsp;예약 정보 상세조회&nbsp;</span></h2><br>
	    <div class="w3-col m1 l1 w3-margin-bottom"></div>
	    <div class="w3-col m5 l5 w3-margin-bottom">
		      <!-- Profile -->
		      <div class="w3-card w3-round w3-white">
		        <div class="w3-container"><br>
		         <h5>${resVo.lodVo.lod_name}</h5>
		         <p class="w3-center"><img src="${ctp}/data/lodging/${resVo.lodVo.save_file_name}" style="height:300px;"></p>
		         <hr>
		         <table class="table table-borderless">
		         	<colgroup>
						<col style="width:30%;">
						<col style="width:70%;">
					</colgroup>
		         	<tr>
		         		<td class="title">숙소번호</td>
		         		<td>${resVo.lodVo.idx}번</td>
		         	</tr>
		         	<tr>
		         		<td class="title">숙소주소</td>
		         		<td>${resVo.lodVo.address}</td>
		         	</tr>
		         	<tr>
		         		<td class="title">회원 아이디</td>
		         		<td>${resVo.memVo.mid}</td>
		         	</tr>
		         	<tr>
		         		<td class="title">회원 전화번호</td>
		         		<td>
		         			${resVo.memVo.tel}
		         		</td>
		         	</tr>
		         	<tr>
		         		<td class="title">회원 Email</td>
		         		<td>
		         			${resVo.memVo.email}
		         		</td>
		         	</tr>
		         </table>
		        </div>
		      </div>
		      <br>
        </div>  
        
        <!-- Middle Column -->
	    <div class="w3-col m5 l5 w3-margin-bottom">
	      <div class="w3-row-padding">
	        <div class="w3-col m12">
	          <div class="w3-card w3-round w3-white">
	            <div class="w3-container w3-padding">
	            	<table class="table table-borderless">
			         	<colgroup>
							<col style="width:30%;">
							<col style="width:70%;">
						</colgroup>
			         	<tr>
			         		<td class="title">예약번호</td>
			         		<td>${resVo.idx} 번</td>
			         	</tr>
			         	<tr>
			         		<td class="title">체크인 날짜</td>
			         		<td>${resVo.check_in}</td>
			         	</tr>
			         	<tr>
			         		<td class="title">체크아웃 날짜</td>
			         		<td>${resVo.check_out}</td>
			         	</tr>
			         	<tr>
			         		<td class="title">숙박기간</td>
			         		<td>${resVo.term} 일 (${resVo.term -1}박)</td>
			         	</tr>
			         	
			         	<tr>
			         		<td class="title">숙박 인원</td>
			         		<td>${resVo.number_guests} 명</td>
			         	</tr>
			         	<tr>
			         		<td class="title">예약일</td>
			         		<td>
			         			${fn:substring(resVo.create_date, 0, 19)}
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">결제금액</td>
			         		<td>
			         			<fmt:formatNumber value="${resVo.payment_price}"/> 원
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">적립 포인트</td>
			         		<td>
			         			<fmt:formatNumber value="${resVo.point}"/> Point 
			         			<c:if test="${resVo.state == '확정완료'}">(적립완료)</c:if>
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">예약 상태</td>
			         		<td>
			         			<c:if test="${resVo.state == '예약'}"><font color="red">${resVo.state}</font></c:if>
		        				<c:if test="${resVo.state == '사용완료' || resVo.state == '확정완료'}">${resVo.state}</c:if>
		        				<c:if test="${resVo.state == '예약취소'}"><font color="gray">${resVo.state}</font></c:if>
		        				<c:if test="${resVo.state == '사용중'}"><font color="blue">${resVo.state}</font></c:if>
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">리뷰 여부</td>
			         		<td>
			         			<c:if test="${empty resVo.review}">사용완료 전입니다.</c:if>
			         			${resVo.review}
			         		</td>
			         	</tr>
			         </table>
	            </div>
	          </div>
		      
	        </div>
	      </div>
	      <div style="text-align: center" class="mt-3">
	      		<c:if test="${resVo.state == '예약'}">
		            <a class="w3-button w3-black w3-hover-black" onclick="resCancel(${resVo.lodVo.idx},${resVo.mem_idx},'${resVo.check_in}','${resVo.check_out}');"> 예약취소 처리</a> &nbsp;&nbsp;
	      		</c:if>
	            <a href="${ctp}/res_management.ad?pag=${pag}&pageSize=${pageSize}" class="w3-button w3-blue w3-hover-blue"> 목록으로</a> 
	        </div>     
       	</div>  
       	 <div class="w3-col m1 l1 w3-margin-bottom"></div>
      </div>   
     </div>
     <br>
  </section>
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey text-center">
    <p>Copyright © The Fantastic Lodging. All Rights reserved.</p>
    <p>Happiness & Rest & Peace</p>
  </footer>

  <!-- End page content -->
</div>
<div style="display:none;">
	<form name="deleteForm" action="memDelete.ad" method="POST">
		<input type="hidden" name="idx" value="">
		<input type="hidden" name="pag" value="${pag}">
		<input type="hidden" name="pageSize" value="${pageSize}">
	 </form>
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