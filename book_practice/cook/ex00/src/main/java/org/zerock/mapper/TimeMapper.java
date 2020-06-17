package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
//	메서드 선언은 interface에서, sql은 xml에서 ( xml에서 namespace 통해 interface와 연결 )
	
	@Select("SELECT sysdate FROM dual")
	public String getTime();

	public String getTime2();

}
