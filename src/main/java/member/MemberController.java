package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.MemUpdateCommand;
import admin.MemUpdateOkCommand;

@WebServlet("*.mem")
public class MemberController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1,uri.lastIndexOf("."));
		
		//세션이 끊겼으면 작업의 진행을 홈으로 보내기 위함.(비정상적인 접근)
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel") == null ? 99 : (int)session.getAttribute("sLevel");
		
		if(com.equals("termsOfService")) {
			viewPage += "/member/termsOfService.jsp";
		}
		else if(com.equals("memJoin")) {
			viewPage += "/member/memJoin.jsp";
		}
		else if(com.equals("memIdCheckOk")) {
			viewPage += "/member/memIdCheck.jsp";
		}
		else if(com.equals("memJoinOk")) {
			command = new MemJoinOkCommand();
			command.execute(request, response); 
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("memLogin")) {
			command = new MemLoginCommand();
			command.execute(request, response);
			viewPage += "/member/memLogin.jsp";
		}
		else if(com.equals("memLoginOk")) {
			command = new MemLoginOkCommand();
			command.execute(request, response); 
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("memIdFind")) {
			viewPage += "/member/memIdFind.jsp";
		}
		else if(com.equals("memIdFindOk")) {
			command = new MemIdFindOkCommand();
			command.execute(request, response);
			viewPage += "/member/memIdFind.jsp";
		}
		else if(com.equals("memPwdFind")) {
			viewPage += "/member/memPwdFind.jsp";
		}
		else if(com.equals("memPwdFindOk")) {
			command = new MemPwdFindCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("memPwdInput")) {
			viewPage += "/member/memPwdInput.jsp";
		}
		else if(com.equals("memPwdInputOk")) {
			command = new MemPwdInputOkCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		else if(level == 99) { //세션이 끊겼으면 작업의 진행을 홈으로 보낸다.(비정상적인 접근)
			RequestDispatcher dispatcher = request.getRequestDispatcher("/memLogin.mem");
			dispatcher.forward(request, response);
		}
		else if(com.equals("memLogOut")) {
			command = new MemLogOutCommand();
			command.execute(request, response); 
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("memMypage")) {
			command = new MemMypageCommand();
			command.execute(request, response); 
			viewPage += "/member/memMypage.jsp";
		}
		else if(com.equals("memUpdate")) {
			command = new MemUpdateMemCommand();
			command.execute(request, response); 
			viewPage += "/member/memUpdate.jsp";
		}
		else if(com.equals("memUpdateOk")) {
			command = new MemUpdateOkMemCommand();
			command.execute(request, response); 
			viewPage = "/message/message.jsp";
		}
		else if(com.equals("memDelete")) {
			command = new MemDeleteMemCommand();
			command.execute(request, response); 
			viewPage = "/message/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
