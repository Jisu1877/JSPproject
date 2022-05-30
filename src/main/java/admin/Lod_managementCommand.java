package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lodging.LodgingDAO;
import lodging.LodgingVO;

public class Lod_managementCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LodgingDAO dao = new LodgingDAO();
		
		//페이징처리를 위한 준비...
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag")); 
		int pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = dao.totRecCnt();
		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) == 0 ? (totPage / blockSize) - 1 : (totPage / blockSize);
		
		//숙소정보 모두 알아오기
		ArrayList<LodgingVO> lodList = dao.getLodList(startIndexNo, pageSize);
		
		request.setAttribute("lodList", lodList);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		request.setAttribute("pageSize", pageSize);

	}

}
