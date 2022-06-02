package reservation;

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

@WebServlet("*.res")
public class ReservationController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReservationInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1,uri.lastIndexOf("."));
		
		//세션이 끊겼으면 작업의 진행을 홈으로 보내기 위함.(비정상적인 접근)
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel") == null ? 99 : (int)session.getAttribute("sLevel");
		
		if(com.equals("resSearch")) {
			command = new resSearchCommand();
			command.execute(request, response); 
			viewPage += "/reservation/resSearch.jsp";
		}
		else if(level != 1 && level != 0) { //세션이 끊겼으면 작업의 진행을 홈으로 보낸다.(비정상적인 접근) RequestDispatcher
			request.setAttribute("msg", "accessNO");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/message.jsp");
			dispatcher.forward(request, response);
		}
		else if(com.equals("payment_confirmation")) {
			command = new Payment_confirmationCommand();
			command.execute(request, response);
			viewPage += "/reservation/payment_confirmation.jsp";
		}
		else if(com.equals("reserInput")) {
			command = new ReserInputCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("stateChange")) {
			command = new StateChangeCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("resCancel")) {
			command = new ResCancelCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("resInfor")) {
			command = new ResInforCommand();
			command.execute(request, response);
			viewPage += "/reservation/resInfor.jsp";
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
