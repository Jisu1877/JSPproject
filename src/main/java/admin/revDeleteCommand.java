package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lodging.LodgingDAO;

@WebServlet("/revDeleteCommand")
public class revDeleteCommand extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		LodgingDAO dao = new LodgingDAO();
		
		int res = dao.deleteReview(idx);
		
		if(res == 1) {
			response.getWriter().write("deleteOk");
		}
		else {
			response.getWriter().write("deleteNo");
		}
	}
}
