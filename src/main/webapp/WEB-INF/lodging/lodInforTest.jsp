<%@page import="lodging.LodgingVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	int mem_idx = session.getAttribute("sMidx") == null ? 0 : (int) session.getAttribute("sMidx"); 
	String mid = session.getAttribute("sMid") == null ? "" : (String) session.getAttribute("sMid"); 
	pageContext.setAttribute("mem_idx", mem_idx); 
	pageContext.setAttribute("mid", mid); 
	
	pageContext.setAttribute("newLine", "\n"); 
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 상세 정보 조회</title>
    <%@ include file="/include/bs4.jsp" %>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	<script src="https://code.iconify.design/2/2.2.1/iconify.min.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
.mySlides {display: none; width:100%; margin:0 auto;}
.mySlides > img {width:100%; max-height:600px;}

.post-slider{
  width:70%;
  margin:0px auto;
  position:relative;
}
.post-slider .silder-title{
  text-align:center;
  margin:30px auto;
}
.post-slider .next{
  position:absolute;
  top:50%;
  right:30px;
  font-size:2em;
  color:gray;
  cursor: pointer;
}
.post-slider .prev{
  position:absolute;
  top:50%;
  left:30px;
  font-size:2em;
  color:gray;
  cursor: pointer;
}
.post-slider .post-wrapper{

  width:84%;
  /* height:350px; */
  margin: 0px auto;
  overflow: hidden;
  padding:10px 0px 10px 0px;
  
}
.post-slider .post-wrapper .post{
  width:300px;
  /* height:150px; */
  margin:0px 10px;
  display:inline-block;
  background:white;
  border-radius: 5px;
}
.post-slider .post-wrapper .post .post-info{
  font-size:15px;
  height:30%;
  padding-left:10px;
}
.post-slider .post-wrapper .post .slider-image{
  width:100%;
  height:175px;
  border-top-left-radius:5px;
  border-top-right-radius:5px;
  line-height:200px;
  text-align:center;
}

.slick-active {
	overflow:hidden;
	height: 146px;
}
.slick-active > img {
	width:100%;
	height:100%;
}

.reservation {
	border-radius: 8px 8px 8px 8px;
	box-shadow: 3px 3px 3px 3px #ccc;
}

.numPlusMinus {
	margin-top:18px;
	margin-left:30px;
	font-size: 22px;
}

.priceCl {
	font-size : 20px;
}

a {
	color : black;
}

 @media screen and (max-width:1000px) { 
 	.slick-active {
	overflow:hidden;
	height: 100%;
	
	}
	.slick-active > img {
		width:100%;
	}
	
	.numPlusMinus {
		margin-top: 40px;
		
	}
	
	#numMinus {
		margin-left : 3px;
	}
 
 }

@media screen and (max-width:800px) { 
	.priceCl {
	font-size : 13px;
	}
}

 @media screen and (max-width:600px) { 
	.numPlusMinus {
		margin-top:18px;
	}
	#numMinus {
		margin-left : 30px;
	}
	.priceCl {
	font-size : 20px;
	}
 }
