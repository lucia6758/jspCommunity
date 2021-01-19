package com.sbs.example.jspCommunity.service;

import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dao.ArticleDao;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dto.Board;

public class ArticleService {
	private ArticleDao articleDao;

	public ArticleService() {
		articleDao = Container.articleDao;
	}

	public List<Article> getForPrintArticlesByBoardId(int boardId) {
		return articleDao.getForPrintArticlesByBoardId(boardId);

	}

	public Article getForPrintArticle(int id) {
		return articleDao.getForPrintArticle(id);
	}

	public int doWrite(int memberId, String title, String body, int boardId) {
		return articleDao.write(memberId, title, body, boardId);
	}

	public int doModify(Map<String, Object> modifyArgs) {
		return articleDao.modify(modifyArgs);
	}

	public int delete(int id) {
		return articleDao.delete(id);
	}

	public Board getBoardById(int boardId) {
		return articleDao.getBoardById(boardId);
	}

}
