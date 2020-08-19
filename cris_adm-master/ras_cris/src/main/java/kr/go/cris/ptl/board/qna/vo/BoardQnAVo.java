package kr.go.cris.ptl.board.qna.vo;

import java.io.Serializable;

import kr.go.cris.commons.vo.CommonsVo;

import org.apache.ibatis.type.Alias;

@Alias("boardQnAVo")
public class BoardQnAVo extends CommonsVo implements Serializable{
	
	/** serialVersionUID */
	private static final long serialVersionUID = 519380524109527938L;
	/** 상세보기 unique index  */	
	private int idx_board;
	/** pages for calculate */
	private int rn;
	/** 분류 */
	private String classification;
	/** 제목 */
	private String title;
	/** 작성자 */
	private String writer;
	/** 등록일 */
	private String insertdate_board;
	/** 상태 */
	private String situation;
	
	
	/** 검색시 selectbox - sunhwa test  */
	private String searchClassification;
	private String searchCustomHeader;
	private String searchSituation;
	

	/*  총 rows => page */
	private int total_rows;

	public int getIdx_board() {
		return idx_board;
	}

	public void setIdx_board(int idx_board) {
		this.idx_board = idx_board;
	}

	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}
	
	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getInsertdate_board() {
		return insertdate_board;
	}

	public void setInsertdate_board(String insertdate_board) {
		this.insertdate_board = insertdate_board;
	}

	public String getSituation() { //테이블 코드는 숫자여도 받는건 글자니까 String
		return situation;
	}

	public void setSituation(String situation) {
		this.situation = situation;
	}
	
	public int getTotal_rows() {
		return total_rows;
	}


	public void setTotal_rows(int total_rows) {
		this.total_rows = total_rows;
	}
	
	/**  sunhwa test*/
	public String getSearchClassification() {
		return searchClassification;
	}

	public void setSearchClassification(String searchClassification) {
		this.searchClassification = searchClassification;
	}
	
	public String getSearchCustomHeader() {
		return searchCustomHeader;
	}

	public void setSearchCustomHeader(String searchCustomHeader) {
		this.searchCustomHeader = searchCustomHeader;
	}
	
	public String getSearchSituation() {
		return searchSituation;
	}

	public void setSearchSituation(String searchSituation) {
		this.searchSituation = searchSituation;
	}

}
