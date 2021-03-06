package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class MemInforCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int applyDiff = request.getParameter("applyDiff") == null ? 0 : Integer.parseInt(request.getParameter("applyDiff"));
		int pag = request.getParameter("pag") == null? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null? 10 : Integer.parseInt(request.getParameter("pageSize"));
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemInfor(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("applyDiff", applyDiff);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);

	}

}
