package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Payment_confirmationCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String checkIn = request.getParameter("checkIn") == null ? "" : request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut") == null ? "" : request.getParameter("checkOut");
		int peopleNum = request.getParameter("peopleNum") == null ? 0 : Integer.parseInt(request.getParameter("peopleNum"));
		int priceCal = request.getParameter("priceCal") == null ? 0 : Integer.parseInt(request.getParameter("priceCal"));
		int dateDays = request.getParameter("dateDays") == null ? 0 : Integer.parseInt(request.getParameter("dateDays"));
		int point = request.getParameter("point") == null ? 0 : Integer.parseInt(request.getParameter("point"));
		int mem_idx = request.getParameter("mem_idx") == null ? 0 : Integer.parseInt(request.getParameter("mem_idx"));
		int lod_idx = request.getParameter("lod_idx") == null ? 0 : Integer.parseInt(request.getParameter("lod_idx"));
		
		
	}

}
