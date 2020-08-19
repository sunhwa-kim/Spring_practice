package kr.go.cris.ptl.archive.report.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.go.cris.commons.utils.StringUtil;
import kr.go.cris.commons.vo.CommonsVo;



@Alias("archiveAnnualInfoVo")
public class ArchiveAnnualInfoVo extends CommonsVo implements Serializable   {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 2811998568201430666L;

	/** seq*/
	private int annual_seq;
	/** 보고서 id*/
	private String rep_id;
	/** 기간 구분 */
	private String period_gbn;
	/** 기간 */
	private String research_dt;
	/** 비용 */
	private String research_fund;
	
	private String del_yn;	
	/** 최초등록시점 */
	private String frst_regist_pnttm;
	/** 최초등록자ID */
	private String frst_register_id;
	/** 최종수정시점 */
	private String last_updt_pnttm;
	/** 최종수정자ID */
	private String last_updusr_id;
	public int getAnnual_seq() {
		return annual_seq;
	}
	public void setAnnual_seq(int annual_seq) {
		this.annual_seq = annual_seq;
	}
	public String getRep_id() {
		return rep_id;
	}
	public void setRep_id(String rep_id) {
		this.rep_id = rep_id;
	}
	public String getPeriod_gbn() {
		return period_gbn;
	}
	public void setPeriod_gbn(String period_gbn) {
		this.period_gbn = period_gbn;
	}
	public String getResearch_dt() {
		return research_dt;
	}
	public void setResearch_dt(String research_dt) {
		this.research_dt = research_dt;
	}
	public String getResearch_fund() {
		return research_fund;
	}
	public void setResearch_fund(String research_fund) {
		this.research_fund = research_fund;
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

	
	
}
