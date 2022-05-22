package lodging;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LodInforCommand implements LodgingInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("lodIdx") == null ? 0 : Integer.parseInt(request.getParameter("lodIdx"));
		
		LodgingDAO lodDao = new LodgingDAO();
		
		//idx에 해당하는 숙소 상세정보가져오기
		LodgingVO lodVo = lodDao.getLodInfor(idx);
		
		//idx에 해당하는 숙소 사진 파일 가져오기
		ArrayList<FileVO> fileList = lodDao.getLodFile(idx);
		
		request.setAttribute("lodVo", lodVo);
		request.setAttribute("fileList", fileList);

	}

}
