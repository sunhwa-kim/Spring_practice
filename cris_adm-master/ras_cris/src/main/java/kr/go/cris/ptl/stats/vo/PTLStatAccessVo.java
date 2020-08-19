package kr.go.cris.ptl.stats.vo;
   
import org.apache.ibatis.type.Alias;

@Alias("pTLStatAccessVo")
public class PTLStatAccessVo {

	/** 접속IP **/
    private String noSeq = "";	
	
	/** 접속IP **/
    private String userIp = "";
    
	/** 접속IP **/
    private String userId = "";
    
	/** 접속IP **/
    private String wkid = "";
    
	/** 접속IP **/
    private String mbid = "";
    
	/** 접속IP **/
    private String title = "";
    
	/** 접속IP **/
    private String regDate = "";    
    

	public String getNoSeq() {
		return noSeq;
	}

	public void setNoSeq(String noSeq) {
		this.noSeq = noSeq;
	}

	public String getUserIp() {
		return userIp;
	}

	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getWkid() {
		return wkid;
	}

	public void setWkid(String wkid) {
		this.wkid = wkid;
	}

	public String getMbid() {
		return mbid;
	}

	public void setMbid(String mbid) {
		this.mbid = mbid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}    
	
    
	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
	
}
