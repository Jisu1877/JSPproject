package lodging;

import member.MemberVO;

public class reviewVO {
	private int idx;
	private int lod_idx;
	private int mem_idx;
	private int rating;
	private String review_subject;
	private String review_contents;
	private String exposure_yn;
	private String create_date;
	
	private LodgingVO lodVo;
	private MemberVO member;
	
	
	public MemberVO getMember() {
		return member;
	}


	public void setMember(MemberVO member) {
		this.member = member;
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


	public int getRating() {
		return rating;
	}


	public void setRating(int rating) {
		this.rating = rating;
	}


	public String getReview_subject() {
		return review_subject;
	}


	public void setReview_subject(String review_subject) {
		this.review_subject = review_subject;
	}


	public String getReview_contents() {
		return review_contents;
	}


	public void setReview_contents(String review_contents) {
		this.review_contents = review_contents;
	}


	public String getExposure_yn() {
		return exposure_yn;
	}


	public void setExposure_yn(String exposure_yn) {
		this.exposure_yn = exposure_yn;
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


	@Override
	public String toString() {
		return "reviewVO [idx=" + idx + ", lod_idx=" + lod_idx + ", mem_idx=" + mem_idx + ", rating=" + rating
				+ ", review_subject=" + review_subject + ", review_contents=" + review_contents + ", exposure_yn="
				+ exposure_yn + ", create_date=" + create_date + ", lodVo=" + lodVo + ", member=" + member + "]";
	}

	
}
