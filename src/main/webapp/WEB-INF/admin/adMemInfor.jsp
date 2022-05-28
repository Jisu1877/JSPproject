<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adMemInfor.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript">
	
	</script>
	<style>
		html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
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
    <h5><b><i class="fa fa-users fa-fw"></i> Member management</b></h5>
  </header>
  <section>
  	<!-- Page Container -->
	<div class="w3-container w3-content" style="max-width:1400px;">    
	  <!-- The Grid -->
	  <div class="w3-row">
	    <!-- Left Column -->
      	<h2 class="text-center"><i class="fa-solid fa-id-card"></i> 회원 정보 상세조회</h2><br>
	    <div class="w3-col m2 l2 w3-margin-bottom"></div>
	    <div class="w3-col m3 l3 w3-margin-bottom">
		      <!-- Profile -->
		      <div class="w3-card w3-round w3-white">
		        <div class="w3-container"><br>
		         <h4 class="w3-center">Profile Picture</h4>
		         <p class="w3-center"><img src="${ctp}/data/member/${vo.save_file_name}"" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
		         <hr>
		         <table class="table table-borderless">
		         	<colgroup>
						<col style="width:30%;">
						<col style="width:70%;">
					</colgroup>
		         	<tr>
		         		<td>회원번호</td>
		         		<td>${vo.idx}번</td>
		         	</tr>
		         	<tr>
		         		<td>아이디</td>
		         		<td>${vo.mid}</td>
		         	</tr>
		         	<tr>
		         		<td>성명</td>
		         		<td>${vo.name}</td>
		         	</tr>
		         	<tr>
		         		<td>성별</td>
		         		<td>
		         			<c:if test="${vo.gender == 'm'}">남자</c:if>
		         			<c:if test="${vo.gender == 'f'}">여자</c:if>
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
			         		<td>전화번호</td>
			         		<td>${vo.tel}</td>
			         	</tr>
			         	<tr>
			         		<td>Email</td>
			         		<td>${vo.email}</td>
			         	</tr>
			         	<tr>
			         		<td>주소</td>
			         		<td>
			         			${vo.postcode}<br> ${vo.roadAddress}<br>
			         			${vo.detailAddress} | ${vo.extraAddress}
				         	<hr>
			         		</td>
			         	</tr>
			         	<tr>
			         		<td>가입일</td>
			         		<td>
			         			${vo.create_date}
			         		</td>
			         	</tr>
			         	<tr>
			         		<td>최종접속일</td>
			         		<td>
			         			${vo.lastDate}
			         		</td>
			         	</tr>
			         	<tr>
			         		<td>회원등급</td>
			         		<td>
			         			<c:if test="${vo.level == '1'}">정회원</c:if>
			         			<c:if test="${vo.level == '0'}">관리자</c:if>
			         		</td>
			         	</tr>
			         	<tr>
			         		<td>보유 포인트</td>
			         		<td>
			         			${vo.point} Point
			         		</td>
			         	</tr>
			         	<tr>
			         		<td>동의여부</td>
			         		<td>
			         			${vo.agreement}
			         		</td>
			         	</tr>
			         	<tr>
			         		<td>활동여부</td>
			         		<td>
			         			<c:if test="${vo.del_yn == 'y'}">
				         			<font color="red">탈퇴신청</font><br>
				         			경과일 : <font color="blue"> ${applyDiff}일</font><br>
									<c:if test="${applyDiff > 30}">
										<button type="button" class="btn w3-black btn-sm" onclick="javascript:userDelCheck(${vo.idx})">탈퇴처리</button>
									</c:if>
									탈퇴신청일 : ${vo.delete_date}
			         			</c:if>
			         			<c:if test="${vo.del_yn == 'n'}">활동중</c:if>
			         		</td>
			         	</tr>
			         </table>
			      <div style="text-align: center">
		              <button type="button" class="w3-button w3-theme"> 회원정보 수정</button> &nbsp;&nbsp;
		              <button type="button" class="w3-button w3-theme"> 탈퇴처리</button> 
		          </div>
	            </div>
	          </div>
	        </div>
	      </div>
       	</div>  
       	 <div class="w3-col m2 l2 w3-margin-bottom"></div>
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