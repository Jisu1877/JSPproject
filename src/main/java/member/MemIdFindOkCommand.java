package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemIdFindOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String tel = request.getParameter("tel") == null ? "" : request.getParameter("tel");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemInfor(name,tel);
		
		request.setAttribute("mid", vo.getMid());
		request.setAttribute("flag", "true");
		
	}

}
