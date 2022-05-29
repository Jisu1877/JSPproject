<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	String agreementCheck = request.getParameter("agreementCheck") == null ? "2" : request.getParameter("agreementCheck");
	pageContext.setAttribute("agreementCheck", agreementCheck); //동의를 2개 했으면 2, 동의를 3개했으면 3이 넘어온다.
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memUpdate.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	//우편번호 검색 다음 api
		function sample6_execDaumPostcode() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            var addr = ''; // 주소 변수
		            var extraAddr = ''; // 참고항목 변수
	
		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }
	
		            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		            if(data.userSelectedType === 'R'){
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraAddr !== ''){
		                    extraAddr = ' (' + extraAddr + ')';
		                }
		                // 조합된 참고항목을 해당 필드에 넣는다.
		                document.getElementById("sample6_extraAddress").value = extraAddr;
		            
		            } else {
		                document.getElementById("sample6_extraAddress").value = '';
		            }
	
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById('sample6_postcode').value = data.zonecode;
		            document.getElementById("sample6_address").value = addr;
		            // 커서를 상세주소 필드로 이동한다.
		            document.getElementById("sample6_detailAddress").focus();
		        }
		    }).open();
		}	
	
	
		// 프로필 사진 삭제
		function previewDelete() {
			let ans = confirm("프로필 사진을 삭제하시겠습니까?");
			if(!ans) {
				return false;				
			}
			document.getElementById("noimageID").style.display = "block";
			document.getElementById("previewId").style.display = "none";
			document.getElementById("photoDelete").style.display = "none";
			$(".noimage").attr("src", "images/noimage.jpg");
			/* document.getElementById("noimage").src = "./images/noimage.jpg"; */
		}
		
		// 프로필사진 미리보기
		function previewImage(targetObj, previewId) { 
			let fName = myForm.myphoto.value;
	 		let ext = fName.substring(fName.lastIndexOf(".")+1); //파일 확장자 발췌
			let uExt = ext.toUpperCase(); //확장자를 대문자로 변환
	 		let maxSize = 1024 * 1024 * 2 //업로드할 회원사진의 용량은 2MByte까지로 제한한다.
			
			let fileSize = document.getElementById("myphoto").files[0].size;  //첫번째 파일의 사이즈..! 아이디를 예약어인 file 로 주기.
		
			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
				alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF'파일입니다.") 					
				return false;
			}
			else if(fName.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
				alert("업로드 파일명에 공백을 포함할 수 없습니다.");
				return false;
			}
			else if(fileSize > maxSize) {
				alert("업로드 파일의 크기는 2MByte를 초과할 수 없습니다.");
				return false;
			}
			
			document.getElementById("noimageID").style.display = "none";
			document.getElementById("photoDelete").style.display = "block";
			document.getElementById("previewId").style.display = "block";
			
			var preview = document.getElementById(previewId);  
			var ua = window.navigator.userAgent; 
			if (ua.indexOf("MSIE") > -1) { 
				targetObj.select(); 
				try { 
					var src = document.selection.createRange().text; 
					var ie_preview_error = document .getElementById("ie_preview_error_" + previewId); 
					
					if (ie_preview_error) { 
						preview.removeChild(ie_preview_error); 
						
					} 
					
					var img = document.getElementById(previewId); //이미지가 뿌려질 곳 
					
					img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='scale')"; 
					
				} catch (e) { 
					if (!document.getElementById("ie_preview_error_" + previewId)) { 
						var info = document.createElement("<p>"); 
						info.id = "ie_preview_error_" + previewId; info.innerHTML = "a"; 
						preview.insertBefore(info, null);
						
					} 
					
				} 
			
			} else {  
				var files = targetObj.files; 
				for ( var i = 0; i < files.length; i++) {
					var file = files[i];
					var imageType = /image.*/;   //이미지 파일일경우만.. 뿌려준다.
					if (!file.type.match(imageType)) 
						continue; 
					
					var prevImg = document.getElementById("prev_" + previewId);  //이전에 미리보기가 있다면 삭제
					if (prevImg) { 
						preview.removeChild(prevImg); 
						
					} 
					var img = document.createElement("img");  
					img.id = "prev_" + previewId; 
					img.classList.add("obj"); 
					img.file = file; 
					img.style.width = '200px';
					img.style.height = '200px'; 
					
					preview.appendChild(img); 
					
					if (window.FileReader) { // FireFox, Chrome, Opera 확인. 
						
						var reader = new FileReader(); 
						reader.onloadend = (function(aImg) { 
							return function(e) {
								aImg.src = e.target.result;
								
							}; 
							
						})(img); 
						reader.readAsDataURL(file);
						
					} else { // safari is not supported FileReader 
						//alert('not supported FileReader'); 
					if (!document.getElementById("sfr_preview_error_" + previewId)) {
						var info = document.createElement("p");
						info.id = "sfr_preview_error_" + previewId;
						info.innerHTML = "not supported FileReader";
						preview.insertBefore(info, null);
						
						}
						
					}
						
				}
					
			}
				
		}
		
	
		
		function fCheck() {
				let name = myForm.name.value;
				let email1 = myForm.email1.value;
				let email2 = myForm.email2.value;
				let email = email1 + '@' + email2;
			    let fName = document.getElementById("myphoto").value;
			    
				let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
				
				if(name == "") {
					alert("성명을 입력하세요");
					myForm.name.focus();
					return false;
				}
				else if(email1 == "") {
					alert("이메일을 입력하세요");
					myForm.email1.focus();
					return false;
				}
				else if(!regEmail.test(email)) {
		            alert("이메일 형식에 맞지않습니다.");
		            myForm.email1.focus();
		            return false;
		        }
				else {
					//프로필 사진을 변경했는지 여부 확인
					if(fName == "") {
						document.getElementById("flag").value = "no";
					}
					else {
						document.getElementById("flag").value = "yes";
					}
					
					//묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
					myForm.email.value = email;
					myForm.tel.value = tel;
					
					myForm.submit();
				}
				
			}	
		
			
	</script>
	<style>
	  	.headerJoin {
	  		font-size: 60px;
	        color: black;
	        font-weight: bolder;
	        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
	  	}
	  	.gender {
	  		accent-color: grey;
	  	}
	  	#photoDelete {
	  		margin : 0px auto;
	  	}
	  	#previewId {
	  		margin-bottom: 5px;
	  	}
	</style>
	
