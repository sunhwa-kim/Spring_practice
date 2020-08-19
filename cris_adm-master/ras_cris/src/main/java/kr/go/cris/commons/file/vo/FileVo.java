/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.file.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.go.cris.base.vo.BaseVo;
import kr.go.cris.commons.vo.CommonsVo;


/**
 * <pre>
 * 
 * 첨부 파일 정보를 가지고 있는 Vo.
 * </pre>
 * @FileName : FileVo.java
 * @package  : kr.go.cris.commons.file.vo
 * @author   : wonki0138
 * @date     : 2018. 2. 26.
 * 
 */

@Alias("ncmikFileVo")
public class FileVo extends CommonsVo implements Serializable {
 
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3084065318552282416L;

	/** 첨부파일ID */
	private String atch_file_id;
	
	/** 파일순번 */
	private int file_sn;
	
	/** 파일저장경로 */
	private String file_stre_cours;
	
	/** 저장파일명 */
	private String stre_file_nm;
	
	/** 원파일명 */
	private String orignl_file_nm;
	
	/** 파일확장자 */
	private String file_extsn;
	
	/** 파일내용 */
	private String file_cn;
	
	/** 파일크기 */
	private int file_size;
	
	/** 첨부파일 데이터 */
	private byte[] file_byte = null;

	
    private String fileId;       // 파일번호
    private String fileNm;       // 파일명
    private String fileConvNm;   // 변환파일명
    private long fileSize;       // 파일크기
    private String createDt;     // 생성일
    private int fileOrd;         // 첨부파일 연번
	
	public String getAtch_file_id() {
		return atch_file_id;
	}

	public void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}

	public int getFile_sn() {
		return file_sn;
	}

	public void setFile_sn(int file_sn) {
		this.file_sn = file_sn;
	}

	public String getFile_stre_cours() {
		return file_stre_cours;
	}

	public void setFile_stre_cours(String file_stre_cours) {
		this.file_stre_cours = file_stre_cours;
	}

	public String getStre_file_nm() {
		return stre_file_nm;
	}

	public void setStre_file_nm(String stre_file_nm) {
		this.stre_file_nm = stre_file_nm;
	}

	public String getOrignl_file_nm() {
		return orignl_file_nm;
	}

	public void setOrignl_file_nm(String orignl_file_nm) {
		this.orignl_file_nm = orignl_file_nm;
	}

	public String getFile_extsn() {
		return file_extsn;
	}

	public void setFile_extsn(String file_extsn) {
		this.file_extsn = file_extsn;
	}

	public String getFile_cn() {
		return file_cn;
	}

	public void setFile_cn(String file_cn) {
		this.file_cn = file_cn;
	}

	public int getFile_size() {
		return file_size;
	}

	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}

	

	
	public byte[] getFile_byte() {
		byte[] newFile_byte = new byte[file_byte.length];
	    System.arraycopy(file_byte, 0, newFile_byte, 0, file_byte.length);
		return newFile_byte;

	}

	public void setFile_byte(byte[] file_byte) {
		byte[] newFile_byte = new byte[file_byte.length];
		    if(newFile_byte.length > 0){
			    System.arraycopy(file_byte, 0, newFile_byte, 0, file_byte.length);
			    this.file_byte = newFile_byte;	
		    }
	
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public String getFileConvNm() {
		return fileConvNm;
	}

	public void setFileConvNm(String fileConvNm) {
		this.fileConvNm = fileConvNm;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public int getFileOrd() {
		return fileOrd;
	}

	public void setFileOrd(int fileOrd) {
		this.fileOrd = fileOrd;
	}
	
	

	
	
}
