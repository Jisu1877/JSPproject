<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰작성</title>
    <%@ include file="/include/bs4.jsp" %>
    <script>
    	function reviewInput() {
			let rating = document.getElementById("rating").value;
			let review_subject = document.getElementById("review_subject").value;
			let review_contents = document.getElementById("review_contents").value;
			
			if(rating == "") {
				alert("평점을 선택해주세요.");
				return false;
			}
			else if(review_subject == "") {
				alert("리뷰 제목을 입력해주세요.");
				return false;
			}
			else if(review_contents == "") {
				alert("리뷰 내용을 입력해주세요.");
				return false;
			}
			
			return true;
		}
    </script>
    <style>
   		.headerJoin {
	  		font-size: 50px;
	        color: black;
	        font-weight: bolder;
	        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
	        margin-top: 0px;
	        margin-bottom: 20px;
	  	}
    </style>
</head>
<body class="w3-light-grey">
<%@ include file="/include/nav2.jsp" %>
<p><br/><p>
<div class="container">
	<!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    <h5><b><i class="fa-solid fa-file-pen"></i> Write a review</b></h5>
  </header>
  <section>
  <p><br/><p>
	  <div class="w3-container" id="contact">
	  <h2 class="headerJoin text-center"><i class="fa-solid fa-file-pen" style="font-size: 40px;"></i> Review</h2>
	   <!--  <h2 class="headerJoin text-center"><i class="fa-solid fa-file-pen" style="font-size: 25px;"></i>  Review</h2> -->
		<div class="w3-row-padding w3-padding-16">
		<div style="font-size:0.9em; color:grey; margin-top:0px; text-align: center">
			<i class="fa-solid fa-circle-exclamation"></i> 
			작성한 리뷰는 수정이 불가하며, 삭제만 가능합니다. 비속어, 광고글 등 포함시 삭제처리 될 수 있습니다.
		</div>
			<div class="w3-col m2 l2 w3-margin-bottom"></div>
			<div class="w3-col m8 l8 w3-margin-bottom">
				<div style="margin-top: 15px; padding-left: 10px;">
					<i class="fa-solid fa-tents"></i>&nbsp;  숙소명 : ${param.lod_name}
				</div>
			    <form name="myForm" method="post" action="${ctp}/reviewInput.lod" class="was-validated" onsubmit="return reviewInput();">
			    	 <div class="form-group">
			    		<div class="w3-row-padding w3-padding-16">
				      		<div class="input-group mb-3">
				      			<label><i class="fa-solid fa-star"></i>&nbsp; 평점 : </label>
					            <select class="w3-select w3-border" id="rating" name="rating">
					            	<option value="">&nbsp;평점을 입력하세요.</option>
					            	<option value="5">★★★★★</option>
					            	<option value="4">★★★★</option>
					            	<option value="3">★★★</option>
					            	<option value="2">★★</option>
					            	<option value="1">★</option>
					            </select>
				    		</div>
				    		<label for="review_subject">리뷰 제목 : &nbsp; &nbsp;</label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="review_subject" name="review_subject" type="text" placeholder="리뷰 제목을 입력하세요." required>
				    		</div>
				    		<label for="review_contents">내용 : &nbsp; &nbsp;</label>
				      		<div class="input-group mb-3">
				    			<textarea rows="7" class="input w3-padding-16 w3-border form-control" id="review_contents" name="review_contents" placeholder="리뷰 내용을 입력하세요." style="resize: none;" required></textarea>
				    		</div>
			    		</div>
		    		</div>
		    		<p style="text-align: center;">
		    			<button class="w3-button w3-theme" type="submit">리뷰 등록</button>&nbsp;&nbsp;
				        <button class="w3-button w3-black" type="reset">다시입력</button>
				    </p>
				    <input type="hidden" name="lodIdx" value="${param.lodIdx }">
				    <input type="hidden" name="memIdx" value="${param.memIdx}">
				    <input type="hidden" name="checkIn" value="${param.checkIn}">
				    <input type="hidden" name="checkOut" value="${param.checkOut}">
			    </form>
	    	</div>
   			</div>
		    <div class="w3-col m2 l2 w3-margin-bottom"></div>
	    </div>
  </section>
</div>
<p><br/><p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>