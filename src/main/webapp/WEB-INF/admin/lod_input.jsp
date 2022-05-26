<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>숙소 등록 페이지</title>
<%@ include file="/include/bs4.jsp" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
	a {
		text-decoration: none;	
	}
	a:hover {
		color : black;
	}
	input[type=radio]:checked{
            background-color: yellow;
            -webkit-appearance: none;
            -moz-appearance: none;
           /*  margin-left: 16px; */
           	border: 2px solid darkgray;
            width: 14px;
            height: 14px;
            border-radius: 100%;
    }
</style>
<script>
   	'use strict';
   	let nameCheckSw = 0;
   	let cnt = 1;
   	function fileBoxAppend() {
		const fileCount = $('.file_div').length;
		if (fileCount >= 9) {
			alert('더 이상 추가할 수 없습니다.');
			return;
		}
		cnt++;
		let fileBox = "";
		fileBox += '<div id="fBox'+cnt+'" class="form-group file_div">';
		fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" style="width:85%; float:left"/>';
		fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn w3-black w3-small ml-2"/>';
		fileBox += '</div>';
   		document.getElementById("photoLabel").style.display = "block";
		$("#fileBoxInsert").append(fileBox);
	}
   	
   	function deleteBox(cnt) {
		$("#fBox"+cnt).remove();
		
	}
   	
   	function lodNameCheck() {
   		var lod_name = document.getElementById("lod_name").value;
   		
   		if(lod_name.trim() == "") {
   			alert("숙소명을 입력하세요.");
   			return false;
   		}
   		
   		$.ajax({
   			type : "post",
   			url : "${ctp}/lodNameCheck",
   			data : {lod_name : lod_name},
   			success : function(data) {
   				if(data == "nameOk") {
					nameCheckSw = 1;
					alert("등록가능한 숙소명입니다.");
					$('#lod_name').attr('readonly', true);
				}
				else {
					alert("중복된 숙소명입니다. 다시입력해주세요.");
					myForm.lod_name.value = "";
				}
   			},
			error : function() {
				alert("전송오류.");
			}
   		});
	}
   	
   	
   	
   	function lod_input() {
   		//값 가져오기
		var code = $("#category_code option:selected").val();
		var codeSub = $("#sub_category_code option:selected").val();
		var codeDetail = $("#detail_category_code option:selected").val();
		var lod_name = document.getElementById("lod_name").value;
		var price = document.getElementById("price").value;
		var number_guests = document.getElementById("number_guests").value;
		var country = $("#country option:selected").val();
		var address = document.getElementById("address").value;
		var explanation = document.getElementById("explanation").value;
		var bedroom = document.getElementById("bedroom").value;
		var bed = document.getElementById("bed").value;
		var bathroom = document.getElementById("bathroom").value;
   		
   		let fName = $("#fName1").val();
   		let maxSize = 1024 * 1024 * 20;
   		
   		if(code == "") {
   			alert("대분류를 선택하세요.");
   			return false;
   		}
   		else if(codeSub == "") {
   			alert("중분류를 선택하세요.");
   			return false;
   		}
   		else if(codeDetail == "") {
   			alert("소분류를 선택하세요.");
   			return false;
   		}
   		else if(lod_name.trim() == "") {
   			alert("숙소명을 입력하세요.");
   			return false;
   		}
   		else if(nameCheckSw == 0) {
   			alert("숙소명 중복체크가 이루어지지 않았습니다.");
   			return false;
   		}
   		else if(price.trim() == "") {
   			alert("숙소가격을 입력하세요.");
   			return false;
   		}
   		else if(country == "") {
   			alert("숙소위치의 국가를 선택하세요.");
   			return false;
   		}
   		else if(address.trim() == "") {
   			alert("숙소의 상세주소를 입력하세요.");
   			return false;
   		}
   		else if(explanation.trim() == "") {
   			alert("상세설명을 입력하세요.");
   			return false;
   		}
   		else if(fName.trim() == "") {
   			alert("썸네일 사진 등록(최소 1장)은 필수사항입니다.");
   			return false;
   		}
   		else if(bedroom.trim() == "") {
   			alert("침실개수를 입력하세요.");
   			return false;
   		}
   		else if(bed.trim() == "") {
   			alert("침대개수를 입력하세요.");
   			return false;
   		}
   		else if(bathroom.trim() == "") {
   			alert("욕실 개수를 입력하세요.");
   			return false;
   		}
   		
   		let fileSize = 0;
   		for(let i=1; i<=cnt; i++) {
   			let imsiName = "fName" + i;
   			
   			if(imsiName == "fName1") {
   				document.getElementById("sumFname").value = document.getElementById("fName1").value;
   			}
   			if(document.getElementById(imsiName) != null) {
	   			fName = document.getElementById(imsiName).value;
	   			
	   			if(fName.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
					alert("업로드 파일명에 공백을 포함할 수 없습니다.");
					return false;
				}
	   			else if(fName != ""){
	   				let ext = fName.substring(fName.lastIndexOf(".")+1);
	   	    		let uExt = ext.toUpperCase();
	   	    		fileSize += document.getElementById(imsiName).files[0].size; //파일 선택이 1개밖에 안되기 때문에 0번 배열에만 파일이 있는 상태이다.
	
	   	    		if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
	   	    			alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF' 입니다.");
	   	    			return false;
	   	    		}
	   			}
   			}
   		}
   		
   		if(fileSize > maxSize) {
   			alert("업로드할 파일의 총 최대 용량은 20MByte 입니다.");
   			return false;
   		}    		
   		else {
			myForm.submit();
   		}
	}
   /* 	
   	function priceToString(price) {
   	    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
   	}
   	
   	function numberFomat() {
   		let price = document.getElementById("price").value;
   		if(price.trim() == "") {
   			alert("가격을 입력하세요.");
   			return false;
   		}
   		let price2 = priceToString(price);
   		document.getElementById("price").value = price2;
   		numberFomatSw = 1;
	} */
