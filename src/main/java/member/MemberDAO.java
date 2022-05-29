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
			sql = "insert into member values(default,?,?,?,?,?,?,?,?,?,?,?,?,default,default,default,default,?,default,default)";
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

		//회원정보 idx로 1건 가져오기
		public MemberVO getMemInfor(int mem_idx) {
			MemberVO vo = new MemberVO();
			try {
				sql = "select * from member where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mem_idx);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setFile_name(rs.getString("file_name"));
					vo.setSave_file_name(rs.getString("save_file_name"));
					vo.setPostcode(rs.getString("postcode"));
					vo.setRoadAddress(rs.getString("roadAddress"));
					vo.setDetailAddress(rs.getString("detailAddress"));
					vo.setExtraAddress(rs.getString("extraAddress"));
					vo.setCreate_date(rs.getString("create_date"));
					vo.setLastDate(rs.getString("lastDate"));
					vo.setLevel(rs.getInt("level"));
					vo.setPoint(rs.getInt("point"));
					vo.setAgreement(rs.getInt("agreement"));
					vo.setDel_yn(rs.getString("del_yn"));
					vo.setDelete_date(rs.getString("delete_date"));
				}
			} catch (SQLException e) {
				System.out.println("sql 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}
		
		//오버로딩 1
		public MemberVO getMemInfor(String name, String tel) {  //getMemInfor 메소드 오버로딩
			MemberVO vo = new MemberVO();
			try {
				sql = "select * from member where name = ? and tel = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, tel);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setFile_name(rs.getString("file_name"));
					vo.setSave_file_name(rs.getString("save_file_name"));
					vo.setPostcode(rs.getString("postcode"));
					vo.setRoadAddress(rs.getString("roadAddress"));
					vo.setDetailAddress(rs.getString("detailAddress"));
					vo.setExtraAddress(rs.getString("extraAddress"));
					vo.setCreate_date(rs.getString("create_date"));
					vo.setLastDate(rs.getString("lastDate"));
					vo.setLevel(rs.getInt("level"));
					vo.setPoint(rs.getInt("point"));
					vo.setAgreement(rs.getInt("agreement"));
					vo.setDel_yn(rs.getString("del_yn"));
					vo.setDelete_date(rs.getString("delete_date"));
				}
			} catch (SQLException e) {
				System.out.println("sql 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}
		
		// 오버로딩 2
		public MemberVO getMemInfor(String mid, String name, String tel) {  //getMemInfor 메소드 오버로딩
			MemberVO vo = new MemberVO();
			try {
				sql = "select * from member where mid = ? and name = ? and tel = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.setString(2, name);
				pstmt.setString(3, tel);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setFile_name(rs.getString("file_name"));
					vo.setSave_file_name(rs.getString("save_file_name"));
					vo.setPostcode(rs.getString("postcode"));
					vo.setRoadAddress(rs.getString("roadAddress"));
					vo.setDetailAddress(rs.getString("detailAddress"));
					vo.setExtraAddress(rs.getString("extraAddress"));
					vo.setCreate_date(rs.getString("create_date"));
					vo.setLastDate(rs.getString("lastDate"));
					vo.setLevel(rs.getInt("level"));
					vo.setPoint(rs.getInt("point"));
					vo.setAgreement(rs.getInt("agreement"));
					vo.setDel_yn(rs.getString("del_yn"));
					vo.setDelete_date(rs.getString("delete_date"));
				}
			} catch (SQLException e) {
				System.out.println("sql 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}

		//비밀번호 재생성
		public int memPwdInput(String pwd, String mid) {
			int res = 0;
			try {
				sql = "update member set pwd = ? where mid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, pwd);
				pstmt.setString(2, mid);
				pstmt.executeUpdate();
				res = 1;
			} catch (SQLException e) {
				System.out.println("sql 에러" + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

		// 페이징처리를 위한 전체 레코드수 구하기
		public int totRecCnt() {
			int totRecCnt = 0;
			try {
				sql = "select count(*) as cnt from member";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				rs.next();
				totRecCnt = rs.getInt("cnt");
			} catch (SQLException e) {
				System.out.println("sql 에러" + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return totRecCnt;
		}
		
		//최종방문일 업데이트
		public int setLastDate(String mid) {
			int res2 = 0;
			try {
				sql = "update member set lastDate = now() where mid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.executeUpdate();
				res2 = 1;
			} catch (SQLException e) {
				System.out.println("sql 에러" + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res2;
		}

		// 한페이지의 분량을 정해서 회원정보 가져오기
		public ArrayList<MemberVO> getMemList(int startIndexNo, int pageSize) {
			ArrayList<MemberVO> memList = new ArrayList<MemberVO>();
			try {
				sql = "select *,timestampdiff(DAY, delete_date, NOW()) as applyDiff from member order by idx desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new MemberVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setFile_name(rs.getString("file_name"));
					vo.setSave_file_name(rs.getString("save_file_name"));
					vo.setPostcode(rs.getString("postcode"));
					vo.setRoadAddress(rs.getString("roadAddress"));
					vo.setDetailAddress(rs.getString("detailAddress"));
					vo.setExtraAddress(rs.getString("extraAddress"));
					vo.setCreate_date(rs.getString("create_date"));
					vo.setLastDate(rs.getString("lastDate"));
					vo.setLevel(rs.getInt("level"));
					vo.setPoint(rs.getInt("point"));
					vo.setAgreement(rs.getInt("agreement"));
					vo.setDel_yn(rs.getString("del_yn"));
					vo.setDelete_date(rs.getString("delete_date"));
					vo.setApplyDiff(rs.getInt("applyDiff"));
					
					memList.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("sql 에러" + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return memList;
		}

		// 회원정보 수정하기(관리자모드)
		public int setMemUpdateOk(MemberVO vo) {
			int res = 0;
			try {
				if(!vo.getFile_name().equals("")) {
					sql = "update member set name = ?, gender = ?, email = ?, file_name = ?, save_file_name = ?, postcode = ?, roadAddress = ?, detailAddress = ?, extraAddress = ? where idx = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, vo.getName());
					pstmt.setString(2, vo.getGender());
					pstmt.setString(3, vo.getEmail());
					pstmt.setString(4, vo.getFile_name());
					pstmt.setString(5, vo.getSave_file_name());
					pstmt.setString(6, vo.getPostcode());
					pstmt.setString(7, vo.getRoadAddress());
					pstmt.setString(8, vo.getDetailAddress());
					pstmt.setString(9, vo.getExtraAddress());
					pstmt.setInt(10, vo.getIdx());
				}
				else {
					sql = "update member set name = ?, gender = ?, email = ?, postcode = ?, roadAddress = ?, detailAddress = ?, extraAddress = ? where idx = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, vo.getName());
					pstmt.setString(2, vo.getGender());
					pstmt.setString(3, vo.getEmail());
					pstmt.setString(4, vo.getPostcode());
					pstmt.setString(5, vo.getRoadAddress());
					pstmt.setString(6, vo.getDetailAddress());
					pstmt.setString(7, vo.getExtraAddress());
					pstmt.setInt(8, vo.getIdx());
				}
				pstmt.executeUpdate();
				res = 1;
			} catch (SQLException e) {
				System.out.println("sql 에러" + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

		//회원 탈퇴처리
		public int memDelete(int idx) {
			int res = 0;
			try {
				sql = "update member set del_yn = 'y', delete_date = now() where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
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
