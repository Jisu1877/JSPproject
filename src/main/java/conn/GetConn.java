package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetConn {
	private Connection conn = null;   
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/javagreen_ljs";
	private String user = "root";
	private String password = "1234";
	
	//필드.. instance 변수를 GetConn.getInstance 로 부르면 이미 static으로 메소드영역에 올라가있는 GetConn()가 생성되어있는 instance를 사용할 수 있게 된다.
	private static GetConn instance = new GetConn();  //싱글톤은 대체로 변수명을 'instance'로 한다.
	
	//외부에서 생성할 수 없도록 접근 제한(private)
	private GetConn() { 
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패");
		} catch (SQLException e) {
			System.out.println("데이터베이스 연동 실패");
		}
	}

	//conn 와 instance 는 불러다 사용해야하기때문에 getter가 필요하다.
	
	public Connection getConn() {
		return conn;
	}

	public static GetConn getInstance() {
		return instance;
	}
	
	//싱글톤은 해당 줄 까지.
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
				pstmtClose();
			} catch (SQLException e) {}
		}
	}
}
