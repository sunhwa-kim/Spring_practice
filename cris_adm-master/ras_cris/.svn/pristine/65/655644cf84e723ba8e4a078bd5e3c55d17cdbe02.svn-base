/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.menu.dao;

import java.util.List;

import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.commons.menu.vo.MenuVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * FileName: MenuDao.java
 * Package : kr.go.cris.commons.menu.dao
 *
 * 사용자 메뉴 목록 DAO.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 10. 2.
 */
@Repository
public interface MenuDao {
	/**
	 *
	 * <pre>
	 * Top 메뉴 목록 조회
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 10. 2.
	 * @param userVo
	 * @return
	 */
	public List<MenuVo> selectTopMenuList(UserVo userVo);

	/**
	 *
	 * <pre>
	 * Left 메뉴 목록 조회
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 10. 2.
	 * @param userVo
	 * @return
	 */
	public List<MenuVo> selectLeftMenuList(UserVo userVo);

	/**
	 *
	 * <pre>
	 * 전체 URL 목록 조회
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 10. 6.
	 * @return
	 */
	public List<MenuVo> selectUrlList();
}
