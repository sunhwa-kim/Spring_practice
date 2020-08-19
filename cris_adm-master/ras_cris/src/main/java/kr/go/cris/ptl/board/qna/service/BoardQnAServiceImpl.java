package kr.go.cris.ptl.board.qna.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.board.qna.dao.BoardQnADao;
import kr.go.cris.ptl.board.qna.vo.BoardQnAVo;

import org.springframework.stereotype.Service;


@Service
public class BoardQnAServiceImpl extends BaseServiceImpl implements BoardQnAService{
	@Resource 
	private BoardQnADao boardQnADao;
	
	
	public List<BoardQnAVo> selectBoardQnAList(BoardQnAVo boardQnAVo)  throws IOException , SQLException , NullPointerException{

		return boardQnADao.selectBoardQnAList(boardQnAVo);
	}
	
	@Override
	public int selectBQnAT_Rows (BoardQnAVo boardQnAVo)  throws IOException, SQLException, NullPointerException {
		return boardQnADao.selectBQnAT_Rows(boardQnAVo);
	}
	
	@Override
	public BoardQnAVo selectBoardQnaDetailed(BoardQnAVo boardQnAVo) throws IOException , SQLException , NullPointerException {
		return boardQnADao.selectBoardQnaDetailed(boardQnAVo);
	}
	
}
