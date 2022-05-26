package reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import org.apache.catalina.webresources.EmptyResource;

import conn.GetConn;

public class ReservationDAO {
	GetConn getConn = GetConn.getInstance(); //메모리에 있는 instance 가져오기
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	ReservationVO vo = null;
	
	//예약하기
	public int setReserInput(ReservationVO vo,  String stay_date) {
		int res = 0;
		try {
			sql = "insert into reservation values(default, ?,?,?,?,?,?,?,?,null,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getLod_idx());
			pstmt.setInt(2, vo.getMem_idx());
			pstmt.setString(3, stay_date);
			pstmt.setString(4, vo.getCheck_in());
			pstmt.setString(5, vo.getCheck_out());
			pstmt.setInt(6, vo.getNumber_guests());
			pstmt.setInt(7, vo.getPayment_price());
			pstmt.setInt(8, vo.getTerm());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	
	
}
