/*
	회원가입폼 체크
 */
  	let idCheckSw = 0;
    let nickCheckSw = 0;
    
  	// 회원가입폼 체크 후 서버로 전송하기
  	function fCheck() {
		let mid = myForm.mid.value;
		let pwd = myForm.pwd.value;
		let nickName = myForm.nickName.value;
		let name = myForm.name.value;
		let email1 = myForm.email1.value;
		let email2 = myForm.email2.value;
		let email = email1 + '@' + email2;
		let homePage = myForm.homePage.value;
		let tel1 = myForm.tel1.value;
	    let tel2 = myForm.tel2.value; 
	    let tel3 = myForm.tel3.value;
	    let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
		
		//정규식
		let regMid = /^[a-z0-9_]{4,20}$/;
		let regPwd = /(?=.*[a-zA-ZS])(?=.*?[#?!@$%^&*-]).{6,24}/;
		let regNickName = /^[가-힣]+$/;
		let regName = /^[가-힣a-zA-Z]+$/;
		let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		let regURL = /^(https?:\/\/)?([a-z\d\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$/;
		let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
	      
	    let submitFlag = 0; //전송체크버튼으로 값이 1이면 체크완료되어 전송처리한다.
	    
		//사진업로드체크
 		let fName = myForm.fName.value;
 		let ext = fName.substring(fName.lastIndexOf(".")+1); //파일 확장자 발췌
		let uExt = ext.toUpperCase(); //확장자를 대문자로 변환
 		let maxSize = 1024 * 1024 * 2 //업로드할 회원사진의 용량은 2MByte까지로 제한한다.
 		
		//정규식 체크를 하게 되면 필요 없어진다..
		if(mid == "") {
			alert("아이디를 입력하세요");
			myForm.mid.focus();
		}
		else if(pwd == "") {
			alert("비밀번호를 입력하세요");
			myForm.pwd.focus();
		}
		else if(nickName == "") {
			alert("닉네임을 입력하세요");
			myForm.nickName.focus();
		}
		else if(name == "") {
			alert("성명을 입력하세요");
			myForm.name.focus();
		}
		else if(email1 == "") {
			alert("이메일을 입력하세요");
			myForm.email1.focus();
		}
		// 기타 추가로 체크해야할 항목들을 모두 체크하세요...
		if(!regMid.test(mid)) {
            alert("아이디는 영문 소문자와 숫자, 언더바(_)만 사용가능합니다.(길이는 4~20자리까지 허용)");
            myForm.mid.focus();
            return false;
        }
		else if(!regPwd.test(pwd)) {
            alert("비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성해주세요.");
            myForm.pwd.focus();
            return false;
        }
		else if(!regNickName.test(nickName)) {
            alert("닉네임은 한글만 사용가능합니다.");
            myForm.nickName.focus();
            return false;
        }
		else if(!regName.test(name)) {
            alert("성명은 한글과 영문대소문자만 사용가능합니다.");
            myForm.name.focus();
            return false;
        }
		else if(!regEmail.test(email)) {
            alert("이메일 형식에 맞지않습니다.");
            myForm.email1.focus();
            return false;
        }
		else if(homePage != "http://" && homePage != "") {
			if(!regURL.test(homePage)) {
	            alert("작성하신 홈페이지 주소가 URL 형식에 맞지않습니다.");
	            myForm.homePage.focus();
	            return false;
		    }
		    else {
		    	submitFlag = 1;
		    }
		}
		if(tel2 != "" || tel3 != "") {
			if(!regTel.test(tel)) {
		        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
		        myForm.tel2.focus();
		        return false;
		    }
		    else {
		    	submitFlag = 1;
		    }
	    }
		
		//전송 전에 주소를 하나로 묶어서 전송처리 준비한다.
		let postcode = myForm.postcode.value + " ";
		let roadAddress = myForm.roadAddress.value  + " ";
		let detailAddress = myForm.detailAddress.value  + " ";
		let extraAddress = myForm.extraAddress.value + " ";
		myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
			
		//전송 전에 파일에 관한 사항 체크
		if(fName.trim() == "") {
			myForm.photo.value = "noimage";
			submitFlag = 1;
		}
		else {
			let fileSize = document.getElementById("file").files[0].size;  //첫번째 파일의 사이즈..! 아이디를 예약어인 file 로 주기.
		
			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG") {
				alert("업로드 가능한 파일은 'JPG/GIF/PNG'파일입니다.") 					
				return false;
			} 				// 혹시 파일명에 공백이 있으면~~~
			else if(fName.indexOf(" ") != -1) {
				alert("업로드 파일명에 공백을 포함할 수 없습니다.");
				return false;
			}
			else if(fileSize > maxSize) {
				alert("업로드 파일의 크기는 2MByte를 초과할 수 없습니다.");
				return false;
			}
			submitFlag = 1;
		}	
			
			
		// 전송전에 모든 체크가 끝나서 submitFlag가 1이되면 서버로 전송한다.
		if(submitFlag == 1) {
			if(idCheckSw == 0) {
				alert("아이디 중복체크버튼을 눌러주세요!");
			}
			else if(nickCheckSw == 0) {
				alert("닉네임 중복체크버튼을 눌러주세요!");
			}
			else {
				//묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
				myForm.email.value = email;
				myForm.tel.value = tel;
				
				myForm.submit();
			}
		}
		else {
			alert("회원가입 실패~~");
		}
  	}
  	//아이디 중복체크
  	function idCheck() {
  		let mid = myForm.mid.value;
  		let url = "${ctp}/memIdCheck.mem?mid="+mid;
		
  		if(mid == "") {
			alert("아이디를 입력하세요");
			myForm.mid.focus();
		}
		else {
			idCheckSw = 1;
			window.open(url, "nWin", "width=500px,height=250px");
		}
	}
  	//닉네임 중복체크
  	function nickCheck() {
		let nickName = myForm.nickName.value;
		let url = "${ctp}/memNickCheck.mem?nickName="+nickName;
		
		if(nickName == "") {
			alert("닉네임을 입력하세요");
			myForm.nickName.focus();
		}
		else {
			nickCheckSw = 1;
			window.open(url, "nWin", "width=500px,height=250px");
		}
	}