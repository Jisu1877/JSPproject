<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>payment_confirmation.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	table { table-layout:fixed; }
    	#table2 {
    		font-size:20px;
    		border: 1px solid black;
    	}
    </style>
    <script>
    	let payment_price_cal = 0;
    	let changePoint = 0;
    	
    	function ownPointUse(i) {
			let point = document.getElementById("point").value;
			let ownPoint = ${ownPoint}
			let payment_price = ${vo.payment_price}
			
			if(i == 1) {
				document.getElementById("point").value = ownPoint;
				let point2 = document.getElementById("point").value;
				if(point2 == "") {
					document.getElementById("zeroPoint").style.display = "none";
					document.getElementById("pointUse").style.display = "block";
					document.getElementById("pointUse").innerText = "-0" + point + "Point";
					
					payment_price_cal = Number(payment_price) - Number(point2); 
					
					document.getElementById("payment").style.display = "none";
					document.getElementById("priceCalc").style.display = "block";
					document.getElementById("priceCalc").innerText = payment_price_cal.toLocaleString() + " 원";
					
					changePoint = payment_price_cal * (5/100);
					let changePoint2 = Math.floor(changePoint).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
					
					document.getElementById("originPoint").style.display = "none";
					document.getElementById("changePoint").style.display = "block";
					document.getElementById("changePoint").innerText = changePoint2 + " Point";
					return false;
				}
				
				document.getElementById("zeroPoint").style.display = "none";
				document.getElementById("pointUse").style.display = "block";
				
				document.getElementById("pointUse").innerText = "-" + point2 + " Point";
				
				payment_price_cal = Number(payment_price) - Number(point2); 
				
				document.getElementById("payment").style.display = "none";
				document.getElementById("priceCalc").style.display = "block";
				document.getElementById("priceCalc").innerText = payment_price_cal.toLocaleString() + " 원";
				
				changePoint = payment_price_cal * (5/100);
				let changePoint2 = Math.floor(changePoint).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
				
				document.getElementById("originPoint").style.display = "none";
				document.getElementById("changePoint").style.display = "block";
				document.getElementById("changePoint").innerText = changePoint2 + " Point";
				return false;
			}
			
			if(point > ownPoint) {
				alert("보유하신 포인트보다 많은 포인트를 입력하셨습니다.");
				document.getElementById("point").focus();
				return false;
			}
			else if(point < 0) {
				alert("포인트는 음수값을 입력할 수 없습니다.");
				document.getElementById("point").focus();
				return false;
			}
			else {
					if(point == "") {
						document.getElementById("zeroPoint").style.display = "none";
						document.getElementById("pointUse").style.display = "block";
						document.getElementById("pointUse").innerText = "-0" + point + " Point";
						
						payment_price_cal = Number(payment_price) - Number(point); 
						
						document.getElementById("payment").style.display = "none";
						document.getElementById("priceCalc").style.display = "block";
						document.getElementById("priceCalc").innerText = payment_price_cal.toLocaleString() + " 원";
						
						changePoint = payment_price_cal * (5/100);
						let changePoint2 = Math.floor(changePoint).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
						
						document.getElementById("originPoint").style.display = "none";
						document.getElementById("changePoint").style.display = "block";
						document.getElementById("changePoint").innerText = changePoint2 + " Point";
						
						return false;
					}
					else {
						document.getElementById("zeroPoint").style.display = "none";
						document.getElementById("pointUse").style.display = "block";
						
						document.getElementById("pointUse").innerText = "-" + point + " Point";
						
						payment_price_cal = Number(payment_price) - Number(point); 
						
						document.getElementById("payment").style.display = "none";
						document.getElementById("priceCalc").style.display = "block";
						document.getElementById("priceCalc").innerText = payment_price_cal.toLocaleString() + " 원";
						
						changePoint = payment_price_cal * (5/100);
						let changePoint2 = Math.floor(changePoint).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
						
						document.getElementById("originPoint").style.display = "none";
						document.getElementById("changePoint").style.display = "block";
						document.getElementById("changePoint").innerText = changePoint2 + " Point";
					}
			}
		}
    	
    	
    	$(function() {

    		  $('.button-class1').click(function(){
    		    if( $(this).hasClass('btn-default') ) $(this).removeClass('btn-default');
    		    if( !$(this).hasClass('btn-warning') ) $(this).addClass('btn-warning');
    		    if( $('.button-class2').hasClass('btn-warning') ) $('.button-class2').removeClass('btn-warning');
    		    if( !$('.button-class2').hasClass('btn-default') ) $('.button-class2').addClass('btn-default');
    		  });
    		  
    		  $('.button-class2').click(function(){
    		    if( $(this).hasClass('btn-default') ) $(this).removeClass('btn-default');
    		    if( !$(this).hasClass('btn-warning') ) $(this).addClass('btn-warning');
    		    if( $('.button-class1').hasClass('btn-warning') ) $('.button-class1').removeClass('btn-warning');
    		    if( !$('.button-class1').hasClass('btn-default') ) $('.button-class1').addClass('btn-default');
    		  });
    		  
    	});
    	
    	let buttonSw = 0;
    	function buttonCheck() {
    		buttonSw = 1;
		}
    	
    	//결제하기
    	function payInput() {
			if(buttonSw == 0) {
				alert("결제방식을 선택해주세요.");
				return false;
			}
			else if(!document.getElementById("checked").checked) {
				alert("결제내역 확인 체크박스를 체크해주세요.");
	            return false;
			}
			
			if(payment_price_cal != 0) {
				document.getElementById("priceCal").value  = payment_price_cal;
			}
			else {
				document.getElementById("priceCal").value = ${vo.payment_price};
			}
			
			if(changePoint != 0) {
				 document.getElementById("appPoint").value = Math.floor(changePoint);
			}
			else {
				document.getElementById("appPoint").value  = ${vo.point};
			}
			payForm.submit();
			
		}
    </script>
