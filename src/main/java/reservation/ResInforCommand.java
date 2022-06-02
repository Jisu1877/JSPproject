package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResInforCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memIdx = request.getParameter("memIdx") == null ? 0 : Integer.parseInt(request.getParameter("memIdx"));
		int lodIdx = request.getParameter("lodIdx") == null ? 0 : Integer.parseInt(request.getParameter("lodIdx"));
		String checkIn = request.getParameter("checkIn") == null ? "" : request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut") == null ? "" : request.getParameter("checkOut");
		
		ReservationDAO dao = new ReservationDAO();
		
		ReservationVO resVo = dao.getResInfor(memIdx,lodIdx,checkIn,checkOut);
		
		request.setAttribute("resVo", resVo);
	}

}
