<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n");  %>
<% 
	Date today = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("YYYY-MM-dd");
	pageContext.setAttribute("today", sf.format(today));
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
	  	.headerJoin {
	  		font-size: 50px;
	        color: black;
	        font-weight: bolder;
	        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
	        margin-top: 50px;
	        margin-bottom: 50px;
	  	}
	  	.tableStyle {
	  		width:100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  	}
	  	a {
	  		color : black;
	  	}
    </style>
    <script>
    	function stateChange(lodIdx,memIdx,checkIn,checkOut,flag) {
    		if(flag == 0) {
				let ans = confirm("해당 예약을 취소하시겠습니까?");
				if(!ans) return false;
    		}
    		else {
    			let ans = confirm("해당 예약을 구매확정하시겠습니까?");
				if(!ans) return false;
    		}
			
			let query = {
				lodIdx : lodIdx,
				memIdx : memIdx,
				checkIn : checkIn,
				checkOut : checkOut,
				flag : flag
			}
			$.ajax({
				type : "post",
				url : "${ctp}/stateChange.res",
				data : query,
				success : function(data) {
					if(data == "cancelOk") {
						alert("예약취소가 완료되었습니다.");
						location.reload();
					}
					else if(data == "confirmationOk") {
						alert("구매확정이 완료되었습니다.");
						location.reload();
						/* let ans = confirm("리뷰 작성 창으로 이동하시겠습니까?\n리뷰작성시 500Point가 적립됩니다.");
						if(!ans) {
							location.reload();
						}else {
							location.href="${ctp}/writeAreview.lod?lodIdx="+lodIdx+"&memIdx="+memIdx+"&checkIn="+checkIn+"&checkOut="+checkOut+"&lod_name=${resVo.lodVo.lod_name}";
						}  */
					}
					else if(data == "cancelNo") {
						alert("예약 취소 처리 실패.");
					}
					else {
						alert("구매확정 처리 실패.");
					}
				},
				error : function () {
					alert("전송실패");
				}
			});
		}
    	
    	function reviewDel(idx) {
    		let ans = confirm("해당 리뷰를 삭제하시겠습니까?");
    		if(!ans) return false;
    		
    		$.ajax({
				type : "post",
				url : "${ctp}/reviewDel.lod",
				data : {idx : idx},
				success : function(data) {
					if(data == "reviewDelOk") {
						alert("리뷰가 삭제되었습니다.");
						location.reload();
					}
					else {
						alert("리뷰 삭제 처리 실패.");
					}
				},
				error : function () {
					alert("전송실패");
				}
			});
    		
    	}
    	
    	function memDelete(idx) {
			let ans = confirm("정말로 탈퇴하시겠습니까?\n탈퇴 후 현재 아이디로는 재가입이 불가합니다.");
			if(!ans) return false;
			
			deleteForm.submit();
		}
    	
    	function resInfor(memIdx, lodIdx, checkIn, checkOut) {
    		let url = "${ctp}/resInfor.res?memIdx="+memIdx+"&lodIdx="+lodIdx+"&checkIn="+checkIn+"&checkOut="+checkOut;
      		let winX = 1300;
            let winY = 700;
            let x = (window.screen.width/2) - (winX/2);
            let y = (window.screen.height/2) - (winY/2)
   			window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		}
    </script>
</head>
<body>
<%@ include file="/include/nav2.jsp" %>

