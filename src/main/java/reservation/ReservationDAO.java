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

	// 이미 예약되어있는 날짜 가져오기
	public ArrayList<ReservationVO> getLodStayDate(int idx) {
		ArrayList<ReservationVO> resList = new ArrayList<ReservationVO>();
		try {
			//stay_date > date_format(now(), '%Y-%m-%d') -> 이걸 쓴 이유는 과거내용은 이미 지워졌으니 오늘 이후 내용만 가져오는 것.
			sql = "select * from reservation where lod_idx = ? and stay_date > date_format(now(), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationVO vo = new ReservationVO();
				vo.setStay_date(rs.getString("stay_date"));
				resList.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return resList;
	}
	
	//예약내역이 있는지 체크 메소드
	public ArrayList<ReservationVO> checkRes(int lodIdx) {
		ArrayList<ReservationVO> resList = new ArrayList<ReservationVO>();
		try {
			sql = "select * from reservation where lod_idx = ? and state = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lodIdx);
			pstmt.setString(2, "예약");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new ReservationVO();
				vo.setCheck_in(rs.getString("check_in"));
				
				resList.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return resList;
	}

	//회원당 예약리스트 가져오기
	public ArrayList<ReservationVO> getResList(int idx) {
		ArrayList<ReservationVO> resList = new ArrayList<ReservationVO>();
		try {
			sql = "select * from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx where re.mem_idx = ? group by re.check_in order by re.idx desc;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReservationVO vo = new ReservationVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setLod_idx(rs.getInt("lod_idx"));
				vo.setMem_idx(rs.getInt("mem_idx"));
				vo.setStay_date(rs.getString("stay_date")); //체크인날짜로 그룹화한거라 체크인날짜와 동일함.
				vo.setCheck_in(rs.getString("check_in"));
				vo.setCheck_out(rs.getString("check_out"));
				vo.setNumber_guests(rs.getInt("number_guests"));
				vo.setPayment_price(rs.getInt("payment_price"));
				vo.setTerm(rs.getInt("term"));
				vo.setReview(rs.getString("review"));
				vo.setState(rs.getString("state"));
				vo.setCancel_yn(rs.getString("cancel_yn"));
				vo.setCreate_date(rs.getString("create_date"));
				
				resList.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return resList;
	}
	
}
