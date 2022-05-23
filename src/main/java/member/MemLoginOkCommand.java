package member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String hostIp = request.getParameter("hostIp") == null ? "" : request.getParameter("hostIp");
		
		//비밀번호 암호화
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		//아이디/비번 맞는지 확인
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemCheck(mid, pwd);
		
		//로그인 실패
		if(vo.getName() == null) {
			request.setAttribute("msg", "loginNo");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
			return;
		}
		
		//로그인 성공 이후 작업들..
		
		//1. 주요자료 세션저장하기 2.로그인 기록 테이블에 자료 저장 3.쿠키에 아이디 저장유무 
		HttpSession session = request.getSession();
		
		session.setAttribute("sMid", mid);
		session.setAttribute("sName", vo.getName());
		session.setAttribute("sLevel", vo.getLevel());
		
		//로그인 기록 테이블에 자료 저장
		int res = dao.setMem_log(vo.getIdx(), hostIp);
		
		//아이디 저장 체크시..
		String idCheck = request.getParameter("idCheck") == null ? "off" : request.getParameter("idCheck");
		Cookie cookieMid = new Cookie("cMid", mid);
		if(idCheck.equals("on")) {  //아이디 저장 체크 함.
			cookieMid.setMaxAge(24*60*60*7);	// cookieMi 쿠키 만료시간은 7일
		}
		else {
			cookieMid.setMaxAge(0);	// cookieMi 쿠키 삭제
		}
		response.addCookie(cookieMid);
		
		if(res == 1) {
			request.setAttribute("msg", "loginOk");
			request.setAttribute("url", request.getContextPath()+"/");
		}
		else {
			request.setAttribute("msg", "loginNo");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
		}

	}

}
