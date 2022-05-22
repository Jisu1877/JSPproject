<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.mySlides {display:none;}
</style>
<!-- Header -->
<header class="w3-display-container w3-content" style="max-width:1500px;">
	<img class="w3-image mySlides" src="images/air1.jpg" alt="The Hotel" style="min-width:1000px; width:100%; height:700px;">
	<img class="w3-image mySlides" src="images/air2.jpg" alt="The Hotel" style="min-width:1000px; width:100%; height:700px;">
	<img class="w3-image mySlides" src="images/air3.jpg" alt="The Hotel" style="min-width:1000px; width:100%; height:700px;">
	<img class="w3-image mySlides" src="images/air4.jpg" alt="The Hotel" style="min-width:1000px; width:100%; height:700px;">
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
		$(function() {
			$('input[name="CheckIn"]').datepicker({
				minDate: new Date()
			});
			$('input[name="CheckOut"]').datepicker({
				minDate: new Date()
			});
		});
		
	</script>
  	
  <div class="w3-display-left w3-padding w3-col l6 m8" style="top:40%;">
    <div class="w3-container w3-theme p-2" style="border-radius: 10px 10px 0px 0px;">
      <h2><i class="fa-solid fa-person-walking-luggage"></i>&nbsp;Reservation</h2>
    </div>
    <div class="w3-container w3-white w3-padding-16" style="border-radius: 0px 0px 30px 10px;">
      <form action="/action_page.php" target="_blank">
        <div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-half w3-margin-bottom">
            <label><i class="fa fa-calendar-o"></i>&nbsp; Check In</label>
            <input class="w3-input w3-border" type="text" placeholder="DD MM YYYY" name="CheckIn" required>
          </div>
          <div class="w3-half">
            <label><i class="fa fa-calendar-o"></i>&nbsp; Check Out</label>
            <input class="w3-input w3-border" type="text" placeholder="DD MM YYYY" name="CheckOut" required>
          </div>
        </div>
        <div class="w3-row-padding" style="margin:8px -16px;">
           <div class="w3-half">
            <label><i class="fa-solid fa-map-location-dot"></i>&nbsp; travel area </label>
            <select class="w3-select w3-border">
            	<option value="">Please select area!</option>
            	<option value="어디든지">어디든지</option>
            	<option value="유럽">유럽</option>
            	<option value="아시아">아시아</option>
            	<option value="미국">미국</option>
            	<option value="프랑스">프랑스</option>
            	<option value="이탈리아">이탈리아</option>
            </select>
          </div>
          <div class="w3-half w3-margin-bottom">
            <label><i class="fa-solid fa-person-circle-question"></i>&nbsp;Number of people</label>
            <input class="w3-input w3-border" type="number" value="1" name="Adults" min="1" max="6">
          </div>
        </div>
        <div class="text-right">
        	<button class="w3-button w3-amber" type="submit"><i class="fa fa-search w3-margin-right"></i> Search</button>
        </div>
        
      </form>
    </div>
  </div>
</header>