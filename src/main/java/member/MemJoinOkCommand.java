package member;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import conn.SecurityUtil;

public class MemJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext(); //어플리케이션 객체 사용을 위해 불러오기
		// 경로알아내서 realPath 변수에 담기
		String realPath = application.getRealPath("/data/member");  
		int maxSize = 1024 * 1024 * 10; //최대용량을 2MByte로 사용하고자 한다.
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String mid = multipartRequest.getParameter("mid") == null? "" : multipartRequest.getParameter("mid");
		String pwd = multipartRequest.getParameter("pwd") == null? "" : multipartRequest.getParameter("pwd");
		String name = multipartRequest.getParameter("name") == null? "" : multipartRequest.getParameter("name");
		String name_ = name;
		String gender = multipartRequest.getParameter("gender") == null? "" : multipartRequest.getParameter("gender");
		String tel = multipartRequest.getParameter("tel") == null? "" : multipartRequest.getParameter("tel");
		String email = multipartRequest.getParameter("email") == null? "" : multipartRequest.getParameter("email");
		String file_name = multipartRequest.getOriginalFileName("myphoto")  == null ? "": multipartRequest.getOriginalFileName("myphoto"); //form태그의 name 
		// 실제로 서버에 저장되는 파일명
		String save_file_name = multipartRequest.getFilesystemName("myphoto") == null ? "": multipartRequest.getFilesystemName("myphoto");
		String postcode = multipartRequest.getParameter("postcode") == null ? "" : multipartRequest.getParameter("postcode");
		String roadAddress = multipartRequest.getParameter("roadAddress") == null ? "" : multipartRequest.getParameter("roadAddress");
		String detailAddress = multipartRequest.getParameter("detailAddress") == null ? "" : multipartRequest.getParameter("detailAddress");
		String extraAddress = multipartRequest.getParameter("extraAddress") == null ? "" : multipartRequest.getParameter("extraAddress");
		int agreement = multipartRequest.getParameter("agreementCheck") == null? 2 : Integer.parseInt(multipartRequest.getParameter("agreementCheck"));
		
		//비밀번호 암호화처리(sha256)
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		//프로필사진을 등록하지 않으면..!
		if(file_name.equals("")) {
			file_name = "noimage.jpg";
			save_file_name = "noimage.jpg";
		}
		
		MemberDAO dao = new MemberDAO();
		
		//아이디, 전화번호 중복 다시한번 체크
		name = dao.memIdCheck(mid);
		if(!name.equals("")) {		//사용 불가한 아이디
			request.setAttribute("msg", "idCheckNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
			return;
		}
		name = dao.memTelCheck(tel);
		if(!name.equals("")) {		//사용 불가한 전화번호
			request.setAttribute("msg", "telCheckNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
			return;
		}
		
		MemberVO vo = new MemberVO();
		
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setName(name_);
		vo.setGender(gender);
		vo.setTel(tel);
		vo.setEmail(email);
		vo.setFile_name(file_name);
		vo.setSave_file_name(save_file_name);
		vo.setPostcode(postcode);
		vo.setRoadAddress(roadAddress);
		vo.setDetailAddress(detailAddress);
		vo.setExtraAddress(extraAddress);
		vo.setAgreement(agreement);
		
		//System.out.println("vo : " + vo);
		
		int res = dao.setMemJoinOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "memJoinOk");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
		}
		else {
			request.setAttribute("msg", "memJoinNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
		}
		
	}

}
