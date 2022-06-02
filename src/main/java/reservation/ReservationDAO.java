package reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import lodging.LodgingVO;
import member.MemberVO;

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
			sql = "insert into reservation values(default, ?,?,?,?,?,?,?,?,null,default,default,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getLod_idx());
			pstmt.setInt(2, vo.getMem_idx());
			pstmt.setString(3, stay_date);
			pstmt.setString(4, vo.getCheck_in());
			pstmt.setString(5, vo.getCheck_out());
			pstmt.setInt(6, vo.getNumber_guests());
			pstmt.setInt(7, vo.getPayment_price());
			pstmt.setInt(8, vo.getTerm());
			pstmt.setInt(9, vo.getPoint());
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
			sql = "select * from reservation where lod_idx = ? and stay_date > date_format(now(), '%Y-%m-%d') and state = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, "예약");
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
			sql = "select * from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx where re.mem_idx = ? group by re.create_date order by re.idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new ReservationVO();
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
				
				LodgingVO lodVo = new LodgingVO();
				lodVo.setIdx(rs.getInt("l.idx"));
				lodVo.setFile_name(rs.getString("file_name"));
				lodVo.setSave_file_name(rs.getString("save_file_name"));
				lodVo.setCategory_code(rs.getInt("category_code"));
				lodVo.setSub_category_code(rs.getInt("sub_category_code"));
				lodVo.setDetail_category_code(rs.getInt("detail_category_code"));
				lodVo.setLod_name(rs.getString("lod_name"));
				lodVo.setPrice(rs.getInt("price"));
				lodVo.setCountry(rs.getString("country"));
				lodVo.setAddress(rs.getString("address"));
				lodVo.setExplanation(rs.getString("explanation"));
				lodVo.setNumber_guests(rs.getInt("number_guests"));
				lodVo.setCreate_date(rs.getString("l.create_date"));
				
				vo.setLodVo(lodVo);
				
				resList.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return resList;
	}
	
	//예약테이블 업데이트
	public int setUpdate(String today) {
		int res = 0;
		try {
			sql = "update reservation set state = '사용완료', review = '필요' where check_out <= ? and state != '확정완료'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, today);
			pstmt.executeUpdate();
			getConn.pstmtClose();

			sql = "update reservation set state = '사용중' where check_in = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, today);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	//예약 취소
	public int setCancel(int lodIdx, int memIdx, String checkIn, String checkOut, int flag) {
		int res = 0;
		try {
			if(flag == 0) {
				sql = "update reservation set state = '예약취소', cancel_yn = 'y' where lod_idx = ? and mem_idx = ? and check_in = ? and check_out = ?";
			}
			else {
				sql = "update reservation set state = '확정완료' where lod_idx = ? and mem_idx = ? and check_in = ? and check_out = ?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lodIdx);
			pstmt.setInt(2, memIdx);
			pstmt.setString(3, checkIn);
			pstmt.setString(4, checkOut);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
		
	//구매확정시 적립해줄 포인트 알아오기
	public int getPoint(int lodIdx, int memIdx, String checkIn, String checkOut) {
		int point = 0;
		try {
			sql = "select * from reservation where lod_idx = ? and mem_idx = ? and check_in = ? and check_out = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lodIdx);
			pstmt.setInt(2, memIdx);
			pstmt.setString(3, checkIn);
			pstmt.setString(4, checkOut);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				point = rs.getInt("point");
			}
 		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return point;
	}
	
	//리뷰 등록시 상태값 '작성완료'로 바꾸기
	public int setReviewState(int lodIdx, int memIdx, String checkIn, String checkOut) {
		int res = 0;
		try {
			sql = "update reservation set review = '작성완료' where lod_idx = ? and mem_idx = ? and check_in = ? and check_out = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lodIdx);
			pstmt.setInt(2, memIdx);
			pstmt.setString(3, checkIn);
			pstmt.setString(4, checkOut);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	//전체 예약정보 모두 가져오기(취소하지 않은 건만)
	public ArrayList<ReservationVO> getResList() {
		ArrayList<ReservationVO> resList = new ArrayList<ReservationVO>();
		try {
			sql = "select * from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx where cancel_yn = 'n' group by re.create_date order by re.idx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new ReservationVO();
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
				
				LodgingVO lodVo = new LodgingVO();
				lodVo.setIdx(rs.getInt("l.idx"));
				lodVo.setFile_name(rs.getString("file_name"));
				lodVo.setSave_file_name(rs.getString("save_file_name"));
				lodVo.setCategory_code(rs.getInt("category_code"));
				lodVo.setSub_category_code(rs.getInt("sub_category_code"));
				lodVo.setDetail_category_code(rs.getInt("detail_category_code"));
				lodVo.setLod_name(rs.getString("lod_name"));
				lodVo.setPrice(rs.getInt("price"));
				lodVo.setCountry(rs.getString("country"));
				lodVo.setAddress(rs.getString("address"));
				lodVo.setExplanation(rs.getString("explanation"));
				lodVo.setNumber_guests(rs.getInt("number_guests"));
				lodVo.setCreate_date(rs.getString("l.create_date"));
				
				vo.setLodVo(lodVo);
				
				resList.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return resList;
	}

	
	// 페이징처리를 위한 전체 레코드수 구하기
	public int totRecCnt() {
		int totRecCnt = 0;
		int cnt = 0;
		try {
			sql = "select count(*) as cnt from reservation group by create_date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cnt++;
				//otRecCnt += rs.getInt("cnt");
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return cnt;
	}
	
	//예약정보 모두 알아오기(취소건까지도)
	public ArrayList<ReservationVO> getResList(int startIndexNo, int pageSize) {
		ArrayList<ReservationVO> resList = new ArrayList<ReservationVO>(); 
		try {
			sql = "select * from reservation re " + 
				  "LEFT JOIN lodging l " + 
				  "ON re.lod_idx = l.idx " + 
				  "LEFT JOIN member m " +
				  "ON re.mem_idx = m.idx " + 
				  "group by re.create_date order by re.idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReservationVO();
				
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
				
				LodgingVO lodVo = new LodgingVO();
				lodVo.setIdx(rs.getInt("l.idx"));
				lodVo.setFile_name(rs.getString("file_name"));
				lodVo.setSave_file_name(rs.getString("save_file_name"));
				lodVo.setCategory_code(rs.getInt("category_code"));
				lodVo.setSub_category_code(rs.getInt("sub_category_code"));
				lodVo.setDetail_category_code(rs.getInt("detail_category_code"));
				lodVo.setLod_name(rs.getString("lod_name"));
				lodVo.setPrice(rs.getInt("price"));
				lodVo.setCountry(rs.getString("country"));
				lodVo.setAddress(rs.getString("address"));
				lodVo.setExplanation(rs.getString("explanation"));
				lodVo.setNumber_guests(rs.getInt("number_guests"));
				lodVo.setCreate_date(rs.getString("l.create_date"));
				
				vo.setLodVo(lodVo);
				
				MemberVO memVo = new MemberVO();
				
				memVo.setIdx(rs.getInt("idx"));
				memVo.setMid(rs.getString("mid"));
				memVo.setPwd(rs.getString("pwd"));
				memVo.setName(rs.getString("name"));
				memVo.setGender(rs.getString("gender"));
				memVo.setTel(rs.getString("tel"));
				memVo.setEmail(rs.getString("email"));
				memVo.setFile_name(rs.getString("file_name"));
				memVo.setSave_file_name(rs.getString("save_file_name"));
				memVo.setPostcode(rs.getString("postcode"));
				memVo.setRoadAddress(rs.getString("roadAddress"));
				memVo.setDetailAddress(rs.getString("detailAddress"));
				memVo.setExtraAddress(rs.getString("extraAddress"));
				memVo.setCreate_date(rs.getString("create_date"));
				memVo.setLastDate(rs.getString("lastDate"));
				memVo.setLevel(rs.getInt("level"));
				memVo.setPoint(rs.getInt("point"));
				memVo.setAgreement(rs.getInt("agreement"));
				memVo.setDel_yn(rs.getString("del_yn"));
				memVo.setDelete_date(rs.getString("delete_date"));
				
				vo.setMemVo(memVo);
				
				resList.add(vo);
				
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return resList;
	}
	
	//예약정보 가져오기(1건만)
	public ReservationVO getResInfor(int memIdx, int lodIdx, String checkIn, String checkOut) {
		vo = new ReservationVO();
		try {
			sql =  "select * from reservation re " + 
				   "LEFT JOIN lodging l " + 
				   "ON re.lod_idx = l.idx " + 
				   "LEFT JOIN member m " +
				   "ON re.mem_idx = m.idx " + 
				   "where re.mem_idx = ? and re.lod_idx = ? and re.check_in = ? and re.check_out = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memIdx);
			pstmt.setInt(2, lodIdx);
			pstmt.setString(3, checkIn);
			pstmt.setString(4, checkOut);
			rs = pstmt.executeQuery();
			if(rs.next()) {
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
				vo.setPoint(rs.getInt("point"));
				
				LodgingVO lodVo = new LodgingVO();
				lodVo.setIdx(rs.getInt("l.idx"));
				lodVo.setFile_name(rs.getString("file_name"));
				lodVo.setSave_file_name(rs.getString("save_file_name"));
				lodVo.setCategory_code(rs.getInt("category_code"));
				lodVo.setSub_category_code(rs.getInt("sub_category_code"));
				lodVo.setDetail_category_code(rs.getInt("detail_category_code"));
				lodVo.setLod_name(rs.getString("lod_name"));
				lodVo.setPrice(rs.getInt("price"));
				lodVo.setCountry(rs.getString("country"));
				lodVo.setAddress(rs.getString("address"));
				lodVo.setExplanation(rs.getString("explanation"));
				lodVo.setNumber_guests(rs.getInt("number_guests"));
				lodVo.setCreate_date(rs.getString("l.create_date"));
				
				vo.setLodVo(lodVo);
				
				MemberVO memVo = new MemberVO();
				
				memVo.setIdx(rs.getInt("idx"));
				memVo.setMid(rs.getString("mid"));
				memVo.setPwd(rs.getString("pwd"));
				memVo.setName(rs.getString("name"));
				memVo.setGender(rs.getString("gender"));
				memVo.setTel(rs.getString("tel"));
				memVo.setEmail(rs.getString("email"));
				memVo.setFile_name(rs.getString("file_name"));
				memVo.setSave_file_name(rs.getString("save_file_name"));
				memVo.setPostcode(rs.getString("postcode"));
				memVo.setRoadAddress(rs.getString("roadAddress"));
				memVo.setDetailAddress(rs.getString("detailAddress"));
				memVo.setExtraAddress(rs.getString("extraAddress"));
				memVo.setCreate_date(rs.getString("create_date"));
				memVo.setLastDate(rs.getString("lastDate"));
				memVo.setLevel(rs.getInt("level"));
				memVo.setPoint(rs.getInt("point"));
				memVo.setAgreement(rs.getInt("agreement"));
				memVo.setDel_yn(rs.getString("del_yn"));
				memVo.setDelete_date(rs.getString("delete_date"));
				
				vo.setMemVo(memVo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}
	
	//예약취소처리하기
	public int setCancel(int lodIdx, int memIdx, String checkIn, String checkOut) {
		int res = 0;
		try {
			sql = "update reservation set state = '예약취소', cancel_yn = 'y' where lod_idx = ? and mem_idx = ? and check_in = ? and check_out = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lodIdx);
			pstmt.setInt(2, memIdx);
			pstmt.setString(3, checkIn);
			pstmt.setString(4, checkOut);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	//회원 idx로 예약정보 있는지 확인하기
	public ReservationVO checkMemRes(int mem_idx) {
		vo = new ReservationVO();
		try {
			sql = "select * from reservation where mem_idx = ? and state = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_idx);
			pstmt.setString(2, "예약");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new ReservationVO();
				vo.setCheck_in(rs.getString("check_in"));
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}
	
}
