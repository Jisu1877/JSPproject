package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResCancelCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int lodIdx = request.getParameter("lodIdx") == null ? 0 : Integer.parseInt(request.getParameter("lodIdx"));
		int memIdx = request.getParameter("memIdx") == null ? 0 : Integer.parseInt(request.getParameter("memIdx"));
		String checkIn = request.getParameter("checkIn") == null ? ""  : request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut") == null ? ""  : request.getParameter("checkOut");
		
		ReservationDAO dao = new ReservationDAO();
		
		//예약취소처리
		int res = dao.setCancel(lodIdx, memIdx, checkIn, checkOut);
		
		if(res == 1) {
			response.getWriter().write("cancelOk");
		}
		else {
			response.getWriter().write("cancelNo");
		}
		
	}

}
