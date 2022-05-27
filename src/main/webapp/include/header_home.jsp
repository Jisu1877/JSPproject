<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.mySlides {display:none;}
</style>

<!-- Header -->
<header class="w3-display-container w3-content" style="max-width:1500px;">
	<a href="lodInfor.lod?lodIdx=1">
	<img class="w3-image mySlides" src="images/air1.jpg" alt="The Hotel" style="width:100%; height:800px;">
	</a>
	<a href="lodInfor.lod?lodIdx=4">
	<img class="w3-image mySlides" src="images/air2.jpg" alt="The Hotel" style="width:100%; height:800px;">
	</a>
	<a href="lodInfor.lod?lodIdx=2">
	<img class="w3-image mySlides" src="images/air3.jpg" alt="The Hotel" style="width:100%; height:800px;">
	</a>
	<a href="lodInfor.lod?lodIdx=3">
	<img class="w3-image mySlides" src="images/air4.jpg" alt="The Hotel" style="width:100%; height:800px;">
	</a>
	<script>
		var myIndex = 0;
		carousel();

		function carousel() {
			var i;
			var x = document.getElementsByClassName("mySlides");
			for (i = 0; i < x.length; i++) {
				x[i].style.display = "none";
			}
			myIndex++;
			if (myIndex > x.length) {
				myIndex = 1
			}
			x[myIndex - 1].style.display = "block";
			setTimeout(carousel, 10000); // Change image every 2 seconds
		}
	</script>
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
	
		/* $.datepicker.setDefaults({
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
		}); */
		
		function searchCheck() {
			let checkIn = document.getElementById("checkIn").value;
			let checkOut = document.getElementById("checkOut").value;
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
			else if(peopleNum == "") {
				alert("숙박인원을 입력해주세요.");
				document.getElementById("peopleNum").focus();
				return false;
			}
			
			myForm.submit();
		}
		
	</script>
  	
  <div class="w3-display-left w3-padding w3-col l6 m8" style="top:40%;">
    <div class="w3-container w3-theme p-2" style="border-radius: 10px 10px 0px 0px;">
      <h2><i class="fa-solid fa-person-walking-luggage"></i>&nbsp;Reservation</h2>
    </div>
    <div class="w3-container w3-white w3-padding-16" style="border-radius: 0px 0px 30px 10px;">
      <form name="myForm" action="${ctp}/resSearch.res" target="_blank">
        <div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-half w3-margin-bottom">
            <label><i class="fa fa-calendar-o"></i>&nbsp; Check In</label>
            <input class="w3-input w3-border" type="text" title="숙박 시작 일자" placeholder="YYYY-DD-MM" name="checkIn" id="checkIn" autocomplete="off">
          </div>
          <div class="w3-half">
            <label><i class="fa fa-calendar-o"></i>&nbsp; Check Out</label>
            <input class="w3-input w3-border" type="text" title="숙박 마지막 일자" placeholder="YYYY-DD-MM" name="checkOut" id="checkOut" autocomplete="off">
          </div>
        </div>
        <div class="w3-row-padding" style="margin:8px -16px;">
           <div class="w3-half">
            <label><i class="fa-solid fa-map-location-dot"></i>&nbsp; travel area </label>
            <select class="w3-select w3-border" name="area" title="숙박할 지역">
            	<option value="어디든지" selected>Like anywhere! 어디든지!</option>
            	<option value="유럽">유럽</option>
            	<option value="아시아">아시아</option>
            	<option value="미국">미국</option>
            	<option value="프랑스">프랑스</option>
            	<option value="이탈리아">이탈리아</option>
            </select>
          </div>
          <div class="w3-half w3-margin-bottom">
            <label><i class="fa-solid fa-person-circle-question"></i>&nbsp;Number of people</label>
            <input class="w3-input w3-border" type="number" value="1" id="peopleNum" name="peopleNum" min="1" title="숙박할 인원">
          </div>
        </div>
        <div class="text-right">
        	<button class="w3-button w3-amber" type="button" onclick="searchCheck()"><i class="fa fa-search w3-margin-right"></i> Search</button>
        </div>
        
      </form>
    </div>
  </div>
</header>