<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>title</title>
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
    </style>
</head>
<body>
<%@ include file="/include/nav2.jsp" %>

<!-- Page Container -->
<div class="w3-content w3-margin-top" style="max-width:1400px;">
	<h2 class="headerJoin text-center">My Page</h2>
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
        	<div style="font-size: 18px;">
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
			<div style="font-size:35px;">
				<strong><fmt:formatNumber value="${point}"/>Point</strong>
			</div>
          </p>
          <hr>
          
          <div style="font-size: 18px;" class="w3-text-grey">
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
        <h2 class="w3-padding-16"><i class="fa-solid fa-person-walking-luggage w3-margin-right"></i>Reservation List</h2>
        <tabal class="w3-table-all w3-small w3-hoverable" >
        	<tr>
        		<th>예약번호</th>
        		<th>예약번호</th>
        	</tr>
        </tabal>
      </div>

      <div class="w3-container w3-card w3-white">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-certificate fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>Education</h2>
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