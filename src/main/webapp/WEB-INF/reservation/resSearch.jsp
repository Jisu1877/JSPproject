<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 상세검색</title>
    <%@ include file="/include/bs4.jsp" %>
    <script src="https://code.iconify.design/2/2.2.1/iconify.min.js"></script>
    	<script>
    	$(document).ready(function(){       
		       $( "#checkIn,#checkOut" ).datepicker({
		    	   dateFormat: 'yy-mm-dd',
					  prevText: '이전 달',
					  nextText: '다음 달',
					  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
					  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
					  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
					  showMonthAfterYear: true,
					  yearSuffix: '년',
					  //beforeShowDay: disableSelectedDates
		        });
		       let today = new Date();
		       today.setDate(today.getDate() + 1);
		       
		       $('#checkIn').datepicker("option", "minDate", today);
		       $('#checkIn').datepicker("option", "maxDate", $("#checkOut").val());
		       $('#checkIn').datepicker("option", "onClose", function (selectedDate){
		           $("#checkOut").datepicker( "option", "minDate", selectedDate );
		           });
		       
		       $('#checkOut').datepicker();
		       $('#checkOut').datepicker("option", "minDate", $("#checkIn").val());
		       $('#checkOut').datepicker("option", "onClose", function (selectedDate){
		           $("#checkIn").datepicker( "option", "maxDate", selectedDate );
		          });
		});
		
		function searchCheck() {
			let checkIn = document.getElementById("checkIn").value;
			let checkOut = document.getElementById("checkOut").value;
			
		/* 	if($("#peopleNum").val() ===  undefined){
				alert("숙박인원을 입력해주세요.");
				return false; 
			} 
			*/
			let peopleNum = document.getElementById("peopleNum").value;
			let regDate = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
			
			if(checkIn != "" && checkOut != "") {
				if(!regDate.test(checkIn)) {
					alert("입력하신 날짜가 날짜형식에 맞지 않습니다.");
					document.getElementById("checkIn").focus();
					return false;
				}
				else if(!regDate.test(checkOut)) {
					alert("입력하신 날짜가 날짜형식에 맞지 않습니다.");
					document.getElementById("checkOut").focus();
					return false;
				}
				else if(checkIn == checkOut) {
					alert("체크인 날짜와 체크아웃 날짜가 같습니다. 1박 이상으로 선택해주세요.");
					document.getElementById("checkOut").focus();
					return false;
				}
			}
			if(peopleNum <= 0) {
				alert("숙박인원은 1명 이상부터 검색가능합니다.");
				document.getElementById("peopleNum").focus();
				return false;
			}
			else if(peopleNum == undefined) {
				alert("숙박인원을 입력해주세요.2");
				document.getElementById("peopleNum").focus();
				return false;
			}
			if($("#peopleNum").val() !==  undefined){
				return true;
			}
		}
		
		function categorySearch(CategoryCode) {
			document.getElementById("code").value = CategoryCode;
			myForm.submit();
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
	@media screen and (max-width:1000px) { 
	 	#category {
	 		display: none;
	 	}
	 }
	</style>
</head>
<body>
<%@ include file="/include/nav2.jsp" %>
<div class="container" style="max-width:1500px;">
	<div id="category" style="margin-top: 40px;">
		<h2 style="text-align: center; margin-bottom: 30px;"><strong>Lodging Houses</strong></h2>
	  <!--  <h5 class="text-center">Choose a theme!</h5> -->
	    <!-- <div style="text-align: center">
		    <span><i class="fa-solid fa-palette" style="font-size:30px;"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>&nbsp;&nbsp;<i class="fa-solid fa-campground" style="font-size:30px;"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><i class="fa-solid fa-igloo" style="font-size:30px;"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><i class="fa-solid fa-umbrella-beach" style="font-size:30px;"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><i class="fa-brands fa-fort-awesome" style="font-size:32px;"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><i class="fa-solid fa-house-flood-water" style="font-size:32px;"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><i class="fa-solid fa-dungeon" style="font-size:32px;"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><i class="fa-solid fa-water-ladder" style="font-size:30px;"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><span class="iconify" data-icon="icon-park:dome" style="font-size:32px; margin-bottom: 8px;"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><span class="iconify" data-icon="emojione-monotone:palm-tree" style="font-size:32px; margin-bottom: 8px;"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><span class="iconify" data-icon="emojione-monotone:house-with-garden" style="font-size:32px; margin-bottom: 8px;"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span><i class="fa-solid fa-panorama" style="font-size:30px;"></i></span><br>
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>디자인</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>캠핑장</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>북극</span>&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>해변근처</span>&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>캐슬</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>호숫가</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>동굴</span>&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>멋진수영장</span>&nbsp;&nbsp;&nbsp;&nbsp;
		    <span>돔하우스</span>&nbsp;&nbsp;
		    <span>열대지역</span>&nbsp;&nbsp;
		    <span>한적한시골</span>&nbsp;&nbsp;
		    <a href="javascript:categorySearch(300);"><span>최고의전망</span></a>&nbsp;&nbsp;
	    </div> -->
	 </div>
	<div style="margin-top:20px; margin-left:10px;">
		<h3><strong>Search</strong></h3>
	</div>
	<form name="myForm" action="${ctp}/resSearch.res" onsubmit="return searchCheck()">
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
            	<option value="106" ${area == 106 ? 'selected' : '' }>어디든지</option>
            	<option value="100" ${area == 100 ? 'selected' : '' }>유럽</option>
            	<option value="101" ${area == 101 ? 'selected' : '' }>아시아</option>
            	<option value="102" ${area == 102 ? 'selected' : '' }>미국</option>
            	<option value="103" ${area == 103 ? 'selected' : '' }>프랑스</option>
            	<option value="104" ${area == 104 ? 'selected' : '' }>이탈리아</option>
            </select>
	    </div>
	    <div class="w3-col m2">
	      <label><i class="fa-solid fa-person-circle-question"></i>&nbsp; 인원</label>
	      <input class="w3-input w3-border" type="number" value="${resVO.number_guests}" name="peopleNum" id="peopleNum" min="1" title="숙박할 인원">
	    </div>
	    <div class="w3-col m2">
	      <label><i class="fa fa-search"></i></label>
	      <button class="w3-button w3-block w3-black w3-hover-black" type="submit">Search</button>
	    </div>
	  </div>
	  <input type="hidden" name="code" id="code" value=""/>
	</form>
	

	<div class="w3-row-padding w3-padding-16 houses">
   <c:forEach var="lodVO" items="${lodVos}">
	   <div class="w3-third w3-margin-bottom">
   	 	  	
	  	   <a href="lodInfor.lod?lodIdx=${lodVO.idx}&checkIn=${resVO.check_in}&checkOut=${resVO.check_out}" ><img src="${ctp}/data/lodging/${lodVO.save_file_name}" style="width:100%; height: 300px;"/></a>
	      <div class="w3-container w3-white">
	        <a href="lodInfor.lod?lodIdx=${lodVO.idx}&checkIn=${resVO.check_in}&checkOut=${resVO.check_out}" >
	        <h3 class="mt-2" style="font-size: 17px;">
	        	${lodVO.address} &nbsp;&nbsp;&nbsp;&nbsp;
	        </h3></a>
        	<div class="mb-2">
        		<i class="fa-solid fa-star" style="font-size: 18px;"><span style="font-size: 18px;"> ${lodVO.rating}&nbsp;/&nbsp;5</span></i>
        	</div>
	        </a>
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