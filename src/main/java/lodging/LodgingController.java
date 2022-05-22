package lodging;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lodging.Lod_Input_OkCommand;
import member.MemJoinOkCommand;

@WebServlet("*.lod")
public class LodgingController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LodgingInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1,uri.lastIndexOf("."));
		
		//세션이 끊겼으면 작업의 진행을 홈으로 보내기 위함.(비정상적인 접근)
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel") == null ? 99 : (int)session.getAttribute("sLevel");
		
		if(com.equals("lodInfor")) {
			command = new LodInforCommand();
			command.execute(request, response); 
			viewPage += "/lodging/lodInfor.jsp";
		}
		/*
		 * if(level != 99) { //세션이 끊겼으면 작업의 진행을 홈으로 보낸다.(비정상적인 접근) RequestDispatcher
		 * dispatcher = request.getRequestDispatcher("/memLogin.mem");
		 * dispatcher.forward(request, response); }
		 */
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
