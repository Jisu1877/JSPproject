package reservation;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lodging.LodgingDAO;
import lodging.LodgingVO;

public class resSearchCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String checkIn = request.getParameter("checkIn") == null ? "" : request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut") == null ? "" : request.getParameter("checkOut");
		String area = request.getParameter("area") == null ? "" : request.getParameter("area");
		int peopleNum = request.getParameter("peopleNum") == null ? 0 : Integer.parseInt(request.getParameter("peopleNum"));
		
		ReservationVO resvo = new ReservationVO();
		resvo.setCheck_in(checkIn);
		resvo.setCheck_out(checkOut);
		resvo.setNumber_guests(peopleNum);
		
		//System.out.println("resvo :" + resvo);
		
		LodgingDAO lodDao = new LodgingDAO();
		ArrayList<LodgingVO> lodVos = lodDao.getLodList();
		
		request.setAttribute("lodVos", lodVos);
		request.setAttribute("resVO", resvo);
		request.setAttribute("area", area);
		
	}

}
