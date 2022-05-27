package reservation;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReserInputCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String checkIn = request.getParameter("checkIn") == null ? "" : request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut") == null ? "" : request.getParameter("checkOut");
		int peopleNum = request.getParameter("peopleNum") == null ? 0 : Integer.parseInt(request.getParameter("peopleNum"));
		int priceCal = request.getParameter("priceCal") == null ? 0 : Integer.parseInt(request.getParameter("priceCal"));
		int dateDays = request.getParameter("dateDays") == null ? 0 : Integer.parseInt(request.getParameter("dateDays"));
		int mem_idx = request.getParameter("mem_idx") == null ? 0 : Integer.parseInt(request.getParameter("mem_idx"));
		int lod_idx = request.getParameter("lod_idx") == null ? 0 : Integer.parseInt(request.getParameter("lod_idx"));
		int point = request.getParameter("point") == null ? 0 : Integer.parseInt(request.getParameter("point"));;
		int usePoint;
		if(request.getParameter("usePoint") == null || request.getParameter("usePoint").equals("")) {
			usePoint = 0;
		}
		else {
			usePoint = Integer.parseInt(request.getParameter("usePoint"));
		}
		
		System.out.println("checkIn : " + checkIn);
		System.out.println("checkOut : " + checkOut);
		System.out.println("peopleNum : " + peopleNum);
		System.out.println("priceCal : " + priceCal);
		System.out.println("dateDays : " + dateDays);
		System.out.println("point : " + point);
		System.out.println("mem_idx : " + mem_idx);
		System.out.println("lod_idx : " + lod_idx);
		System.out.println("usePoint : " + usePoint);
		
		
		//숙박하는 모든 날짜 구해오기 전에, 
		//반환값이 마지막 날은 포함하지 않기에 checkOut 날짜의 다음날을 checkOut에 먼저 넣어주는 작업을 진행.
		
		//다음날짜 구해오는 메소드가 date 타입이라서 checkOut을 Date 타입으로 변환
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date checkOutDate;
		Date checkout = null;
		try {
			checkOutDate = new Date(sdf.parse(checkOut).getTime());
			checkout = getNextDay(checkOutDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		//다음날짜가 되어 날짜형식으로 반환된 값을 다시 문자열로 변환
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String nextDay = dateFormat.format(checkout);
		
		
		//숙박하는 모든 날짜 구해오기(체크아웃 다음 날짜를 넣어주기)
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		LocalDate startDate = LocalDate.parse(checkIn, formatter);
		LocalDate endDate = LocalDate.parse(nextDay, formatter);

		//System.out.println(getDatesBetweenTwoDates(startDate, endDate));
		//System.out.println(getDatesBetweenTwoDates(startDate, endDate).size());
		
		//구해온 모든 값 vo에 담기
		ReservationVO resvo = new ReservationVO();
		resvo.setLod_idx(lod_idx);
		resvo.setMem_idx(mem_idx);
		resvo.setCheck_in(checkIn);
		resvo.setCheck_out(checkOut);
		resvo.setNumber_guests(peopleNum);
		resvo.setPayment_price(priceCal);
		resvo.setTerm(dateDays);
		
		//반복문을 통해 예약된 숙소예약일자만큼 DB에 넣기
		ReservationDAO dao = new ReservationDAO();
		int res = 0;
		int i = 0;
		while(true) {
			//System.out.println("여기1");
			DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
			//System.out.println("dateFormat2 : " + dateFormat2);
			String stay_date2 = getDatesBetweenTwoDates(startDate, endDate).get(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			//System.out.println("stay_date2 : " + stay_date2);
			//String stay_date = dateFormat2.format(getDatesBetweenTwoDates(startDate, endDate).get(i));
			res = dao.setReserInput(resvo,stay_date2);
			if(getDatesBetweenTwoDates(startDate, endDate).size() -1 == i) {
				break;
			}
			i++;
		}
		if(res == 1) {
			request.setAttribute("msg", "reserInputOk");
			request.setAttribute("url", request.getContextPath()+"/"); //일단은 홈으로 보내고 마이페이지 만들면 예약현황으로 보내기
		}
		else {
			request.setAttribute("msg", "reserInputNo");
			request.setAttribute("url", request.getContextPath()+"/lodInfor.lod?lodIdx="+lod_idx);
		}
		
		
	}
	
	public static List<LocalDate> getDatesBetweenTwoDates(LocalDate startDate, LocalDate endDate) {
		return startDate.datesUntil(endDate)
        	.collect(Collectors.toList());
	}
	
	 private java.util.Date getNextDay(java.util.Date today){
		  Calendar cal=Calendar.getInstance();
		  
		  cal.setTime(today);
		  cal.add(Calendar.DATE, 1);
		  return cal.getTime();

	 }
	


}
