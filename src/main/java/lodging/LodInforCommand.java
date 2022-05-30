package lodging;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import reservation.ReservationDAO;
import reservation.ReservationVO;

public class LodInforCommand implements LodgingInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("lodIdx") == null ? 0 : Integer.parseInt(request.getParameter("lodIdx"));
		
		LodgingDAO lodDao = new LodgingDAO();
		ReservationDAO resDao = new ReservationDAO();
		
		//idx에 해당하는 숙소 상세정보가져오기
		LodgingVO lodVo = lodDao.getLodInfor(idx);
		
		//idx에 해당하는 숙소 사진 파일 가져오기
		ArrayList<FileVO> fileList = lodDao.getLodFile(idx);
		
		//이미 예약되어있는 날짜 가져오기
		ArrayList<ReservationVO> resList =  resDao.getLodStayDate(idx);
		//Gson 형식으로 바꾸기
		Gson gson = new Gson();
		String jsonStr = gson.toJson(resList);
		
		request.setAttribute("lodVo", lodVo);
		request.setAttribute("fileList", fileList);
		request.setAttribute("resList", resList);
		request.setAttribute("resListJson", jsonStr);
	}

}
