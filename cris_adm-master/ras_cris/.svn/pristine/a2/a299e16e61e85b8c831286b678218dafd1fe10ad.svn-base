package kr.go.cris.ptl.archive.intro.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.go.cris.commons.utils.StringUtil;
import kr.go.cris.commons.vo.CommonsVo;



/**
 * <pre>
 * 아카이브 소개 Value Object 구현
 * 
 * </pre>
 * @FileName : ArchiveIntroVo.java
 * @package  : kr.go.cris.ptl.archive.intro.vo
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
@Alias("archiveIntroVo")
public class ArchiveIntroVo extends CommonsVo implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 3378897412201223489L;

	/** 보고서ID */
	private String rep_id;
	
	/** 논문ID */
	private String rnd_id;

	
	/** 발행년도(보고서 , 성과논문) 차트구성 */
	private String pubyear;
	private String pubyear_cnt;
	
	/** 주제분류 */
	private String subject;  //명
	private String subject_cd;  //코드
	private String subrow; // 선택된 row
	private String subject_cnt; // 그룹 cnt
	
	/** 다운로드수 */
	private int downcnt;
	
	
	/** 최초등록시점 */
	private String frst_regist_pnttm;
	
	/** 최초등록자ID */
	private String frst_register_id;
	
	/** 최종수정시점 */
	private String last_updt_pnttm;
	
	/** 최종수정자ID */
	private String last_updusr_id;
	
	
	/********* 최근 등록 자료(보고서, 논문성과, 회색문헌) STR ********/
	
	/** 아카이브 ID  */
	private String archive_id;  
   
	/** 아카이브 제목 */
	private String archive_sj;  
	
	/** 아카이브 구분  */
	private String archive_gbn;     // 1 : 보고서 , 2 : 논문성과 , 3: 회색문헌
	
	/********* 최근 등록 자료(보고서, 논문성과, 회색문헌) END ********/
	
	
  /** 공개/비공개 사용자 처리*/
    private String conParam;
    
    
    public String getRep_id() {
		return rep_id;
	}


	public void setRep_id(String rep_id) {
		this.rep_id = rep_id;
	}
		

	public String getRnd_id() {
		return rnd_id;
	}


	public void setRnd_id(String rnd_id) {
		this.rnd_id = rnd_id;
	}
	
	


	public String getPubyear() {
		return pubyear;
	}


	public void setPubyear(String pubyear) {
		this.pubyear = pubyear;
	}


	public String getPubyear_cnt() {
		return pubyear_cnt;
	}


	public void setPubyear_cnt(String pubyear_cnt) {
		this.pubyear_cnt = pubyear_cnt;
	}

	

	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}

	
	public String getSubject_cd() {
		return subject_cd;
	}


	public void setSubject_cd(String subject_cd) {
		this.subject_cd = subject_cd;
	}


	public String getSubrow() {
		return subrow;
	}


	public void setSubrow(String subrow) {
		this.subrow = subrow;
	}


	public String getSubject_cnt() {
		return subject_cnt;
	}


	public void setSubject_cnt(String subject_cnt) {
		this.subject_cnt = subject_cnt;
	}


	public int getDowncnt() {
		return downcnt;
	}


	public void setDowncnt(int downcnt) {
		this.downcnt = downcnt;
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


	public String getArchive_id() {
		return archive_id;
	}


	public void setArchive_id(String archive_id) {
		this.archive_id = archive_id;
	}


	public String getArchive_sj() {
		return archive_sj;
	}


	public void setArchive_sj(String archive_sj) {
		this.archive_sj = archive_sj;
	}


	public String getArchive_gbn() {
		return archive_gbn;
	}


	public void setArchive_gbn(String archive_gbn) {
		this.archive_gbn = archive_gbn;
	}


	public String getConParam() {
		return conParam;
	}


	public void setConParam(String conParam) {
		this.conParam = conParam;
	}

	
	
}