<!-- Page Container -->
<div class="w3-content w3-margin-top" style="max-width:1400px;">
	<h2 class="headerJoin text-center">MyPage</h2>
  <!-- The Grid -->
  <div class="w3-row-padding">
  
    <!-- Left Column -->
    <div class="w3-third">
    
      <div class="w3-white w3-card-4">
        <div class="w3-display-container">
          <img src="${ctp}/data/member/${vo.save_file_name}" style="width:100%" alt="Avatar">
          <div class="w3-display-bottomright w3-container w3-text-black">
            <h4 class="w3-white"><b>${vo.mid}</b></h4>
          </div>
        </div>
        <div class="w3-container"><br>
        	<div style="font-size: 15px;">
	          <p><i class="fa-solid fa-user-tag w3-margin-right w3-large"></i>${vo.name}</p>
	          <p><i class="fa fa-phone fa-fw w3-margin-right w3-large"></i>${vo.tel}</p>
	          <p><i class="fa fa-envelope fa-fw w3-margin-right w3-large"></i>${vo.email}</p>
	          <p><i class="fa fa-home fa-fw w3-margin-right w3-large"></i>
	          	<c:if test="${!empty vo.postcode}">
	      			${vo.postcode} | ${vo.roadAddress}
	      			${vo.detailAddress} | ${vo.extraAddress}
	     		</c:if>
	    		<c:if test="${empty vo.postcode}">미입력</c:if>
	          </p>
	          <p><i class="fa-solid fa-person"></i><i class="fa-solid fa-person-dress w3-margin-right"></i>
	          	<c:if test="${vo.gender == 'm'}">남자</c:if>
	          	<c:if test="${vo.gender == 'f'}">여자</c:if>
	          </p>
	        </div>
          <hr>

          <p class="w3-large">
          	<b><i class="fa-solid fa-circle-dollar-to-slot w3-margin-right w3-text-amber"></i>보유 포인트</b>
          	<c:set var="point" value="${vo.point}"></c:set>
			<div style="font-size:25px;">
				<strong><fmt:formatNumber value="${point}"/>Point</strong>
			</div>
          </p>
          <hr>
          
          <div style="font-size: 15px;" class="w3-text-grey">
	          <p>등급&nbsp;&nbsp; | &nbsp;&nbsp;
	          	<c:if test="${vo.level == '1'}">정회원</c:if>
       			<c:if test="${vo.level == '0'}">관리자</c:if>
	          </p>
	          <p>가입일&nbsp;&nbsp; | &nbsp;&nbsp;${fn:substring(vo.create_date, 0,19)}</p>
	          <div class="w3-row">
	          	<div class="w3-half text-right mt-5">
	          		<a href="${ctp}/memUpdate.mem?idx=${vo.idx}" class="w3-button w3-black w3-hover-theme">정보수정</a>&nbsp;&nbsp;
	          	</div>
	          	<form name="deleteForm" method="post" action="memDelete.mem">
		          	<div class="w3-half text-left mt-5">
		          		<button type="button" onclick="memDelete();" class="w3-button w3-black w3-hover-black">회원탈퇴</button>
		          	</div>
		          	<input type="hidden" name="idx" value="${vo.idx}"/>
	          	</form>
	          </div>
	      </div>
          <br>
     
        </div>
      </div><br>

    <!-- End Left Column -->
    </div>

    <!-- Right Column -->
    <div class="w3-twothird">
    
      <div class="w3-container w3-card w3-white w3-margin-bottom">
        <div class="w3-padding-16">
	        <i class="fa-solid fa-person-walking-luggage w3-margin-right w3-text-amber" style="font-size:30px;"></i><span style="font-size:30px;">Reservation List</span>
	        &nbsp;&nbsp;<span style="font-size:0.9em; color:grey; margin-top:0px"><i class="fa-solid fa-circle-exclamation"></i> 구매확정을 진행하시면 구매포인트가 적립됩니다.😊 리뷰작성시 500Point 추가지급❤️!</span>
        </div>
        <div class="w3-responsive tableStyle">
        <form name="myForm" method="post" action="">
	        <table class="w3-table w3-striped w3-bordered" style="width:auto;">
	        	<tr>
	        		<th class="text-center">✔</th>
	        		<th class="text-center">예약번호</th>
	        		<th class="text-center">숙소명</th>
	        		<th class="text-center">체크인</th>
	        		<th class="text-center">체크아웃</th>
	        		<th class="text-center">숙박인원</th>
	        		<th class="text-center">결제금액</th>
	        		<th class="text-center">상태</th>
	        	</tr>
	        	<fmt:parseDate var="todayDate" value="${today}" pattern="yyyy-MM-dd"/>
	        	<fmt:parseNumber var="nowNum" value="${todayDate.time / (1000*60*60*24)}" integerOnly="true"/>
	        	<c:forEach var="resVo" items="${resList}">
	        		<tr>
	        			<td class="text-center">
	        				<fmt:parseDate var="checkInDate" value="${resVo.check_in}" pattern="yyyy-MM-dd"/>
	        				<fmt:parseNumber var="checkInNum" value="${checkInDate.time / (1000*60*60*24)}" integerOnly="true"/>
	        				<c:choose>
	        					<c:when test="${checkInNum - nowNum >= 7 && resVo.cancel_yn == 'n'}">
		        					<input type="button" class="btn btn-outline-dark btn-sm" onclick="stateChange(${resVo.lodVo.idx},${mIdx},'${resVo.check_in}','${resVo.check_out}',0)" value="예약취소">
	        					</c:when>
	        					<c:when test="${checkInNum - nowNum < 7 && resVo.check_out > today && resVo.cancel_yn == 'n'}">
		        					<input type="button" class="btn btn-danger btn-sm" value="취소불가" disabled>
	        					</c:when>
	        					<c:when test="${resVo.cancel_yn == 'y'}">
		        					<input type="button" class="btn btn-secondary btn-sm" value="취소완료" disabled>
	        					</c:when>
	        					<c:otherwise>
	        						<c:choose>
				        				<c:when test="${resVo.check_in < today && resVo.state == '사용완료'}">
				        					<input type="button" class="btn btn-warning btn-sm" onclick="stateChange(${resVo.lodVo.idx},${mIdx},'${resVo.check_in}','${resVo.check_out}',1)" value="구매확정">
				        				</c:when>
				        				<c:when test="${resVo.review == '필요'}">
				        					<input type="button" class="btn btn-success btn-sm" onclick="location.href='${ctp}/writeAreview.lod?lodIdx=${resVo.lodVo.idx}&memIdx=${mIdx}&checkIn=${resVo.check_in}&checkOut=${resVo.check_out}&lod_name=${resVo.lodVo.lod_name}'" value="리뷰작성">
				        				</c:when>
				        				<c:otherwise>
				        					<input type="button" class="btn btn-light btn-sm" value="작성완료" disabled>		
				        				</c:otherwise>
			        				</c:choose>
	        					</c:otherwise>
	        				</c:choose>
	        			</td>
	        			<td class="text-center">${resVo.idx}</td>
	        			<td>
	        				<a href="javascript:resInfor(${vo.idx},${resVo.lodVo.idx},'${resVo.check_in}','${resVo.check_out}')">
	        					${resVo.lodVo.lod_name}
	        				</a>
	        			</td>
	        			<td>${resVo.check_in}</td>
	        			<td>${resVo.check_out}</td>
	        			<td class="text-center">${resVo.number_guests} 명</td>
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
	        <div style="font-size:0.9em; color:grey; margin-top:8px"><i class="fa-solid fa-circle-exclamation"></i> 체크인 날짜로부터 일주일 전까지만 취소가 가능하며,<font color="red"> 예약취소시 사용한 포인트는 재적립 되지 않습니다.</font></div>
	    </form>
        <p><br></p>
        </div>
      </div>
      <div class="w3-container w3-card w3-white">
        <h2 class="w3-text-black w3-padding-16"><i class="fa fa-certificate fa-fw w3-margin-right w3-xxlarge w3-text-amber"></i>Review</h2>
       		<c:forEach var="review" items="${reviewList}">
       			<div class="w3-container">
       				<div class="w3-row mb-2">
	       				<div class="w3-opacity">
	       					<div class="w3-third">
	       						<b>숙소명 : </b> ${review.lodVo.lod_name} &nbsp;&nbsp;
	       					</div>
	       					<div class="w3-third text-right">
	       						<b>작성일 : </b> ${fn:substring(review.create_date, 0,19)}
	       					</div> 
	       					<div class="w3-third text-right">
	       						<button class="btn w3-button w3-small w3-black" onclick="reviewDel(${review.idx});">삭제하기</button>
	       					</div> 
	       				</div>
	       			</div>
       				<div class="w3-row">
       					<div class="w3-half mb-1">
       						<div style="font-size: 18px; color:orange">${review.review_subject}</div>
       					</div> 
       					<div class="w3-half">
       						<i class="fa-solid fa-star w3-text-amber"></i> 평점 : 
	       					 <c:if test="${review.rating == 5}">★★★★★</c:if> 
	       					 <c:if test="${review.rating == 4}">★★★★</c:if> 
	       					 <c:if test="${review.rating == 3}">★★★</c:if> 
	       					 <c:if test="${review.rating == 2}">★★</c:if> 
	       					 <c:if test="${review.rating == 1}">★</c:if> 
       					</div>
	       			</div>
	       			<div id="moreCont">
	       				<c:if test="${fn:indexOf(review.review_contents,newLine) != -1}">${fn:replace(review.review_contents,newLine,"<br>")}</c:if>
			  		    <c:if test="${fn:indexOf(review.review_contents,newLine) == -1}">${review.review_contents}</c:if>
	       			</div>
       				<hr>
      				</div>
       		</c:forEach>
      </div>
    <!-- End Right Column -->
    </div>
    
  <!-- End Grid -->
  </div>
  
  <!-- End Page Container -->
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>