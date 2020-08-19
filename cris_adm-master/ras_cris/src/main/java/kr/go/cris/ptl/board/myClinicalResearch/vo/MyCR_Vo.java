package kr.go.cris.ptl.board.myClinicalResearch.vo;

import java.io.Serializable;
import java.util.Date;

import kr.go.cris.commons.vo.CommonsVo;

import org.apache.ibatis.type.Alias;


@Alias ("myCRvo")
public class MyCR_Vo extends CommonsVo implements Serializable {
	/** serialVersionUID */ //???
	
	private int seq;
	private String seq_group;
	private int status;
	private String version;
	private String system_number;
	private String research_number;
	private String research_title_kr;
	private Date ins_date;
	private Date sub_date;
	private Date app_date;
	private Date upt_date;
	private Date last_date;
	private String workstat;
	private String chargestat;
	private Date workconfdate;
	private Date chargeconfdate;
	private int temp_seq;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getSeq_group() {
		return seq_group;
	}
	public void setSeq_group(String seq_group) {
		this.seq_group = seq_group;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getSystem_number() {
		return system_number;
	}
	public void setSystem_number(String system_number) {
		this.system_number = system_number;
	}
	public String getResearch_number() {
		return research_number;
	}
	public void setResearch_number(String research_number) {
		this.research_number = research_number;
	}
	public String getResearch_title_kr() {
		return research_title_kr;
	}
	public void setResearch_title_kr(String research_title_kr) {
		this.research_title_kr = research_title_kr;
	}
	public Date getIns_date() {
		return ins_date;
	}
	public void setIns_date(Date ins_date) {
		this.ins_date = ins_date;
	}
	public Date getSub_date() {
		return sub_date;
	}
	public void setSub_date(Date sub_date) {
		this.sub_date = sub_date;
	}
	public Date getApp_date() {
		return app_date;
	}
	public void setApp_date(Date app_date) {
		this.app_date = app_date;
	}
	public Date getUpt_date() {
		return upt_date;
	}
	public void setUpt_date(Date upt_date) {
		this.upt_date = upt_date;
	}
	public Date getLast_date() {
		return last_date;
	}
	public void setLast_date(Date last_date) {
		this.last_date = last_date;
	}
	public String getWorkstat() {
		return workstat;
	}
	public void setWorkstat(String workstat) {
		this.workstat = workstat;
	}
	public String getChargestat() {
		return chargestat;
	}
	public void setChargestat(String chargestat) {
		this.chargestat = chargestat;
	}
	public Date getWorkconfdate() {
		return workconfdate;
	}
	public void setWorkconfdate(Date workconfdate) {
		this.workconfdate = workconfdate;
	}
	public Date getChargeconfdate() {
		return chargeconfdate;
	}
	public void setChargeconfdate(Date chargeconfdate) {
		this.chargeconfdate = chargeconfdate;
	}
	public int getTemp_seq() {
		return temp_seq;
	}
	public void setTemp_seq(int temp_seq) {
		this.temp_seq = temp_seq;
	}

	
}
