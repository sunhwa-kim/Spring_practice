package kr.go.cris.ptl.archive.rnd.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.go.cris.commons.utils.StringUtil;
import kr.go.cris.commons.vo.CommonsVo;


@Alias("archiveRndVo")
public class ArchiveRndVo extends CommonsVo  implements Serializable  {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 4915784194039565236L;

	/** 성과논문 ID */
	private String rnd_id;
	/** 발행년도 */
	private String pubyear;
	/** 성과발생년도 */
	private String occu_year;
	/** 성과논문명_국문 */
	private String atc_title_kor;	
	/** 성과논문명_영문 */
	private String atc_title_eng;	
	
	/** 국내외구분 / 국내 : I , 국외 : O */
	private String inoutflag;
	/** 학술지명 */
	private String journal_nm;
	/** ISSN */
	private String rnd_issn;
	/** ISBN */
	private String doi;
	/** 주저자 */
	private String author;
	/** 공동저자 */
	private String co_author;
	/** 교신저자 */
	private String commu_author;
	/** 권호명 */
	private String volumename;
	/** 저널 시작 페이지 */
	private String jour_str_page;
	/** 저널 끝페이지 */
	private String jour_end_page;
	/** SIC 구분 /  예 : Y , 아니오 : N */
	private String sci_gbn;
	/** 학술지출판일자 */
	private String publishing_date;
	/** 학술지임팩트팩터 */
	private String impact_factor;
	/** 키워드 */
	private String keyword;
	/** 초록 */
	private String rnd_abs;
	/** 아카이브 보고서 ID */
	private String archive_rep_id;
	/** 아카이브 과제번호 */
	private String archive_busino;
	/** 조회수 */
	private int rdcnt;
	/** 다운로드수 */
	private int downcnt;
	/** 삭제여부 */
	private String del_yn;
	/** 최초등록시점 */
	private String frst_regist_pnttm;
	/** 최초등록자ID */
	private String frst_register_id;
	/** 최종수정시점 */
	private String last_updt_pnttm;
	/** 최종수정자ID */
	private String last_updusr_id;


	/** 보고서 연계 vo STR */
	
	/** 연구과제명_국문 */
	private String proj_tit_kor;
	
	/** 연구과제명_영문 */
	private String proj_tit_eng;
	
	/** 책임연구원 */
	private String pi;
	
	/** 과제번호 */
	private String busino;
	
	/** 세부사업명 */
	private String detail_busi_nm;
	
	/** 발행자 */
	private String org_name;
	/** 보고서 ID */
	private String rep_id;
	/** 보고서 연계 vo END */
	
	/** 검색결과제한 구성을 위한 param STR */

	/** 검색 데이터 CODE */
	private String fillter_code;

	/** 검색 데이터 NAME */
	private String fillter_data;

	/** 검색 데이터 갯수 */
	private String fillter_cnt;

	/** 검색 데이터 구분 */
	private String fillter_gbn;

	/** 검색 데이터 더보기(발행연도) */
	private String fillterYear;

	/** 검색결과제한 구성을 위한 param END */

	/** 검색결과제한 목록 조회 조건에 사용 STR */

	/** 목록 조회조건(필터-발행년도 : JSP에서 -> 자바로) */
	private String fillterYearList;
	
	/** 목록 조회조건(필터-발행년도 : SELECT 조건으로 사용하기위한 LIST) */
	private List<String> fillterYearList_L;

	/** 목록 조회조건(필터-발행년도 : 화면 이동시 필터 조건 유지) */
	private String fillterYearList_s;
	
	/** 목록 조회조건(필터-발행년도 : 화면 이동시 열려있던 필터의 수를 유지) */
	private String fillterYearCnt;

	/** 검색결과제한 목록 조회 조건에 사용 END */

	/** 리턴 페이지 구분 */
	private String returnPageGbn;

	
	
    /** 첨부파일 STR */
    private String atch_file_id;

    private String atch_link_id;
    /** 첨부파일 END */
    
    private String conParam;
    
