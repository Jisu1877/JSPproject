package admin;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import member.MemberDAO;
import member.MemberVO;

public class MemUpdateOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext(); //어플리케이션 객체 사용을 위해 불러오기
		// 경로알아내서 realPath 변수에 담기
		String realPath = application.getRealPath("/data/member");  
		int maxSize = 1024 * 1024 * 2; //최대용량을 2MByte로 사용하고자 한다.
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String flag = multipartRequest.getParameter("flag") == null ? "no" : multipartRequest.getParameter("flag");
		String name = multipartRequest.getParameter("name") == null? "" : multipartRequest.getParameter("name");
		String gender = multipartRequest.getParameter("gender") == null? "" : multipartRequest.getParameter("gender");
		String email = multipartRequest.getParameter("email") == null? "" : multipartRequest.getParameter("email");
		String postcode = multipartRequest.getParameter("postcode") == null ? "" : multipartRequest.getParameter("postcode");
		String roadAddress = multipartRequest.getParameter("roadAddress") == null ? "" : multipartRequest.getParameter("roadAddress");
		String detailAddress = multipartRequest.getParameter("detailAddress") == null ? "" : multipartRequest.getParameter("detailAddress");
		String extraAddress = multipartRequest.getParameter("extraAddress") == null ? "" : multipartRequest.getParameter("extraAddress");
		int applyDiff = multipartRequest.getParameter("applyDiff") == null? 2 : Integer.parseInt(multipartRequest.getParameter("applyDiff"));
		int idx = multipartRequest.getParameter("idx") == null? 0 : Integer.parseInt(multipartRequest.getParameter("idx"));
		int pag = multipartRequest.getParameter("pag") == null? 1 : Integer.parseInt(multipartRequest.getParameter("pag"));
		int pageSize = multipartRequest.getParameter("pageSize") == null? 10 : Integer.parseInt(multipartRequest.getParameter("pageSize"));
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = new MemberVO();
		
		if(flag.equals("yes")) {
			String file_name = multipartRequest.getOriginalFileName("myphoto")  == null ? "": multipartRequest.getOriginalFileName("myphoto"); //form태그의 name 
			// 실제로 서버에 저장되는 파일명
			String save_file_name = multipartRequest.getFilesystemName("myphoto") == null ? "": multipartRequest.getFilesystemName("myphoto");
			
			if(file_name.equals("")) {
				file_name = "noimage.jpg";
				save_file_name = "noimage.jpg";
			}
			
			vo.setFile_name(file_name);
			vo.setSave_file_name(save_file_name);
		}
		else {
			vo.setFile_name("");
			vo.setSave_file_name("");
		}
		
		vo.setIdx(idx);
		vo.setName(name);
		vo.setGender(gender);
		vo.setEmail(email);
		vo.setPostcode(postcode);
		vo.setRoadAddress(roadAddress);
		vo.setDetailAddress(detailAddress);
		vo.setExtraAddress(extraAddress);
		
		System.out.println("vo : " + vo);
		
		int res = dao.setMemUpdateOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "adMemUpdateOk");
		}
		else {
			request.setAttribute("msg", "adMemUpdateNo");
		}
		request.setAttribute("url", request.getContextPath()+"/memInfor.ad?idx="+idx+"&applyDiff="+applyDiff+"&pag="+pag+"&pageSize="+pageSize);
		
	}

}
