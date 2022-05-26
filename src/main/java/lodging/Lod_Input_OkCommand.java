package lodging;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.AdminDAO;
import admin.AdminInterface;

public class Lod_Input_OkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/lodging");  
		int maxSize = 1024 * 1024 * 20; //최대용량을 20MByte로 사용하고자 한다.
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		Enumeration<?> fileNames =  multipartRequest.getFileNames();
		
		String file = "";
		ArrayList<String> originalFileNameList = new ArrayList<String>(10);
		ArrayList<String> filesystemNameList = new ArrayList<String>(10);
		
		//서버에 사진등록
		while(fileNames.hasMoreElements()) {
			file = (String)fileNames.nextElement();
			originalFileNameList.add(multipartRequest.getOriginalFileName(file));
			filesystemNameList.add(multipartRequest.getFilesystemName(file));
		}
		//System.out.println("originalFileName : " + originalFileName);
		//System.out.println("filesystemName : " + filesystemName);
		
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
		
		//썸네일 사진 파일명만 따로 알아오기
		String file_sumName = multipartRequest.getOriginalFileName("fName1")  == null ? "": multipartRequest.getOriginalFileName("fName1"); //form태그의 name 
		String save_file_sumName = multipartRequest.getFilesystemName("fName1") == null ? "": multipartRequest.getFilesystemName("fName1");; 
		
		//vo에 필수입력값 모두 set 하기
		LodgingVO lodVO = new LodgingVO();
		lodVO.setFile_name(file_sumName);
		lodVO.setSave_file_name(save_file_sumName);
		lodVO.setCategory_code(category_code);
		lodVO.setSub_category_code(sub_category_code);
		lodVO.setDetail_category_code(detail_category_code);
		lodVO.setLod_name(lod_name);
		lodVO.setPrice(price);
		lodVO.setCountry(country);
		lodVO.setAddress(address);
		lodVO.setExplanation(explanation);
		lodVO.setNumber_guests(number_guests);
		
		//System.out.println("lodVO : " + lodVO);
		
		//필수입력사항 DB에 넣기
		AdminDAO dao = new AdminDAO();
		
		int lodRes = dao.setLodInput(lodVO);
		
		lodVO = dao.getlodInfor(lod_name);
		int lodIdx = lodVO.getIdx();
		
		//file 정렬하기
		String[] fileArray = new String[originalFileNameList.size()];
		for(int i=0; i<originalFileNameList.size(); i++) {
			fileArray[i] = multipartRequest.getOriginalFileName("fName"+(i+1))  == null ? "": multipartRequest.getOriginalFileName("fName"+(i+1));
		}
		
		//추가사진내용(썸네일 사진까지 포함해서) file DB에 저장하기
		int[] fileResults = new int[originalFileNameList.size()];
		for(int i=0; i<originalFileNameList.size(); i++) {
			if(originalFileNameList.get(i) != null && !originalFileNameList.get(i).equals("")) {
				int file_order = 0;
				boolean sw = true;
				int j = 0;
				int temp = 1;
				while(sw) {
					if(originalFileNameList.get(j) != null) {
						if(originalFileNameList.get(j).equals(fileArray[i])) {
							file_order = temp;
							sw = false;
						}
						j++;
						temp++;
					}
				}
				fileResults[i] = dao.setFileName(originalFileNameList.get(i), filesystemNameList.get(i), lodIdx, file_order);
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
		
		int optRes = dao.setOptionInfor(optionVo);
		
		if(lodRes == 1 && optRes == 1) {
			request.setAttribute("msg", "lodInputOk");
			request.setAttribute("url", request.getContextPath()+"/lod_management.ad");
		}
		else {
			request.setAttribute("msg", "lodInputNo");
			request.setAttribute("url", request.getContextPath()+"/lod_input.ad");
		}
		
	}

}