</head>
<body>
<%@ include file="/include/nav2.jsp" %>
<p><br/><p>
<div class="container" style="margin-bottom:100px">
		<div class="container p-3">
			<h1 class="headerJoin text-center"><strong> 결제 확인</strong></h1><p><br></p>
			<form name="payForm" method="post" action="reserInput.res">
				<div class="w3-row-padding w3-padding-16">
					<div class="w3-half" style="border: 1px solid black; margin-bottom: 20px;">
						<table class="table table-borderless" style="font-size : 17px;">
							<colgroup>
								<col style="width:30%;">
								<col style="width:70%;">
							</colgroup>
							<tr>
								<td colspan="2" style="font-size:25px;"><b>예약 정보</b></td>
							</tr>
							<tr>
								<td><b>숙소명</b></td>
								<td>${lod_name}</td>
							</tr>
							<tr>
								<td><b>숙소 주소</b></td>
								<td>${address}</td>
							</tr>
							<tr>
								<td><b>회원아이디</b></td>
								<td>${mid}</td>
							</tr>
							<tr>
								<td><b>체크인</b></td>
								<td>${vo.check_in} &nbsp;pm 03:00</td>
							</tr>
							<tr>
								<td><b>체크아웃</b></td>
								<td>${vo.check_out} &nbsp;am 11:00</td>
							</tr>
							<tr>
								<td><b>숙박 인원수</b></td>
								<td>${vo.number_guests}명</td>
							</tr>
							<tr>
								<td><b>숙박 기간</b></td>
								<td>총 ${vo.term}박</td>
							</tr>
							<tr>
								<td><b>포인트 사용</b></td>
								<td>
									<div class="input-group mb-1">
						    			<input class="input w3-border form-control" id="point" name="usePoint" type="number" onchange="ownPointUse(0)">
						    			<div class="input-group-append">
									      	<input type="button" value="전액사용" class="btn btn-outline-danger" onclick="ownPointUse(1)"/>
									    </div>
						    		</div>
									보유포인트 : <fmt:formatNumber value="${ownPoint}"/> Point
								</td>
							</tr>
						</table>
					</div>
					<div class="w3-half">
						<table class="table table-borderless w3-centered" id="table2">
							<colgroup>
								<col style="width:40%;">
								<col style="width:60%;">
							</colgroup>
							<tr>
								<td colspan="2" style="font-size:25px;"><b>결제금액</b></td>
							</tr>
							<tr>
								<td><b>결제 금액</b></td>
								<td><fmt:formatNumber value="${vo.payment_price}"/> 원</td>
							</tr>
							<tr>
								<td><b>포인트 사용</b></td>
								<td id="zeroPoint">-0 Point</td>
								<td style="display: none;" id="pointUse"></td>
							</tr>
							<tr>
								<td colspan="2"><hr></td>
							</tr>
							<tr>
								<td><b>총 결제금액</b></td>
								<td id="payment" style="font-size: 23px;"><fmt:formatNumber value="${vo.payment_price}"/> 원</td>
								<td id="priceCalc" style="display: none; font-size: 23px;"></td>
							</tr>
							<tr>
								<td><b>포인트 적립</b></td>
								<td style="font-size: 20px;" id="originPoint"><fmt:formatNumber value="${vo.point}"/> Point</td>
								<td style="font-size: 20px;" id="changePoint"></td>
							</tr>
							<tr>
								<td colspan="2"><hr></td>
							</tr>
							<tr>
								<td><b>결제방식 선택</b></td>
								<td style="font-size: 20px;">
									<div class="btn-group">
										<input type="button" value="카드" class="btn btn-outline-warning w3-text-black button-class1" onclick="buttonCheck()"/>
										<input type="button" value="실시간계좌이체" class="btn btn-outline-warning w3-text-black button-class2" onclick="buttonCheck()"/>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type='checkbox' id='checked' name='check'>
	            					<label for='check' style="font-size:16px;"> &nbsp;&nbsp;<a onclick="javascript:$('#checked').click();"> 상기 결제 내역을 모두 확인했습니다.</a> </label>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div>
										<input type="button" value="결제하기" class="btn w3-theme form-control" onclick="payInput()" style="height: 45px; font-size:18px;"/>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<input type="hidden" name="checkIn" value="${vo.check_in}"/>
				<input type="hidden" name="checkOut" value="${vo.check_out}"/>
				<input type="hidden" name="peopleNum" value="${vo.number_guests}"/>
				<input type="hidden" name="priceCal" id="priceCal"/>
				<input type="hidden" name="dateDays" value="${vo.term}"/>
				<input type="hidden" name="point" id="appPoint"/>
				<input type="hidden" name="mem_idx" value="${memVo.idx}"/>
				<input type="hidden" name="lod_idx" value="${vo.lod_idx}"/>
			</form>
		</div>
	</div>
<p><br/><p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>