package kr.go.cris.ptl.board.qna.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.board.qna.vo.BoardQnAVo;

import org.springframework.stereotype.Repository;


@Repository
public interface BoardQnADao {
	public List<BoardQnAVo> selectBoardQnAList(BoardQnAVo boardQnAVo)throws IOException , SQLException , NullPointerException;
	
	public int selectBQnAT_Rows(BoardQnAVo boardQnAVo) throws IOException , SQLException , NullPointerException;

	public BoardQnAVo selectBoardQnaDetailed(BoardQnAVo boardQnAVo)throws IOException , SQLException , NullPointerException;
}
