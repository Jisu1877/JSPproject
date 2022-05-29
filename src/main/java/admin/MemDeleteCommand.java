package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

public class MemDeleteCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		
		MemberDAO dao = new  MemberDAO();
		
		int res = dao.memDelete(idx);
		
		if(res == 1) {
			request.setAttribute("msg", "adMemDeleteOk");
		}
		else {
			request.setAttribute("msg", "adMemDeleteNo");
		}
		request.setAttribute("url", request.getContextPath()+"/mem_management.ad?pag="+pag+"&pageSize="+pageSize);

	}

}
