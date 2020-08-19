package kr.go.cris.ptl.cmmn.mainpopup.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.go.cris.commons.utils.StringUtil;
import kr.go.cris.commons.vo.CommonsVo;


/**
 * <pre>
 *  메인 팝업존 구현
 * 
 * </pre>
 * @FileName : MainPopupVo.java
 * @package  : kr.go.cris.ptl.cmmn.mainpopup.vo
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
@Alias("mainPopupVo")
public class MainPopupVo extends CommonsVo implements Serializable {

	/** serialVersionUID */


	/**
	 * 
	 */
	private static final long serialVersionUID = -1621660261574845803L;

	/** 팝업 순번 */
	private String pop_id;
	
	/** 팝업 제목 */
	private String pop_sj;
	
	/** 팝업 내용 */
	private String pop_cn;
	
	/** 팝업 링크 */
	private String pop_link;
	
	/** 팝업 시작 일자 */
	private String pop_str_dt;
	
	/** 팝업 종료 일자 */
	private String pop_end_dt;
	
	/** 게시 여부 */
	private String post_yn;
	
	/** 첨부파일 ID */
	private String atch_file_id;
	
	/** 삭제 여부 */
	private String del_yn;
	
	/** 생성 일시 */
	private String frst_regist_pnttm;
	
	/** 생성자 ID */
	private String frst_register_id;
	
	/** 수정 일시 */
	private String last_updt_pnttm;
	
	/** 수정자 ID */
	private String last_updusr_id;

	
	/** 첨부 파일 */
	private String file_sn;
	
	private String file_extsn;
	
	private byte[] file_byte;
	
	
	
	public String getPop_id() {
		return pop_id;
	}

	public void setPop_id(String pop_id) {
		this.pop_id = pop_id;
	}

	public String getPop_sj() {
		return pop_sj;
	}

	public void setPop_sj(String pop_sj) {
		this.pop_sj = pop_sj;
	}

	public String getPop_cn() {
		return pop_cn;
	}

	public void setPop_cn(String pop_cn) {
		this.pop_cn = pop_cn;
	}

	public String getPop_link() {
		return pop_link;
	}

	public void setPop_link(String pop_link) {
		this.pop_link = pop_link;
	}

	public String getPop_str_dt() {
		return pop_str_dt;
	}

	public void setPop_str_dt(String pop_str_dt) {
		this.pop_str_dt = pop_str_dt;
	}

	public String getPop_end_dt() {
		return pop_end_dt;
	}

	public void setPop_end_dt(String pop_end_dt) {
		this.pop_end_dt = pop_end_dt;
	}

	public String getPost_yn() {
		return post_yn;
	}

	public void setPost_yn(String post_yn) {
		this.post_yn = post_yn;
	}

	public String getAtch_file_id() {
		return atch_file_id;
	}

	public void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
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

	public String getFile_sn() {
		return file_sn;
	}

	public void setFile_sn(String file_sn) {
		this.file_sn = file_sn;
	}

	public String getFile_extsn() {
		return file_extsn;
	}

	public void setFile_extsn(String file_extsn) {
		this.file_extsn = file_extsn;
	}

	public byte[] getFile_byte() {
		byte[] newFile_byte = new byte[file_byte.length];
	    System.arraycopy(file_byte, 0, newFile_byte, 0, file_byte.length);
		return newFile_byte;	
	}

	public void setFile_byte(byte[] file_byte) {
		byte[] newFile_byte = new byte[file_byte.length];
	    if(newFile_byte.length > 0){
		    System.arraycopy(file_byte, 0, newFile_byte, 0, file_byte.length);
		    this.file_byte = newFile_byte;	
	    }

	}

	
}
