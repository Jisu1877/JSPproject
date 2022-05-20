package member;

public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String gender;
	private String tel;
	private String email;
	private String file_name;
	private String save_file_name;
	private String postcode;
	private String roadAddress;
	private String detailAddress;
	private String extraAddress;
	private String create_date;
	private int level;
	private int point;
	private int agreement;
	private String del_yn;
	private String delete_date;
	
	private String strLevel; //회원 등급을 문자로 저장하는 필드
	private int applyDiff; 	//날짜 차이를 저장하는 필드
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getRoadAddress() {
		return roadAddress;
	}
	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getExtraAddress() {
		return extraAddress;
	}
	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getAgreement() {
		return agreement;
	}
	public void setAgreement(int agreement) {
		this.agreement = agreement;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(String delete_date) {
		this.delete_date = delete_date;
	}
	public String getStrLevel() {
		return strLevel;
	}
	public void setStrLevel(String strLevel) {
		this.strLevel = strLevel;
	}
	public int getApplyDiff() {
		return applyDiff;
	}
	public void setApplyDiff(int applyDiff) {
		this.applyDiff = applyDiff;
	}
	@Override
	public String toString() {
		return "MemberVO [idx=" + idx + ", mid=" + mid + ", pwd=" + pwd + ", name=" + name + ", gender=" + gender
				+ ", tel=" + tel + ", email=" + email + ", file_name=" + file_name + ", save_file_name="
				+ save_file_name + ", postcode=" + postcode + ", roadAddress=" + roadAddress + ", detailAddress="
				+ detailAddress + ", extraAddress=" + extraAddress + ", create_date=" + create_date + ", level=" + level
				+ ", point=" + point + ", agreement=" + agreement + ", del_yn=" + del_yn + ", delete_date="
				+ delete_date + ", strLevel=" + strLevel + ", applyDiff=" + applyDiff + "]";
	}
	
}
