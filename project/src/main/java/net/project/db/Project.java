package net.project.db;

public class Project {

	private int p_num;
	private String p_name;
	private String p_status;
	private String p_start;
	private String p_closing;
	private String p_created;
	private String p_file;
	
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_status() {
		return p_status;
	}
	public void setP_status(String p_status) {
		this.p_status = p_status;
	}
	public String getP_start() {
		return p_start;
	}
	public void setP_start(String p_start) {
		this.p_start = p_start.substring(0,10);
	}
	public String getP_closing() {
		return p_closing;
	}
	public void setP_closing(String p_closing) {
		this.p_closing = p_closing.substring(0,10);
	}
	public String getP_created() {
		return p_created;
	}
	public void setP_created(String p_created) {
		this.p_created = p_created.substring(0,10);
	}
	public String getP_file() {
		if(p_file==null) {
			  p_file="img/pj_file.png";
		}else {
			this.p_file = "projectupload/"+p_file;
		}
		
		return p_file;
	}
	public void setP_file(String p_file) {
		this.p_file = p_file;
	}
	
	
}
