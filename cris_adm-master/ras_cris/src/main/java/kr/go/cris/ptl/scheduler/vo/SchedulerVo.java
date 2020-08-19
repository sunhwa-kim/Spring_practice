package kr.go.cris.ptl.scheduler.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import kr.go.cris.commons.vo.CommonsVo;


@Alias("schedulerVo")
public class SchedulerVo extends CommonsVo {
	       
	private String sch_id;  
	
    private String copy_user_id;  // 현재 사용 안함, 추후 정보 사용시 사용
    private String copy_login_id;// 현재 사용 안함, 추후 정보 사용시 사용
    private String copy_name;// 현재 사용 안함, 추후 정보 사용시 사용
    // 스케줄러 제목
    private String sch_sj;
    
    // 스케줄러 실행 내용
    private String sch_cn;
    // 스케줄러 실행 상태  (성공/에러)
    private String sch_state;
    // 등록일
    private Date reg_date;

	

	public String getSch_id() {
		return sch_id;
	}

	public void setSch_id(String sch_id) {
		this.sch_id = sch_id;
	}

	public String getCopy_user_id() {
		return copy_user_id;
	}

	public void setCopy_user_id(String copy_user_id) {
		this.copy_user_id = copy_user_id;
	}

	public String getCopy_login_id() {
		return copy_login_id;
	}

	public void setCopy_login_id(String copy_login_id) {
		this.copy_login_id = copy_login_id;
	}

	public String getCopy_name() {
		return copy_name;
	}

	public void setCopy_name(String copy_name) {
		this.copy_name = copy_name;
	}

    
	public String getSch_sj() {
		return sch_sj;
	}

	public void setSch_sj(String sch_sj) {
		this.sch_sj = sch_sj;
	}

	public String getSch_cn() {
		return sch_cn;
	}

	public void setSch_cn(String sch_cn) {
		this.sch_cn = sch_cn;
	}

	public String getSch_state() {
		return sch_state;
	}

	public void setSch_state(String sch_state) {
		this.sch_state = sch_state;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}


	
   
    

	
	
}
