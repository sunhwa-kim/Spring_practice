package kr.go.cris.ptl.data.vo;

import java.io.Serializable;

import kr.go.cris.commons.vo.CommonsVo;

import org.apache.ibatis.type.Alias;


/**
 * <pre>
 * FileName: MngCodeVo.java
 * Package : kr.go.cris.ptl.mng.code.vo
 * 
 * 코드관리 vo
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 1. 19.
 */

@Alias("dataCenterVo")
public class DataCenterVo extends CommonsVo implements Serializable  {

	/** serialVersionUID */
	private static final long serialVersionUID = -868765154594486307L;

	
	/** 데이터센터 구분코드 */
	private String data_center_gbn;
	/** 데이터센터 구분코드명 */
	private String data_center_gbnm;
	/** 데이터센터 ID */
	private String data_center_id;
	/** 데이터센터 제목 */
	private String data_center_sj;
	/** 데이터센터 내용 */
	private String data_center_cn;
	/** 조회수 */
	private int rdcnt;
	/** 최초등록자ID */
	private String frst_register_id;
	/** 최초등록시점 */
	private String frst_regist_pnttm;
	/** 최종수정자ID */
	private String last_updusr_id;
	/** 최종수정시점 */
	private String last_updt_pnttm;
	/** 첨부파일ID */
	private String atch_file_id;
	/** 정보제공처ID */
	private String data_info;
	/** 삭제여부 */
	private String del_yn;
	/** 첨부파일 링크 ID */
	private String atch_link_id;
	
	private String order_sn;
	
	
	
	public String getData_center_gbnm() {
		return data_center_gbnm;
	}
	public void setData_center_gbnm(String data_center_gbnm) {
		this.data_center_gbnm = data_center_gbnm;
	}
	
	public String getOrder_sn() {
		return order_sn;
	}
	public void setOrder_sn(String order_sn) {
		this.order_sn = order_sn;
	}
	public String getData_center_gbn() {
		return data_center_gbn;
	}
	public void setData_center_gbn(String data_center_gbn) {
		this.data_center_gbn = data_center_gbn;
	}
	public String getData_center_id() {
		return data_center_id;
	}
	public void setData_center_id(String data_center_id) {
		this.data_center_id = data_center_id;
	}
	public String getData_center_sj() {
		return data_center_sj;
	}
	public void setData_center_sj(String data_center_sj) {
		this.data_center_sj = data_center_sj;
	}
	public String getData_center_cn() {
		return data_center_cn;
	}
	public void setData_center_cn(String data_center_cn) {
		this.data_center_cn = data_center_cn;
	}
	public int getRdcnt() {
		return rdcnt;
	}
	public void setRdcnt(int rdcnt) {
		this.rdcnt = rdcnt;
	}
	public String getFrst_register_id() {
		return frst_register_id;
	}
	public void setFrst_register_id(String frst_register_id) {
		this.frst_register_id = frst_register_id;
	}
	public String getFrst_regist_pnttm() {
		return frst_regist_pnttm;
	}
	public void setFrst_regist_pnttm(String frst_regist_pnttm) {
		this.frst_regist_pnttm = frst_regist_pnttm;
	}
	public String getLast_updusr_id() {
		return last_updusr_id;
	}
	public void setLast_updusr_id(String last_updusr_id) {
		this.last_updusr_id = last_updusr_id;
	}
	public String getLast_updt_pnttm() {
		return last_updt_pnttm;
	}
	public void setLast_updt_pnttm(String last_updt_pnttm) {
		this.last_updt_pnttm = last_updt_pnttm;
	}
	public String getAtch_file_id() {
		return atch_file_id;
	}
	public void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}
	public String getData_info() {
		return data_info;
	}
	public void setData_info(String data_info) {
		this.data_info = data_info;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getAtch_link_id() {
		return atch_link_id;
	}
	public void setAtch_link_id(String atch_link_id) {
		this.atch_link_id = atch_link_id;
	}

	
	
	
}
