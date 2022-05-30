package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lodging.LodInforCommand;
import lodging.Lod_Input_OkCommand;
import lodging.LodgingInterface;
import member.MemJoinOkCommand;

@WebServlet("*.ad")
public class AdminController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1,uri.lastIndexOf("."));
		
		//세션이 끊겼으면 작업의 진행을 홈으로 보내기 위함.(비정상적인 접근)
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel") == null ? 99 : (int)session.getAttribute("sLevel");
		
		if(level != 0) { //세션이 끊겼으면 작업의 진행을 홈으로 보낸다.(비정상적인 접근)
			RequestDispatcher dispatcher = request.getRequestDispatcher("/memLogin.mem");
			dispatcher.forward(request, response);
		}
		else if(com.equals("adminHome")) {
			viewPage += "/admin/adminHome.jsp";
		}
		else if(com.equals("lod_management")) {
			command = new Lod_managementCommand();
			command.execute(request, response); 
			viewPage += "/admin/lod_management.jsp";
		}
		else if(com.equals("mem_management")) {
			command = new Mem_managementCommand();
			command.execute(request, response); 
			viewPage += "/admin/mem_management.jsp";
		}
		else if(com.equals("memInfor")) {
			command = new MemInforCommand();
			command.execute(request, response); 
			viewPage += "/admin/adMemInfor.jsp";
		}
		else if(com.equals("lod_input")) {
			viewPage += "/admin/lod_input.jsp";
		}
		else if(com.equals("lod_Input_Ok")) {
			command = new Lod_Input_OkCommand();
			command.execute(request, response); 
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("memUpdate")) {
			command = new MemUpdateCommand();
			command.execute(request, response); 
			viewPage += "/admin/memUpdate.jsp";
		}
		else if(com.equals("memUpdateOk")) {
			command = new MemUpdateOkCommand();
			command.execute(request, response); 
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("memDelete")) {
			command = new MemDeleteCommand();
			command.execute(request, response); 
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("lodInfor")) {
			LodgingInterface lod_command = new LodInforCommand();
			lod_command.execute(request, response); 
			viewPage += "/admin/adLodInfor.jsp";
		}
		else if(com.equals("lodUpdate")) {
			command = new LodUpdateCommand();
			command.execute(request, response); 
			viewPage += "/admin/lodUpdate.jsp";
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
