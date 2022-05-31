package admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import lodging.FileVO;
import lodging.LodgingDAO;
import lodging.LodgingVO;
import lodging.OptionVO;

public class LodUpdateOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/lodging");  
		int maxSize = 1024 * 1024 * 20; //최대용량을 20MByte로 사용하고자 한다.
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		Enumeration<?> fileNames =  multipartRequest.getFileNames();
		
		//필수 입력 값 가져오기
		int category_code = multipartRequest.getParameter("category_code") == null? 2 : Integer.parseInt(multipartRequest.getParameter("category_code"));
		int sub_category_code = multipartRequest.getParameter("sub_category_code") == null? 2 : Integer.parseInt(multipartRequest.getParameter("sub_category_code"));
		int detail_category_code = multipartRequest.getParameter("detail_category_code") == null? 2 : Integer.parseInt(multipartRequest.getParameter("detail_category_code"));
		String lod_name = multipartRequest.getParameter("lod_name") == null? "" : multipartRequest.getParameter("lod_name");
		int price = multipartRequest.getParameter("price") == null? 2 : Integer.parseInt(multipartRequest.getParameter("price"));
		String country = multipartRequest.getParameter("country") == null? "" : multipartRequest.getParameter("country");
		String address = multipartRequest.getParameter("address") == null? "" : multipartRequest.getParameter("address");
		String explanation = multipartRequest.getParameter("explanation") == null? "" : multipartRequest.getParameter("explanation");
		int number_guests = multipartRequest.getParameter("number_guests") == null? 2 : Integer.parseInt(multipartRequest.getParameter("number_guests"));
		
		int lodIdx = multipartRequest.getParameter("lodIdx") == null? 2 : Integer.parseInt(multipartRequest.getParameter("lodIdx"));
		int pag = multipartRequest.getParameter("pag") == null? 2 : Integer.parseInt(multipartRequest.getParameter("pag"));
		int pageSize = multipartRequest.getParameter("pageSize") == null? 2 : Integer.parseInt(multipartRequest.getParameter("pageSize"));
		//썸네일 사진을 새로 등록헀으면 'yes'
		String flag = multipartRequest.getParameter("flag") == null? "" : multipartRequest.getParameter("flag");
		//기존 썸네일 사진 이름
		String thumbFile_save_file_name = multipartRequest.getParameter("thumbFile_save_file_name") == null? "" : multipartRequest.getParameter("thumbFile_save_file_name");

		LodgingVO lodVO = new LodgingVO();
		AdminDAO dao = new AdminDAO();
		
		System.out.println(thumbFile_save_file_name);
		
		if(flag.equals("yes")) {
			//썸네일 사진 파일명만 따로 알아오기
			String thumbFileName = multipartRequest.getOriginalFileName("thumbFile")  == null ? "": multipartRequest.getOriginalFileName("thumbFile"); //form태그의 name 
			String saveThumbFileName = multipartRequest.getFilesystemName("thumbFile") == null ? "": multipartRequest.getFilesystemName("thumbFile");
			lodVO.setFile_name(thumbFileName);
			lodVO.setSave_file_name(saveThumbFileName);
			
			//기존 썸네일 삭제
			dao.thumbfileDelete(lodIdx);
			
			// 썸네일 등록
			dao.setFileName(thumbFileName, saveThumbFileName, lodIdx, 1);
		}
		
		//vo에 필수입력값 모두 set 하기
		lodVO.setIdx(lodIdx);
		lodVO.setCategory_code(category_code);
		lodVO.setSub_category_code(sub_category_code);
		lodVO.setDetail_category_code(detail_category_code);
		lodVO.setLod_name(lod_name);
		lodVO.setPrice(price);
		lodVO.setCountry(country);
		lodVO.setAddress(address);
		lodVO.setExplanation(explanation);
		lodVO.setNumber_guests(number_guests);
		
		//필수입력사항 DB에 업데이트
		int lodRes = dao.setLodUpdate(lodVO, flag);
		
//		lodVO = dao.getlodInfor(lod_name);
//		int lodIdx = lodVO.getIdx();
		
		// 첨부파일 리스트에 차곡차곡 넣기
		ArrayList<FileVO> fileList = new ArrayList<FileVO>(5);
		while(fileNames.hasMoreElements()) {
			String name = (String) fileNames.nextElement();
			if (name != null && !name.equals("") && !name.equals("thumbFile")) {
				FileVO vo = new FileVO();
				String originalFileName = multipartRequest.getOriginalFileName(name);
				String filesystemName = multipartRequest.getFilesystemName(name);
				
				if ((originalFileName != null && !originalFileName.equals("")) &&
					(filesystemName != null && !filesystemName.equals(""))) {
					vo.setFile_name(originalFileName);
					vo.setSave_file_name(filesystemName);
					fileList.add(vo);
				}
			}
		}
		
		// 첨부파일 정보 DB에 저장
		for(int i=0; i<fileList.size(); i++) {
			FileVO file = fileList.get(i);
			if (file != null) {
				dao.setFileName(file.getFile_name(), file.getSave_file_name(), lodIdx, i+2);
			}
		}
				
		//옵션입력내용 값 모두 받아오기
		String air_conditioner = multipartRequest.getParameter("air_conditioner") == null? "" : multipartRequest.getParameter("air_conditioner");
		String tv = multipartRequest.getParameter("tv") == null? "" : multipartRequest.getParameter("tv");
		String wifi = multipartRequest.getParameter("wifi") == null? "" : multipartRequest.getParameter("wifi");
		String washer = multipartRequest.getParameter("washer") == null? "" : multipartRequest.getParameter("washer");
		String kitchen = multipartRequest.getParameter("kitchen") == null? "" : multipartRequest.getParameter("kitchen");
		String heating = multipartRequest.getParameter("heating") == null? "" : multipartRequest.getParameter("heating");
		String toiletries = multipartRequest.getParameter("toiletries") == null? "" : multipartRequest.getParameter("toiletries");
		int bedroom = multipartRequest.getParameter("bedroom") == null? 0 : Integer.parseInt(multipartRequest.getParameter("bedroom"));
		int bed = multipartRequest.getParameter("bed") == null? 0 : Integer.parseInt(multipartRequest.getParameter("bed"));
		int bathroom = multipartRequest.getParameter("bathroom") == null? 0 : Integer.parseInt(multipartRequest.getParameter("bathroom"));
		
		//옵션 DB에 모두 저장
		OptionVO optionVo = new OptionVO();
		
		optionVo.setLod_idx(lodIdx);
		optionVo.setAir_conditioner(air_conditioner);
		optionVo.setTv(tv);
		optionVo.setWifi(wifi);
		optionVo.setWasher(washer);
		optionVo.setKitchen(kitchen);
		optionVo.setHeating(heating);
		optionVo.setToiletries(toiletries);
		optionVo.setBedroom(bedroom);
		optionVo.setBed(bed);
		optionVo.setBathroom(bathroom);
		
		int optRes = dao.udateOptionInfor(optionVo);
		
		if(lodRes == 1 && optRes == 1) {
			request.setAttribute("msg", "lodUpdateOk");
		}
		else {
			request.setAttribute("msg", "lodUpdateNo");
		}
		request.setAttribute("url", request.getContextPath()+"/lodInfor.ad?lodIdx="+lodIdx+"&pag="+pag+"&pageSize="+pageSize);
		
	}

}
