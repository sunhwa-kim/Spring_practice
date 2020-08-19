package kr.go.cris.ptl.board.columnAbbreviation.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface ColmnAbbrevtService {

	public List<Map<String, Object>> selectColAbbrvt() throws SQLException;
	
}
