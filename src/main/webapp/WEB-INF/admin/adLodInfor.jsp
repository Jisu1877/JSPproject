<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n");  %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소정보 상세조회</title>
    <%@ include file="/include/bs4.jsp" %>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
	<script type="text/javascript">
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
		
		function moreContent() {
			document.getElementById("main").style.display = "none";
			document.getElementById("more").style.display = "none";
			document.getElementById("sub").style.display = "block";
		}
		
		function closeContent() {
			document.getElementById("main").style.display = "block";
			document.getElementById("more").style.display = "block";
			document.getElementById("sub").style.display = "none";
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
			background-color: rgb(228, 228, 228);
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
     <h5><b><i class="fa-solid fa-tents"></i> Lodging management</b></h5>
  </header>
  <section>
  	<!-- Page Container -->
	<div class="w3-container w3-content" style="max-width:1400px;">    
	  <!-- The Grid -->
	  <div class="w3-row">
	    <!-- Left Column -->
      	<h2 class="text-center" ><span>&nbsp;<i class="fa-solid fa-tents"></i> &nbsp;숙소 정보 상세조회&nbsp;</span></h2><br>
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
			         		<td class="title">숙소 고유번호</td>
			         		<td>${lodVo.idx}</td>
			         	</tr>
			         	<tr>
			         		<td class="title">대분류(지역)</td>
			         		<td>
			         			<c:if test="${lodVo.category_code == 100}">유럽</c:if> 
			         			<c:if test="${lodVo.category_code == 101}">아시아</c:if> 
			         			<c:if test="${lodVo.category_code == 102}">미국</c:if> 
			         			<c:if test="${lodVo.category_code == 103}">프랑스</c:if> 
			         			<c:if test="${lodVo.category_code == 104}">이탈리아</c:if> 
			         			<c:if test="${lodVo.category_code == 105}">기타</c:if> 
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">중분류(크기)</td>
			         		<td>
			         			<c:if test="${lodVo.sub_category_code == 200}">대형(침실 5개이상)</c:if> 
			         			<c:if test="${lodVo.sub_category_code == 201}">중형(침실 2개이상)</c:if> 
			         			<c:if test="${lodVo.sub_category_code == 202}">소형(침실 1개)</c:if> 
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">소분류(특성)</td>
			         		<td>
			         			<c:if test="${lodVo.detail_category_code == 300}">최고의 전망</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 301}">디자인</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 302}">해변근처</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 303}">캠핑장</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 304}">돔하우스</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 305}">동굴</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 306}">서핑</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 307}">호숫가</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 308}">한적한시골</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 309}">열대지역</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 310}">통나무집</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 311}">멋진 수영장</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 312}">캐슬</c:if> 
			         			<c:if test="${lodVo.detail_category_code == 313}">북극</c:if> 
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">숙소명</td>
			         		<td>${lodVo.lod_name}</td>
			         	</tr>
			         	<tr>
			         		<td class="title">숙소위치(국가)</td>
			         		<td>${lodVo.country}</td>
			         	</tr>
			         	<tr>
			         		<td class="title">숙박가능인원</td>
			         		<td>${lodVo.number_guests} 명</td>
			         	</tr>
			         	<tr>
			         		<td class="title">주소</td>
			         		<td>
			         			${lodVo.address}
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">숙소설명</td>
			         		<td>
			         			<div id="shortCont">
				         			${fn:substring(lodVo.explanation, 0, 15)}
				         			<c:if test="${fn:length(lodVo.explanation) > 14}">
								    ...<span style="text-decoration: underline;" class="more"><button type="button" class="btn btn-dark btn-sm" data-toggle="modal" data-target="#myModal">더보기</button></span>
								    </c:if>
							    </div>
							    <!-- The Modal -->
								  <div class="modal fade" id="myModal">
								    <div class="modal-dialog">
								      <div class="modal-content">
								      
								        <!-- Modal Header -->
								        <div class="modal-header">
								          <h4 class="modal-title">숙소 상세 설명</h4>
								          <button type="button" class="close" data-dismiss="modal">&times;</button>
								        </div>
								        
								        <!-- Modal body -->
								        <div class="modal-body">
								          <c:if test="${fn:indexOf(lodVo.explanation,newLine) != -1}">${fn:replace(lodVo.explanation,newLine,"<br>")}</c:if>
								  		  <c:if test="${fn:indexOf(lodVo.explanation,newLine) == -1}">${lodVo.explanation}</c:if>
								        </div>
								        
								        <!-- Modal footer -->
								        <div class="modal-footer">
								          <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
								        </div>
								        
								      </div>
								    </div>
								  </div>
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">숙소 등록일</td>
			         		<td>
			         			${fn:substring(lodVo.create_date, 0, 19)}
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">상태</td>
			         		<td>
			         			<c:if test="${lodVo.del_yn == 'y'}"><font color="red">판매중지</font></c:if>
								<c:if test="${lodVo.del_yn == 'n'}">판매중</c:if>
			         		</td>
			         	</tr>
			         	<tr>
			         		<td class="title">평점평균</td>
			         		<td>
			         			<i class="fa-solid fa-star" style="font-size: 13px;"><span style="font-size: 13px;"> ${lodVo.rating}&nbsp;/&nbsp;5점</span></i>
			         		</td>
			         	</tr>
			         </table>
	            </div>
	          </div>
	        </div>
	      </div>
	      <div style="text-align: center" class="mt-3">
	      		<c:if test="${lodVo.del_yn == 'n'}">
		            <a class="w3-button w3-black w3-hover-black" href="lodUpdate.ad?lodIdx=${param.lodIdx}&pag=${param.pag}&pageSize=${param.pageSize}"> 숙소정보 수정</a> &nbsp;&nbsp;
		            <a class="w3-button w3-black w3-hover-black" onclick="lodDelete(${lodVo.idx});"> 판매중지</a> &nbsp;&nbsp;
	            </c:if>
	            <a href="${ctp}/lod_management.ad?pag=${param.pag}&pageSize=${param.pageSize}" class="w3-button w3-theme w3-hover-yellow"> 목록으로</a> 
	        </div>     
       	</div>  
       	 <div class="w3-col m7 l7 w3-margin-bottom">
       	 	  <div class="w3-row-padding w3-text-white w3-large">
		      <div class="w3-display-container" id="main">
		        <img src="${ctp}/data/lodging/${lodVo.save_file_name}" alt="Cinque Terre" style="width:100%">
		        <span class="w3-display-bottomleft w3-padding" style="background-color: black;">메인 사진</span>
		      </div>
		      <c:if test="${fileList.size() >= 1}">
		      	<div id="more"><a href="javascript:moreContent();" style="color:black"><b> More</b> 👇</a></div>
		      </c:if>
			    <div class="w3-row-padding w3-text-white w3-large" id="sub" style="display: none">
			      <c:forEach var="fileVo" items="${fileList}" varStatus="st">
			      	<div class="w3-row-padding" style="margin:0 -16px">
			      		<div class="w3-margin-bottom">
				          <div class="w3-display-container">
				            <img src="${ctp}/data/lodging/${fileVo.save_file_name}" style="width:100%">
				          </div>
				        </div>
			      	</div>
			      </c:forEach>
			      <div id="more"><a href="javascript:closeContent();" style="color:black"><b> close</b> 👆</a></div>
			    </div>
			  </div>
       	 </div>
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