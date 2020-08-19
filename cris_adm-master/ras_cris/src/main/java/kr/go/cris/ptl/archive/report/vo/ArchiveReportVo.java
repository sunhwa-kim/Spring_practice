package kr.go.cris.ptl.archive.report.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.go.cris.commons.utils.StringUtil;
import kr.go.cris.commons.vo.CommonsVo;


/**
 * <pre>
 * 아카이브 보고서 VO 
 * 
 * </pre>
 * @FileName : ArchiveReportVo.java
 * @package  : kr.go.cris.ptl.archive.report.vo
 * @author   : wonki0138
 * @date     : 2018. 6. 21.
 * 
 */

@Alias("archiveReportVo")
public class ArchiveReportVo extends CommonsVo  implements Serializable  {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 4915784194039565236L;


	/** 보고서ID */
	private String rep_id;

	/** 발주부서 */
	private String order_dept;


	
	/** 담당자명 */
	private String charger_nm;

	/** 발행연도 */
	private String pubyear;
	/** 연차구분 */
	private String annual_gbn;
	/** 연차 */
	private String annual_num;

	/** 공개 여부 1.공개 : 2.비공개 */
	private String con_type;
	/** 비공개사유 */
	private String private_rs;
	/** 비공개시작일자 */
	private String private_str_dt;
	/** 비공개종료일자 */
	private String private_end_dt;
	/** 연구과제명_한글 */
	private String proj_tit_kor;
	/** 연구과제명_영문 */
	private String proj_tit_eng;
	/** 책임연구원 */
	private String pi;

	/** 참여연구원 */
	private String rp;

	/** 주관연구기관 */
	private String org_name;
	/** 색인단어_한글 */
	private String keyword_kor;
	/** 색인단어_영문 */
	private String keyword_eng;
	/** 보고서 초록 */
	private String rep_abs;
	/** 과제번호 */
	private String busino;
	/** 조회수 */
	private int rdcnt;
	/** 다운로드수 */
	private int downcnt;
	/** 삭제여부 */
	private String del_yn;
	/** 최초등록시점 */
    private String frst_regist_dt;
	/** 최초등록시점 */
	private String frst_regist_pnttm;
	/** 최초등록자ID */
	private String frst_register_id;
	/** 최종수정시점 */
	private String last_updt_pnttm;
	/** 최종수정자ID */
	private String last_updusr_id;
	

	/** 주제분류 코드*/
	private String subject;
	
	/** 주제분류 명 */
	private String subject_nm;
	
	// 연차정보STR
	/** seq*/
	private int annual_seq;
	/** 기간 구분 */
	private String period_gbn;
	/** 기간 */
	private String research_dt;
	/** 비용 */
	private String research_fund;
	// 연차정보END	
	 
	
	/** 엑셀 첨부파일 */
	private String excel_upload;
	
	/** 엑셀 첨부파일 에러 내용 */
	private String excel_upload_err;
	
    /** 검색결과제한 구성을 위한 param  STR*/
    
    /** 검색 데이터 CODE*/
    private String fillter_code;
    
    /** 검색 데이터 NAME*/
    private String fillter_data;
    
    /** 검색 데이터 갯수*/
    private String fillter_cnt;
        
    /** 검색 데이터 구분*/
    private String fillter_gbn;
    
    /** 검색 데이터 더보기(발행연도)*/
    private String fillterYear;
    
    /** 검색 데이터 더보기(발주부서)*/
    private String fillterDept;
    
    /** 검색 데이터 더보기(주제분류)*/
    private String fillterSubject;
           
    /** 검색결과제한 구성을 위한 param  END*/
	
    
    /** 검색결과제한 목록 조회 조건에 사용  STR*/
    
    /** 목록 조회조건(필터-발행년도)*/
    private String fillterYearList;
    
    
    /** 목록 조회조건(필터-부서)*/
    private String fillterDeptList;
    
    /** 목록 조회조건(필터-부서)*/
    private String fillterSubjectList;

    private List<String> fillterYearList_L;
    
    private List<String> fillterDeptList_L;
    
    private List<String> fillterSubjectList_L;
        
    private String fillterYearList_s;
    
    private String fillterDeptList_s;
    
    private String fillterSubjectList_s;
    
    private String fillterYearCnt;
    
    private String fillterDeptCnt;
    
    private String fillterSubjectCnt;
    
    /** 검색결과제한 목록 조회 조건에 사용  END*/
	
    /** 리턴 페이지 구분*/
    private String returnPageGbn;
    
    
    
    /** 엑셀 일괄등록 순번 */
    private String rn;
    
   
    private String error_cn;
    
    
    /** 첨부파일 STR */
    private String atch_file_id;

    private String atch_link_id;
    /** 첨부파일 END */
    
    /** 공개/비공개 사용자 처리*/
    private String conParam;
    
	public String getRep_id() {
		return rep_id;
	}


	public void setRep_id(String rep_id) {
		this.rep_id = rep_id;
	}

	


	public String getOrder_dept() {
		return order_dept;
	}


