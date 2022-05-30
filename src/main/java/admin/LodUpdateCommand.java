package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import lodging.FileVO;
import lodging.LodgingDAO;
import lodging.LodgingVO;
import reservation.ReservationVO;

public class LodUpdateCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("lodIdx") == null ? 0 : Integer.parseInt(request.getParameter("lodIdx"));
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		
		LodgingDAO lodDao = new LodgingDAO();
		
		//idx에 해당하는 숙소 상세정보가져오기
		LodgingVO lodVo = lodDao.getLodInfor(idx);
		
		//idx에 해당하는 숙소 사진 파일 가져오기
		ArrayList<FileVO> fileList = lodDao.getLodFile(idx);
		
		request.setAttribute("lodVo", lodVo);
		request.setAttribute("fileList", fileList);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
	}

}
