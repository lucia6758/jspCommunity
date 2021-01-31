package com.sbs.example.jspCommunity.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dto.Board;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.jspCommunity.util.Util;

public class UsrArticleController {
	private ArticleService articleService;

	public UsrArticleController() {
		articleService = Container.articleService;
	}

	public String showList(HttpServletRequest req, HttpServletResponse resp) {
		String searchKeyword = req.getParameter("searchKeyword");
		String searchKeywordType = req.getParameter("searchKeywordType");

		int itemsInAPage = 20;
		int page = Util.getAsInt(req.getParameter("page"), 1);
		int limitStart = (page - 1) * itemsInAPage;

		int boardId = Integer.parseInt(req.getParameter("boardId"));

		Board board = articleService.getBoardById(boardId);

		int totalCount = articleService.getArticlesCountByBoardId(boardId, searchKeyword, searchKeywordType);
		List<Article> articles = articleService.getForPrintArticlesByBoardId(boardId, limitStart, itemsInAPage,
				searchKeyword, searchKeywordType);

		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);
		int pagesInAList = 10;
		int pageBoundary = page / pagesInAList;
		if (page % pagesInAList == 0) {
			pageBoundary = page / pagesInAList - 1;
		}
		int startPage = 1 + pagesInAList * pageBoundary;
		int endPage = startPage + pagesInAList - 1;
		if (endPage >= totalPage) {
			endPage = totalPage;
		}

		int pageBefore = startPage - 1;
		if (pageBefore < 1) {
			pageBefore = 1;
		}

		int pageAfter = endPage + 1;
		if (pageAfter > totalPage) {
			pageAfter = totalPage;
		}

		boolean pageBeforeBtnNeedToShow = pageBefore != startPage;
		boolean pageAfterBtnNeedToShow = pageAfter != endPage;

		req.setAttribute("currentPage", page);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("pageBefore", pageBefore);
		req.setAttribute("pageAfter", pageAfter);
		req.setAttribute("pageBeforeBtnNeedToShow", pageBeforeBtnNeedToShow);
		req.setAttribute("pageAfterBtnNeedToShow", pageAfterBtnNeedToShow);

		req.setAttribute("board", board);
		req.setAttribute("articles", articles);
		req.setAttribute("totalCount", totalCount);

		return "usr/article/list";

	}

	public String showDetail(HttpServletRequest req, HttpServletResponse resp) {
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			req.setAttribute("alertMsg", id + "번 게시물이 존재하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}
		
		articleService.increaseHitsCount(id);

		req.setAttribute("article", article);

		return "usr/article/detail";
	}

	public String write(HttpServletRequest req, HttpServletResponse resp) {
		int boardId = Integer.parseInt(req.getParameter("boardId"));

		Board board = articleService.getBoardById(boardId);

		req.setAttribute("board", board);

		return "usr/article/write";
	}

	public String doWrite(HttpServletRequest req, HttpServletResponse resp) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		String title = req.getParameter("title");
		String body = req.getParameter("body");
		int boardId = Integer.parseInt(req.getParameter("boardId"));

		int id = articleService.doWrite(loginedMemberId, title, body, boardId);

		req.setAttribute("alertMsg", id + "번 게시물이 생성되었습니다.");
		req.setAttribute("replaceUrl", String.format("detail?id=%d", id));

		return "common/redirect";
	}

	public String modify(HttpServletRequest req, HttpServletResponse resp) {
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			req.setAttribute("alertMsg", id + "번 게시물이 존재하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (article.getMemberId() != loginedMemberId) {
			req.setAttribute("alertMsg", "수정할 권한이 없습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		req.setAttribute("article", article);

		return "usr/article/modify";
	}

	public String doModify(HttpServletRequest req, HttpServletResponse resp) {
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			req.setAttribute("alertMsg", id + "번 게시물이 존재하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (article.getMemberId() != loginedMemberId) {
			req.setAttribute("alertMsg", "수정할 권한이 없습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		String title = req.getParameter("title");
		String body = req.getParameter("body");

		Map<String, Object> modifyArgs = new HashMap<>();
		modifyArgs.put("id", id);
		modifyArgs.put("title", title);
		modifyArgs.put("body", body);

		articleService.doModify(modifyArgs);

		req.setAttribute("alertMsg", id + "번 게시물이 수정되었습니다.");
		req.setAttribute("replaceUrl", String.format("detail?id=%d", id));

		return "common/redirect";
	}

	public String doDelete(HttpServletRequest req, HttpServletResponse resp) {
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = Container.articleService.getForPrintArticle(id);

		if (article == null) {
			req.setAttribute("alertMsg", id + "번 게시물이 존재하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (article.getMemberId() != loginedMemberId) {
			req.setAttribute("alertMsg", "삭제할 권한이 없습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		articleService.delete(id);

		req.setAttribute("alertMsg", id + "번 게시물이 삭제되었습니다.");
		req.setAttribute("replaceUrl", String.format("list?boardId=%d", article.getBoardId()));

		return "common/redirect";
	}

}