</script>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <span class="w3-bar-item w3-right w3-white"><a href="${ctp}/">Home</a></span>
</div>

<%@ include file="/include/admin_sidebarMenu.jsp" %>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    <h5><b><i class="fa-solid fa-tents"></i> Lodging management</b></h5>
  </header>

  <section>
  <p><br/><p>
	  <div class="w3-container" id="contact">
	    <h2 class="headerJoin text-center">Lodging Registration</h2>
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m2 l2 w3-margin-bottom"></div>
			<div class="w3-col m8 l8 w3-margin-bottom">
			    <form name="myForm" method="post" action="${ctp}/lod_Input_Ok.ad" class="was-validated" enctype="multipart/form-data">
			    	<div class="form-group">
			    		<div class="w3-row-padding w3-padding-16">
			      		<div class="input-group mb-3 w3-third">
			      			<label><i class="fa-solid fa-map-location-dot"></i>&nbsp; 대분류(지역) </label>
				            <select class="w3-select w3-border" id="category_code" name="category_code">
				            	<option value="">Please select area</option>
				            	<option value="100">유럽</option>
				            	<option value="101">아시아</option>
				            	<option value="102">미국</option>
				            	<option value="103">프랑스</option>
				            	<option value="104">이탈리아</option>
				            	<option value="105">기타</option>
				            </select>
			    		</div>
			    		<div class="input-group mb-3 w3-third">
			    			<label><i class="fa-solid fa-people-roof"></i>&nbsp; 중분류(크기) </label>
				            <select class="w3-select w3-border" id="sub_category_code" name="sub_category_code">
				            	<option value="">Please select size</option>
				            	<option value="200">대형(침실 5개이상)</option>
				            	<option value="201">중형(침실 2개이상)</option>
				            	<option value="202">소형(침실 1개)</option>
				            </select>
			    		</div>
			    		<div class="input-group mb-3 w3-third">
			    			<label><i class="fa-regular fa-circle-question"></i>&nbsp; 소분류(특성) </label>
				            <select class="w3-select w3-border" id="detail_category_code" name="detail_category_code">
				            	<option value="">Please select characteristic</option>
				            	<option value="300">최고의 전망</option>
				            	<option value="301">디자인</option>
				            	<option value="302">해변근처</option>
				            	<option value="303">캠핑장</option>
				            	<option value="304">돔하우스</option>
				            	<option value="305">동굴</option>
				            	<option value="306">서핑</option>
				            	<option value="307">호숫가</option>
				            	<option value="308">한적한 시골</option>
				            	<option value="309">열대지역</option>
				            	<option value="310">통나무집</option>
				            	<option value="311">멋진 수영장</option>
				            	<option value="312">캐슬</option>
				            	<option value="313">북극</option>
				            </select>
			    		</div>
			    		</div>
			    	</div>
			    	<div class="w3-row-padding">
				    	<div class="w3-col m2 l2 w3-margin-bottom"></div>
				    	<div class="w3-col m8 l8 w3-margin-bottom">
					    	<div class="form-group">
					    		<label for="lod_name">숙소명 : &nbsp; &nbsp;</label>
					      		<div class="input-group mb-3">
					    			<input class="input w3-padding-16 w3-border form-control" id="lod_name" name="lod_name" type="text" placeholder="숙소명을 입력하세요." required>
					    			<div class="input-group-append">
								      	<input type="button" value="중복체크" class="btn w3-theme" onclick="lodNameCheck()"/>
								    </div>
					    		</div>
					    		<div style="font-size:0.9em; color:grey; margin-top:0px"><i class="fa-solid fa-circle-exclamation"></i> <font color="red">숙소명은 추후 수정이 불가합니다.</font> 숙소의 특성을 담아 간단히 작성하세요.</div>
					    	</div>
					    	<div class="form-group">
					    		<label for="price">가격&nbsp; [1박 기준] : &nbsp; &nbsp;</label>
					      		<div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" id="price" name="price" type="number" placeholder="숙소 가격을 입력하세요." required>
					    			<div class="input-group-append">
								      	<input type="button" value="￦" size="2" class="btn w3-black" disabled='disabled' />
								    </div>
					    		</div>
				    		</div>
				    		<div class="form-group">
					    		<label for="number_guests">숙박 가능 최대 인원수 : &nbsp; &nbsp;</label>
					      		<div class="input-group mb-3">
					    			<input class="input w3-padding-16 w3-border form-control" id="number_guests" name="number_guests" type="number" maxlength="3" min="0" max="100" placeholder="숙박 가능 인원수룰 입력하세요." required>
					    		</div>
					    	</div>
				    		<div class="form-group">
				    		<label for="country">숙소 위치(국가) : &nbsp; &nbsp;</label>
				      		<div class="input-group mb-3">
				    			 <select class="w3-select w3-border" id="country" name="country">
				    			 	<optgroup label="country">
										<option value="">Please select countries</option>
										<option data-countryCode="DZ" value="Algeria">Algeria (+213)</option>
										<option data-countryCode="AD" value="Andorra">Andorra (+376)</option>
										<option data-countryCode="AO" value="Angola">Angola (+244)</option>
										<option data-countryCode="AI" value="Anguilla">Anguilla (+1264)</option>
										<option data-countryCode="AG" value="Antigua&Barbuda">Antigua &amp; Barbuda (+1268)</option>
										<option data-countryCode="AR" value="Argentina">Argentina (+54)</option>
										<option data-countryCode="AM" value="Armenia">Armenia (+374)</option>
										<option data-countryCode="AW" value="Aruba">Aruba (+297)</option>
										<option data-countryCode="AU" value="Australia">Australia (+61)</option>
										<option data-countryCode="AT" value="Austria">Austria (+43)</option>
										<option data-countryCode="AZ" value="Azerbaijan">Azerbaijan (+994)</option>
										<option data-countryCode="BS" value="Bahamas">Bahamas (+1242)</option>
										<option data-countryCode="BH" value="Bahrain">Bahrain (+973)</option>
										<option data-countryCode="BD" value="Bangladesh">Bangladesh (+880)</option>
										<option data-countryCode="BB" value="Barbados">Barbados (+1246)</option>
										<option data-countryCode="BY" value="Belarus">Belarus (+375)</option>
										<option data-countryCode="BE" value="Belgium">Belgium (+32)</option>
										<option data-countryCode="BZ" value="Belize">Belize (+501)</option>
										<option data-countryCode="BJ" value="Benin">Benin (+229)</option>
										<option data-countryCode="BM" value="Bermuda">Bermuda (+1441)</option>
										<option data-countryCode="BT" value="Bhutan">Bhutan (+975)</option>
										<option data-countryCode="BO" value="Bolivia">Bolivia (+591)</option>
										<option data-countryCode="BA" value="Bosnia Herzegovina">Bosnia Herzegovina (+387)</option>
										<option data-countryCode="BW" value="Botswana">Botswana (+267)</option>
										<option data-countryCode="BR" value="Brazil">Brazil (+55)</option>
										<option data-countryCode="BN" value="Brunei">Brunei (+673)</option>
										<option data-countryCode="BG" value="Bulgaria">Bulgaria (+359)</option>
										<option data-countryCode="BF" value="Burkina Faso">Burkina Faso (+226)</option>
										<option data-countryCode="BI" value="Burundi">Burundi (+257)</option>
										<option data-countryCode="KH" value="Cambodia">Cambodia (+855)</option>
										<option data-countryCode="CM" value="Cameroon">Cameroon (+237)</option>
										<option data-countryCode="CA" value="Canada">Canada (+1)</option>
										<option data-countryCode="CV" value="Cape Verde Islands">Cape Verde Islands (+238)</option>
										<option data-countryCode="KY" value="Cayman Islands">Cayman Islands (+1345)</option>
										<option data-countryCode="CF" value="Central African Republic">Central African Republic (+236)</option>
										<option data-countryCode="CL" value="Chile">Chile (+56)</option>
										<option data-countryCode="CN" value="China">China (+86)</option>
										<option data-countryCode="CO" value="Colombia">Colombia (+57)</option>
										<option data-countryCode="KM" value="Comoros">Comoros (+269)</option>
										<option data-countryCode="CG" value="Congo">Congo (+242)</option>
										<option data-countryCode="CK" value="Cook Islands">Cook Islands (+682)</option>
										<option data-countryCode="CR" value="Costa Rica">Costa Rica (+506)</option>
										<option data-countryCode="HR" value="Croatia">Croatia (+385)</option>
										<option data-countryCode="CU" value="Cuba">Cuba (+53)</option>
										<option data-countryCode="CY" value="Cyprus North">Cyprus North (+90392)</option>
										<option data-countryCode="CY" value="Cyprus South">Cyprus South (+357)</option>
										<option data-countryCode="CZ" value="Czech Republic">Czech Republic (+42)</option>
										<option data-countryCode="DK" value="Denmark">Denmark (+45)</option>
										<option data-countryCode="DJ" value="Djibouti">Djibouti (+253)</option>
										<option data-countryCode="DM" value="Dominica">Dominica (+1809)</option>
										<option data-countryCode="DO" value="Dominican Republic">Dominican Republic (+1809)</option>
										<option data-countryCode="EC" value="Ecuador">Ecuador (+593)</option>
										<option data-countryCode="EG" value="Egypt">Egypt (+20)</option>
										<option data-countryCode="SV" value="El Salvador">El Salvador (+503)</option>
										<option data-countryCode="GQ" value="Equatorial Guinea">Equatorial Guinea (+240)</option>
										<option data-countryCode="ER" value="Eritrea">Eritrea (+291)</option>
										<option data-countryCode="EE" value="Estonia">Estonia (+372)</option>
										<option data-countryCode="ET" value="Ethiopia">Ethiopia (+251)</option>
										<option data-countryCode="FK" value="Falkland Islands">Falkland Islands (+500)</option>
										<option data-countryCode="FO" value="Faroe Islands">Faroe Islands (+298)</option>
										<option data-countryCode="FJ" value="Fiji">Fiji (+679)</option>
										<option data-countryCode="FI" value="Finland">Finland (+358)</option>
										<option data-countryCode="FR" value="France">France (+33)</option>
										<option data-countryCode="GF" value="France Guiana">French Guiana (+594)</option>
										<option data-countryCode="PF" value="French Polynesia">French Polynesia (+689)</option>
										<option data-countryCode="GA" value="Gabon">Gabon (+241)</option>
										<option data-countryCode="GM" value="Gambia">Gambia (+220)</option>
										<option data-countryCode="GE" value="Georgia">Georgia (+7880)</option>
										<option data-countryCode="DE" value="Germany">Germany (+49)</option>
										<option data-countryCode="GH" value="Ghana">Ghana (+233)</option>
										<option data-countryCode="GI" value="Gibraltar">Gibraltar (+350)</option>
										<option data-countryCode="GR" value="Greece">Greece (+30)</option>
										<option data-countryCode="GL" value="Greenland">Greenland (+299)</option>
										<option data-countryCode="GD" value="Grenada">Grenada (+1473)</option>
										<option data-countryCode="GP" value="Guadeloupe">Guadeloupe (+590)</option>
										<option data-countryCode="GU" value="Guam">Guam (+671)</option>
										<option data-countryCode="GT" value="Guatemala">Guatemala (+502)</option>
										<option data-countryCode="GN" value="Guinea">Guinea (+224)</option>
										<option data-countryCode="GW" value="Guinea - Bissau">Guinea - Bissau (+245)</option>
										<option data-countryCode="GY" value="Guyana">Guyana (+592)</option>
										<option data-countryCode="HT" value="Haiti">Haiti (+509)</option>
										<option data-countryCode="HN" value="Honduras">Honduras (+504)</option>
										<option data-countryCode="HK" value="Hong Kong">Hong Kong (+852)</option>
										<option data-countryCode="HU" value="Hungary">Hungary (+36)</option>
										<option data-countryCode="IS" value="Iceland">Iceland (+354)</option>
										<option data-countryCode="IN" value="India">India (+91)</option>
										<option data-countryCode="ID" value="Indonesia">Indonesia (+62)</option>
										<option data-countryCode="IR" value="Iran">Iran (+98)</option>
										<option data-countryCode="IQ" value="Iraq">Iraq (+964)</option>
										<option data-countryCode="IE" value="Ireland">Ireland (+353)</option>
										<option data-countryCode="IL" value="Israel">Israel (+972)</option>
										<option data-countryCode="IT" value="Italy">Italy (+39)</option>
										<option data-countryCode="JM" value="Jamaica">Jamaica (+1876)</option>
										<option data-countryCode="JP" value="Japan">Japan (+81)</option>
										<option data-countryCode="JO" value="Jordan">Jordan (+962)</option>
										<option data-countryCode="KZ" value="Kazakhstan">Kazakhstan (+7)</option>
										<option data-countryCode="KE" value="Kenya">Kenya (+254)</option>
										<option data-countryCode="KI" value="Kiribati">Kiribati (+686)</option>
										<option data-countryCode="KP" value="Korea North">Korea North (+850)</option>
										<option data-countryCode="KR" value="Korea South">Korea South (+82)</option>
										<option data-countryCode="KW" value="Kuwait">Kuwait (+965)</option>
										<option data-countryCode="KG" value="Kyrgyzstan">Kyrgyzstan (+996)</option>
										<option data-countryCode="LA" value="Laos">Laos (+856)</option>
										<option data-countryCode="LV" value="Latvia">Latvia (+371)</option>
										<option data-countryCode="LB" value="Lebanon">Lebanon (+961)</option>
										<option data-countryCode="LS" value="Lesotho">Lesotho (+266)</option>
										<option data-countryCode="LR" value="Liberia">Liberia (+231)</option>
										<option data-countryCode="LY" value="Libya">Libya (+218)</option>
										<option data-countryCode="LI" value="Liechtenstein">Liechtenstein (+417)</option>
										<option data-countryCode="LT" value="Lithuania">Lithuania (+370)</option>
										<option data-countryCode="LU" value="Luxembourg">Luxembourg (+352)</option>
										<option data-countryCode="MO" value="Macao">Macao (+853)</option>
										<option data-countryCode="MK" value="Macedonia">Macedonia (+389)</option>
										<option data-countryCode="MG" value="Madagascar">Madagascar (+261)</option>
										<option data-countryCode="MW" value="Malawi">Malawi (+265)</option>
										<option data-countryCode="MY" value="Malaysia">Malaysia (+60)</option>
										<option data-countryCode="MV" value="Maldives">Maldives (+960)</option>
										<option data-countryCode="ML" value="Mali">Mali (+223)</option>
										<option data-countryCode="MT" value="Malta">Malta (+356)</option>
										<option data-countryCode="MH" value="Marshall Islands">Marshall Islands (+692)</option>
										<option data-countryCode="MQ" value="Martinique">Martinique (+596)</option>
										<option data-countryCode="MR" value="Mauritania">Mauritania (+222)</option>
										<option data-countryCode="YT" value="Mayotte">Mayotte (+269)</option>
										<option data-countryCode="MX" value="Mexico">Mexico (+52)</option>
										<option data-countryCode="FM" value="Micronesia">Micronesia (+691)</option>
										<option data-countryCode="MD" value="Moldova">Moldova (+373)</option>
										<option data-countryCode="MC" value="Monaco">Monaco (+377)</option>
										<option data-countryCode="MN" value="Mongolia">Mongolia (+976)</option>
										<option data-countryCode="MS" value="Montserrat">Montserrat (+1664)</option>
										<option data-countryCode="MA" value="Morocco">Morocco (+212)</option>
										<option data-countryCode="MZ" value="Mozambique">Mozambique (+258)</option>
										<option data-countryCode="MN" value="Myanmar">Myanmar (+95)</option>
										<option data-countryCode="NA" value="Namibia">Namibia (+264)</option>
										<option data-countryCode="NR" value="Nauru">Nauru (+674)</option>
										<option data-countryCode="NP" value="Nepal">Nepal (+977)</option>
										<option data-countryCode="NL" value="Netherlands">Netherlands (+31)</option>
										<option data-countryCode="NC" value="New Caledonia">New Caledonia (+687)</option>
										<option data-countryCode="NZ" value="New Zealand">New Zealand (+64)</option>
										<option data-countryCode="NI" value="Nicaragua">Nicaragua (+505)</option>
										<option data-countryCode="NE" value="Niger">Niger (+227)</option>
										<option data-countryCode="NG" value="Nigeria">Nigeria (+234)</option>
										<option data-countryCode="NU" value="Niue">Niue (+683)</option>
										<option data-countryCode="NF" value="Norfolk Islands">Norfolk Islands (+672)</option>
										<option data-countryCode="NP" value="Northern Marianas">Northern Marianas (+670)</option>
										<option data-countryCode="NO" value="Norway">Norway (+47)</option>
										<option data-countryCode="OM" value="Oman">Oman (+968)</option>
										<option data-countryCode="PW" value="Palau">Palau (+680)</option>
										<option data-countryCode="PA" value="Panama">Panama (+507)</option>
										<option data-countryCode="PG" value="Papua New Guinea">Papua New Guinea (+675)</option>
										<option data-countryCode="PY" value="Paraguay">Paraguay (+595)</option>
										<option data-countryCode="PE" value="Peru">Peru (+51)</option>
										<option data-countryCode="PH" value="Philippines">Philippines (+63)</option>
										<option data-countryCode="PL" value="Poland">Poland (+48)</option>
										<option data-countryCode="PT" value="Portugal">Portugal (+351)</option>
										<option data-countryCode="PR" value="Puerto Rico">Puerto Rico (+1787)</option>
										<option data-countryCode="QA" value="Qatar">Qatar (+974)</option>
										<option data-countryCode="RE" value="Reunion">Reunion (+262)</option>
										<option data-countryCode="RO" value="Romania">Romania (+40)</option>
										<option data-countryCode="RU" value="Russia">Russia (+7)</option>
										<option data-countryCode="RW" value="Rwanda">Rwanda (+250)</option>
										<option data-countryCode="SM" value="San Marino">San Marino (+378)</option>
										<option data-countryCode="ST" value="Sao Tome&Principe">Sao Tome &amp; Principe (+239)</option>
										<option data-countryCode="SA" value="Saudi Arabia">Saudi Arabia (+966)</option>
										<option data-countryCode="SN" value="Senegal">Senegal (+221)</option>
										<option data-countryCode="CS" value="Serbia">Serbia (+381)</option>
										<option data-countryCode="SC" value="Seychelles">Seychelles (+248)</option>
										<option data-countryCode="SL" value="Sierra Leone">Sierra Leone (+232)</option>
										<option data-countryCode="SG" value="Singapore">Singapore (+65)</option>
										<option data-countryCode="SK" value="Slovak Republic">Slovak Republic (+421)</option>
										<option data-countryCode="SI" value="Slovenia">Slovenia (+386)</option>
										<option data-countryCode="SB" value="Solomon Islands">Solomon Islands (+677)</option>
										<option data-countryCode="SO" value="Somalia">Somalia (+252)</option>
										<option data-countryCode="ZA" value="South Africa">South Africa (+27)</option>
										<option data-countryCode="ES" value="Spain">Spain (+34)</option>
										<option data-countryCode="LK" value="Sri Lanka">Sri Lanka (+94)</option>
										<option data-countryCode="SH" value="St. Helena">St. Helena (+290)</option>
										<option data-countryCode="KN" value="St. Kitts">St. Kitts (+1869)</option>
										<option data-countryCode="SC" value="St. Lucia">St. Lucia (+1758)</option>
										<option data-countryCode="SD" value="Sudan">Sudan (+249)</option>
										<option data-countryCode="SR" value="Suriname">Suriname (+597)</option>
										<option data-countryCode="SZ" value="Swaziland">Swaziland (+268)</option>
										<option data-countryCode="SE" value="Sweden">Sweden (+46)</option>
										<option data-countryCode="CH" value="Switzerland">Switzerland (+41)</option>
										<option data-countryCode="SI" value="Syria">Syria (+963)</option>
										<option data-countryCode="TW" value="Taiwan">Taiwan (+886)</option>
										<option data-countryCode="TJ" value="Tajikstan">Tajikstan (+7)</option>
										<option data-countryCode="TH" value="Thailand">Thailand (+66)</option>
										<option data-countryCode="TG" value="Togo">Togo (+228)</option>
										<option data-countryCode="TO" value="Tonga">Tonga (+676)</option>
										<option data-countryCode="TT" value="Trinidad&Tobago">Trinidad &amp; Tobago (+1868)</option>
										<option data-countryCode="TN" value="Tunisia">Tunisia (+216)</option>
										<option data-countryCode="TR" value="Turkey">Turkey (+90)</option>
										<option data-countryCode="TM" value="Turkmenistan">Turkmenistan (+7)</option>
										<option data-countryCode="TM" value="Turkmenistan">Turkmenistan (+993)</option>
										<option data-countryCode="TC" value="Turks&Caicos Islands">Turks &amp; Caicos Islands (+1649)</option>
										<option data-countryCode="TV" value="Tuvalu">Tuvalu (+688)</option>
										<option data-countryCode="UG" value="Uganda">Uganda (+256)</option>
										<option data-countryCode="GB" value="UK">UK (+44)</option>
										<option data-countryCode="UA" value="Ukraine">Ukraine (+380)</option>
										<option data-countryCode="AE" value="United Arab Emirates">United Arab Emirates (+971)</option>
										<option data-countryCode="UY" value="Uruguay">Uruguay (+598)</option>
										<option data-countryCode="US" value="USA">USA (+1)</option>
										<option data-countryCode="UZ" value="Uzbekistan">Uzbekistan (+7)</option>
										<option data-countryCode="VU" value="Vanuatu">Vanuatu (+678)</option>
										<option data-countryCode="VA" value="Vatican">Vatican City (+379)</option>
										<option data-countryCode="VE" value="Venezuela">Venezuela (+58)</option>
										<option data-countryCode="VN" value="Vietnam">Vietnam (+84)</option>
										<option data-countryCode="VG" value="Virgin Islands - British">Virgin Islands - British (+1284)</option>
										<option data-countryCode="VI" value="Virgin Islands - US">Virgin Islands - US (+1340)</option>
										<option data-countryCode="WF" value="Wallis&Futuna">Wallis &amp; Futuna (+681)</option>
										<option data-countryCode="YE" value="Yemen (North)">Yemen (North)(+969)</option>
										<option data-countryCode="YE" value="Yemen(South)">Yemen (South)(+967)</option>
										<option data-countryCode="ZM" value="Zambia">Zambia (+260)</option>
										<option data-countryCode="ZW" value="Zimbabwe">Zimbabwe (+263)</option>
									</optgroup>
					            </select>
				    		</div>
				    		<div class="form-group">
					    		<label for="address">주소 : &nbsp; &nbsp;</label>
					      		<div class="input-group mb-3">
					    			<input class="input w3-padding-16 w3-border form-control" id="address" name="address" type="text" placeholder="숙소 주소룰 입력하세요." required>
					    		</div>
					    	</div>
					    	<div class="form-group">
					    		<label for="explanation">숙소 상세 설명 : &nbsp; &nbsp;</label>
					      		<div class="input-group mb-3">
					    			<textarea rows="5" class="input w3-padding-16 w3-border form-control" id="explanation" name="explanation" placeholder="숙소 상세 설명을 입력하세요." style="resize: none;"  required></textarea>
					    		</div>
					    	</div><p><br></p>
					    	<hr style="border: solid 0.1px #ddd; background-color: #ddd; "><p><br></p>
					    	<div class="form-group">
					    		<label for="explanation" style="text-align:center; font-weight: bold;"><i class="fa-solid fa-image"></i>&nbsp; &nbsp;  숙소 사진 등록</label>
					    		<div style="font-size:0.9em; color:grey; margin-top:0px"><i class="fa-solid fa-circle-exclamation"></i> 최대 10장까지 등록가능합니다.</div>
					    		<div style="text-align:right">
								<input type="button" value="사진 추가" onclick="fileBoxAppend()" class="btn w3-small w3-theme mb-2"/><br>
								</div>
								<div class="mb-2">썸네일 사진 : </div>
								<input type="file" name="fName1" id="fName1" class="form-control-file border" accept=".jpg, .gif, .png, .jpeg, .jfif" />
							</div>
							<div class="mb-2" id="photoLabel" style="display: none">추가 사진 :</div>
							<div class="form-group" id="fileBoxInsert"></div><br>
							<hr style="border: solid 0.1px #ddd; background-color: #ddd; "><p><br></p>
						  <p class="text-center" style="font-weight: bold; font-size: 17px;">- 옵션 사항 - </p><br>
						  <table class="table table-borderless">
						  	<tr>
								<td>에어컨이 있나요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="form-check">
											    <input type="radio" name="air_conditioner" value="n" >&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="air_conditioner" value="y" checked>&nbsp;&nbsp;있음
											</div>
									  </div>
								   </div>
								</td>
						  	</tr>
						  	<tr>
								<td>TV가 있나요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="form-check">
											    <input type="radio" name="tv" value="n" >&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="tv" value="y" checked>&nbsp;&nbsp;있음
											</div>
									  </div>
								   </div>
								</td>
						  	</tr>
						  	<tr>
								<td>무선인터넷(wifi)가 있나요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="form-check">
											    <input type="radio" name="wifi" value="n" >&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="wifi" value="y" checked>&nbsp;&nbsp;있음
											</div>
									  </div>
								   </div>
								</td>
						  	</tr>
						  	<tr>
								<td>세탁기가 있나요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="form-check">
											    <input type="radio" name="washer" value="n" >&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="washer" value="y" checked>&nbsp;&nbsp;있음
											</div>
									  </div>
								   </div>
								</td>
						  	</tr>
						  	<tr>
								<td>주방시설이 있나요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="form-check">
											    <input type="radio" name="kitchen" value="n" >&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="kitchen" value="y" checked>&nbsp;&nbsp;있음
											</div>
									  </div>
								   </div>
								</td>
						  	</tr>
						  	<tr>
								<td>난방시설이 있나요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="form-check">
											    <input type="radio" name="heating" value="n" >&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="heating" value="y" checked>&nbsp;&nbsp;있음
											</div>
									  </div>
								   </div>
								</td>
						  	</tr>
						  	<tr>
								<td>세면도구가 비치되어 있나요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="form-check">
											    <input type="radio" name="toiletries" value="n" >&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="toiletries" value="y" checked>&nbsp;&nbsp;있음
											</div>
									  </div>
								   </div>
								</td>
						  	</tr>
						  	<tr>
								<td>침실개수가 몇 개 인가요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="input-group mb-3">
								    			&nbsp;&nbsp;&nbsp;&nbsp;<input class="input w3-padding-16 w3-border form-control" id="bedroom" name="bedroom" type="number" maxlength="3" min="0" max="100" required>
								    		</div>
								    		<span class="mb-3">&nbsp;&nbsp;개</span>
									 	  </div>
								   	</div>
								</td>
						  	</tr>
						  	<tr>
								<td>침대 개수가 몇 개 인가요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="input-group mb-3">
								    			&nbsp;&nbsp;&nbsp;&nbsp;<input class="input w3-padding-16 w3-border form-control" id="bed" name="bed" type="number" maxlength="3" min="0" max="100" required>
								    		</div>
								    		<span class="mb-3">&nbsp;&nbsp;개</span>
									 	  </div>
								   	</div>
								</td>
						  	</tr>
						  	<tr>
								<td>욕실 개수가 몇 개 인가요?</td>
								<td>
									<div class="form-group">
									      <div class="form-check-inline">
								        	<div class="input-group mb-3">
								    			&nbsp;&nbsp;&nbsp;&nbsp;<input class="input w3-padding-16 w3-border form-control" id="bathroom" name="bathroom" type="number" maxlength="3" min="0" max="100" required>
								    		</div>
								    		<span class="mb-3">&nbsp;&nbsp;개</span>
									 	  </div>
								   	</div>
								</td>
						  	</tr>
						  </table>
					  </div>
				  </div>
				    <div class="w3-col m2 l2 w3-margin-bottom"></div>
			    	</div>
				  
				  <p><br></p>
			      <p style="text-align: center;"><button class="w3-btn w3-theme w3-padding-large" type="button" onclick="lod_input()">등록</button>&nbsp;&nbsp;
			      <button class="w3-btn w3-black w3-padding-large" type="reset">다시입력</button></p>
			      <input type="hidden" name="sumFname" id="sumFname"/>
			    </form>
			    	</div>
			    </div>
		    <div class="w3-col m2 l2 w3-margin-bottom"></div>
	    </div>
  </section>

  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey text-center">
    <p>Copyright © The Fantastic Lodging. All Rights reserved.</p>
    <p>Happiness & Rest & Peace</p>
  </footer>
</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>

</body>
</html>