package net.issue.db;

public class IssueBean {
	
	private int    i_seq;
	private int    p_num;    //프로젝트 번호
	private String i_name;   //글 작성자
	private String i_title;   //글 제목
	private String i_content;//글 내용
	private String i_status;//이슈의 진행 상태
	private String i_file;   //첨부될 파일의 이름
	private String i_created;
	private String i_modified;
	private String i_reporter;
	private String i_assign;
	private String i_related;
	private int    i_readcount;//글의 조회수
	
	public String getI_related() {
		return i_related;
	}
	public void setI_related(String i_related) {
		this.i_related = i_related;
	}
	
	public int getI_seq() {
		return i_seq;
	}
	public void setI_seq(int i_seq) {
		this.i_seq = i_seq;
	}
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public String getI_name() {
		return i_name;
	}
	public void setI_name(String i_name) {
		this.i_name = i_name;
	}
	public String getI_title() {
		return i_title;
	}
	public void setI_title(String i_title) {
		this.i_title = i_title;
	}
	public String getI_content() {
		return i_content;
	}
	public void setI_content(String i_content) {
		this.i_content = i_content;
	}
	public String getI_status() {
		return i_status;
	}
	public void setI_status(String i_status) {
		this.i_status = i_status;
	}
	public String getI_file() {
		return i_file;
	}
	public void setI_file(String i_file) {
		this.i_file = i_file;
	}
	public String getI_created() {
		return i_created.substring(0, 10);
	}
	public void setI_created(String i_created) {
		this.i_created = i_created;
	}
	public String getI_modified() {
		return i_modified;
	}
	public void setI_modified(String i_modified) {
		this.i_modified = i_modified;
	}
	public String getI_reporter() {
		return i_reporter;
	}
	public void setI_reporter(String i_reporter) {
		this.i_reporter = i_reporter;
	}
	public String getI_assign() {
		return i_assign;
	}
	public void setI_assign(String i_assign) {
		this.i_assign = i_assign;
	}
	public int getI_readcount() {
		return i_readcount;
	}
	public void setI_readcount(int i_readcount) {
		this.i_readcount = i_readcount;
	}
	
	
	
	
}
