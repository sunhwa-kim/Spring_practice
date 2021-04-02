package kr.go.cris.ptl.board.columnAbbreviation.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface ColmnAbbrevtDao {

	public List<Map<String, Object>> selectColAbbrvt() throws SQLException;
}
