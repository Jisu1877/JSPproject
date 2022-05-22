package admin.lodging;

public class FileVO {
	private int idx;
	private int lod_idx;
	private String file_name;
	private String save_file_name;
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
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	@Override
	public String toString() {
		return "FileVO [idx=" + idx + ", lod_idx=" + lod_idx + ", file_name=" + file_name + ", save_file_name="
				+ save_file_name + ", create_date=" + create_date + "]";
	}
	
	
}
