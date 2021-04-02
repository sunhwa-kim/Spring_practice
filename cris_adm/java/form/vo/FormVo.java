package kr.go.cris.ptl.mng.form.vo;

import java.io.Serializable;

import kr.go.cris.commons.vo.CommonsVo;


public class FormVo extends CommonsVo implements Serializable
{

	private static final long serialVersionUID = -409416561327600343L;

	String elmnt_id;  
	String elmnt_nm;  
	String data_type; 
	String cd;        
	String lbl_kor;   
	String lbl_eng;
	
	public String getElmnt_id() {
		return elmnt_id;
	}
	public void setElmnt_id(String elmnt_id) {
		this.elmnt_id = elmnt_id;
	}
	public String getElmnt_nm() {
		return elmnt_nm;
	}
	public void setElmnt_nm(String elmnt_nm) {
		this.elmnt_nm = elmnt_nm;
	}
	public String getData_type() {
		return data_type;
	}
	public void setData_type(String data_type) {
		this.data_type = data_type;
	}
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getLbl_kor() {
		return lbl_kor;
	}
	public void setLbl_kor(String lbl_kor) {
		this.lbl_kor = lbl_kor;
	}
	public String getLbl_eng() {
		return lbl_eng;
	}
	public void setLbl_eng(String lbl_eng) {
		this.lbl_eng = lbl_eng;
	}  

}
