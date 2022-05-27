package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemPwdFindCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String tel = request.getParameter("tel") == null ? "" : request.getParameter("tel");
		
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemInfor(mid, name, tel);
		
		if(vo.getName() != null) {
			request.setAttribute("msg", "MemPwdFindOk");
			request.setAttribute("url", request.getContextPath()+"/member/memPwdInput.mem?mid="+mid);
		}
		else {
			request.setAttribute("msg", "MemPwdFindNo");
			request.setAttribute("url", request.getContextPath()+"/member/memPwdFind.mem");
		}
	}

}
