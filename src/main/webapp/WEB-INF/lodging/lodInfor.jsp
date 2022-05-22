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
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
.mySlides {display: none; width:100%; margin:0 auto;}
.mySlides > img {width:100%; max-height:600px;}
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
    <c:forEach var="fileVo" items="${fileList}" varStatus="status">
  		<c:if test="${lodVo.save_file_name != fileVo.save_file_name}">
		    <div class="w3-margin-bottom">
		      <div class="w3-display-container mySlides">
		        <img src="${ctp}/data/lodging/${fileVo.save_file_name}">
		      </div>
		    </div>
  		</c:if>
  	</c:forEach>
  </div>
  </div>
  <div class="w3-row-padding w3-section">
  <c:forEach var="fileVo" items="${fileList}" varStatus="status">
  	<c:if test="${lodVo.save_file_name != fileVo.save_file_name}">
    <div class="w3-col s3">
      <img class="demo w3-opacity w3-hover-opacity-off" src="${ctp}/data/lodging/${fileVo.save_file_name}" style="width:100%;cursor:pointer" onclick="currentDiv(${status.count})" title="Living room">
    </div>
    </c:if>
  </c:forEach>
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