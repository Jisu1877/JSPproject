package lodging;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import reservation.ReservationDAO;
import reservation.ReservationVO;

public class ReviewInputCommand implements LodgingInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int rating = request.getParameter("rating") == null ? 0 : Integer.parseInt(request.getParameter("rating"));
		String review_subject = request.getParameter("review_subject") == null ? "" : request.getParameter("review_subject");
		String review_contents = request.getParameter("review_contents") == null ? "" : request.getParameter("review_contents");
		
		int lodIdx = request.getParameter("lodIdx") == null ? 0 : Integer.parseInt(request.getParameter("lodIdx"));
		int memIdx = request.getParameter("memIdx") == null ? 0 : Integer.parseInt(request.getParameter("memIdx"));
		String checkIn = request.getParameter("checkIn") == null ? "" : request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut") == null ? "" : request.getParameter("checkOut");
		
		reviewVO vo = new reviewVO();
		
		vo.setLod_idx(lodIdx);
		vo.setMem_idx(memIdx);
		vo.setRating(rating);
		vo.setReview_subject(review_subject);
		vo.setReview_contents(review_contents);
		
		//System.out.println(vo);
		//리뷰테이블에 등록
		LodgingDAO lodDao = new LodgingDAO();
		int res = lodDao.setReviewInput(vo);
		
		//예약테이블 리뷰 상태값 변경
		ReservationDAO resDao = new ReservationDAO();
		int res2 = resDao.setReviewState(lodIdx, memIdx, checkIn, checkOut);
		
		//멤버테이블에서 리뷰작성 포인트 500point 부여
		MemberDAO memDao = new MemberDAO();
		int res3 = memDao.setReviewPoint(memIdx);
		
		if(res == 1 && res2 == 1 && res3 == 1) {
			request.setAttribute("msg", "reviewInputOk");
		}
		else {
			request.setAttribute("msg", "reviewInputNo");
		}
		request.setAttribute("url", request.getContextPath()+"/memMypage.mem");
 
	}

}
