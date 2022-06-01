package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lodging.LodgingDAO;
import lodging.LodgingVO;
import lodging.reviewVO;
import member.MemberDAO;
import member.MemberVO;
import reservation.ReservationDAO;
import reservation.ReservationVO;

public class AdminHomeCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//숙소정보 모두 가져오기
		LodgingDAO lodDao = new LodgingDAO();
		ArrayList<LodgingVO> lodList = lodDao.getLodList(0);
		//숙소 개수
		int lodCnt = lodList.size();
		
		//Best숙소정보 가져오기(3건)
		ArrayList<LodgingVO> BestlodList = lodDao.getBestLodList();
		
		//회원정보 모두 가져오기
		MemberDAO memDao = new MemberDAO();
		ArrayList<MemberVO> memList = memDao.getMemList();
		//회원 명수
		int memCnt = memList.size();
		
		//예약정보 모두 가져오기
		ReservationDAO resDao = new ReservationDAO();
		ArrayList<ReservationVO> resList = resDao.getResList();
		//예약 건수
		int resCnt = resList.size();
		
		//리뷰정보 모두 가져오기
		ArrayList<reviewVO> reviewList = lodDao.getReviewList("노출만");
		int revCnt = reviewList.size();
		
		request.setAttribute("lodList", lodList);
		request.setAttribute("lodCnt", lodCnt);
		request.setAttribute("BestlodList", BestlodList);
		request.setAttribute("memList", memList);
		request.setAttribute("memCnt", memCnt);
		request.setAttribute("resList", resList);
		request.setAttribute("resCnt", resCnt);
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("revCnt", revCnt);

	}

}
