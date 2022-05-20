package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/memTelCheck")
public class memTelCheck extends HttpServlet {
	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tel = request.getParameter("tel") == null ? "" : request.getParameter("tel");
		MemberDAO dao = new MemberDAO();
		
		String name = dao.memTelCheck(tel);
		String data = "";
		if(name.equals("")) {
			data = "telOk";
		}
		else {
			data = "telNo";
		}
		response.getWriter().write(data);
	}
}
