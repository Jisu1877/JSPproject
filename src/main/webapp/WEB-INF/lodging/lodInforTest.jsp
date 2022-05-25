<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
 
 @media screen and (max-width:600px) { 
	.numPlusMinus {
		margin-top:18px;
	}
	#numMinus {
		margin-left : 30px;
	}
 }
</style>
<script>
	function NumPlus() {
		let peopleNum = document.getElementById("peopleNum").value;
		peopleNum = Number(peopleNum) + 1;
		document.getElementById("peopleNum").value = peopleNum
	}
	
	function NumMinus() {
		let peopleNum = document.getElementById("peopleNum").value;
		peopleNum = Number(peopleNum) - 1;
		document.getElementById("peopleNum").value = peopleNum
	}
</script>
</head>
<body>
<%@ include file="/include/nav1.jsp" %>

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
					  yearSuffix: '년'
		        });
		       
		       $('#checkIn').datepicker("option", "minDate", new Date());
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
	
	</script>
	
  </div>

  <div class="w3-container" id="content">
	  <div class="w3-col m6 l7">
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
		    
		    <h4><strong>Amenities</strong></h4>
		    <div class="w3-row w3-large">
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-shower"></i> Shower</p>
		        <p><i class="fa fa-fw fa-wifi"></i> WiFi</p>
		        <p><i class="fa fa-fw fa-tv"></i> TV</p>
		      </div>
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-cutlery"></i> Kitchen</p>
		        <p><i class="fa fa-fw fa-thermometer"></i> Heating</p>
		        <p><i class="fa fa-fw fa-wheelchair"></i> Accessible</p>
		      </div>
		    </div>
		    <hr>
		    
		    <div class="w3-row w3-large">
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-shower"></i> Shower</p>
		        <p><i class="fa fa-fw fa-wifi"></i> WiFi</p>
		        <p><i class="fa fa-fw fa-tv"></i> TV</p>
		      </div>
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-cutlery"></i> Kitchen</p>
		        <p><i class="fa fa-fw fa-thermometer"></i> Heating</p>
		        <p><i class="fa fa-fw fa-wheelchair"></i> Accessible</p>
		      </div>
		    </div>
		    <hr>
		    
		    <div class="w3-row w3-large">
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-shower"></i> Shower</p>
		        <p><i class="fa fa-fw fa-wifi"></i> WiFi</p>
		        <p><i class="fa fa-fw fa-tv"></i> TV</p>
		      </div>
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-cutlery"></i> Kitchen</p>
		        <p><i class="fa fa-fw fa-thermometer"></i> Heating</p>
		        <p><i class="fa fa-fw fa-wheelchair"></i> Accessible</p>
		      </div>
		    </div>
		    <hr>
		    
		    <div class="w3-row w3-large">
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-shower"></i> Shower</p>
		        <p><i class="fa fa-fw fa-wifi"></i> WiFi</p>
		        <p><i class="fa fa-fw fa-tv"></i> TV</p>
		      </div>
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-cutlery"></i> Kitchen</p>
		        <p><i class="fa fa-fw fa-thermometer"></i> Heating</p>
		        <p><i class="fa fa-fw fa-wheelchair"></i> Accessible</p>
		      </div>
		    </div>
		    <hr>
		    
		    <div class="w3-row w3-large">
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-shower"></i> Shower</p>
		        <p><i class="fa fa-fw fa-wifi"></i> WiFi</p>
		        <p><i class="fa fa-fw fa-tv"></i> TV</p>
		      </div>
		      <div class="w3-col s6">
		        <p><i class="fa fa-fw fa-cutlery"></i> Kitchen</p>
		        <p><i class="fa fa-fw fa-thermometer"></i> Heating</p>
		        <p><i class="fa fa-fw fa-wheelchair"></i> Accessible</p>
		      </div>
		    </div>
		    <hr>
		    
		    
	  </div>
  	  <div class="w3-col m6 l5">
  	  	<form>
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
						<input class="w3-input w3-border" type="text" title="숙박 시작 일자" placeholder="YYYY-DD-MM" name="checkIn" id="checkIn" autocomplete="off" required>
					</div>
					<div class="w3-half">
						<label><i class="fa fa-calendar-o"></i>&nbsp; Check Out</label>
           				<input class="w3-input w3-border" type="text" title="숙박 마지막 일자" placeholder="YYYY-DD-MM" name="checkOut" id="checkOut" autocomplete="off" required>
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
			</div>
		</div>
		</form>
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