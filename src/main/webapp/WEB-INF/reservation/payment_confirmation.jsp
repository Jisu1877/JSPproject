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
    	function ownPointUse() {
			let point = document.getElementById("point").value;
			let ownPoint = ${ownPoint}
			let payment_price = ${vo.payment_price}
			
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
					document.getElementById("pointUse").innerText = "-" + point + "Point";
				}
				else {
					
				}
				document.getElementById("zeroPoint").style.display = "none";
				document.getElementById("pointUse").style.display = "block";
				
				document.getElementById("pointUse").innerText = "-" + point + "Point";
				
				let payment_price_cal = Number(payment_price) - Number(point); 
				
				document.getElementById("payment").style.display = "none";
				document.getElementById("priceCalc").style.display = "block";
				document.getElementById("priceCalc").innerText = payment_price_cal.toLocaleString() + "원";
			}
		}
    </script>
</head>
<body>
<%@ include file="/include/nav2.jsp" %>
<p><br/><p>
<div class="container" style="margin-bottom:100px">
		<div class="container p-3">
			<h1 class="headerJoin text-center"><strong> 결제 확인</strong></h1><p><br></p>
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
							<td>총 ${vo.term}일</td>
						</tr>
						<tr>
							<td><b>포인트 사용</b></td>
							<td>
								<div class="input-group mb-1">
					    			<input class="input w3-border form-control" id="point" name="point" type="number" onchange="ownPointUse()">
					    			<div class="input-group-append">
								      	<input type="button" value="전액사용" class="btn btn-outline-danger" onclick="idCheck()"/>
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
							<td style="font-size: 20px;"><fmt:formatNumber value="${vo.point}"/> Point</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
<p><br/><p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>