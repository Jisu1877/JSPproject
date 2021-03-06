package reservation;

import lodging.LodgingVO;
import member.MemberVO;

public class ReservationVO {
	private int idx;
	private int lod_idx;
	private int mem_idx;
	private String stay_date;
	private String check_in;
	private String check_out;
	private int number_guests;
	private int payment_price;
	private int term;
	private String review;
	private String state;
	private String cancel_yn;
	private String create_date;
	private int point;
	
	private LodgingVO lodVo;
	private MemberVO memVo;
	
	
	public MemberVO getMemVo() {
		return memVo;
	}
	public void setMemVo(MemberVO memVo) {
		this.memVo = memVo;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getLod_idx() {
		return lod_idx;
	}
	public void setLod_idx(int lod_idx) {
		this.lod_idx = lod_idx;
	}
	public int getMem_idx() {
		return mem_idx;
	}
	public void setMem_idx(int mem_idx) {
		this.mem_idx = mem_idx;
	}
	public String getStay_date() {
		return stay_date;
	}
	public void setStay_date(String stay_date) {
		this.stay_date = stay_date;
	}
	public String getCheck_in() {
		return check_in;
	}
	public void setCheck_in(String check_in) {
		this.check_in = check_in;
	}
	public String getCheck_out() {
		return check_out;
	}
	public void setCheck_out(String check_out) {
		this.check_out = check_out;
	}
	public int getNumber_guests() {
		return number_guests;
	}
	public void setNumber_guests(int number_guests) {
		this.number_guests = number_guests;
	}
	public int getPayment_price() {
		return payment_price;
	}
	public void setPayment_price(int payment_price) {
		this.payment_price = payment_price;
	}
	public int getTerm() {
		return term;
	}
	public void setTerm(int term) {
		this.term = term;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCancel_yn() {
		return cancel_yn;
	}
	public void setCancel_yn(String cancel_yn) {
		this.cancel_yn = cancel_yn;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public LodgingVO getLodVo() {
		return lodVo;
	}
	public void setLodVo(LodgingVO lodVo) {
		this.lodVo = lodVo;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	@Override
	public String toString() {
		return "ReservationVO [idx=" + idx + ", lod_idx=" + lod_idx + ", mem_idx=" + mem_idx + ", stay_date="
				+ stay_date + ", check_in=" + check_in + ", check_out=" + check_out + ", number_guests=" + number_guests
				+ ", payment_price=" + payment_price + ", term=" + term + ", review=" + review + ", state=" + state
				+ ", cancel_yn=" + cancel_yn + ", create_date=" + create_date + ", point=" + point + ", lodVo=" + lodVo
				+ ", memVo=" + memVo + "]";
	}
	

	
	
}
