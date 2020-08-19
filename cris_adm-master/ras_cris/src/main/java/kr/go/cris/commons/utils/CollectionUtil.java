/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.utils;

import java.util.Collection;

/**
 * <pre>
 * FileName: CollectionUtil.java
 * Package : kr.go.cris.commons.utils
 *
 * Collection 객체 관련 유틸리티 객체.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 3. 6.
 */
public class CollectionUtil {
    /**
     *
     * <pre>
     * null 혹은 데이터가 없으면 true를 반환
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 3. 6.
     * @param col
     * @return
     */
    public static boolean isEmpty(Collection<?> col) {
        return col == null || col.isEmpty();
    }

    /**
     *
     * <pre>
     * 데이터가 있으면 true를 반환
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 3. 6.
     * @param col
     * @return
     */
    public static boolean isNotEmpty(Collection<?> col) {
        return !isEmpty(col);
    }
}
