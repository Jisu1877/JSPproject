package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.catalina.webresources.EmptyResource;

import conn.GetConn;

public class MemberDAO {
	GetConn getConn = GetConn.getInstance(); //메모리에 있는 instance 가져오기
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	MemberVO vo = null;
	
	//아이디 중복체크
	public String memIdCheck(String mid) {
		String name = "";
		try {
			sql = "select * from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}
	
	
	//연락처 중복체크
	public String memTelCheck(String tel) {
		String name = "";
		try {
			sql = "select * from member where tel = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tel);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}

	//회원가입 처리
	public int setMemJoinOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into member values(default,?,?,?,?,?,?,?,?,?,?,?,?,default,default,default,?,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getGender());
			pstmt.setString(5, vo.getTel());
			pstmt.setString(6, vo.getEmail());
			pstmt.setString(7, vo.getFile_name());
			pstmt.setString(8, vo.getSave_file_name());
			pstmt.setString(9, vo.getPostcode());
			pstmt.setString(10, vo.getRoadAddress());
			pstmt.setString(11, vo.getDetailAddress());
			pstmt.setString(12, vo.getExtraAddress());
			pstmt.setInt(13, vo.getAgreement());
			pstmt.executeUpdate();
			res = 1;
		}catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	//멤버 체크(로그인 체크)
		public MemberVO getMemCheck(String mid, String pwd) {
			vo = new MemberVO();
			try {
				sql = "select * from member where mid = ? and pwd = ? and del_yn = 'n'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.setString(2, pwd);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setName(rs.getString("name"));
					vo.setLevel(rs.getInt("level"));
					vo.setPoint(rs.getInt("point"));
				}
			} catch (SQLException e) {
				System.out.println("sql 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}

		//로그인 기록 저장
		public int setMem_log(int idx, String hostIp) {
			int res = 0;
			try {
				sql = "insert into mem_log values(default, ?, default, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.setString(2, hostIp);
				pstmt.executeUpdate();
				res = 1;
			} catch (SQLException e) {
				System.out.println("sql 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

}
