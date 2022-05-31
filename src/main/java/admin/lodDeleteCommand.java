package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lodging.LodgingDAO;
import reservation.ReservationDAO;
import reservation.ReservationVO;

@WebServlet("/lodDeleteCommand")
public class lodDeleteCommand extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int lodIdx = request.getParameter("lodIdx") == null ? 0 : Integer.parseInt(request.getParameter("lodIdx"));
		
		LodgingDAO dao = new LodgingDAO();
		ReservationDAO resDao = new ReservationDAO();
		
		ArrayList<ReservationVO> resList = resDao.checkRes(lodIdx);
		
		if(resList.size() >= 1) {
			response.getWriter().write("exist");
		}
		else {
			int res = dao.lodDelete(lodIdx);
			
			if(res == 1) {
				response.getWriter().write("deleteOk");
			}
			else {
				response.getWriter().write("deleteNo");
			}
			
		}
		
	}
}
