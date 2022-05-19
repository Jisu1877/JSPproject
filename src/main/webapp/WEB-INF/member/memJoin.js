// join
function noprofile() {
  var ans = confirm("프로필 사진을 지우시겠습니까?");
  
  if(ans) {
    $("#file").val("");
    $(".file").attr("src", "/joyakdol/resources/profiles/profile.png");
  }
}

$(document).ready(function () {
  var regExpId = /^[A-Za-z]{1}[A-Za-z0-9-_]{3,19}$/;
  var regExpPwd = /^[a-zA-Z\d\W]{4,20}$/;
  var regExpTel = /^\d{8,13}$/;
  var regExpEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,4}$/;

  $(".profile").height($(".profile").width());
  var width = $(".profile").width();
  var height = $(".profile").height();
  var imgAspect = $(".file").height() / $(".file").width();
  
  if(imgAspect <= 1) {
    var imgWidth = height / imgAspect;
    var marginLeft = -Math.round((imgWidth - width) / 2);
    
    $(".file").attr("style", "width: auto; height: " + height + "px; margin-left: " + marginLeft + "px;");
  }
  else {
    var imgHeight = width * imgAspect;
    var marginTop = -Math.round((imgHeight - height) / 2);
    $(".file").attr("style", "width: " + width + "px; height: auto; margin-top: " + marginTop + "px; margin-left: 0;");
  }
  
  $(window).resize(function() {
    $(".profile").height($(".profile").width());
    width = $(".profile").width();
    height = $(".profile").height();
    imgAspect = $(".file").height() / $(".file").width();
    
    if(imgAspect <= 1) {
      var imgWidth = height / imgAspect;
      var marginLeft = -Math.round((imgWidth - width) / 2);
      $(".file").attr("style", "width: auto; height: " + height + "px; margin-left: " + marginLeft + "px;");
    }
    else {
      var imgHeight = width * imgAspect;
      var marginTop = -Math.round((imgHeight - height) / 2);
      $(".file").attr("style", "width: " + width + "px; height: auto; margin-top: " + marginTop + "px; margin-left: 0;");
    }
  });
  
  $("#file").change(function() {
    var file = document.getElementById("file").files[0];
    var fileName = $("#file").val();                                                   // 파일명
    var ext = fileName.substr(fileName.lastIndexOf(".") + 1).toLowerCase();         // 확장자
    var type = "png/jpg/jpeg/jfif/gif";  // 허용된 확장자
    var fileSize = document.getElementById("file").files[0].size;               // 업로드 할 파일 용량
    var maxSize = 1024 * 1024 * 10;                                                 // 최대 파일 용량: 10MByte
    
    if(type.indexOf(ext) == -1) {
      alert("업로드 가능한 파일이 아닙니다.");
      $("#file").val("");
    }
    else if(fileName.length > 100) {
      alert("파일명은 100자 이내만 가능합니다.");
      $("#file").val("");
    }
    else if(fileSize > maxSize) {
      alert("파일 용량은 10MByte를 초과할 수 없습니다.\n업로드 하려는 용량: " + (fileSize / (1024 * 1024)).toFixed(2) + "MB");
      $("#file").val("");
    }
    else {
      var reader = new FileReader();
      
      reader.onload = function(e) {
        $(".file").attr("src", e.target.result);
      }
      
      reader.readAsDataURL(file);
      
      $(".file").removeAttr("style");
      
      $(".file").load(function () {
        imgAspect = $(".file").height() / $(".file").width();
        
        if(imgAspect <= 1) {
          var imgWidth = height / imgAspect;
          var marginLeft = -Math.round((imgWidth - width) / 2);
          $(".file").attr("style", "width: auto; height: " + height + "px; margin-left: " + marginLeft + "px;");
        }
        else {
          var imgHeight = width * imgAspect;
          var marginTop = -Math.round((imgHeight - height) / 2);
          $(".file").attr("style", "width: " + width + "px; height: auto; margin-top: " + marginTop + "px; margin-left: 0;");
        }
      });
      
      $(".profile").append("<a href='javascript: noprofile();' class='noprofile'>❌</a>");
    }
  });
  
  $("#mid").blur(function() {
    var mid = $(this).val();
    
    $.ajax({
      type: "POST",
      url: "idCheck",
      data: {
        mid: mid
      },
      success: function(data) {
        if(!regExpId.test(mid))
          $(".vaildCheck").eq(0).text("4~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다. (첫글자는 반드시 영문 소문자)");
        else if(data)
          $(".vaildCheck").eq(0).text("사용 가능한 아이디입니다.");
        else
          $(".vaildCheck").eq(0).text("이미 사용중인 아이디입니다.");
      }
    });
  });
  
  $("#pwd").blur(function() {
    /* var regExpPwd = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{4,20}$/; */
    var pwd = $(this).val();
    
    if(!regExpPwd.test(pwd))
      $(".vaildCheck").eq(1).text("4~20자의 영문 대소문자/숫자/특수기호만 사용 가능합니다.");
      /* $(".vaildCheck").eq(1).text("4~20자의 영문 대소문자/숫자/특수기호 중 2가지 이상 조합하여 사용 가능합니다."); */
    else
      $(".vaildCheck").eq(1).text("");
  });
  
  $("#pwd2").blur(function() {
    var pwd = $("#pwd").val();
    var pwd2 = $(this).val();
    
    if(pwd2 != pwd)
      $(".vaildCheck").eq(2).text("비밀번호가 일치하지 않습니다.");
    else
      $(".vaildCheck").eq(2).text("");
  });
  
  $("#name").blur(function() {
    var name = $(this).val();
    
    if(name == "")
      $(".vaildCheck").eq(3).text("이름을 입력하세요.");
    else
      $(".vaildCheck").eq(3).text("");
  });
  
  $("#tel").blur(function() {
    var tel = $(this).val();
    
    if(tel == "")
      $(".vaildCheck").eq(4).text("전화번호를 입력하세요.");
    else if(!regExpTel.test(tel))
      $(".vaildCheck").eq(4).text("올바르지 않은 전화번호입니다.");
    else
      $(".vaildCheck").eq(4).text("");
  });
  
  $("#eid").blur(function() {
    var eid = $(this).val();
    
    if(eid == "")
      $(".vaildCheck").eq(5).text("이메일을 입력하세요.");
    else
      $(".vaildCheck").eq(5).text("");
  });
  
  $("#direct").change(function() {
    var checked = $(this).is(":checked");
    
    if(checked) {
      $(".emailUrl").html("<input type='text' name='eurl' id='eurl' class='form-control' placeholder='이메일 주소'/>");
      $("#eurl").focus();
    }
    else {
      $(".emailUrl").html(
          "<select class='form-control' name='eurl' id='eurl'>" +
            "<option value=''>- 이메일 선택 -</option>" +
            "<option value='naver.com'>naver.com</option>" +
            "<option value='daum.net'>daum.net</option>" +
            "<option value='nate.com'>nate.com</option>" +
            "<option value='gmail.com'>gmail.com</option>" +
          "</select>"
  		);
      $("#eurl").focus();
    }
  });
  
  $("#joinBtn").click(function() {
    if($(".vaildCheck").eq(0).text().indexOf("사용 가능한 아이디") == -1) {
      alert("아이디를 확인하세요.");
      $("#mid").focus();
    }
    else if($(".vaildCheck").eq(1).text() != "" || $("#pwd").val() == "") {
      alert("비밀번호를 확인하세요.");
      $("#pwd").focus();
    }
    else if($(".vaildCheck").eq(2).text() != "" || $("#pwd2").val() == "") {
      alert("비밀번호가 일치하지 않습니다.");
      $("#pwd2").focus();
    }
    else if($(".vaildCheck").eq(3).text() != "" || $("#name").val() == "") {
      alert("성명을 확인하세요.");
      $("#name").focus();
    }
    else if($(".vaildCheck").eq(4).text() != "" || $("#tel").val() == "") {
      alert("전화번호를 확인하세요.");
      $("#tel").focus();
    }
    else if($(".vaildCheck").eq(5).text() != "" || $("#eid").val() == "") {
      alert("이메일을 확인하세요.");
      $("#eid").focus();
    }
    else if($("#eurl").val() == "" || !regExpEmail.test($("#eurl").val())) {
      alert("이메일을 확인하세요.");
      $("#eurl").focus();
    }
    else {
      $("#mid").val($("#mid").val().toLowerCase());
      
      $("#email").val($("#eid").val() + "@" + $("#eurl").val());
      
      var info1 = $("#info1").is(":checked") == true ? "y" : "n";
      var info2 = $("#info2").is(":checked") == true ? "y" : "n";
      var info3 = $("#info3").is(":checked") == true ? "y" : "n";
      $("#info").val(info1 + info2 + info3);
      
      $("#joinform").submit();
    }
  });
});