	public void setOrder_dept(String order_dept) {
		this.order_dept = order_dept;
	}


	public String getCharger_nm() {
		return charger_nm;
	}


	public void setCharger_nm(String charger_nm) {
		this.charger_nm = charger_nm;
	}




	public String getPubyear() {
		return pubyear;
	}


	public void setPubyear(String pubyear) {
		this.pubyear = pubyear;
	}


	public String getAnnual_gbn() {
		return annual_gbn;
	}


	public void setAnnual_gbn(String annual_gbn) {
		this.annual_gbn = annual_gbn;
	}


	public String getAnnual_num() {
		return annual_num;
	}


	public void setAnnual_num(String annual_num) {
		this.annual_num = annual_num;
	}



	public String getCon_type() {
		return con_type;
	}


	public void setCon_type(String con_type) {
		this.con_type = con_type;
	}


	public String getPrivate_rs() {
		return private_rs;
	}


	public void setPrivate_rs(String private_rs) {
		this.private_rs = private_rs;
	}


	public String getPrivate_str_dt() {
		return private_str_dt;
	}


	public void setPrivate_str_dt(String private_str_dt) {
		this.private_str_dt = private_str_dt;
	}


	public String getPrivate_end_dt() {
		return private_end_dt;
	}


	public void setPrivate_end_dt(String private_end_dt) {
		this.private_end_dt = private_end_dt;
	}


	public String getProj_tit_kor() {
		return proj_tit_kor;
	}


	public void setProj_tit_kor(String proj_tit_kor) {
		this.proj_tit_kor = proj_tit_kor;
	}


	public String getProj_tit_eng() {
		return proj_tit_eng;
	}


	public void setProj_tit_eng(String proj_tit_eng) {
		this.proj_tit_eng = proj_tit_eng;
	}


	public String getPi() {
		return pi;
	}


	public void setPi(String pi) {
		this.pi = pi;
	}



	public String getRp() {
		return rp;
	}


	public void setRp(String rp) {
		this.rp = rp;
	}


