package lodging;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;

@WebServlet("/lodNameCheck")
public class lodNameCheck extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String lod_name = request.getParameter("lod_name") == null ? "" : request.getParameter("lod_name");
		
		AdminDAO dao = new AdminDAO();
		
		LodgingVO lodVO = dao.getlodInfor(lod_name);
		String data = "";
		if(lodVO.getCountry() == null) {
			data = "nameOk";
		}
		else {
			data = "nameNo";
		}
		response.getWriter().write(data);
	}
}
