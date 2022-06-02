package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import reservation.ReservationDAO;
import reservation.ReservationVO;

public class MemDeleteMemCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int mem_idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		//사용완료되지않은 예약되어있는 건수가 있는지 확인하기
		ReservationDAO resDao = new ReservationDAO();
		
		ReservationVO resVo = resDao.checkMemRes(mem_idx);	
		
		if(resVo.getCheck_in() != null) {
			request.setAttribute("msg", "noMemDelete");
			request.setAttribute("url", request.getContextPath()+"/memMypage.mem");
		}
		else {
			MemberDAO dao = new  MemberDAO();
			
			int res = dao.memDelete(mem_idx);
			
			if(res == 1) {
				//탈퇴했으니 세션을 끊는다.
				HttpSession session = request.getSession();
				session.invalidate();
				
				request.setAttribute("msg", "adMemDeleteOk");
				request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
			}
			else {
				request.setAttribute("msg", "adMemDeleteNo");
				request.setAttribute("url", request.getContextPath()+"/memMypage.mem");
			}
		}
		

	}

}
