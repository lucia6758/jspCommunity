package com.sbs.example.jspCommunity.service;

import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dao.ArticleDao;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dto.Board;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.dto.Reply;

public class ArticleService {
	private ArticleDao articleDao;
	private LikeService likeService;

	public ArticleService() {
		articleDao = Container.articleDao;
		likeService = Container.likeService;
	}

	public List<Article> getForPrintArticlesByBoardId(int boardId, int limitStart, int limitCount, String searchKeyword,
			String searchKeywordType) {
		return articleDao.getForPrintArticlesByBoardId(boardId, limitStart, limitCount, searchKeyword,
				searchKeywordType);
	}

	public Article getForPrintArticle(int id) {
		return getForPrintArticle(id, null);
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

	public int getArticlesCountByBoardId(int boardId, String searchKeyword, String searchKeywordType) {
		return articleDao.getArticlesCountByBoardId(boardId, searchKeyword, searchKeywordType);
	}

	public int increaseHitsCount(int id) {
		return articleDao.increaseHitsCount(id);
	}

	public List<Article> getArticlesForMainByBoardId(int boardId) {
		return articleDao.getArticlesForMainByBoardId(boardId);
	}

	public Article getForPrintArticle(int id, Member actor) {
		Article article = articleDao.getForPrintArticle(id);

		if (article == null) {
			return null;
		}
		if (actor != null) {
			updateInfoForPrint(article, actor);
		}
		return article;
	}

	private void updateInfoForPrint(Article article, Member actor) {
		boolean actorCanLike = likeService.actorCanLike(article, actor);
		boolean actorCanCancelLike = likeService.actorCanCancelLike(article, actor);
		boolean actorCanDislike = likeService.actorCanDislike(article, actor);
		boolean actorCanCancelDislike = likeService.actorCanCancelDislike(article, actor);

		article.getExtra().put("actorCanLike", actorCanLike);
		article.getExtra().put("actorCanCancelLike", actorCanCancelLike);
		article.getExtra().put("actorCanDislike", actorCanDislike);
		article.getExtra().put("actorCanCancelDislike", actorCanCancelDislike);

	}

	public List<Article> getArticlesForMainOrderByLikeCnt() {
		return articleDao.getArticlesForMainOrderByLikeCnt();
	}

	public int getArticlesCountByMemberId(int loginedMemberId) {
		return articleDao.getArticlesCountByMemberId(loginedMemberId);
	}

	public List<Article> getForPrintArticlesByMemberId(int loginedMemberId, int limitStart, int itemsInAPage) {
		return articleDao.getForPrintArticlesByMemberId(loginedMemberId, limitStart, itemsInAPage);
	}

}