	public String getOrg_name() {
		return org_name;
	}


	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}


	public String getKeyword_kor() {
		return keyword_kor;
	}


	public void setKeyword_kor(String keyword_kor) {
		this.keyword_kor = keyword_kor;
	}


	public String getKeyword_eng() {
		return keyword_eng;
	}


	public void setKeyword_eng(String keyword_eng) {
		this.keyword_eng = keyword_eng;
	}


	public String getRep_abs() {
		return rep_abs;
	}


	public void setRep_abs(String rep_abs) {
		this.rep_abs = rep_abs;
	}


	public String getBusino() {
		return busino;
	}


	public void setBusino(String busino) {
		this.busino = busino;
	}


	public int getRdcnt() {
		return rdcnt;
	}


	public void setRdcnt(int rdcnt) {
		this.rdcnt = rdcnt;
	}


	public int getDowncnt() {
		return downcnt;
	}


	public void setDowncnt(int downcnt) {
		this.downcnt = downcnt;
	}


	public String getDel_yn() {
		return del_yn;
	}


	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}


	public String getFrst_regist_dt() {
		return frst_regist_dt;
	}


	public void setFrst_regist_dt(String frst_regist_dt) {
		this.frst_regist_dt = frst_regist_dt;
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



	
	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}


	
	public String getSubject_nm() {
		return subject_nm;
	}


	public void setSubject_nm(String subject_nm) {
		this.subject_nm = subject_nm;
	}


	public int getAnnual_seq() {
		return annual_seq;
	}


	public void setAnnual_seq(int annual_seq) {
		this.annual_seq = annual_seq;
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


	public String getExcel_upload() {
		return excel_upload;
	}


	public void setExcel_upload(String excel_upload) {
		this.excel_upload = excel_upload;
	}


	public String getExcel_upload_err() {
		return excel_upload_err;
	}


	public void setExcel_upload_err(String excel_upload_err) {
		this.excel_upload_err = excel_upload_err;
	}


	public String getFillter_code() {
		return fillter_code;
	}

	public void setFillter_code(String fillter_code) {
		this.fillter_code = fillter_code;
	}

	public String getFillter_data() {
		return fillter_data;
	}

	public void setFillter_data(String fillter_data) {
		this.fillter_data = fillter_data;
	}

	public String getFillter_cnt() {
		return fillter_cnt;
	}

	public void setFillter_cnt(String fillter_cnt) {
		this.fillter_cnt = fillter_cnt;
	}

	public String getFillter_gbn() {
		return fillter_gbn;
	}

	public void setFillter_gbn(String fillter_gbn) {
		this.fillter_gbn = fillter_gbn;
	}

	public String getFillterYear() {
		return fillterYear;
	}

	public void setFillterYear(String fillterYear) {
		this.fillterYear = fillterYear;
	}


	public String getFillterDept() {
		return fillterDept;
	}

	public void setFillterDept(String fillterDept) {
		this.fillterDept = fillterDept;
	}


	
	public String getFillterSubject() {
		return fillterSubject;
	}


	public void setFillterSubject(String fillterSubject) {
		this.fillterSubject = fillterSubject;
	}


	public String getFillterYearList() {
		return fillterYearList;
	}


	public void setFillterYearList(String fillterYearList) {
		this.fillterYearList = fillterYearList;
	}


	public String getFillterDeptList() {
		return fillterDeptList;
	}


	public void setFillterDeptList(String fillterDeptList) {
		this.fillterDeptList = fillterDeptList;
	}


	
	public String getFillterSubjectList() {
		return fillterSubjectList;
	}


	public void setFillterSubjectList(String fillterSubjectList) {
		this.fillterSubjectList = fillterSubjectList;
	}


	public List<String> getFillterYearList_L() 	{	
 		List<String> newFillterYearList_L = null; 
		if(this.fillterYearList_L !=null) {
			newFillterYearList_L = 	new ArrayList<String>();
			newFillterYearList_L = this.fillterYearList_L;
		}					
	    return newFillterYearList_L;		
	}

	public void setFillterYearList_L(List<String> fillterYearList_L) {		
		
		if(fillterYearList_L != null){
			this.fillterYearList_L = new ArrayList<String>(fillterYearList_L.size());
			for (int i = 0; i < fillterYearList_L.size(); ++i){
				this.fillterYearList_L.add(i, fillterYearList_L.get(i));
			}
		}		
	}

	public List<String> getFillterDeptList_L() {		
	
		List<String> newFillterDeptList_L = null; 
		if(this.fillterDeptList_L !=null) {
			newFillterDeptList_L = 	new ArrayList<String>();
			newFillterDeptList_L = this.fillterDeptList_L;
		}					
	    return newFillterDeptList_L;	    
	}


	public void setFillterDeptList_L(List<String> fillterDeptList_L) {		
		
		if(fillterDeptList_L != null){
			this.fillterDeptList_L = new ArrayList<String>(fillterDeptList_L.size());
			for (int i = 0; i < fillterDeptList_L.size(); ++i){
				this.fillterDeptList_L.add(i, fillterDeptList_L.get(i));
			}
		}		
	}
	
	public List<String> getFillterSubjectList_L() {
		
		List<String> newFillterSubjectList_L = null; 
		if(this.fillterSubjectList_L !=null) {
			newFillterSubjectList_L = 	new ArrayList<String>();
			newFillterSubjectList_L = this.fillterSubjectList_L;
		}					
	    return newFillterSubjectList_L;	    
	}

	public void setFillterSubjectList_L(List<String> fillterSubjectList_L) {
		
		if(fillterSubjectList_L != null){
			this.fillterSubjectList_L = new ArrayList<String>(fillterSubjectList_L.size());
			for (int i = 0; i < fillterSubjectList_L.size(); ++i){
				this.fillterSubjectList_L.add(i, fillterSubjectList_L.get(i));
			}
		}		
	
	}

	public String getFillterYearList_s() {
		return fillterYearList_s;
	}


	public void setFillterYearList_s(String fillterYearList_s) {
		this.fillterYearList_s = fillterYearList_s;
	}


	public String getFillterDeptList_s() {
		return fillterDeptList_s;
	}


	public void setFillterDeptList_s(String fillterDeptList_s) {
		this.fillterDeptList_s = fillterDeptList_s;
	}

	

	public String getFillterSubjectList_s() {
		return fillterSubjectList_s;
	}


	public void setFillterSubjectList_s(String fillterSubjectList_s) {
		this.fillterSubjectList_s = fillterSubjectList_s;
	}


	public String getFillterYearCnt() {
		return fillterYearCnt;
	}


	public void setFillterYearCnt(String fillterYearCnt) {
		this.fillterYearCnt = fillterYearCnt;
	}

	

	public String getFillterDeptCnt() {
		return fillterDeptCnt;
	}


	public void setFillterDeptCnt(String fillterDeptCnt) {
		this.fillterDeptCnt = fillterDeptCnt;
	}
		

	
	public String getFillterSubjectCnt() {
		return fillterSubjectCnt;
	}


	public void setFillterSubjectCnt(String fillterSubjectCnt) {
		this.fillterSubjectCnt = fillterSubjectCnt;
	}


	public String getReturnPageGbn() {
		return returnPageGbn;
	}


	public void setReturnPageGbn(String returnPageGbn) {
		this.returnPageGbn = returnPageGbn;
	}


	public String getRn() {
		return rn;
	}


	public void setRn(String rn) {
		this.rn = rn;
	}


	public String getError_cn() {
		return error_cn;
	}


	public void setError_cn(String error_cn) {
		this.error_cn = error_cn;
	}


	public String getAtch_file_id() {
		return atch_file_id;
	}


	public void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}


	public String getAtch_link_id() {
		return atch_link_id;
	}


	public void setAtch_link_id(String atch_link_id) {
		this.atch_link_id = atch_link_id;
	}


	public String getConParam() {
		return conParam;
	}


	public void setConParam(String conParam) {
		this.conParam = conParam;
	}
	
	
	
}
