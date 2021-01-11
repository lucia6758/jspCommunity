package com.sbs.example.jspCommunity.service;

import java.util.List;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dao.ArticleDao;
import com.sbs.example.jspCommunity.dto.Article;

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
		return articleDao.add(memberId, title, body, boardId);
	}

	public int doModify(int memberId, int id, String title, String body) {
		return articleDao.modify(memberId, id, title, body);	
	}

	public int delete(int id) {
		return articleDao.delete(id);
	}

}
