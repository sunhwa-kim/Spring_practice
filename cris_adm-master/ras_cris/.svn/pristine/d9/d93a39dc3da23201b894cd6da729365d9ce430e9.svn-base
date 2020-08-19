/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.menu.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.SerializationUtils;
import org.apache.ibatis.type.Alias;

import kr.go.cris.base.vo.BaseVo;

/**
 * <pre>
 * FileName: MenuVo.java
 * Package : kr.go.cris.commons.menu.vo
 *
 * 메뉴 VO.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 10. 2.
 */

@Alias("menuVo")
public class MenuVo extends BaseVo implements Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = -190294265033092479L;

	private String lvl;     // 메뉴 레벨
	private String url;     // 메뉴 URL
	private String menuNm;  // 메뉴 명
	private String menuOrd; // 메뉴 순서
	private List<MenuVo> subList; // 서브 메뉴
	private boolean selYn = false; // 메뉴 선택여부
	private String menu_id; // 메뉴 ID
	private String menu_prts_id; // 상위 메뉴 ID
	private String menu_con; // 메뉴 뎁스구분(0:하위메뉴있음 1:하위메뉴없음)
	

	/**
	 *
	 * <pre>
	 * 메뉴 객체를 복사(deep copy) 한다.
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 10. 5.
	 * @return
	 */
	public MenuVo runClone() {
		MenuVo menuVo = SerializationUtils.clone(this);
		return menuVo;
	}

	public String getLvl() {
		return lvl;
	}
	public void setLvl(String lvl) {
		this.lvl = lvl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getMenuOrd() {
		return menuOrd;
	}
	public void setMenuOrd(String menuOrd) {
		this.menuOrd = menuOrd;
	}
	public List<MenuVo> getSubList() {
		
		List<MenuVo> newSubList = null; 
		if(this.subList !=null) {
			newSubList = 	new ArrayList<MenuVo>();
			newSubList = this.subList;
		}					
	    return newSubList;	
	
	}
	
	public void setSubList(List<MenuVo> subList) {
		if(subList != null){
			this.subList = new ArrayList<MenuVo>(subList.size());
			for (int i = 0; i < subList.size(); ++i){
				this.subList.add(i, subList.get(i));
			}
		}	
	
	}
	
	public boolean getSelYn() {
		return selYn;
	}
	public void setSelYn(boolean selYn) {
		this.selYn = selYn;
	}

	public String getMenu_id() {
		return menu_id;
	}

	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}

	public String getMenu_prts_id() {
		return menu_prts_id;
	}

	public void setMenu_prts_id(String menu_prts_id) {
		this.menu_prts_id = menu_prts_id;
	}

	public String getMenu_con() {
		return menu_con;
	}

	public void setMenu_con(String menu_con) {
		this.menu_con = menu_con;
	}
}
