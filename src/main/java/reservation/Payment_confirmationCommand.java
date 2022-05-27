package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class Payment_confirmationCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String checkIn = request.getParameter("checkIn") == null ? "" : request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut") == null ? "" : request.getParameter("checkOut");
		String lod_name = request.getParameter("lod_name") == null ? "" : request.getParameter("lod_name");
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String address = request.getParameter("address") == null ? "" : request.getParameter("address");
		int peopleNum = request.getParameter("peopleNum") == null ? 0 : Integer.parseInt(request.getParameter("peopleNum"));
		int priceCal = request.getParameter("priceCal") == null ? 0 : Integer.parseInt(request.getParameter("priceCal"));
		int dateDays = request.getParameter("dateDays") == null ? 0 : Integer.parseInt(request.getParameter("dateDays"));
		int point = request.getParameter("point") == null ? 0 : Integer.parseInt(request.getParameter("point"));
		int mem_idx = request.getParameter("mem_idx") == null ? 0 : Integer.parseInt(request.getParameter("mem_idx"));
		int lod_idx = request.getParameter("lod_idx") == null ? 0 : Integer.parseInt(request.getParameter("lod_idx"));
		
		ReservationVO resvo = new ReservationVO();
		resvo.setLod_idx(lod_idx);
		resvo.setMem_idx(mem_idx);
		resvo.setCheck_in(checkIn);
		resvo.setCheck_out(checkOut);
		resvo.setNumber_guests(peopleNum);
		resvo.setPayment_price(priceCal);
		resvo.setTerm(dateDays);
		resvo.setPoint(point);
		
		MemberDAO memDao = new MemberDAO();
		
		MemberVO memVo = memDao.getMemInfor(mem_idx);
		
		request.setAttribute("vo", resvo);
		request.setAttribute("lod_name", lod_name);
		request.setAttribute("mid", mid);
		request.setAttribute("address", address);
		request.setAttribute("ownPoint", memVo.getPoint());
	}

}
