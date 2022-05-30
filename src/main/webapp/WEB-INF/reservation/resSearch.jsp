<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>resSearch.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <script src="https://code.iconify.design/2/2.2.1/iconify.min.js"></script>
    	<script>
		$.datepicker.setDefaults({
			  dateFormat: 'yy-mm-dd',
			  prevText: '이전 달',
			  nextText: '다음 달',
			  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			  showMonthAfterYear: true,
			  yearSuffix: '년'
			});	
	
		$(function() {
			$('input[name="checkIn"]').datepicker({
				minDate: new Date()
			});
			$('input[name="checkOut"]').datepicker({
				minDate: new Date()
			});
		});
		
		function searchCheck() {
			let checkIn = document.getElementById("checkIn").value;
			let checkOut = document.getElementById("checkOut").value;
			
			if(checkIn > checkOut) {
				alert("숙박 시작날짜는 마지막날짜보다 늦을 수 없습니다.");
				return false;
			}
			else {
				myForm.submit();
			}
			
		}
	</script>
	<style>
	a {
		color:black;
		text-decoration-line: none !important; 
	}
	
	.houses a:hover {
		color:black;
	}
	</style>
</head>
<body>
<%@ include file="/include/nav2.jsp" %>
<div class="container" style="max-width:1500px;">
	<div style="margin-top:20px; margin-left:10px;">
		<h3><strong>Search</strong></h3>
	</div>
	<form>
	  <div class="w3-row-padding">
	    <div class="w3-col m3">
	      <label><i class="fa fa-calendar-o"></i> Check In</label>
	      <input class="w3-input w3-border" type="text" title="숙박 시작 일자" value="${resVO.check_in}" placeholder="YYYY-DD-MM" name="checkIn" id="checkIn" autocomplete="off" required>
	    </div>
	    <div class="w3-col m3">
	      <label><i class="fa fa-calendar-o"></i> Check Out</label>
	      <input class="w3-input w3-border" type="text" title="숙박 마지막 일자" value="${resVO.check_out}" placeholder="YYYY-DD-MM" name="checkOut" id="checkOut" autocomplete="off" required>
	    </div>
	    <div class="w3-col m2">
	      <label><i class="fa-solid fa-map-location-dot"></i>&nbsp; 지역 </label>
	      <select class="w3-select w3-border" name="area" title="숙박할 지역">
            	<option value="어디든지" ${area == 106 ? 'selected' : '' }>어디든지</option>
            	<option value="유럽" ${area == 100 ? 'selected' : '' }>유럽</option>
            	<option value="아시아" ${area == 101 ? 'selected' : '' }>아시아</option>
            	<option value="미국" ${area == 102 ? 'selected' : '' }>미국</option>
            	<option value="프랑스" ${area == 103 ? 'selected' : '' }>프랑스</option>
            	<option value="이탈리아" ${area == 104 ? 'selected' : '' }>이탈리아</option>
            </select>
	    </div>
	    <div class="w3-col m2">
	      <label><i class="fa-solid fa-person-circle-question"></i>&nbsp; 인원</label>
	      <input class="w3-input w3-border" type="number" value="${resVO.number_guests}" name="peopleNum" min="1" max="6" title="숙박할 인원">
	    </div>
	    <div class="w3-col m2">
	      <label><i class="fa fa-search"></i></label>
	      <button class="w3-button w3-block w3-black">Search</button>
	    </div>
	  </div>
	</form>

	<div class="w3-row-padding w3-padding-16 houses">
   <c:forEach var="lodVO" items="${lodVos}">
	   <div class="w3-third w3-margin-bottom">
   	 	  	
	  	   <a href="lodInfor.lod?lodIdx=${lodVO.idx}&checkIn=${resVO.check_in}&checkOut=${resVO.check_out}" ><img src="${ctp}/data/lodging/${lodVO.save_file_name}" style="width:100%; height: 300px;"/></a>
	      <div class="w3-container w3-white">
	        <a href="lodInfor.lod?lodIdx=${lodVO.idx}" ><h3 class="mt-2" style="font-size: 17px;">${lodVO.address}</h3></a>
	        <c:set var="priceFmt" value="${lodVO.price}"></c:set>
	        <h6><b>￦<fmt:formatNumber value="${priceFmt}"/>/박</b></h6>
	        <p class="w3-opacity">
	        침실 ${lodVO.option.bedroom}개, 침대 ${lodVO.option.bed}개, 욕실 ${lodVO.option.bathroom}개
	        </p>
	        
	        <p class="w3-large"> 
	        <c:if test="${lodVO.option.air_conditioner == 'y'}">
	       	 <span class="iconify" data-icon="iconoir:air-conditioner" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.tv == 'y'}">
	       	 <span class="iconify" data-icon="gala:tv" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.wifi == 'y'}">
	         <i class="fa fa-wifi"></i>
	        </c:if>
	        <c:if test="${lodVO.option.washer == 'y'}">
	         <span class="iconify" data-icon="bxs:washer" data-width="25"></span>
	        </c:if>
	        <c:if test="${lodVO.option.kitchen == 'y'}">
	        	<i class="fa-solid fa-fire-burner"></i>
	        </c:if>
	        <c:if test="${lodVO.option.heating == 'y'}">
	        	<i class="fa-solid fa-temperature-high"></i>
	        </c:if>
	        <c:if test="${lodVO.option.toiletries == 'y'}">
	        	<span class="iconify" data-icon="mdi:toothbrush-paste" data-width="25"></span>
	        </c:if>
	         </p>
	      </div>
	    	
	    </div>
    </c:forEach>
</div>
</div>
<p><br/><p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>