</head>
<body>
<%@ include file="/include/nav2.jsp" %>
<p><br/><p>
  <div class="w3-container" id="contact">
    <h2 class="headerJoin text-center">JOIN</h2>
    <h4 class="text-center">Welcome to join us!</h4><br>
<!--     <i class="fa fa-map-marker w3-text-red" style="width:30px"></i> Chicago, US<br>
    <i class="fa fa-phone w3-text-red" style="width:30px"></i> Phone: +00 151515<br>
    <i class="fa fa-envelope w3-text-red" style="width:30px"> </i> Email: mail@mail.com<br> -->
	<div class="w3-row-padding w3-padding-16">
		<div class="w3-third w3-margin-bottom"></div>
		<div class="w3-third w3-margin-bottom">
		    <form name="myForm" method="post" action="${ctp}/memUpdateOk.ad" class="was-validated" enctype="multipart/form-data">
		    	<div id="profile" style="text-align:center">
		    		<label for="picture" style="font-size:16px; font-weight: bold; background-color:yellow;">Profile Picture</label>
		    		<!-- <img id="previewImage" name="previewImage" src="images/noimage.jpg" width="200px"/><br><br> margin-top:0px"-->
		    		<div id='previewId' style="text-align:center;" ></div><div id="noimageID" style="text-align:center;">
		    		<c:if test="${empty vo.idx}">
		    			<img id="noimage" src="images/noimage.jpg" width="200px"/>
		    		</c:if>
		    		<c:if test="${!empty vo.idx}">
		    			<img id="noimage" src="${ctp}/data/member/${vo.save_file_name}" width="200px"/>
		    		</c:if>
		    		</div>
					<input type="button" id="photoDelete" value="삭제" class="w3-button w3-black w3-border w3-padding-small w3-tiny" style="display: none;" onclick="previewDelete()"/>	    		
		    		<img class="uplode" src="images/carmera.png" width="50px" onclick="javascript:$('#myphoto').click();">
		    		<p style="font-size:15px;">Click!<br><span style="font-size:13px">png/jpg/jpeg/jfif/gif 파일만 등록가능</span></p> 
		    		<input type="file" name="myphoto" id="myphoto" onchange="previewImage(this,'previewId')" class="form-control input" accept=".png, .jpg, .jpeg, .jfif, .gif" hidden="true">
		    	</div><hr>
		    	<div class="form-group">
		    		<label for="name">성명 : &nbsp; &nbsp;</label>
		      		<div class="input-group mb-3">
		    			<input class="input w3-padding-16 w3-border form-control" id="name" name="name" value="${vo.name}" type="text" placeholder="성명을 입력하세요." required>
		    		</div>
		    	</div>
		    	<div class="form-group">
		    		<label for="mid">아이디 : &nbsp; &nbsp;</label>
		      		<div class="input-group mb-3">
		    			<input class="input w3-padding-16 w3-border form-control" id="mid" name="mid" type="text" value="${vo.mid}" readonly>
		    		</div>
		    	</div>
		    	<div class="form-group">
			      <label for="tel">연락처 :</label>
			      <div class="input-group mb-3">
				      <input class="input w3-padding-16 w3-border form-control" id="tel" name="tel" value="${vo.tel}" type="text" readonly>
				  </div> 
			   </div>
			   <div class="form-group">
			      <label for="email">Email address:</label>
			      	<c:set var="emailArray" value="${fn:split(vo.email, '@')}"/>
					<div class="input-group mb-3">
					  <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" value="${emailArray[0]}" required />
					  <div class="input-group-append">
					    <select name="email2" class="custom-select w3-border">
						    <option value="naver.com" ${emailArray[1] == 'naver.com' ? 'selected' : ''}>naver.com</option>
						    <option value="hanmail.net"  ${emailArray[1] == 'hanmail.net' ? 'selected' : ''}>hanmail.net</option>
						    <option value="hotmail.com"  ${emailArray[1] == 'hotmail.com' ? 'selected' : ''}>hotmail.com</option>
						    <option value="gmail.com"  ${emailArray[1] == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
						    <option value="nate.com"  ${emailArray[1] == 'nate.com' ? 'selected' : ''}>nate.com</option>
						    <option value="yahoo.com"  ${emailArray[1] == 'yahoo.com' ? 'selected' : ''}>yahoo.com</option>
						  </select>
					  </div>
					</div>
			  </div><br>
			  <p class="text-center">- 선택 입력 사항 - </p>
			   <div class="form-group">
			      <label for="gender">성별 :</label>
			      <div class="form-check-inline">
		        	<div class="form-check">
					    <input type="radio" class="w3-radio gender" name="gender" value="m" ${vo.gender == 'm' ? 'checked' : ''}>남자&nbsp;&nbsp;&nbsp;
					    <input type="radio" class="w3-radio gender" name="gender" value="f" ${vo.gender == 'f' ? 'checked' : ''}>여자
					</div>
				 </div>
			  </div>
			  <div class="form-group">
			      <label for="address">주소 :</label><br>
					<div class="input-group mb-1">
						<input type="text" name="postcode" id="sample6_postcode" value="${vo.postcode}" placeholder="우편번호" class="form-control w3-border">
						<div class="input-group-append">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn w3-black">
						</div>
					</div>
					<input type="text" name="roadAddress" value="${vo.roadAddress}" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1 w3-border">
					<div class="input-group mb-1">
						<input type="text" name="detailAddress" value="${vo.detailAddress}" id="sample6_detailAddress" placeholder="상세주소" class="form-control w3-border"> &nbsp;&nbsp;
						<div class="input-group-append">
							<input type="text" name="extraAddress" value="${vo.extraAddress}" id="sample6_extraAddress" placeholder="참고항목" class="form-control w3-border">
						</div>
					</div>
			  </div>
			  <p><br></p>
		      <p style="text-align: center;"><button class="w3-button w3-black w3-padding-large" type="button" onclick="fCheck()">수정하기</button></p>
		      <input type="hidden" name="photo"/>
			  <input type="hidden" name="email"/>
			  <input type="hidden" name="flag" id="flag"/>
			  <input type="hidden" name="idx" value="${param.idx}"/>
			  <input type="hidden" name="applyDiff" value="${param.applyDiff}"/>
			  <input type="hidden" name="pag" value="${param.pag}"/>
			  <input type="hidden" name="pageSize" value="${param.pageSize}"/>
		    </form>
	    </div>
	    <div class="w3-third w3-margin-bottom">
	    </div>
    </div>
  </div>
  <%@ include file="/include/footer.jsp" %>
</body>
</html>