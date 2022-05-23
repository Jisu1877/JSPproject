package lodging;

public class FileVO {
	private int file_idx;
	private int lod_idx;
	private int file_order;
	private String file_name;
	private String save_file_name;
	private String create_date;
	public int getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}
	public int getLod_idx() {
		return lod_idx;
	}
	public void setLod_idx(int lod_idx) {
		this.lod_idx = lod_idx;
	}
	public int getFile_order() {
		return file_order;
	}
	public void setFile_order(int file_order) {
		this.file_order = file_order;
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
		return "FileVO [file_idx=" + file_idx + ", lod_idx=" + lod_idx + ", file_order=" + file_order + ", file_name="
				+ file_name + ", save_file_name=" + save_file_name + ", create_date=" + create_date + "]";
	}
	
	
	
	
}
