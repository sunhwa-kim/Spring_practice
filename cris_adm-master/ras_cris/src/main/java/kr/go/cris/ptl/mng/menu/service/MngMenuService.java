package kr.go.cris.ptl.mng.menu.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.mng.menu.vo.MngMenuRolVo;
import kr.go.cris.ptl.mng.menu.vo.MngMenuVo;

/**
 *
 * <pre>
 * FileName: MngMenuService.java
 * Package : kr.go.cris.ptl.mng.menu.service
 *
 * mng Menu 관리 interface Service
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 2. 11.
 */
public interface MngMenuService {


	/**
	 * <pre>
	 * 메뉴관리 - 메뉴조회
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 11.
	 * @param mngMenuVo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<MngMenuVo> readMenuList(MngMenuVo mngMenuVo)  throws IOException, SQLException , NullPointerException ;

	
	/**
	 * <pre>
	 * 메뉴관리 - 메뉴등록
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 12.
	 * @param mngMenuVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertMenu(MngMenuVo mngMenuVo) throws IOException, SQLException , NullPointerException ;


	/**
	 * <pre>
	 * 메뉴관리 - 메뉴수정
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 12.
	 * @param mngMenuVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void updateMenu(MngMenuVo mngMenuVo) throws IOException, SQLException , NullPointerException ;


	/**
	 * <pre>
	 * 메뉴관리 - 메뉴삭제
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 16.
	 * @param mngMenuVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void deleteMenu(MngMenuVo mngMenuVo) throws IOException, SQLException , NullPointerException ;


	/**
	 * <pre>
	 * 메뉴관리 - 메뉴권한삭제
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 16.
	 * @param mngMenuVo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public int deleteMenuRol(MngMenuRolVo mngMenuVo)throws IOException, SQLException , NullPointerException ;


	/**
	 * <pre>
	 * 메뉴관리 - 메뉴권한등록
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 16.
	 * @param mngMenuVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertMenuRol(MngMenuRolVo mngMenuVo)throws IOException, SQLException , NullPointerException ;
	
	/**
	 * <pre>
	 * 메뉴관리 - 메뉴권한등록
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 16.
	 * @param mngMenuVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void mergeMenuRol(MngMenuRolVo mngMenuVo)throws IOException, SQLException , NullPointerException ;


	/**
	 * <pre>
	 * 메뉴관리 - 메뉴권한조회
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 17.
	 * @param menu_id
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<MngMenuVo> readMenuRolList(String menu_id)throws IOException, SQLException , NullPointerException ;


	/**
	 * <pre>
	 * 메뉴관리 - 하위메뉴사용유무 수정
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 25.
	 * @param mngMenuVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void updateMenuDtl(MngMenuVo mngMenuVo)throws IOException, SQLException , NullPointerException ;

}
