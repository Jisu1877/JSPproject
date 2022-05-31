package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import reservation.ReservationDAO;
import reservation.ReservationVO;

public class MemMypageCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		
		//회원정보 가져오기
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemInfor(mid);

		//예약정보 가져오기
		ReservationDAO resDao = new ReservationDAO();
		ArrayList<ReservationVO> resList = resDao.getResList(vo.getIdx());
		
		request.setAttribute("vo", vo);
		request.setAttribute("resList", resList);
	}

}
