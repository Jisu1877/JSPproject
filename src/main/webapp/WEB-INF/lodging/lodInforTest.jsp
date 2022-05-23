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
</style>

</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main w3-white">

  <!-- Push down content on small screens -->
  <div class="w3-hide-large"></div>
	

<!-- Push down content on small screens -->
  <div class="w3-hide-large"></div>
   <div class="w3-container" id="apartment">
    <h2 class="w3-text-green">The Apartment</h2>
    
  	<div class="w3-row w3-padding-16 w3-text-white w3-large">
	    <div class="w3-margin-bottom">
	    <c:forEach var="fileVo" items="${fileList}" varStatus="status">
	      <div class="w3-display-container">
	        <img src="${ctp}/data/lodging/${fileVo.save_file_name}" class="mySlides" style="width:100%;">
	      </div>
	    </c:forEach>
	    </div>
  </div>
  </div>
  <div class="w3-row-padding w3-section mt-0">
	  <div class="page-wrapper" style="position:relative;">
      <!--page slider -->
      <div class="post-slider">
        <i class="fa-solid fa-circle-chevron-left prev" style="font-size:18px; left:8px" ></i>  <!-- 왼쪽 방향 버튼  -->
        <i class="fa-solid fa-circle-chevron-right next" style="font-size:18px; right:8px" ></i>   <!-- //오른쪽 방향 버튼  -->
        <span class="iconify next" data-icon="ant-design:caret-right-outlined"></span>
        <div class="post-wrapper">
          <c:forEach var="fileVo" items="${fileList}" varStatus="status">
          <div class="post">
            <img class="demo w3-hover-opacity-off" src="${ctp}/data/lodging/${fileVo.save_file_name}" style="width:100%; cursor:pointer" onclick="currentDiv(${status.count})"> <!-- onclick="photoChange(${fileVo.save_file_name})"  -->
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
	</script>
	
  </div>

  <div class="w3-container">
    <h4><strong>The space</strong></h4>
    <div class="w3-row w3-large">
      <div class="w3-col s6">
        <p><i class="fa fa-fw fa-male"></i> Max people: 4</p>
        <p><i class="fa fa-fw fa-bath"></i> Bathrooms: 2</p>
        <p><i class="fa fa-fw fa-bed"></i> Bedrooms: 1</p>
      </div>
      <div class="w3-col s6">
        <p><i class="fa fa-fw fa-clock-o"></i> Check In: After 3PM</p>
        <p><i class="fa fa-fw fa-clock-o"></i> Check Out: 12PM</p>
      </div>
    </div>
    <hr>
    
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
  dots[slideIndex-1].className += " w3-opacity-off";
}
</script>

<%@ include file="/include/footer.jsp" %>
</body>
</html>