</style>
<script>
	function NumPlus() {
		let peopleNum = document.getElementById("peopleNum").value;
		let number_guests = ${lodVo.number_guests};
		if(peopleNum == number_guests) {
			alert("최대 숙박 가능인원은 "+number_guests+"명입니다.");
			return false;
		}
		peopleNum = Number(peopleNum) + 1;
		document.getElementById("peopleNum").value = peopleNum;
	}
	
	function NumMinus() {
		let peopleNum = document.getElementById("peopleNum").value;
		if(peopleNum == 1) {
			alert("최소 숙박인원은 1명입니다.");
			return false;
		}
		peopleNum = Number(peopleNum) - 1;
		document.getElementById("peopleNum").value = peopleNum;
	}
	
	function priceCalc() {
		let checkIn = document.getElementById("checkIn").value;
		let checkOut = document.getElementById("checkOut").value;
		let peopleNum = document.getElementById("peopleNum").value;
		
		let regDate = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
	
		if(checkIn == "") {
			alert("체크인 날짜를 선택해주세요.");
			document.getElementById("checkIn").focus();
			return false;
		}
		else if(checkOut == "") {
			alert("체크아웃 날짜를 선택해주세요.");
			document.getElementById("checkOut").focus();
			return false;
		}
		else if(checkIn == checkOut) {
			alert("체크인 날짜와 체크아웃 날짜가 같습니다. 1박 이상으로 선택해주세요.");
			document.getElementById("checkOut").focus();
			return false;
		}
		else if(!regDate.test(checkIn)) {
			alert("입력하신 날짜가 날짜형식에 맞지 않습니다.");
			document.getElementById("checkIn").focus();
			return false;
		}
		else if(!regDate.test(checkOut)) {
			alert("입력하신 날짜가 날짜형식에 맞지 않습니다.");
			document.getElementById("checkOut").focus();
			return false;
		}
		else if(peopleNum == "") {
			alert("숙박인원을 입력해주세요.");
			document.getElementById("peopleNum").focus();
			return false;
		}
		else if(peopleNum <= 0) {
			alert("숙박인원은 0이나 음수로 입력할 수 없습니다.");
			document.getElementById("peopleNum").focus();
			return false;
		}
		else if(peopleNum > ${lodVo.number_guests}) {
			alert("입력하신 인원수가 숙박 가능 인원보다 많습니다.");
			document.getElementById("peopleNum").focus();
			return false;
		}
		else { 
			// 선택한 2개의 날짜의 차를 구하기
			let checkInDate = new Date(checkIn);
			let checkOutDate = new Date(checkOut);
			let diffDate = checkInDate.getTime() - checkOutDate.getTime();
			
			let dateDays = Math.abs(diffDate / (1000 * 3600 * 24));
			//숙박이 몇박인지 값 화면에 띄워주기
			document.getElementById("dateDiff").innerText = dateDays;
			
			let price = ${lodVo.price};
			let priceCal = price * dateDays;
			let point = priceCal * (5/100);
			let point2 = Math.floor(point).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
			document.getElementById("priceCalcu").innerText = priceCal.toLocaleString();
			document.getElementById("point").innerText = point2;
			document.getElementById("reservation").style.display = "block";
		}
	}
	
	function moreContent() {
		document.getElementById("shortCont").style.display = "none";
		document.getElementById("moreCont").style.display = "block";
	}
	
	function shortContent() {
		document.getElementById("shortCont").style.display = "block";
		document.getElementById("moreCont").style.display = "none";
	}
	
	 function reserInput() {
		let checkIn = document.getElementById("checkIn").value;
		let checkOut = document.getElementById("checkOut").value;
		let peopleNum = document.getElementById("peopleNum").value;
		
		let regDate = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
	
		if(checkIn == "") {
			alert("체크인 날짜를 선택해주세요.");
			document.getElementById("checkIn").focus();
			return false;
		}
		else if(checkOut == "") {
			alert("체크아웃 날짜를 선택해주세요.");
			document.getElementById("checkOut").focus();
			return false;
		}
		else if(checkIn == checkOut) {
			alert("체크인 날짜와 체크아웃 날짜가 같습니다. 1박 이상으로 선택해주세요.");
			document.getElementById("checkOut").focus();
			return false;
		}
		else if(!regDate.test(checkIn)) {
			alert("입력하신 날짜가 날짜형식에 맞지 않습니다.");
			document.getElementById("checkIn").focus();
			return false;
		}
		else if(!regDate.test(checkOut)) {
			alert("입력하신 날짜가 날짜형식에 맞지 않습니다.");
			document.getElementById("checkOut").focus();
			return false;
		}
		else if(peopleNum == "") {
			alert("숙박인원을 입력해주세요.");
			document.getElementById("peopleNum").focus();
			return false;
		}
		else if(peopleNum <= 0) {
			alert("숙박인원은 0이나 음수로 입력할 수 없습니다.");
			document.getElementById("peopleNum").focus();
			return false;
		}
		else if(peopleNum > ${lodVo.number_guests}) {
			alert("입력하신 인원수가 숙박 가능 인원보다 많습니다.");
			document.getElementById("peopleNum").focus();
			return false;
		}
		else { 
			let ans = confirm("숙박날짜와 인원수를 확인해주세요. 선택하신대로 결제를 진행하시겠습니까?");
			if(!ans) {
				return false;
			}
			
			// 선택한 2개의 날짜의 차를 구하기
			let checkInDate = new Date(checkIn);
			let checkOutDate = new Date(checkOut);
			let diffDate = checkInDate.getTime() - checkOutDate.getTime();
			
			let dateDays = Math.abs(diffDate / (1000 * 3600 * 24));
			let price = ${lodVo.price};
			let priceCal = price * dateDays;
			let point = priceCal * (5/100);
			
			reservationForm.priceCal.value = priceCal;
			reservationForm.dateDays.value = dateDays;
			reservationForm.point.value = Math.floor(point);
			
			reservationForm.submit();
		} 
	}
