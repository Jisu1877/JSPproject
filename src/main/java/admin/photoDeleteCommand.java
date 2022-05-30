package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lodging.LodgingDAO;

@WebServlet("/photoDeleteCommand")
public class photoDeleteCommand extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fName = request.getParameter("fName") == null ? "" : request.getParameter("fName");
		
		LodgingDAO lodDao = new LodgingDAO();
		
		int res = lodDao.fileDelete(fName);
		
		if(res == 1) {
			response.getWriter().write("deleteOk");
		}
		else {
			response.getWriter().write("deleteNo");
		}
	}
}
