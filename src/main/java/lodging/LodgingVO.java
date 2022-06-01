package lodging;

import member.MemberVO;

public class LodgingVO {
	private int idx;
	private String file_name;
	private String save_file_name;
	private int category_code;
	private int sub_category_code;
	private int detail_category_code;
	private String lod_name;
	private int price;
	private String country;
	private String address;
	private String explanation;
	private int number_guests;
	private String create_date;
	private String del_yn;
	private OptionVO option;
	private MemberVO member;
	private int cnt;
	private double rating;
	
	
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getSave_file_name() {
		return save_file_name;
	}
	public void setSave_file_name(String save_file_name) {
		this.save_file_name = save_file_name;
	}
	public int getCategory_code() {
		return category_code;
	}
	public void setCategory_code(int category_code) {
		this.category_code = category_code;
	}
	public int getSub_category_code() {
		return sub_category_code;
	}
	public void setSub_category_code(int sub_category_code) {
		this.sub_category_code = sub_category_code;
	}
	public int getDetail_category_code() {
		return detail_category_code;
	}
	public void setDetail_category_code(int detail_category_code) {
		this.detail_category_code = detail_category_code;
	}
	public String getLod_name() {
		return lod_name;
	}
	public void setLod_name(String lod_name) {
		this.lod_name = lod_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public int getNumber_guests() {
		return number_guests;
	}
	public void setNumber_guests(int number_guests) {
		this.number_guests = number_guests;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public OptionVO getOption() {
		return option;
	}
	public void setOption(OptionVO option) {
		this.option = option;
	}
	@Override
	public String toString() {
		return "LodgingVO [idx=" + idx + ", file_name=" + file_name + ", save_file_name=" + save_file_name
				+ ", category_code=" + category_code + ", sub_category_code=" + sub_category_code
				+ ", detail_category_code=" + detail_category_code + ", lod_name=" + lod_name + ", price=" + price
				+ ", country=" + country + ", address=" + address + ", explanation=" + explanation + ", number_guests="
				+ number_guests + ", create_date=" + create_date + ", del_yn=" + del_yn + ", option=" + option
				+ ", member=" + member + ", cnt=" + cnt + ", rating=" + rating + "]";
	}

}
