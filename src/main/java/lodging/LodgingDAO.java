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
	
	//숙소 정보 모두 가져오기(최신자료순)
	public ArrayList<LodgingVO> getLodList() {

		ArrayList<LodgingVO> lodVos = new ArrayList<LodgingVO>();
		try {
			sql = "select * from lodging l " + 
				  "LEFT JOIN lod_option lo " +
				  "ON l.idx = lo.lod_idx " + 
				  "order by l.idx desc";
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
			sql = "select * from lodging l " + 
					"LEFT JOIN lod_option lo " +
					"ON l.idx = lo.lod_idx " + 
					"WHERE l.idx = ?";
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
	public ArrayList<LodgingVO> getLodList(String checkIn, String checkOut, int area, int peopleNum) {
		ArrayList<LodgingVO> lodVos = new ArrayList<LodgingVO>();
		try {
			if(area == 106) {
				sql = "select * from lodging l LEFT JOIN lod_option lo ON l.idx = lo.lod_idx " +
						"where l.idx NOT IN " +
						"(select re.lod_idx from reservation re LEFT JOIN lodging ll ON re.lod_idx = ll.idx where re.stay_date = ? or re.stay_date = ? group by re.lod_idx) " +
						"and l.number_guests >= ? " +
						"order by l.idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, checkIn);
				pstmt.setString(2, checkOut);
				pstmt.setInt(3, peopleNum);
			}
			else {
				sql = "select * from lodging l LEFT JOIN lod_option lo ON l.idx = lo.lod_idx " +
						"where l.idx NOT IN " +
						"(select re.lod_idx from reservation re LEFT JOIN lodging ll ON re.lod_idx = ll.idx where re.stay_date = ? or re.stay_date = ? group by re.lod_idx) " +
						"and l.number_guests >= ? and l.category_code = ? " +
						"order by l.idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, checkIn);
				pstmt.setString(2, checkOut);
				pstmt.setInt(3, peopleNum);
				pstmt.setInt(4, area);
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
}
