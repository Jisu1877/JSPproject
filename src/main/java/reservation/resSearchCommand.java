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
		int area = request.getParameter("area") == null ? 105 : Integer.parseInt(request.getParameter("area"));
		int peopleNum = request.getParameter("peopleNum") == null ? 0 : Integer.parseInt(request.getParameter("peopleNum"));
		int code = (request.getParameter("code") == null || request.getParameter("code").equals("")) ? 0 : Integer.parseInt(request.getParameter("code"));
		
		ReservationVO resvo = new ReservationVO();
		resvo.setCheck_in(checkIn);
		resvo.setCheck_out(checkOut);
		resvo.setNumber_guests(peopleNum);
		
		//System.out.println("resvo :" + resvo);
		
		LodgingDAO lodDao = new LodgingDAO();
		// 예약날짜가 겹치는 숙소 제외 검색
		ArrayList<LodgingVO> lodVos = lodDao.getLodList(checkIn, checkOut, area, peopleNum, code);
		
		request.setAttribute("lodVos", lodVos);
		request.setAttribute("resVO", resvo);
		request.setAttribute("area", area);
		
	}

}
