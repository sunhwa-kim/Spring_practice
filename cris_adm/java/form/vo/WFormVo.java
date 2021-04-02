package kr.go.cris.ptl.mng.form.vo;

import java.io.Serializable;

import kr.go.cris.commons.vo.CommonsVo;


public class WFormVo extends CommonsVo implements Serializable
{

	private static final long serialVersionUID = -409416561327600343L;

	String frm_id;  
	String frm_gbn;  
	String frm_etc; 
	String frm_seq; 
	String frm_elmnt_id; 
	String frm_ord; 
	String use_yn;
	
//	subWrkFrm 
	String frm_col;
	String lst_yn;
	String srch_yn;
	String lbl_kor;
	String lbl_eng;
	String elmnt_nm;
	String data_type;
	String cd;
	String elmnt_id;
//		page
	String totalListCnt;
	String last_brd;
	
	
	public String getLast_brd() {
		return last_brd;
	}
	public void setLast_brd(String last_brd) {
		this.last_brd = last_brd;
	}

	public String getTotalListCnt() {
		return totalListCnt;
	}
	public void setTotalListCnt(String totalListCnt) {
		this.totalListCnt = totalListCnt;
	}
	
public String getElmnt_id() {
		return elmnt_id;
	}
	public void setElmnt_id(String elmnt_id) {
		this.elmnt_id = elmnt_id;
	}
public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
public String getData_type() {
		return data_type;
	}
	public void setData_type(String data_type) {
		this.data_type = data_type;
	}
public String getElmnt_nm() {
		return elmnt_nm;
	}
	public void setElmnt_nm(String elmnt_nm) {
		this.elmnt_nm = elmnt_nm;
	}
public String getLbl_eng() {
		return lbl_eng;
	}
	public void setLbl_eng(String lbl_eng) {
		this.lbl_eng = lbl_eng;
	}

	public String getLbl_kor() {
		return lbl_kor;
	}
	public void setLbl_kor(String lbl_kor) {
		this.lbl_kor = lbl_kor;
	}
	public String getFrm_id() {
		return frm_id;
	}
	public void setFrm_id(String frm_id) {
		this.frm_id = frm_id;
	}
	public String getFrm_gbn() {
		return frm_gbn;
	}
	public void setFrm_gbn(String frm_gbn) {
		this.frm_gbn = frm_gbn;
	}
	public String getFrm_etc() {
		return frm_etc;
	}
	public void setFrm_etc(String frm_etc) {
		this.frm_etc = frm_etc;
	}
	public String getFrm_seq() {
		return frm_seq;
	}
	public void setFrm_seq(String frm_seq) {
		this.frm_seq = frm_seq;
	}
	public String getFrm_elmnt_id() {
		return frm_elmnt_id;
	}
	public void setFrm_elmnt_id(String frm_elmnt_id) {
		this.frm_elmnt_id = frm_elmnt_id;
	}
	public String getFrm_ord() {
		return frm_ord;
	}
	public void setFrm_ord(String frm_ord) {
		this.frm_ord = frm_ord;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}        
	
	
//	 subWrkFrm
	public String getFrm_col() {
		return frm_col;
	}
	public void setFrm_col(String frm_col) {
		this.frm_col = frm_col;
	}
	
	public String getLst_yn() {
		return lst_yn;
	}
	public void setLst_yn(String lst_yn) {
		this.lst_yn = lst_yn;
	}
	public String getSrch_yn() {
		return srch_yn;
	}
	public void setSrch_yn(String srch_yn) {
		this.srch_yn = srch_yn;
	}
	//ALT + SHIFT +S
}
