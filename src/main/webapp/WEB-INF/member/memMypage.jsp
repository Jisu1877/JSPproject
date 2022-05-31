<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>MyPage</title>
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
    </style>
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
	          <div class="text-center mt-5">
	          	<button type="button" class="w3-button w3-black w3-hover-black">정보수정</button>&nbsp;&nbsp;
	          	<button type="button" class="w3-button w3-black w3-hover-black">회원탈퇴</button>
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
	        &nbsp;&nbsp;<span style="font-size:0.9em; color:grey; margin-top:0px"><i class="fa-solid fa-circle-exclamation"></i> 구매확정 후 리뷰작성시 포인트가 적립됩니다.</span>
        </div>
        <div class="w3-responsive tableStyle">
        <form name="myForm" method="post" action="">
	        <table class="w3-table w3-striped w3-bordered" style="width:auto;">
	        	<tr>
	        		<th></th>
	        		<th class="text-center">예약번호</th>
	        		<th class="text-center">숙소명</th>
	        		<th class="text-center">체크인</th>
	        		<th class="text-center">체크아웃</th>
	        		<th class="text-center">숙박인원</th>
	        		<th class="text-center">결제금액</th>
	        		<th class="text-center">상태</th>
	        	</tr>
	        	<c:forEach var="resVo" items="${resList}">
	        		<tr>
	        			<td class="text-center">
	        				<c:if test="${resVo.check_in > today}">
	        					<input type="button" class="btn btn-dark btn-sm" value="예약취소">
	        				</c:if>
	        				<c:if test="${resVo.check_out < today}">
	        					<input type="button" class="btn btn-warning btn-sm" value="구매확정">
	        				</c:if>
	        			</td>
	        			<td class="text-center">${resVo.idx}</td>
	        			<td>${resVo.lodVo.lod_name}</td>
	        			<td>${resVo.check_in}</td>
	        			<td>${resVo.check_out}</td>
	        			<td>${resVo.number_guests} 명</td>
	        			<td><fmt:formatNumber value="${resVo.payment_price}"/>원</td>
	        			<td>
	        				<c:if test="${resVo.state == '예약'}"><font color="red">${resVo.state}</font></c:if>
	        				<c:if test="${resVo.state == '사용완료'}">${resVo.state}</c:if>
	        				<c:if test="${resVo.state == '사용중'}"><font color="blue">${resVo.state}</font></c:if>
	        			</td>
	        		</tr>
	        	</c:forEach>
	        </table>
	        <div style="font-size:0.9em; color:grey; margin-top:8px"><i class="fa-solid fa-circle-exclamation"></i><font color="red"> 예약취소시 사용한 포인트는 재적립 되지 않습니다.</font></div>
	    </form>
        <p><br></p>
        </div>
      </div>

      <div class="w3-container w3-card w3-white">
        <h2 class="w3-text-black w3-padding-16"><i class="fa fa-certificate fa-fw w3-margin-right w3-xxlarge w3-text-amber"></i>Review</h2>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>W3Schools.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Forever</h6>
          <p>Web Development! All I need to know in one place</p>
          <hr>
        </div>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>London Business School</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>2013 - 2015</h6>
          <p>Master Degree</p>
          <hr>
        </div>
        <div class="w3-container">
          <h5 class="w3-opacity"><b>School of Coding</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>2010 - 2013</h6>
          <p>Bachelor Degree</p><br>
        </div>
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