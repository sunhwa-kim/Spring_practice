package kr.go.cris.ptl.centerintro.noti.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.go.cris.commons.utils.StringUtil;
import kr.go.cris.commons.vo.CommonsVo;



/**
 * <pre>
 * 알림마당 Value Object 구현 
 * 
 * </pre>
 * @FileName : IntroNotiVo.java
 * @package  : kr.go.cris.ptl.centerintro.noti.vo
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
@Alias("introNotiVo")
public class IntroNotiVo extends CommonsVo implements Serializable  {

	/** serialVersionUID */
	private static final long serialVersionUID = -736301903272282856L;

	/** 20Byte 공지사항ID */
	private String alit_id;
	
	/** 공지사항제목 */
	private String alit_sj;
	
	/** 공지사항내용 */
	private String alit_cn;
	
	/** 조회수 */
	private int rdcnt;	
	
	/** 최초등록시점 */
	private String frst_regist_pnttm;
	
	/** 최초등록자ID */
	private String frst_register_id;
	
	/** 최종수정시점 */
	private String last_updt_pnttm;
	
	/** 최종수정자ID */
	private String last_updusr_id;
	
	/** 첨부파일ID */
	private String atch_file_id;
	
	/** 탑공지 */
	private String top_status;
	
	/** 공지타입 */
	private String alit_type;   // 1 : 공지 , 2 : 홍보, 3 : 보도 , 4 : 과학(의생명과학소식1,2,3,4) 
	
	/** 공시사항용 첨부파일 링크 ID */
	private String atch_link_id;
	
	/** 의과학소식 승인여부 2단계 */
	private String status;
	
	/** 공공저작물유형 [1,2,3,4] 2단계 */
	private String open_type_info;
	
	/** 등록일 */
    private String reg_date;
    
    /** 신규 new  */
    private String new_img;
    
    /** totla  */
    private int total_count; 

    /** view  조회수 증가 param  */
    private String upd_yn;

    
	public String getNotiCttsXss() {
		return StringUtil.filterXss(this.alit_cn);
	}


	public String getAlit_id() {
		return alit_id;
	}


	public void setAlit_id(String alit_id) {
		this.alit_id = alit_id;
	}


	public String getAlit_sj() {
		return alit_sj;
	}


	public void setAlit_sj(String alit_sj) {
		this.alit_sj = alit_sj;
	}


	public String getAlit_cn() {
		return alit_cn;
	}


	public void setAlit_cn(String alit_cn) {
		this.alit_cn = alit_cn;
	}


	public int getRdcnt() {
		return rdcnt;
	}


	public void setRdcnt(int rdcnt) {
		this.rdcnt = rdcnt;
	}


	public String getFrst_regist_pnttm() {
		return frst_regist_pnttm;
	}


	public void setFrst_regist_pnttm(String frst_regist_pnttm) {
		this.frst_regist_pnttm = frst_regist_pnttm;
	}


	public String getFrst_register_id() {
		return frst_register_id;
	}


	public void setFrst_register_id(String frst_register_id) {
		this.frst_register_id = frst_register_id;
	}


	public String getLast_updt_pnttm() {
		return last_updt_pnttm;
	}


	public void setLast_updt_pnttm(String last_updt_pnttm) {
		this.last_updt_pnttm = last_updt_pnttm;
	}


	public String getLast_updusr_id() {
		return last_updusr_id;
	}


	public void setLast_updusr_id(String last_updusr_id) {
		this.last_updusr_id = last_updusr_id;
	}


	public String getAtch_file_id() {
		return atch_file_id;
	}


	public void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}


	public String getTop_status() {
		return top_status;
	}


	public void setTop_status(String top_status) {
		this.top_status = top_status;
	}


	public String getAlit_type() {
		return alit_type;
	}


	public void setAlit_type(String alit_type) {
		this.alit_type = alit_type;
	}


	public String getAtch_link_id() {
		return atch_link_id;
	}


	public void setAtch_link_id(String atch_link_id) {
		this.atch_link_id = atch_link_id;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getOpen_type_info() {
		return open_type_info;
	}


	public void setOpen_type_info(String open_type_info) {
		this.open_type_info = open_type_info;
	}
	
	
	public String getReg_date() {
		return reg_date;
	}


	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}




	public String getNew_img() {
		return new_img;
	}


	public void setNew_img(String new_img) {
		this.new_img = new_img;
	}


	public int getTotal_count() {
		return total_count;
	}


	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}
	

	public String getUpd_yn() {
		return upd_yn;
	}


	public void setUpd_yn(String upd_yn) {
		this.upd_yn = upd_yn;
	}

	
}
