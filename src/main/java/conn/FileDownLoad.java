package conn;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fileDownLoad")
public class FileDownLoad extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/pdsTest/");
		
		String fName = request.getParameter("file");
		
		// 껍데기 만들기..
		File file = new File(realPath + fName);
		
		// mimeType : 파일의 형식(전송방식) - 앞의 형식설정이 없을 경우는 2진 바이너리형식으로 전송하겠다.
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream"); // 2진 바이너리형식
 		}
		
		// 사용하는 브라우저가 인터넷 익스플로어인경우는 'euc-kr', 나머지는 'utf-8'로 전송한다.
		String downLoadName = "";
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downLoadName = new String(fName.getBytes("UTF-8"), "8859_1");
		}
		else {
			downLoadName = new String(fName.getBytes("EUC-KR"), "8859_1");
		}
		
		// 다운로드할 파일명과 형식을 헤더파일에 담아서 클라이언트에 전송할 준비를 한다.
		response.setHeader("Content-Disposition", "attachment;filename="+downLoadName);
		
		//Java에 의해서 실제로 파일을 다운(업)로드 처리한다.(FileInputStream/FileOutputStream)
		FileInputStream fis = new FileInputStream(file); //껍데기 만든곳에 알맹이 채우기
		//클라이언트에 저장할땐 ServletOutputStream / 서버에 저장할땐 FileOutputStream
		ServletOutputStream sos = response.getOutputStream();
		
		//생성된 객체에 실제로 파일을 전송처리한다.
		byte[] b = new byte[2048];  //2KB씩 전송하는 것이 가장 안정적이다.
		
		int data = 0;
		while((data = fis.read(b, 0, b.length)) != -1) {
			sos.write(b, 0, data);
		}
		sos.flush();
		//여기까지 파일 다운로드 처리이다.
		
		sos.close();
		fis.close();
	}
}
