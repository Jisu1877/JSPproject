package reservation;

public class ReservationVO {
	private int idx;
	private int lod_idx;
	private int mem_idx;
	private String check_in;
	private String check_out;
	private int number_guests;
	private String status_yc;
	private String create_date;
	
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
	public String getStatus_yc() {
		return status_yc;
	}
	public void setStatus_yc(String status_yc) {
		this.status_yc = status_yc;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	@Override
	public String toString() {
		return "ReservationVO [idx=" + idx + ", lod_idx=" + lod_idx + ", mem_idx=" + mem_idx + ", check_in=" + check_in
				+ ", check_out=" + check_out + ", number_guests=" + number_guests + ", status_yc=" + status_yc
				+ ", create_date=" + create_date + "]";
	}
	
}
