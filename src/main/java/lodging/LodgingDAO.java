package lodging;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.catalina.webresources.EmptyResource;

import conn.GetConn;
import lodging.FileVO;
import lodging.LodgingVO;
import lodging.OptionVO;
import member.MemberVO;
import reservation.ReservationVO;

public class LodgingDAO {
	GetConn getConn = GetConn.getInstance(); //메모리에 있는 instance 가져오기
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	//여러 VO 미리 선언
	LodgingVO lodVo = null;
	FileVO fileVo = null;
	OptionVO optVo = null;
	ReservationVO resVo = null;
	reviewVO reviewVo = null;
	MemberVO memVo = null;
	
	//숙소 정보 모두 가져오기(최신자료순)
	public ArrayList<LodgingVO> getLodList(int i) {

		ArrayList<LodgingVO> lodVos = new ArrayList<LodgingVO>();
		try {
			//숙소 정보 모두 가져오기 + 평점평균 계산해서 가져오기
			if(i == 0) {
				sql = "select *, " + 
						"(select sum(rating) / count(rating) as rating from review re " +
						"JOIN lodging l " + 
						"ON re.lod_idx = l.idx " + 
						"where exposure_yn = 'y' " + 
						"and del_yn = 'n' " + 
						"and l.idx = lod.idx " + 
						"group by lod_idx) as rating " + 
						"from lodging lod " + 
						"LEFT JOIN lod_option lo " + 
						"ON lod.idx = lo.lod_idx " + 
						"where del_yn = 'n'"; 
			}
			//신규등록 3개 가져오기 + 평점평균 계산해서 가져오기
			else {
				sql = "select *, " + 
						"(select sum(rating) / count(rating) as rating from review re " +
						"JOIN lodging l " + 
						"ON re.lod_idx = l.idx " + 
						"where exposure_yn = 'y' " + 
						"and del_yn = 'n' " + 
						"and l.idx = lod.idx " + 
						"group by lod_idx) as rating " + 
						"from lodging lod " + 
						"LEFT JOIN lod_option lo " + 
						"ON lod.idx = lo.lod_idx " + 
						"where del_yn = 'n' " +
						"order by lod.idx desc limit 0, 3";
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				lodVo = new LodgingVO();
				
				lodVo.setIdx(rs.getInt("idx"));
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
				lodVo.setCreate_date(rs.getString("create_date"));
				lodVo.setDel_yn(rs.getString("del_yn"));
				lodVo.setRating(rs.getDouble("rating"));
				
				optVo = new OptionVO();
				optVo.setOpt_idx(rs.getInt("opt_idx"));
				optVo.setLod_idx(rs.getInt("lod_idx"));
				optVo.setAir_conditioner(rs.getString("air_conditioner"));
				optVo.setTv(rs.getString("tv"));
				optVo.setWifi(rs.getString("wifi"));
				optVo.setWasher(rs.getString("washer"));
				optVo.setKitchen(rs.getString("kitchen"));
				optVo.setHeating(rs.getString("heating"));
				optVo.setToiletries(rs.getString("toiletries"));
				optVo.setBedroom(rs.getInt("bedroom"));
				optVo.setBed(rs.getInt("bed"));
				optVo.setBathroom(rs.getInt("bathroom"));
				
				lodVo.setOption(optVo);
				
				lodVos.add(lodVo);
			} 
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return lodVos;
	}
	
	
	//Best숙소알아오기
	public ArrayList<LodgingVO> getBestLodList() {
		ArrayList<LodgingVO> lodVos = new ArrayList<LodgingVO>();
		try {
			sql = "SELECT l.`*`, lo.`*`, COUNT(*) as cnt, " + 
					"(select sum(rating) / count(rating) as rating from review re " +
					"JOIN lodging lod " + 
					"ON re.lod_idx = lod.idx " + 
					"where exposure_yn = 'y' " + 
					"and del_yn = 'n' " + 
					"and lod.idx = l.idx " + 
					"group by lod_idx) as rating " + 
					"FROM (SELECT lod_idx, count(lod_idx) as cnt FROM reservation group by create_date) as a " +
					"JOIN lodging l " + 
					"ON a.lod_idx = l.idx " + 
					"JOIN lod_option lo " + 
					"ON a.lod_idx = lo.lod_idx " + 
					"GROUP BY lod_idx " + 
					"ORDER BY cnt DESC " + 
					"LIMIT 6"; 
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				lodVo = new LodgingVO();
				
				lodVo.setIdx(rs.getInt("idx"));
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
				lodVo.setCreate_date(rs.getString("create_date"));
				lodVo.setDel_yn(rs.getString("del_yn"));
				lodVo.setCnt(rs.getInt("cnt"));
				lodVo.setRating(rs.getDouble("rating"));
				
				optVo = new OptionVO();
				optVo.setOpt_idx(rs.getInt("opt_idx"));
				optVo.setLod_idx(rs.getInt("lod_idx"));
				optVo.setAir_conditioner(rs.getString("air_conditioner"));
				optVo.setTv(rs.getString("tv"));
				optVo.setWifi(rs.getString("wifi"));
				optVo.setWasher(rs.getString("washer"));
				optVo.setKitchen(rs.getString("kitchen"));
				optVo.setHeating(rs.getString("heating"));
				optVo.setToiletries(rs.getString("toiletries"));
				optVo.setBedroom(rs.getInt("bedroom"));
				optVo.setBed(rs.getInt("bed"));
				optVo.setBathroom(rs.getInt("bathroom"));
				
				lodVo.setOption(optVo);
				
				lodVos.add(lodVo);
			} 
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return lodVos;
	}
	
	//숙소 정보 idx로 1건 가져오기
	public LodgingVO getLodInfor(int idx) {
		lodVo = new LodgingVO();
		optVo = new OptionVO();
		try {
			sql = "select *, " + 
					"(select sum(rating) / count(rating) as rating from review re " +
					"JOIN lodging l " + 
					"ON re.lod_idx = l.idx " + 
					"where exposure_yn = 'y' " + 
					"and del_yn = 'n' " + 
					"and l.idx = lod.idx " + 
					"group by lod_idx) as rating " + 
					"from lodging lod " + 
					"LEFT JOIN lod_option lo " + 
					"ON lod.idx = lo.lod_idx " + 
					"where lod.idx = ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lodVo.setIdx(rs.getInt("idx"));
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
				lodVo.setCreate_date(rs.getString("create_date"));
				lodVo.setDel_yn(rs.getString("del_yn"));
				lodVo.setRating(rs.getDouble("rating"));
				
				optVo = new OptionVO();
				optVo.setOpt_idx(rs.getInt("opt_idx"));
				optVo.setLod_idx(rs.getInt("lod_idx"));
				optVo.setAir_conditioner(rs.getString("air_conditioner"));
				optVo.setTv(rs.getString("tv"));
				optVo.setWifi(rs.getString("wifi"));
				optVo.setWasher(rs.getString("washer"));
				optVo.setKitchen(rs.getString("kitchen"));
				optVo.setHeating(rs.getString("heating"));
				optVo.setToiletries(rs.getString("toiletries"));
				optVo.setBedroom(rs.getInt("bedroom"));
				optVo.setBed(rs.getInt("bed"));
				optVo.setBathroom(rs.getInt("bathroom"));
				
				lodVo.setOption(optVo);
				
			} 
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return lodVo;
	}

	// 숙소 사진 리스트 가져오기 
	public ArrayList<FileVO> getLodFile(int idx) {
		ArrayList<FileVO> fileVos = new ArrayList<FileVO>();
		try {
			sql = "select * from file where lod_idx = ? order by file_order";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				fileVo = new FileVO();
				
				fileVo.setFile_idx(rs.getInt("file_idx"));
				fileVo.setLod_idx(rs.getInt("lod_idx"));
				fileVo.setFile_name(rs.getString("file_name"));
				fileVo.setSave_file_name(rs.getString("save_file_name"));
				fileVo.setCreate_date(rs.getString("create_date"));
				
				fileVos.add(fileVo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return fileVos;
	}
	
	//조건검색
	public ArrayList<LodgingVO> getLodList(String checkIn, String checkOut, int area, int peopleNum, int code) {
		ArrayList<LodgingVO> lodVos = new ArrayList<LodgingVO>();
		try {
			//체크인, 체크아웃 날짜, 인원수는 입력했는데 지역선택을 안했을때(카테고리 선택 안함)
			if(area == 106 && code == 0) {
				sql = 	"select *, " + 
						"(select sum(rating) / count(rating) as rating from review re " +
						"JOIN lodging l " + 
						"ON re.lod_idx = l.idx " + 
						"where exposure_yn = 'y' " + 
						"and del_yn = 'n' " + 
						"and l.idx = lod.idx " + 
						"group by lod_idx) as rating " + 
						"from lodging lod " + 
						"LEFT JOIN lod_option lo " + 
						"ON lod.idx = lo.lod_idx " + 
						"where lod.idx NOT IN " +
						"(select re.lod_idx from reservation re LEFT JOIN lodging ll ON re.lod_idx = ll.idx where re.stay_date = ? or re.stay_date = ? group by re.lod_idx) " +
						"and lod.number_guests >= ? " +
						"and lod.del_yn = 'n' " +
						"order by lod.idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, checkIn);
				pstmt.setString(2, checkOut);
				pstmt.setInt(3, peopleNum);
			}
			//체크인, 체크아웃 날짜, 인원수, 지역까지 모두 선택(카테고리 선택 안함)
			else if(area != 106 && code == 0) {
				sql = 	"select *, " + 
						"(select sum(rating) / count(rating) as rating from review re " +
						"JOIN lodging l " + 
						"ON re.lod_idx = l.idx " + 
						"where exposure_yn = 'y' " + 
						"and del_yn = 'n' " + 
						"and l.idx = lod.idx " + 
						"group by lod_idx) as rating " + 
						"from lodging lod " + 
						"LEFT JOIN lod_option lo " + 
						"ON lod.idx = lo.lod_idx " + 
						"where lod.idx NOT IN " +
						"(select re.lod_idx from reservation re LEFT JOIN lodging ll ON re.lod_idx = ll.idx where re.stay_date = ? or re.stay_date = ? group by re.lod_idx) " +
						"and lod.number_guests >= ? and lod.category_code = ? " +
						"and lod.del_yn = 'n' " +
						"order by lod.idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, checkIn);
				pstmt.setString(2, checkOut);
				pstmt.setInt(3, peopleNum);
				pstmt.setInt(4, area);
			}
			//체크인, 체크아웃 날짜, 인원수는 입력했는데 지역선택을 안했을때(카테고리 선택 함)
			else if(area == 106 && code != 0) {
				sql = 	"select *, " + 
						"(select sum(rating) / count(rating) as rating from review re " +
						"JOIN lodging l " + 
						"ON re.lod_idx = l.idx " + 
						"where exposure_yn = 'y' " + 
						"and del_yn = 'n' " + 
						"and l.idx = lod.idx " + 
						"group by lod_idx) as rating " + 
						"from lodging lod " + 
						"LEFT JOIN lod_option lo " + 
						"ON lod.idx = lo.lod_idx " + 
						"where lod.idx NOT IN " +
						"(select re.lod_idx from reservation re LEFT JOIN lodging ll ON re.lod_idx = ll.idx where re.stay_date = ? or re.stay_date = ? group by re.lod_idx) " +
						"and lod.number_guests >= ? " +
						"and lod.del_yn = 'n' " +
						"and lod.detail_category_code = ?" +
						"order by lod.idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, checkIn);
				pstmt.setString(2, checkOut);
				pstmt.setInt(3, peopleNum);
				pstmt.setInt(4, code);
			}
			//체크인, 체크아웃 날짜, 인원수, 지역까지 모두 선택(카테고리 함)
			else if(area != 106 && code != 0) {
				sql = "select *, " + 
						"(select sum(rating) / count(rating) as rating from review re " +
						"JOIN lodging l " + 
						"ON re.lod_idx = l.idx " + 
						"where exposure_yn = 'y' " + 
						"and del_yn = 'n' " + 
						"and l.idx = lod.idx " + 
						"group by lod_idx) as rating " + 
						"from lodging lod " + 
						"LEFT JOIN lod_option lo " + 
						"ON lod.idx = lo.lod_idx " + 
						"where lod.idx NOT IN " +
						"(select re.lod_idx from reservation re LEFT JOIN lodging ll ON re.lod_idx = ll.idx where re.stay_date = ? or re.stay_date = ? group by re.lod_idx) " +
						"and lod.number_guests >= ? and lod.category_code = ? " +
						"and lod.del_yn = 'n' " +
						"and lod.detail_category_code = ?" +
						"order by lod.idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, checkIn);
				pstmt.setString(2, checkOut);
				pstmt.setInt(3, peopleNum);
				pstmt.setInt(4, area);
				pstmt.setInt(5, code);
			}
			else {
				sql =	"select *, " + 
						"(select sum(rating) / count(rating) as rating from review re " +
						"JOIN lodging l " + 
						"ON re.lod_idx = l.idx " + 
						"where exposure_yn = 'y' " + 
						"and del_yn = 'n' " + 
						"and l.idx = lod.idx " + 
						"group by lod_idx) as rating " + 
						"from lodging lod " + 
						"LEFT JOIN lod_option lo " + 
						"ON lod.idx = lo.lod_idx " + 
						"where del_yn = 'n'"; 
				pstmt = conn.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				lodVo = new LodgingVO();
				
				lodVo.setIdx(rs.getInt("idx"));
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
				lodVo.setCreate_date(rs.getString("create_date"));
				lodVo.setDel_yn(rs.getString("del_yn"));
				lodVo.setRating(rs.getDouble("rating"));
				
				optVo = new OptionVO();
				optVo.setOpt_idx(rs.getInt("opt_idx"));
				optVo.setLod_idx(rs.getInt("lod_idx"));
				optVo.setAir_conditioner(rs.getString("air_conditioner"));
				optVo.setTv(rs.getString("tv"));
				optVo.setWifi(rs.getString("wifi"));
				optVo.setWasher(rs.getString("washer"));
				optVo.setKitchen(rs.getString("kitchen"));
				optVo.setHeating(rs.getString("heating"));
				optVo.setToiletries(rs.getString("toiletries"));
				optVo.setBedroom(rs.getInt("bedroom"));
				optVo.setBed(rs.getInt("bed"));
				optVo.setBathroom(rs.getInt("bathroom"));
				
				lodVo.setOption(optVo);
				
				lodVos.add(lodVo);
			} 
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return lodVos;
	}
	
	// 페이징처리를 위한 전체 레코드수 구하기
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as cnt from lodging";
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
	
	//페이징처리를 추가한 전체 숙소리스트 가져오기 메소드
	public ArrayList<LodgingVO> getLodList(int startIndexNo, int pageSize) {
		ArrayList<LodgingVO> lodVos = new ArrayList<LodgingVO>();
		try {
			sql =   "select *, " + 
					"(select sum(rating) / count(rating) as rating from review re " +
					"JOIN lodging l " + 
					"ON re.lod_idx = l.idx " + 
					"where exposure_yn = 'y' " + 
					"and del_yn = 'n' " + 
					"and l.idx = lod.idx " + 
					"group by lod_idx) as rating " + 
					"from lodging lod " + 
					"LEFT JOIN lod_option lo " + 
					"ON lod.idx = lo.lod_idx " + 
					"order by lod.idx desc limit ?, ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				lodVo = new LodgingVO();
				
				lodVo.setIdx(rs.getInt("idx"));
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
				lodVo.setCreate_date(rs.getString("create_date"));
				lodVo.setDel_yn(rs.getString("del_yn"));
				lodVo.setRating(rs.getDouble("rating"));
				
				optVo = new OptionVO();
				optVo.setOpt_idx(rs.getInt("opt_idx"));
				optVo.setLod_idx(rs.getInt("lod_idx"));
				optVo.setAir_conditioner(rs.getString("air_conditioner"));
				optVo.setTv(rs.getString("tv"));
				optVo.setWifi(rs.getString("wifi"));
				optVo.setWasher(rs.getString("washer"));
				optVo.setKitchen(rs.getString("kitchen"));
				optVo.setHeating(rs.getString("heating"));
				optVo.setToiletries(rs.getString("toiletries"));
				optVo.setBedroom(rs.getInt("bedroom"));
				optVo.setBed(rs.getInt("bed"));
				optVo.setBathroom(rs.getInt("bathroom"));
				
				lodVo.setOption(optVo);
				
				lodVos.add(lodVo);
			} 
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return lodVos;
	}
	
	//파일테이블에서 사진 삭제
	public int fileDelete(String fName) {
		int res = 0;
		try {
			sql = "delete from file where save_file_name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fName);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	//숙소 삭제하기
	public int lodDelete(int lodIdx) {
		int res = 0;
		try {
			sql = "update lodging set del_yn = 'y' where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lodIdx);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	//리뷰테이블에 리뷰등록
	public int setReviewInput(reviewVO vo) {
		int res = 0;
		try {
			sql = "insert into review values(default,?,?,?,?,?,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getLod_idx());
			pstmt.setInt(2, vo.getMem_idx());
			pstmt.setInt(3, vo.getRating());
			pstmt.setString(4, vo.getReview_subject());
			pstmt.setString(5, vo.getReview_contents());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	//회원당 작성한 리뷰 가져오기
	public ArrayList<reviewVO> getReviewList(int idx) {
		ArrayList<reviewVO> reviewList = new ArrayList<reviewVO>();
		try {
			sql = "select * from review re LEFT JOIN lodging l ON re.lod_idx = l.idx LEFT JOIN member m ON re.mem_idx = m.idx where mem_idx = ? and exposure_yn = 'y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				reviewVo = new reviewVO();
				
				reviewVo.setIdx(rs.getInt("re.idx"));
				reviewVo.setLod_idx(rs.getInt("lod_idx"));
				reviewVo.setMem_idx(rs.getInt("mem_idx"));
				reviewVo.setRating(rs.getInt("rating"));
				reviewVo.setReview_subject(rs.getString("review_subject"));
				reviewVo.setReview_contents(rs.getString("review_contents"));
				reviewVo.setExposure_yn(rs.getString("exposure_yn"));
				reviewVo.setCreate_date(rs.getString("re.create_date"));
				
				lodVo = new LodgingVO();
				
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
				lodVo.setDel_yn(rs.getString("del_yn"));
				
				reviewVo.setLodVo(lodVo);
				
				reviewList.add(reviewVo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return reviewList;
	}
	
	//숙소당 작성된 리뷰 가져오기
	public ArrayList<reviewVO> getReviewListLod(int idx) {
		ArrayList<reviewVO> reviewList = new ArrayList<reviewVO>();
		try {
			sql = "select * from review re LEFT JOIN member m ON re.mem_idx = m.idx where lod_idx = ? and exposure_yn = 'y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				reviewVo = new reviewVO();
				
				reviewVo.setIdx(rs.getInt("re.idx"));
				reviewVo.setLod_idx(rs.getInt("lod_idx"));
				reviewVo.setMem_idx(rs.getInt("mem_idx"));
				reviewVo.setRating(rs.getInt("rating"));
				reviewVo.setReview_subject(rs.getString("review_subject"));
				reviewVo.setReview_contents(rs.getString("review_contents"));
				reviewVo.setExposure_yn(rs.getString("exposure_yn"));
				reviewVo.setCreate_date(rs.getString("re.create_date"));
				
				memVo = new MemberVO();
				
				memVo.setMid(rs.getString("mid"));
				memVo.setSave_file_name(rs.getString("save_file_name"));
				
				reviewVo.setMember(memVo);
				reviewVo.setLodVo(lodVo);
				
				reviewList.add(reviewVo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return reviewList;
	}

	//리뷰삭제(비노출 처리)
	public int deleteReview(int idx) {
		int res = 0;
		try {
			sql = "update review set exposure_yn = 'n' where idx = ?";
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
	
	//리뷰 정보 모두 가져오기
	public ArrayList<reviewVO> getReviewList(String flag) {
		ArrayList<reviewVO> reviewList = new ArrayList<reviewVO>();
		try {
			if(flag.equals("노출만")) {
				sql = "select * from review re JOIN lodging l ON re.lod_idx = l.idx  where exposure_yn = 'y'";
			}
			else {
				sql = "select * from review re JOIN lodging l ON re.lod_idx = l.idx";
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				reviewVo = new reviewVO();
				
				reviewVo.setIdx(rs.getInt("re.idx"));
				reviewVo.setLod_idx(rs.getInt("lod_idx"));
				reviewVo.setMem_idx(rs.getInt("mem_idx"));
				reviewVo.setRating(rs.getInt("rating"));
				reviewVo.setReview_subject(rs.getString("review_subject"));
				reviewVo.setReview_contents(rs.getString("review_contents"));
				reviewVo.setExposure_yn(rs.getString("exposure_yn"));
				reviewVo.setCreate_date(rs.getString("re.create_date"));
				
				lodVo = new LodgingVO();
				
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
				lodVo.setDel_yn(rs.getString("del_yn"));
				
				reviewVo.setLodVo(lodVo);
				
				reviewList.add(reviewVo);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return reviewList;
	}

	//리뷰 정보 가져오기 (리뷰+숙소+회원 테이블 Join)
	public ArrayList<reviewVO> getReviewList(int startIndexNo, int pageSize) {
		ArrayList<reviewVO> revList = new ArrayList<reviewVO>();
		try {
			sql = "select * from review re LEFT JOIN member m ON re.mem_idx = m.idx LEFT JOIN lodging l ON re.lod_idx = l.idx limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				reviewVo = new reviewVO();
				
				reviewVo.setIdx(rs.getInt("re.idx"));
				reviewVo.setLod_idx(rs.getInt("lod_idx"));
				reviewVo.setMem_idx(rs.getInt("mem_idx"));
				reviewVo.setRating(rs.getInt("rating"));
				reviewVo.setReview_subject(rs.getString("review_subject"));
				reviewVo.setReview_contents(rs.getString("review_contents"));
				reviewVo.setExposure_yn(rs.getString("exposure_yn"));
				reviewVo.setCreate_date(rs.getString("re.create_date"));
				
				lodVo = new LodgingVO();
				
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
				lodVo.setDel_yn(rs.getString("del_yn"));
				
				reviewVo.setLodVo(lodVo);
				
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
				
				reviewVo.setMember(memVo);
				
				revList.add(reviewVo);
				
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return revList;
	}

	//전체건수 알아오기
	public int totRecCntRev() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as cnt from review";
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



}