</script>
</head>
<body>
<%@ include file="/include/nav2.jsp" %>

<div class="container">

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main w3-white">

  <!-- Push down content on small screens -->
  <div class="w3-hide-large"></div>
	

<!-- Push down content on small screens -->
  <div class="w3-hide-large"></div>
   <div class="w3-container" id="lodging">
    <div style="margin-top:30px;"><h2>${lodVo.lod_name}</h2></div>
    <div style="font-size:18px; margin-bottom:10px;"><i class="fa-solid fa-map-location-dot"></i>&nbsp;&nbsp;${lodVo.address}</div>
  	<div class="w3-row w3-text-white w3-large">
	    <div class="w3-margin-bottom">
	    <c:forEach var="fileVo" items="${fileList}" varStatus="status">
	      <div class="w3-display-container">
	        <img src="${ctp}/data/lodging/${fileVo.save_file_name}" class="mySlides" style="width:100%;">
	      </div>
	    </c:forEach>
	    </div>
  </div>
  </div>
  <div class="w3-row-padding w3-section">
	  <div class="page-wrapper" style="position:relative;">
      <!--page slider -->
      <div class="post-slider">
        <i class="fa-solid fa-circle-chevron-left prev" style="font-size:18px; left:8px" ></i>  <!-- 왼쪽 방향 버튼  -->
        <i class="fa-solid fa-circle-chevron-right next" style="font-size:18px; right:8px" ></i>   <!-- //오른쪽 방향 버튼  -->
        <div class="post-wrapper">
          <c:forEach var="fileVo" items="${fileList}" varStatus="status">
          <div class="post">
            <img class="w3-hover-opacity-off" src="${ctp}/data/lodging/${fileVo.save_file_name}" style="width:100%; cursor:pointer" onclick="currentDiv(${status.count})"> <!-- onclick="photoChange(${fileVo.save_file_name})"  -->
          </div>
          </c:forEach>
        </div>
      </div>
      <!--post slider-->
    </div>
	<script>
		$('.post-wrapper').slick({
			  slidesToShow: 3,
			  slidesToScroll: 1,
			  autoplay: true,
			  autoplaySpeed: 3000,
			  nextArrow:$('.next'),
			  prevArrow:$('.prev'),
		});
		
	 	let resList = JSON.parse('${resListJson}');
	 	$(document).ready(function() {
	 	  
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
				  beforeShowDay: disableSelectedDates
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
	       
	       function disableSelectedDates(date) {
	    	   let flag = true;
	    	   let tooltip = '';
	    	   for (let i = 0; i < resList.length; i++) {
		    	   if (resList[i].stay_date == getFormatDate(date)) {
		    		   flag = false;
		    		   tooltip = '예약됨';
		    		   break;
		    	   }	    		   
	    	   }
	    	   let result = [flag, '', tooltip];
	    	   return result;
	       }
	       function getFormatDate(date){
	    	    var year = date.getFullYear();              //yyyy
	    	    var month = (1 + date.getMonth());          //M
	    	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    	    var day = date.getDate();                   //d
	    	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    	    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
	    	}
		}); 
	
	</script>
	
  </div>

  <div class="w3-container" id="content">
	  <div class="w3-col m6 l7">
	  		<div style="margin-bottom:15px;">
			  	 <h4><strong>Condition</strong></h4>
			    <div class="w3-row w3-large">
			      <div class="w3-col s6">
			        <p><i class="fa fa-fw fa-male"></i> 최대 인원수: ${lodVo.number_guests}명</p>
			        <p><i class="fa fa-fw fa-bath"></i> 욕실 : ${lodVo.option.bathroom}개</p>
			      </div>
			      <div class="w3-col s6">
			        <p><i class="fa fa-fw fa-bed"></i> 침실 : ${lodVo.option.bedroom}개</p>
			        <p><span class="iconify" data-icon="ion:bed"></span> 침대 : ${lodVo.option.bed}개</p>
			      </div>
			    </div>
		    </div>
		  	<div style="margint-bottom:15px; margin-right: 20px;">
		    	<h4><strong>Explanation</strong></h4>
			    <div class="w3-row w3-large" id="shortCont">
				    ${fn:substring(lodVo.explanation, 0, 50)}
				    <c:if test="${fn:length(lodVo.explanation) > 49}">
				    ...<span style="text-decoration: underline;" class="more"><a href="javascript:moreContent();">더보기</a></span>
				    </c:if>
			    </div>
			    <div class="w3-row w3-large" style="display: none" id="moreCont">
			    	<c:if test="${fn:indexOf(lodVo.explanation,newLine) != -1}">${fn:replace(lodVo.explanation,newLine,"<br>")}</c:if>
				  	<c:if test="${fn:indexOf(lodVo.explanation,newLine) == -1}">${lodVo.explanation}</c:if>
				  	<span style="text-decoration: underline;" class="more"><a href="javascript:shortContent();">접기</a></span>
			    </div>
		    </div>
		    <p></p>
		    <h4><strong>Amenities</strong></h4>
		    <div class="w3-row w3-large">
		      <div class="w3-col s6">
			      <c:if test="${lodVo.option.air_conditioner == 'y' }">
			        <p><span class="iconify" data-icon="iconoir:air-conditioner" data-width="25"></span> 에어컨</p>
			      </c:if>
			      <c:if test="${lodVo.option.tv == 'y'}">
			       	 <p><span class="iconify" data-icon="gala:tv" data-width="25"></span> TV</p>
			      </c:if>
			      <c:if test="${lodVo.option.wifi == 'y'}">
			         <p><i class="fa fa-wifi"></i> 무선인터넷</p>
			      </c:if>
			      </div>
		      <div class="w3-col s6">
		         <c:if test="${lodVo.option.washer == 'y'}">
		         	<p><span class="iconify" data-icon="bxs:washer" data-width="25"></span> 세탁기</p>
		         </c:if>
		         <c:if test="${lodVo.option.kitchen == 'y'}">
		        	<p><i class="fa-solid fa-fire-burner"></i> 주방시설</p>
		         </c:if>
		         <c:if test="${lodVo.option.heating == 'y'}">
		        	<p><i class="fa-solid fa-temperature-high"></i> 난방</p>
		         </c:if>
		         <c:if test="${lodVo.option.toiletries == 'y'}">
		        	<p><span class="iconify" data-icon="mdi:toothbrush-paste" data-width="25"></span> 세면도구</p>
		         </c:if>
		      </div>
		    </div>
		    <hr>
		    
		    
	  </div>
  	  <div class="w3-col m6 l5">
  	  	<form name="reservationForm" method="post" action="payment_confirmation.res">
			<div class="reservation" style="padding:20px">
				<c:set var="priceFmt" value="${lodVo.price}"></c:set>
				<div class="mb-2">
					<span style="font-size:20px;">
						<strong>￦<fmt:formatNumber value="${priceFmt}"/></strong><font size="3">/박</font>
					</span>
				</div>
				<div>
					<div class="w3-row mb-2">
						<div class="w3-half">
							<label><i class="fa fa-calendar-o"></i>&nbsp; Check In</label>
							<input class="w3-input w3-border" type="text" title="숙박 시작 일자" placeholder="YYYY-DD-MM" value="${param.checkIn}" name="checkIn" id="checkIn" autocomplete="off" required>
						</div>
						<div class="w3-half">
							<label><i class="fa fa-calendar-o"></i>&nbsp; Check Out</label>
	           				<input class="w3-input w3-border" type="text" title="숙박 마지막 일자" placeholder="YYYY-DD-MM" value="${param.checkOut}" name="checkOut" id="checkOut" autocomplete="off" required>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col s6">
							<label><i class="fa-solid fa-person-circle-question"></i>&nbsp;Number of people</label>
	            			<input class="w3-input w3-border" type="number" value="1" id="peopleNum" name="peopleNum" min="1" title="숙박할 인원" required>
						</div>
						<div class="w3-col s6">
							<div>&nbsp;</div>
							<a onclick="javascript:NumPlus();"><i class="fa-solid fa-circle-plus numPlusMinus"></i></a>
							<a onclick="javascript:NumMinus();"><i class="fa-solid fa-circle-minus numPlusMinus" id="numMinus"></i></a>
						</div>
					</div>
					<div class="w3-row" style="margin-top:15px;">
						<div>
							<input type="button" value="가격 계산하기" class="btn w3-black form-control" onclick="priceCalc();" style="height: 40px; font-size:18px;"/>
						</div>
					</div>
					<div id="reservation" style="display: none;">
						<div class="w3-row" style="margin-top:15px;">
							<div class="w3-col s6 priceCl">
								￦<fmt:formatNumber value="${priceFmt}"/>&nbsp;X&nbsp;<span id="dateDiff"></span>박
							</div>
							<div class="w3-col s6 priceCl" style="text-align:right">
								￦<b><span id="priceCalcu" class="w3-text-indigo"></span></b>
							</div>
						</div>
						<div class="w3-row" style="margin-top:15px; text-align:right;">
							<span class="w3-text-gray"><i class="fa-solid fa-circle-dollar"></i>&nbsp; 예상 적립금 : ￦<span id="point"></span></span>
						</div>
						<div class="w3-row" style="margin-top:15px; text-align:right;">
						 	<div>
								<input type="button" value="예약하기" class="btn w3-theme form-control" onclick="reserInput()" style="height: 45px; font-size:18px;"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" name="address" value="${lodVo.address}"/>
			<input type="hidden" name="lod_name" value="${lodVo.lod_name}"/>
			<input type="hidden" name="mid" value="${mid}"/>
			<input type="hidden" name="priceCal"/>
			<input type="hidden" name="dateDays"/>
			<input type="hidden" name="point"/>
			<input type="hidden" name="mem_idx" value="${mem_idx}"/>
			<input type="hidden" name="lod_idx" value="${lodVo.idx}"/>
		</form>
	  </div>
	  
</div>
</div>
<p><br/><p>

<!-- End page content -->
</div>

<script>
// Script to open and close sidebar when on tablets and phones
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
  document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
  document.getElementById("myOverlay").style.display = "none";
}

// Slideshow Apartment Images
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-opacity-off", "");
  }
  x[slideIndex-1].style.display = "block";
 /*  dots[slideIndex-1].className += " w3-opacity-off"; */
}
</script>
</body>
<%@ include file="/include/footer.jsp" %>
</html>