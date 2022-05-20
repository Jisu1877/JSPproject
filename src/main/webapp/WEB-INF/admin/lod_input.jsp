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
   	let cnt = 1;
   	function fileBoxAppend() {
		cnt++;
		let fileBox = "";
		fileBox += '<div id="fBox'+cnt+'" class="form-group">';
		fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" style="width:85%; float:left"/>';
		fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn w3-black w3-small ml-2"/>';
		fileBox += '</div>';
   		document.getElementById("photoLabel").style.display = "block";
		$("#fileBoxInsert").append(fileBox);
	}
   	
   	function deleteBox(cnt) {
		$("#fBox"+cnt).remove();
		
	}
   	
   	function fCheck() {
   		let fName = $("#fName1").val();
   		let maxSize = 1024 * 1024 * 20;
   		
   		if(fName.trim() == "") {
   			alert("업로드할 파일을 선택하세요.");
   			return false;
   		}
   		
   		let fileSize = 0;
   		for(let i=1; i<=cnt; i++) {
   			let imsiName = "fName" + i;
   			fName = document.getElementById(imsiName).value;
   			if(fName != ""){
   				let ext = fName.substring(fName.lastIndexOf(".")+1);
   	    		let uExt = ext.toUpperCase();
   	    		fileSize += document.getElementById(imsiName).files[0].size; //파일 선택이 1개밖에 안되기 때문에 0번 배열에만 파일이 있는 상태이다.

   	    		if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "ZIP" && uExt != "HWP" && uExt != "MP4") {
   	    			alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/mp4' 입니다.");
   	    			return false;
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
</script>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <span class="w3-bar-item w3-right w3-white"><a href="${ctp}/">Home</a></span>
</div>

<%@ include file="/include/admin_sidebar_menu.jsp" %>


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
			    <form name="myForm" method="post" action="${ctp}/memJoinOk.mem" class="was-validated" enctype="multipart/form-data">
			    	<div class="form-group">
			    		<div class="w3-row-padding w3-padding-16">
			      		<div class="input-group mb-3 w3-third">
			      			<label><i class="fa-solid fa-map-location-dot"></i>&nbsp; 대분류(지역) </label>
				            <select class="w3-select w3-border" id="category_code" name="category_code">
				            	<option value="">Please select area</option>
				            	<option value="AR-1">유럽</option>
				            	<option value="AR-2">아시아</option>
				            	<option value="AR-3">미국</option>
				            	<option value="AR-4">프랑스</option>
				            	<option value="AR-5">이탈리아</option>
				            	<option value="AR-6">기타</option>
				            </select>
			    		</div>
			    		<div class="input-group mb-3 w3-third">
			    			<label><i class="fa-solid fa-people-roof"></i>&nbsp; 중분류(크기) </label>
				            <select class="w3-select w3-border" id="sub_category_code" name="sub_category_code">
				            	<option value="">Please select size</option>
				            	<option value="SI-1">대형(침실 5개이상)</option>
				            	<option value="SI-2">중형(침실 2개이상)</option>
				            	<option value="SI-3">소형(침실 1개)</option>
				            </select>
			    		</div>
			    		<div class="input-group mb-3 w3-third">
			    			<label><i class="fa-regular fa-circle-question"></i>&nbsp; 소분류(특성) </label>
				            <select class="w3-select w3-border" id="detail_category_code" name="detail_category_code">
				            	<option value="">Please select characteristic</option>
				            	<option value="CH-1">최고의 전망</option>
				            	<option value="CH-2">디자인</option>
				            	<option value="CH-3">해변근처</option>
				            	<option value="CH-4">캠핑장</option>
				            	<option value="CH-5">돔하우스</option>
				            	<option value="CH-6">동굴</option>
				            	<option value="CH-7">서핑</option>
				            	<option value="CH-8">호숫가</option>
				            	<option value="CH-9">한적한 시골</option>
				            	<option value="CH-10">열대지역</option>
				            	<option value="CH-11">통나무집</option>
				            	<option value="CH-12">멋진 수영장</option>
				            	<option value="CH-13">캐슬</option>
				            	<option value="CH-14">북극</option>
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
					    		</div>
					    	</div>
					    	<div class="form-group">
					    		<label for="price">가격&nbsp; [1박 기준] : &nbsp; &nbsp;</label>
					      		<div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" id="price" name="price" type="text" placeholder="숙소 가격을 입력하세요." required>
					    			<div class="input-group-append">
								      	<input type="button" value="￦" size="2" class="btn w3-black" title="천단위 구분"/>
								    </div>
					    		</div>
							    <div style="font-size:0.9em; color:grey; margin-top:0px"><i class="fa-solid fa-circle-exclamation"></i> 주말 숙박 가격은 자동 10% 인상된 가격으로 설정됩니다.</div>
				    		</div>
				    		<div class="form-group">
					    		<label for="number_guests">숙박 가능 인원수 : &nbsp; &nbsp;</label>
					      		<div class="input-group mb-3">
					    			<input class="input w3-padding-16 w3-border form-control" id="number_guests" name="number_guests" type="number" maxlength="3" min="0" max="100" placeholder="숙박 가능 인원수룰 입력하세요." required>
					    		</div>
					    	</div>
				    		<div class="form-group">
				    		<label for="country">숙소 위치(국가) : &nbsp; &nbsp;</label>
				      		<div class="input-group mb-3">
				    			 <select class="w3-select w3-border" id="country" name="country">
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
									<option data-countryCode="PF" value="689">French Polynesia (+689)</option>
									<option data-countryCode="GA" value="241">Gabon (+241)</option>
									<option data-countryCode="GM" value="220">Gambia (+220)</option>
									<option data-countryCode="GE" value="7880">Georgia (+7880)</option>
									<option data-countryCode="DE" value="49">Germany (+49)</option>
									<option data-countryCode="GH" value="233">Ghana (+233)</option>
									<option data-countryCode="GI" value="350">Gibraltar (+350)</option>
									<option data-countryCode="GR" value="30">Greece (+30)</option>
									<option data-countryCode="GL" value="299">Greenland (+299)</option>
									<option data-countryCode="GD" value="1473">Grenada (+1473)</option>
									<option data-countryCode="GP" value="590">Guadeloupe (+590)</option>
									<option data-countryCode="GU" value="671">Guam (+671)</option>
									<option data-countryCode="GT" value="502">Guatemala (+502)</option>
									<option data-countryCode="GN" value="224">Guinea (+224)</option>
									<option data-countryCode="GW" value="245">Guinea - Bissau (+245)</option>
									<option data-countryCode="GY" value="592">Guyana (+592)</option>
									<option data-countryCode="HT" value="509">Haiti (+509)</option>
									<option data-countryCode="HN" value="504">Honduras (+504)</option>
									<option data-countryCode="HK" value="852">Hong Kong (+852)</option>
									<option data-countryCode="HU" value="36">Hungary (+36)</option>
									<option data-countryCode="IS" value="354">Iceland (+354)</option>
									<option data-countryCode="IN" value="91">India (+91)</option>
									<option data-countryCode="ID" value="62">Indonesia (+62)</option>
									<option data-countryCode="IR" value="98">Iran (+98)</option>
									<option data-countryCode="IQ" value="964">Iraq (+964)</option>
									<option data-countryCode="IE" value="353">Ireland (+353)</option>
									<option data-countryCode="IL" value="972">Israel (+972)</option>
									<option data-countryCode="IT" value="39">Italy (+39)</option>
									<option data-countryCode="JM" value="1876">Jamaica (+1876)</option>
									<option data-countryCode="JP" value="81">Japan (+81)</option>
									<option data-countryCode="JO" value="962">Jordan (+962)</option>
									<option data-countryCode="KZ" value="7">Kazakhstan (+7)</option>
									<option data-countryCode="KE" value="254">Kenya (+254)</option>
									<option data-countryCode="KI" value="686">Kiribati (+686)</option>
									<option data-countryCode="KP" value="850">Korea North (+850)</option>
									<option data-countryCode="KR" value="82">Korea South (+82)</option>
									<option data-countryCode="KW" value="965">Kuwait (+965)</option>
									<option data-countryCode="KG" value="996">Kyrgyzstan (+996)</option>
									<option data-countryCode="LA" value="856">Laos (+856)</option>
									<option data-countryCode="LV" value="371">Latvia (+371)</option>
									<option data-countryCode="LB" value="961">Lebanon (+961)</option>
									<option data-countryCode="LS" value="266">Lesotho (+266)</option>
									<option data-countryCode="LR" value="231">Liberia (+231)</option>
									<option data-countryCode="LY" value="218">Libya (+218)</option>
									<option data-countryCode="LI" value="417">Liechtenstein (+417)</option>
									<option data-countryCode="LT" value="370">Lithuania (+370)</option>
									<option data-countryCode="LU" value="352">Luxembourg (+352)</option>
									<option data-countryCode="MO" value="853">Macao (+853)</option>
									<option data-countryCode="MK" value="389">Macedonia (+389)</option>
									<option data-countryCode="MG" value="261">Madagascar (+261)</option>
									<option data-countryCode="MW" value="265">Malawi (+265)</option>
									<option data-countryCode="MY" value="60">Malaysia (+60)</option>
									<option data-countryCode="MV" value="960">Maldives (+960)</option>
									<option data-countryCode="ML" value="223">Mali (+223)</option>
									<option data-countryCode="MT" value="356">Malta (+356)</option>
									<option data-countryCode="MH" value="692">Marshall Islands (+692)</option>
									<option data-countryCode="MQ" value="596">Martinique (+596)</option>
									<option data-countryCode="MR" value="222">Mauritania (+222)</option>
									<option data-countryCode="YT" value="269">Mayotte (+269)</option>
									<option data-countryCode="MX" value="52">Mexico (+52)</option>
									<option data-countryCode="FM" value="691">Micronesia (+691)</option>
									<option data-countryCode="MD" value="373">Moldova (+373)</option>
									<option data-countryCode="MC" value="377">Monaco (+377)</option>
									<option data-countryCode="MN" value="976">Mongolia (+976)</option>
									<option data-countryCode="MS" value="1664">Montserrat (+1664)</option>
									<option data-countryCode="MA" value="212">Morocco (+212)</option>
									<option data-countryCode="MZ" value="258">Mozambique (+258)</option>
									<option data-countryCode="MN" value="95">Myanmar (+95)</option>
									<option data-countryCode="NA" value="264">Namibia (+264)</option>
									<option data-countryCode="NR" value="674">Nauru (+674)</option>
									<option data-countryCode="NP" value="977">Nepal (+977)</option>
									<option data-countryCode="NL" value="31">Netherlands (+31)</option>
									<option data-countryCode="NC" value="687">New Caledonia (+687)</option>
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
					    		<label for="introduce">한줄 소개 : &nbsp; &nbsp;</label>
					      		<div class="input-group mb-3">
					    			<input class="input w3-padding-16 w3-border form-control" id="introduce" name="introduce" type="text" placeholder="한줄 소개를 입력하세요." required>
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
					    		<div style="text-align:right">
								<input type="button" value="사진 추가" onclick="fileBoxAppend()" class="btn w3-small w3-theme mb-2"/><br>
								</div>
								<div class="mb-2">썸네일 사진 : </div>
								<input type="file" name="fName1" id="fName1" class="form-control-file border" autofocus />
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
											    <input type="radio" name="air_conditioner" value="n" checked>&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="air_conditioner" value="y">&nbsp;&nbsp;있음
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
											    <input type="radio" name="tv" value="n" checked>&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="tv" value="y">&nbsp;&nbsp;있음
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
											    <input type="radio" name="wifi" value="n" checked>&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="wifi" value="y">&nbsp;&nbsp;있음
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
											    <input type="radio" name="washer" value="n" checked>&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="washer" value="y">&nbsp;&nbsp;있음
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
											    <input type="radio" name="kitchen" value="n" checked>&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="kitchen" value="y">&nbsp;&nbsp;있음
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
											    <input type="radio" name="heating" value="n" checked>&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="heating" value="y">&nbsp;&nbsp;있음
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
											    <input type="radio" name="toiletries" value="n" checked>&nbsp;&nbsp;없음&nbsp;&nbsp;&nbsp;
											    <input type="radio" name="toiletries" value="y">&nbsp;&nbsp;있음
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
								    			&nbsp;&nbsp;&nbsp;&nbsp;<input class="input w3-padding-16 w3-border form-control" id="number_guests" name="number_guests" type="number" maxlength="3" min="0" max="100">
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
								    			&nbsp;&nbsp;&nbsp;&nbsp;<input class="input w3-padding-16 w3-border form-control" id="number_guests" name="number_guests" type="number" maxlength="3" min="0" max="100">
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
								    			&nbsp;&nbsp;&nbsp;&nbsp;<input class="input w3-padding-16 w3-border form-control" id="number_guests" name="number_guests" type="number" maxlength="3" min="0" max="100">
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
			      <p style="text-align: center;"><button class="w3-button w3-black w3-padding-large" type="button" onclick="fCheck()">회원가입</button></p>
			      <input type="hidden" name="photo"/>
				  <input type="hidden" name="email"/>
				  <input type="hidden" name="tel"/>
				  <input type="hidden" name="agreementCheck" value="${agreementCheck}"/>
			    </form>
			    	</div>
			    </div>
		    <div class="w3-col m2 l2 w3-margin-bottom"></div>
	    </div>
  </section>

</div>
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey text-center">
    <p>Copyright © The Fantastic Lodging. All Rights reserved.</p>
    <p>Happiness & Rest & Peace</p>
  </footer>

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