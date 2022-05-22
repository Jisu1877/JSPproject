package lodging;

public class OptionVO {
	private int opt_idx;
	private int lod_idx;
	private String air_conditioner;
	private String tv;
	private String wifi;
	private String washer;
	private String kitchen;
	private String heating;
	private String toiletries;
	private int bedroom;
	private int bed;
	private int bathroom;
	
	public int getOpt_idx() {
		return opt_idx;
	}
	public void setOpt_idx(int opt_idx) {
		this.opt_idx = opt_idx;
	}
	public int getLod_idx() {
		return lod_idx;
	}
	public void setLod_idx(int lod_idx) {
		this.lod_idx = lod_idx;
	}
	public String getAir_conditioner() {
		return air_conditioner;
	}
	public void setAir_conditioner(String air_conditioner) {
		this.air_conditioner = air_conditioner;
	}
	public String getTv() {
		return tv;
	}
	public void setTv(String tv) {
		this.tv = tv;
	}
	public String getWifi() {
		return wifi;
	}
	public void setWifi(String wifi) {
		this.wifi = wifi;
	}
	public String getWasher() {
		return washer;
	}
	public void setWasher(String washer) {
		this.washer = washer;
	}
	public String getKitchen() {
		return kitchen;
	}
	public void setKitchen(String kitchen) {
		this.kitchen = kitchen;
	}
	public String getHeating() {
		return heating;
	}
	public void setHeating(String heating) {
		this.heating = heating;
	}
	public String getToiletries() {
		return toiletries;
	}
	public void setToiletries(String toiletries) {
		this.toiletries = toiletries;
	}
	public int getBedroom() {
		return bedroom;
	}
	public void setBedroom(int bedroom) {
		this.bedroom = bedroom;
	}
	public int getBed() {
		return bed;
	}
	public void setBed(int bed) {
		this.bed = bed;
	}
	public int getBathroom() {
		return bathroom;
	}
	public void setBathroom(int bathroom) {
		this.bathroom = bathroom;
	}
	@Override
	public String toString() {
		return "OptionVO [opt_idx=" + opt_idx + ", lod_idx=" + lod_idx + ", air_conditioner=" + air_conditioner
				+ ", tv=" + tv + ", wifi=" + wifi + ", washer=" + washer + ", kitchen=" + kitchen + ", heating="
				+ heating + ", toiletries=" + toiletries + ", bedroom=" + bedroom + ", bed=" + bed + ", bathroom="
				+ bathroom + "]";
	}
	
	
	
	
}
