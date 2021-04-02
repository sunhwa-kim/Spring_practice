package kr.go.cris.ptl.board.qna.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.board.qna.vo.BoardQnAVo;

public interface BoardQnAService {
//	조회
	public List<BoardQnAVo> selectBoardQnAList(BoardQnAVo boardQnAVo)  throws IOException , SQLException , NullPointerException ;
	
//	rows 수
	public int selectBQnAT_Rows(BoardQnAVo boardQnAVo) throws IOException, SQLException,NullPointerException;
	
//	상세
	public BoardQnAVo selectBoardQnaDetailed(BoardQnAVo boardQnAVo)   throws IOException , SQLException , NullPointerException;
}
