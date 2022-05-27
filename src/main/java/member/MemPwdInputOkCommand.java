package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class MemPwdInputOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = request.getParameter("pwd1") == null ? "" : request.getParameter("pwd1");
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		
		//비밀번호 암호화처리(sha256)
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		MemberDAO dao = new MemberDAO();
		
		int res = dao.memPwdInput(pwd,mid);
		
		if(res == 0){
			request.setAttribute("msg", "MemPwdInputNo");
			request.setAttribute("url", request.getContextPath()+"/member/memPwdInput.mem");
		}
		else {
			request.setAttribute("msg", "MemPwdInputOk");
			request.setAttribute("url", request.getContextPath()+"/member/memPwdInput.mem");
		}

	}

}
