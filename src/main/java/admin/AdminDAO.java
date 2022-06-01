package admin;

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

public class AdminDAO {
	GetConn getConn = GetConn.getInstance(); //메모리에 있는 instance 가져오기
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	//여러 VO 미리 선언
	LodgingVO lodVo = null;
	FileVO fileVo = null;
	OptionVO optVo = null;
	
	//숙소명 중복체크 및 개별 숙소정보담아오기
	public LodgingVO getlodInfor(String lod_name) {
		lodVo = new LodgingVO();
		try {
			sql = "select * from lodging where lod_name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, lod_name);
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
			}
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return lodVo;
	}
	
	//숙소등록하기
	public int setLodInput(LodgingVO lodVO) {
		int lodRes = 0;
		try {
			sql = "insert into lodging values(default, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default, default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, lodVO.getFile_name());
			pstmt.setString(2, lodVO.getSave_file_name());
			pstmt.setInt(3, lodVO.getCategory_code());
			pstmt.setInt(4, lodVO.getSub_category_code());
			pstmt.setInt(5, lodVO.getDetail_category_code());
			pstmt.setString(6, lodVO.getLod_name());
			pstmt.setInt(7, lodVO.getPrice());
			pstmt.setString(8, lodVO.getCountry());
			pstmt.setString(9, lodVO.getAddress());
			pstmt.setString(10, lodVO.getExplanation());
			pstmt.setInt(11, lodVO.getNumber_guests());
			pstmt.executeUpdate();
			lodRes = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return lodRes;
	}
	
	//file DB에 자료 넣기
	public int setFileName(String file_name, String save_file_name, int lodIdx, int file_order) {
		int fileRes = 0;
		try {
			sql = "insert into file values(default, ?, ?, ?, ?, default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lodIdx);
			pstmt.setInt(2, file_order);
			pstmt.setString(3, file_name);
			pstmt.setString(4, save_file_name);
			pstmt.executeUpdate();
			fileRes = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return fileRes;
	}
	
	//option 내용 넣기
	public int setOptionInfor(OptionVO optionVo) {
		int optRes = 0;
		try {
			sql = "insert into lod_option values(default, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, optionVo.getLod_idx());
			pstmt.setString(2, optionVo.getAir_conditioner());
			pstmt.setString(3, optionVo.getTv());
			pstmt.setString(4, optionVo.getWifi());
			pstmt.setString(5, optionVo.getWasher());
			pstmt.setString(6, optionVo.getKitchen());
			pstmt.setString(7, optionVo.getHeating());
			pstmt.setString(8, optionVo.getToiletries());
			pstmt.setInt(9, optionVo.getBedroom());
			pstmt.setInt(10, optionVo.getBed());
			pstmt.setInt(11, optionVo.getBathroom());
			pstmt.executeUpdate();
			optRes = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return optRes;
	}
	
	//숙소 업데이트하기
	public int setLodUpdate(LodgingVO lodVO, String flag) {
		int res = 0;
		try {
			if(flag.equals("yes")) {
				sql = "update lodging set file_name = ?, save_file_name = ?, category_code = ?, sub_category_code = ?, detail_category_code = ?, lod_name = ?, price = ?, country = ?, address = ?, explanation = ?, number_guests = ? where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, lodVO.getFile_name());
				pstmt.setString(2, lodVO.getSave_file_name());
				pstmt.setInt(3, lodVO.getCategory_code());
				pstmt.setInt(4, lodVO.getSub_category_code());
				pstmt.setInt(5, lodVO.getDetail_category_code());
				pstmt.setString(6, lodVO.getLod_name());
				pstmt.setInt(7, lodVO.getPrice());
				pstmt.setString(8, lodVO.getCountry());
				pstmt.setString(9, lodVO.getAddress());
				pstmt.setString(10, lodVO.getExplanation());
				pstmt.setInt(11, lodVO.getNumber_guests());
				pstmt.setInt(12, lodVO.getIdx());
			}
			else {
				sql = "update lodging set category_code = ?, sub_category_code = ?, detail_category_code = ?, lod_name = ?, price = ?, country = ?, address = ?, explanation = ?, number_guests = ? where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, lodVO.getCategory_code());
				pstmt.setInt(2, lodVO.getSub_category_code());
				pstmt.setInt(3, lodVO.getDetail_category_code());
				pstmt.setString(4, lodVO.getLod_name());
				pstmt.setInt(5, lodVO.getPrice());
				pstmt.setString(6, lodVO.getCountry());
				pstmt.setString(7, lodVO.getAddress());
				pstmt.setString(8, lodVO.getExplanation());
				pstmt.setInt(9, lodVO.getNumber_guests());
				pstmt.setInt(10, lodVO.getIdx());
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
	
	//옵션 업데이트하기
	public int udateOptionInfor(OptionVO optionVo) {
		int optRes = 0;
		try {
			sql = "update lod_option set air_conditioner = ?, tv = ?, wifi = ?, washer = ?, kitchen = ?, heating = ?, toiletries = ?, bedroom = ?, bed = ?, bathroom = ? where lod_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, optionVo.getAir_conditioner());
			pstmt.setString(2, optionVo.getTv());
			pstmt.setString(3, optionVo.getWifi());
			pstmt.setString(4, optionVo.getWasher());
			pstmt.setString(5, optionVo.getKitchen());
			pstmt.setString(6, optionVo.getHeating());
			pstmt.setString(7, optionVo.getToiletries());
			pstmt.setInt(8, optionVo.getBedroom());
			pstmt.setInt(9, optionVo.getBed());
			pstmt.setInt(10, optionVo.getBathroom());
			pstmt.setInt(11, optionVo.getLod_idx());
			pstmt.executeUpdate();
			optRes = 1;
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return optRes;
	}
	
	//썸네일 삭제
	public void thumbfileDelete(int lodIdx) {
		try {
			sql = "delete from file where lod_idx = ? and file_order = 1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lodIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql 에러" + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
	

}
