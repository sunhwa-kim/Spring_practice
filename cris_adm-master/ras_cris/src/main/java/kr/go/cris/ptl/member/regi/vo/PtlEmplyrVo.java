package kr.go.cris.ptl.member.regi.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.go.cris.commons.utils.StringUtil;
import kr.go.cris.commons.vo.CommonsVo;



@Alias("ptlEmplyrVo")
public class PtlEmplyrVo extends CommonsVo implements Serializable  {


	private static final long serialVersionUID = -2973577475097405362L;

	/** 사용자KEY */
	private String emplyrkey;
	
	/** 로그인ID */
	private String user_id;
	
	/** 이름 */
	private String emplyrnm;
	
	/** 비밀번호 */
	private String password;
	
	/** 휴대폰번호 */
	private String mbtlnum;
	
	/** 전화번호 */
	private String telno;
	
	/** 공인인증서여부 */
	private String ogcr;
	
	/** 기관id */
	private Integer instttyid;
	
	/** 기관일련번호 */
	private int insttsn;
	
	/** 핸드폰 인증 유무 */
	private String mbtlnum_yn;
	
	/** SHA2암호화여부 */
	private String sha2;
	
	/** 생년월일 */
	private String brthdy;
	
	/** 회원분류(00.SNS,01.일반회원,02.대출회원,03.직원) */
	private String classify;
	
	/** 탈퇴처리자KEY */
	private String secsnopetrkey;
	
	/** 탈퇴일시 */
	private String secsntredt;
	
	/** 탈퇴여부 */
	private String secsnat;
	
	/** 최종로그인일시 */
	private String lastlogindt;
	
	/** 최종로그아웃일시 */
	private String lastlogoutdt;
	
	/** 최종수정일시 */
	private String lastupddt;
	
	/** 최종수정자KEY */
	private String lastupdusrkey;
	
	/** 등록일 */
	private String reg_date;

	public String getEmplyrkey() {
		return emplyrkey;
	}

	public void setEmplyrkey(String emplyrkey) {
		this.emplyrkey = emplyrkey;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getEmplyrnm() {
		return emplyrnm;
	}

	public void setEmplyrnm(String emplyrnm) {
		this.emplyrnm = emplyrnm;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMbtlnum() {
		return mbtlnum;
	}

	public void setMbtlnum(String mbtlnum) {
		this.mbtlnum = mbtlnum;
	}

	public String getTelno() {
		return telno;
	}

	public void setTelno(String telno) {
		this.telno = telno;
	}

	public String getOgcr() {
		return ogcr;
	}

	public void setOgcr(String ogcr) {
		this.ogcr = ogcr;
	}	
	
	public Integer getInstttyid() {
		return instttyid;
	}

	public void setInstttyid(Integer instttyid) {
		this.instttyid = instttyid;
	}

	public int getInsttsn() {
		return insttsn;
	}

	public void setInsttsn(int insttsn) {
		this.insttsn = insttsn;
	}

	public String getMbtlnum_yn() {
		return mbtlnum_yn;
	}

	public void setMbtlnum_yn(String mbtlnum_yn) {
		this.mbtlnum_yn = mbtlnum_yn;
	}

	public String getSha2() {
		return sha2;
	}

	public void setSha2(String sha2) {
		this.sha2 = sha2;
	}

	public String getBrthdy() {
		return brthdy;
	}

	public void setBrthdy(String brthdy) {
		this.brthdy = brthdy;
	}

	public String getClassify() {
		return classify;
	}

	public void setClassify(String classify) {
		this.classify = classify;
	}

	public String getSecsnopetrkey() {
		return secsnopetrkey;
	}

	public void setSecsnopetrkey(String secsnopetrkey) {
		this.secsnopetrkey = secsnopetrkey;
	}

	public String getSecsntredt() {
		return secsntredt;
	}

	public void setSecsntredt(String secsntredt) {
		this.secsntredt = secsntredt;
	}

	public String getSecsnat() {
		return secsnat;
	}

	public void setSecsnat(String secsnat) {
		this.secsnat = secsnat;
	}

	public String getLastlogindt() {
		return lastlogindt;
	}

	public void setLastlogindt(String lastlogindt) {
		this.lastlogindt = lastlogindt;
	}

	public String getLastlogoutdt() {
		return lastlogoutdt;
	}

	public void setLastlogoutdt(String lastlogoutdt) {
		this.lastlogoutdt = lastlogoutdt;
	}

	public String getLastupddt() {
		return lastupddt;
	}

	public void setLastupddt(String lastupddt) {
		this.lastupddt = lastupddt;
	}

	public String getLastupdusrkey() {
		return lastupdusrkey;
	}

	public void setLastupdusrkey(String lastupdusrkey) {
		this.lastupdusrkey = lastupdusrkey;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	
	
}