	public String getFillter_code() {
		return fillter_code;
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

	public String getOccu_year() {
		return occu_year;
	}

	public void setOccu_year(String occu_year) {
		this.occu_year = occu_year;
	}

	public String getAtc_title_kor() {
		return atc_title_kor;
	}

	public void setAtc_title_kor(String atc_title_kor) {
		this.atc_title_kor = atc_title_kor;
	}

	public String getAtc_title_eng() {
		return atc_title_eng;
	}

	public void setAtc_title_eng(String atc_title_eng) {
		this.atc_title_eng = atc_title_eng;
	}

	
	public String getInoutflag() {
		return inoutflag;
	}

	public void setInoutflag(String inoutflag) {
		this.inoutflag = inoutflag;
	}

	public String getJournal_nm() {
		return journal_nm;
	}

	public void setJournal_nm(String journal_nm) {
		this.journal_nm = journal_nm;
	}

	public String getRnd_issn() {
		return rnd_issn;
	}

	public void setRnd_issn(String rnd_issn) {
		this.rnd_issn = rnd_issn;
	}

	public String getDoi() {
		return doi;
	}

	public void setDoi(String doi) {
		this.doi = doi;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getCo_author() {
		return co_author;
	}

	public void setCo_author(String co_author) {
		this.co_author = co_author;
	}

	public String getCommu_author() {
		return commu_author;
	}

	public void setCommu_author(String commu_author) {
		this.commu_author = commu_author;
	}

	public String getVolumename() {
		return volumename;
	}

	public void setVolumename(String volumename) {
		this.volumename = volumename;
	}

	public String getJour_str_page() {
		return jour_str_page;
	}

	public void setJour_str_page(String jour_str_page) {
		this.jour_str_page = jour_str_page;
	}

	public String getJour_end_page() {
		return jour_end_page;
	}

	public void setJour_end_page(String jour_end_page) {
		this.jour_end_page = jour_end_page;
	}

	public String getSci_gbn() {
		return sci_gbn;
	}

	public void setSci_gbn(String sci_gbn) {
		this.sci_gbn = sci_gbn;
	}

	public String getPublishing_date() {
		return publishing_date;
	}

	public void setPublishing_date(String publishing_date) {
		this.publishing_date = publishing_date;
	}

	public String getImpact_factor() {
		return impact_factor;
	}

	public void setImpact_factor(String impact_factor) {
		this.impact_factor = impact_factor;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getRnd_abs() {
		return rnd_abs;
	}

	public void setRnd_abs(String rnd_abs) {
		this.rnd_abs = rnd_abs;
	}

	public String getArchive_rep_id() {
		return archive_rep_id;
	}

	public void setArchive_rep_id(String archive_rep_id) {
		this.archive_rep_id = archive_rep_id;
	}

	public String getArchive_busino() {
		return archive_busino;
	}

	public void setArchive_busino(String archive_busino) {
		this.archive_busino = archive_busino;
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

	public String getBusino() {
		return busino;
	}

	public void setBusino(String busino) {
		this.busino = busino;
	}

	public String getDetail_busi_nm() {
		return detail_busi_nm;
	}

	public void setDetail_busi_nm(String detail_busi_nm) {
		this.detail_busi_nm = detail_busi_nm;
	}

	public String getOrg_name() {
		return org_name;
	}

	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	
	public String getRep_id() {
		return rep_id;
	}

	public void setRep_id(String rep_id) {
		this.rep_id = rep_id;
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


	public String getFillterYearList() {
		return fillterYearList;
	}

	public void setFillterYearList(String fillterYearList) {
		this.fillterYearList = fillterYearList;
	}


	public List<String> getFillterYearList_L() {
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

	public String getReturnPageGbn() {
		return returnPageGbn;
	}

	public void setReturnPageGbn(String returnPageGbn) {
		this.returnPageGbn = returnPageGbn;
	}

	public String getFillterYearList_s() {
		return fillterYearList_s;
	}

	public void setFillterYearList_s(String fillterYearList_s) {
		this.fillterYearList_s = fillterYearList_s;
	}


	public String getFillterYearCnt() {
		return fillterYearCnt;
	}

	public void setFillterYearCnt(String fillterYearCnt) {
		this.fillterYearCnt = fillterYearCnt;
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
