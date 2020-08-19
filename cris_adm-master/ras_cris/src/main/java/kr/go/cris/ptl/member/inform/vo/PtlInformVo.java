package kr.go.cris.ptl.member.inform.vo;

import org.apache.ibatis.type.Alias;


@Alias("ptlInformVo")
public class PtlInformVo {
	//private static final long serialVersionUID = 1L;
	
	/** USER ID */
	private String user_id;
	
	/** 약관동의 */
	private String agree;
	
	/** 신착자료 수신여부 */
	private String newDataYn;
	
	/** 신착자료 알림일수 */
	private String newDataCnt;
	
	/** 문자동의 */
	private String smsAgree;
	
	/** 메일동의 */
	private String emailAgree;
	
	/** 이메일 */
	private String email;
	
	/** 정보동의 */
	private String addressAgree;
	
	/** 주소 */
	private String address;
	
	/** 상세주소*/
	private String address2;
	
	/** 우편번호 */
	private String zipcode;
	
	/** 팩스 */
	private String faxNum;
	
	/** PMC동의 */
	private String pmcAgree;
	
	/** ORCID */
	private String orcid;
	
	/** 과학기술인등록번호 */
	private String seNumber;
	
	/** MeSH동의 */
	private String meshAgree;
	
	/** MeSH 이용서비스 */
	private String mesh;
	
	/** 이메일1 */
	private String email1;
	
	/** 이메일2 */
	private String email2;
	
	/** totcnt */
	private int totcnt;
	
	/** PMC */
	private String pmc;
	
	/** PMC업무지원 여부 */
	private String pmcConfirm;
	
	/** Age Agree */
	private String ageAgree;
	
	/** 사용자 등록 ID */
	private String resIdNo;
	
	/** 사용자 이름 */
	private String userName;
	
	/** 접근코드 */
	private String acCode;
	
	/** 소속기관 */
	private String mouOrg;
	
	/** 과(학번) */
	private String mouSub;
	
	/** mou대출여부 */
	private String mouLoan;
	
	/** 성별 */
	private String sex;

	/** 장애인여부 */
	private String disabled;
	
	/** 외국인여부 */
	private String foreign;
	
	/** 직업 */
	private String job;
	
    /** MBTLNUM */
    private String mbtlnum;
    
    /** TELNO */
    private String telno;
    
    /** OGCR */
    private String ogcr;

    /** INSTTTYID */
    private Integer instttyid;    
    
    /** INSTTSN */
    private Integer insttsn;
    
    /** MBTLNUM_YN */
    private String mbtlnumYn;
    
    /** BRTHDY */
    private String brthdy;    
    
    /** ELIBAGREE */
    private String elibagree;    
    
	public String getMouOrg() {
		return mouOrg;
	}

	public void setMouOrg(String mouOrg) {
		this.mouOrg = mouOrg;
	}

	public String getMouSub() {
		return mouSub;
	}

	public void setMouSub(String mouSub) {
		this.mouSub = mouSub;
	}

	public String getMouLoan() {
		return mouLoan;
	}

	public void setMouLoan(String mouLoan) {
		this.mouLoan = mouLoan;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getAgree() {
		return agree;
	}

	public void setAgree(String agree) {
		this.agree = agree;
	}

	public String getNewDataYn() {
		return newDataYn;
	}

	public void setNewDataYn(String newDataYn) {
		this.newDataYn = newDataYn;
	}

	public String getNewDataCnt() {
		return newDataCnt;
	}

	public void setNewDataCnt(String newDataCnt) {
		this.newDataCnt = newDataCnt;
	}

	public String getSmsAgree() {
		return smsAgree;
	}

	public void setSmsAgree(String smsAgree) {
		this.smsAgree = smsAgree;
	}

	public String getEmailAgree() {
		return emailAgree;
	}

	public void setEmailAgree(String emailAgree) {
		this.emailAgree = emailAgree;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddressAgree() {
		return addressAgree;
	}

	public void setAddressAgree(String addressAgree) {
		this.addressAgree = addressAgree;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getFaxNum() {
		return faxNum;
	}

	public void setFaxNum(String faxNum) {
		this.faxNum = faxNum;
	}

	public String getPmcAgree() {
		return pmcAgree;
	}

	public void setPmcAgree(String pmcAgree) {
		this.pmcAgree = pmcAgree;
	}

	public String getOrcid() {
		return orcid;
	}

	public void setOrcid(String orcid) {
		this.orcid = orcid;
	}

	public String getSeNumber() {
		return seNumber;
	}

	public void setSeNumber(String seNumber) {
		this.seNumber = seNumber;
	}

	public String getMeshAgree() {
		return meshAgree;
	}

	public void setMeshAgree(String meshAgree) {
		this.meshAgree = meshAgree;
	}

	public String getMesh() {
		return mesh;
	}

	public void setMesh(String mesh) {
		this.mesh = mesh;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public int getTotcnt() {
		return totcnt;
	}

	public void setTotcnt(int totcnt) {
		this.totcnt = totcnt;
	}

	public String getPmc() {
		return pmc;
	}

	public void setPmc(String pmc) {
		this.pmc = pmc;
	}

	public String getPmcConfirm() {
		return pmcConfirm;
	}

	public void setPmcConfirm(String pmcConfirm) {
		this.pmcConfirm = pmcConfirm;
	}

	public String getAgeAgree() {
		return ageAgree;
	}

	public void setAgeAgree(String ageAgree) {
		this.ageAgree = ageAgree;
	}

	public String getResIdNo() {
		return resIdNo;
	}

	public void setResIdNo(String resIdNo) {
		this.resIdNo = resIdNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAcCode() {
		return acCode;
	}

	public void setAcCode(String acCode) {
		this.acCode = acCode;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getDisabled() {
		return disabled;
	}

	public void setDisabled(String disabled) {
		this.disabled = disabled;
	}

	public String getForeign() {
		return foreign;
	}

	public void setForeign(String foreign) {
		this.foreign = foreign;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
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

	public Integer getInsttsn() {
		return insttsn;
	}

	public void setInsttsn(Integer insttsn) {
		this.insttsn = insttsn;
	}

	public String getMbtlnumYn() {
		return mbtlnumYn;
	}

	public void setMbtlnumYn(String mbtlnumYn) {
		this.mbtlnumYn = mbtlnumYn;
	}

	public String getBrthdy() {
		return brthdy;
	}

	public void setBrthdy(String brthdy) {
		this.brthdy = brthdy;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getElibagree() {
		return elibagree;
	}

	public void setElibagree(String elibagree) {
		this.elibagree = elibagree;
	}
	
	
}
