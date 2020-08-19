/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.login.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import kr.go.cris.base.vo.BaseVo;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.type.Alias;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * <pre>
 * FileName: UserVo.java
 * Package : kr.go.cris.commons.login.vo
 * 
 * 사용자관리 -
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 2. 23.
 */


@Alias("userVo")
public class UserVo extends BaseVo implements UserDetails {
    /** serialVersionUID */
    private static final long serialVersionUID = -3830662233084098293L;

    private String loginid;			    // 사용자 ID
	private String password;			// 사용자 비밀번호
	private String status;			    // 사용자 상태
	private String email;		   	    // 사용자 기관코드
	private String uniqId;              // 사용자순번
	private String id;                  // 사용자순번
	private String emplyrkey;           // 사용자순번
	private List<String> roleList;      // 사용자 권한
	private String engYn = "N";         // 영문메뉴여부
	private String sel_Menu = "";       // 선택 메뉴
	private String emplyrnm;            // 한글명
	private String secsnat;             // 탈퇴여부
	private String sha2;				// sha여부
	private String usrIp;        	    // 사용자 IP
	private String internalIp;          // 내부이용자 유
	private String empip;
	private String insttnm;				//사용자 소속 기관명
	private String insttsn;				//사용자 소속 기관번호(PK)
	private String instttyid;			// 사용자 소속기관 유형ID
	private String mouLoan;				//pmc 사용승인
	private String elibagree;			// 전자자원 서비스 이용여부
	private String mbtlnum;			
	private String meshagree;
	private String mesh;
	private String pmcagree;		// PMC동의  
	private String pmcconfirm;		// pmc 사용승인여부
	private String pmcconfirmDt;	// pmc 사용승인일시
	private String pmc;				// PMC 이용서비스
	
	// 권한
	public List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

	/**
	 *
	 * <pre>
	 * 권한을 가지고 있는지 확인한다.
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 10. 1.
	 * @param authCd
	 * @return
	 */
	public boolean isAuth(String authCd) {
		boolean isAuth = false;
		for (GrantedAuthority ga: authorities) {
			if (StringUtils.equals(ga.getAuthority(), authCd)) {
				isAuth = true;
				break;
			}
		}
		return isAuth;
	}

	public String getSha2() {
		return sha2;
	}

	public void setSha2(String sha2) {
		this.sha2 = sha2;
	}

	public void setAuth(List<String> list) {

		if(list != null){
			this.roleList = new ArrayList<String>(list.size());
			for (int i = 0; i < list.size(); ++i){
				this.roleList.add(i, list.get(i));
			}
			for(String auth: list) authorities.add(new SimpleGrantedAuthority(auth));
		}		
		
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}

	@Override
	public String getPassword() {
		return this.password;
	}

	@Override
	public String getUsername() {
		return this.loginid;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	public String getLoginid() {
		return loginid;
	}

	public void setLoginid(String loginid) {
		this.loginid = loginid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUniqId() {
		return uniqId;
	}

	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEmplyrkey() {
		return emplyrkey;
	}

	public void setEmplyrkey(String emplyrkey) {
		this.emplyrkey = emplyrkey;
	}

	public List<String> getRoleList() {
		
		List<String> newRoleList = null; 
		if(this.roleList !=null) {
			newRoleList = 	new ArrayList<String>();
			newRoleList = this.roleList;
		}					
	    return newRoleList;	
	}

	public void setRoleList(List<String> roleList) {
		if(roleList != null){
			this.roleList = new ArrayList<String>(roleList.size());
			for (int i = 0; i < roleList.size(); ++i){
				this.roleList.add(i, roleList.get(i));
			}
		}	
	}

	public String getEngYn() {
		return engYn;
	}

	public void setEngYn(String engYn) {
		this.engYn = engYn;
	}

	public String getSel_Menu() {
		return sel_Menu;
	}

	public void setSel_Menu(String sel_Menu) {
		this.sel_Menu = sel_Menu;
	}

	public String getEmplyrnm() {
		return emplyrnm;
	}

	public void setEmplyrnm(String emplyrnm) {
		this.emplyrnm = emplyrnm;
	}



	public void setPassword(String password) {
		this.password = password;
	}

	public void setAuthorities(List<GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	public String getSecsnat() {
		return secsnat;
	}

	public void setSecsnat(String secsnat) {
		this.secsnat = secsnat;
	}

	public String getUsrIp() {
		return usrIp;
	}

	public void setUsrIp(String usrIp) {
		this.usrIp = usrIp;
	}

	public String getInternalIp() {
		return internalIp;
	}

	public void setInternalIp(String internalIp) {
		this.internalIp = internalIp;
	}

	public String getEmpip() {
		return empip;
	}

	public void setEmpip(String empip) {
		this.empip = empip;
	}
	public String getInsttnm() {
		return insttnm;
	}

	public void setInsttnm(String insttnm) {
		this.insttnm = insttnm;
	}

	public String getInsttsn() {
		return insttsn;
	}

	public void setInsttsn(String insttsn) {
		this.insttsn = insttsn;
	}

	public String getInstttyid() {
		return instttyid;
	}

	public void setInstttyid(String instttyid) {
		this.instttyid = instttyid;
	}

	public String getMouLoan() {
		return mouLoan;
	}

	public void setMouLoan(String mouLoan) {
		this.mouLoan = mouLoan;
	}

	public String getElibagree() {
		return elibagree;
	}

	public void setElibagree(String elibagree) {
		this.elibagree = elibagree;
	}

	public String getMbtlnum() {
		return mbtlnum;
	}

	public void setMbtlnum(String mbtlnum) {
		this.mbtlnum = mbtlnum;
	}

	public String getMeshagree() {
		return meshagree;
	}

	public void setMeshagree(String meshagree) {
		this.meshagree = meshagree;
	}

	public String getMesh() {
		return mesh;
	}

	public void setMesh(String mesh) {
		this.mesh = mesh;
	}

	public String getPmcconfirm() {
		return pmcconfirm;
	}

	public void setPmcconfirm(String pmcconfirm) {
		this.pmcconfirm = pmcconfirm;
	}

	public String getPmcconfirmDt() {
		return pmcconfirmDt;
	}

	public void setPmcconfirmDt(String pmcconfirmDt) {
		this.pmcconfirmDt = pmcconfirmDt;
	}

	public String getPmc() {
		return pmc;
	}

	public void setPmc(String pmc) {
		this.pmc = pmc;
	}

	public String getPmcagree() {
		return pmcagree;
	}

	public void setPmcagree(String pmcagree) {
		this.pmcagree = pmcagree;
	}

}
