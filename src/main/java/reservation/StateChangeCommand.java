package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

public class StateChangeCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int lodIdx = request.getParameter("lodIdx") == null ? 0 : Integer.parseInt(request.getParameter("lodIdx"));
		int memIdx = request.getParameter("memIdx") == null ? 0 : Integer.parseInt(request.getParameter("memIdx"));
		String checkIn = request.getParameter("checkIn") == null ? ""  : request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut") == null ? ""  : request.getParameter("checkOut");
		int flag = request.getParameter("flag") == null ? 0 : Integer.parseInt(request.getParameter("flag"));
		
		ReservationDAO dao = new ReservationDAO();
		
		//상태값 변경
		int res = dao.setCancel(lodIdx, memIdx, checkIn, checkOut, flag);
		
		//구매확정인 경우 포인트를 적립시켜줘야한다.
		//1.적립해줄 포인트 알아오기
		int point = dao.getPoint(lodIdx, memIdx, checkIn, checkOut);
		
		//2.멤버테이블에서 해당 멤버에게 포인트 부여하기
		MemberDAO memDao = new MemberDAO();
		res = memDao.givePoint(memIdx, point);
		
		
		if(res == 1) {
			if(flag == 0) {
				response.getWriter().write("cancelOk");
			}
			else {
				response.getWriter().write("confirmationOk");
			}
		}
		else {
			if(flag == 0) {
				response.getWriter().write("cancelNo");
			}
			else {
				response.getWriter().write("confirmationNo");
			}
		}
	}

}
