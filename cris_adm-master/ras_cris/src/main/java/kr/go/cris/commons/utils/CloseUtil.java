/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.utils;

import java.io.Closeable;
import java.io.IOException;
import org.apache.log4j.Logger;
/**
 * <pre>
 * FileName: CloseUtil.java
 * Package : kr.go.cris.commons.utils
 *
 * close 함수 호출 관력 유틸객체.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 3. 6.
 */
public class CloseUtil {

    /**
     *
     * <pre>
     * Closeable interface 구현객체에 대하여 오류 처리 없이 닫아준다.
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 3. 6.
     * @param closeable
     */
    public static void closeQuietly(Closeable closeable) {
        if (closeable != null) try { closeable.close(); } catch (IOException e) {
        	Logger.getLogger(CloseUtil.class).debug("err closeQuietly");
        }
    }
}
