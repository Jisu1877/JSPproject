package lodging;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReviewDelCommand implements LodgingInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		LodgingDAO dao = new LodgingDAO();
		
		int res = dao.deleteReview(idx);
		
		if(res == 1) {
			response.getWriter().write("reviewDelOk");
		}
		else {
			response.getWriter().write("reviewDelNo");
		}

	}

}
