package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/memIdCheck")
public class memIdCheck extends HttpServlet {
	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		MemberDAO dao = new MemberDAO();
		
		String name = dao.memIdCheck(mid);
		String data = "";
		if(name.equals("")) {
			data = "idOk";
		}
		else {
			data = "idNo";
		}
		response.getWriter().write(data);
	}
}
