package com.sbs.example.jspCommunity.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dto.Board;
import com.sbs.example.jspCommunity.service.ArticleService;

public class UsrArticleController {
	private ArticleService articleService;

	public UsrArticleController() {
		articleService = Container.articleService;
	}

	public String showList(HttpServletRequest req, HttpServletResponse resp) {
		int boardId = Integer.parseInt(req.getParameter("boardId"));

		Board board = articleService.getBoardById(boardId);

		List<Article> articles = articleService.getForPrintArticlesByBoardId(boardId);

		req.setAttribute("board", board);
		req.setAttribute("articles", articles);

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

		req.setAttribute("article", article);

		return "usr/article/detail";
	}

	public String write(HttpServletRequest req, HttpServletResponse resp) {
		int memberId = Integer.parseInt(req.getParameter("memberId"));
		int boardId = Integer.parseInt(req.getParameter("boardId"));

		Board board = articleService.getBoardById(boardId);

		req.setAttribute("board", board);
		req.setAttribute("memberId", memberId);

		return "usr/article/write";
	}

	public String doWrite(HttpServletRequest req, HttpServletResponse resp) {
		int memberId = Integer.parseInt(req.getParameter("memberId"));
		String title = req.getParameter("title");
		String body = req.getParameter("body");
		int boardId = Integer.parseInt(req.getParameter("boardId"));

		int id = articleService.doWrite(memberId, title, body, boardId);

		req.setAttribute("alertMsg", id + "번 게시물이 생성되었습니다.");
		req.setAttribute("replaceUrl", String.format("detail?id=%d", id));

		return "common/redirect";
	}

	public String modify(HttpServletRequest req, HttpServletResponse resp) {
		int memberId = Integer.parseInt(req.getParameter("memberId"));
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			req.setAttribute("alertMsg", id + "번 게시물이 존재하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		req.setAttribute("memberId", memberId);
		req.setAttribute("id", id);
		req.setAttribute("article", article);

		return "usr/article/modify";
	}

	public String doModify(HttpServletRequest req, HttpServletResponse resp) {
		int memberId = Integer.parseInt(req.getParameter("memberId"));
		String title = req.getParameter("title");
		String body = req.getParameter("body");
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			req.setAttribute("alertMsg", id + "번 게시물이 존재하지 않습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}
		
		if (article.getMemberId() != memberId) {
			req.setAttribute("alertMsg", id + "번 게시물을 수정할 권한이 없습니다.");
			req.setAttribute("historyBack", true);
			return "common/redirect";
		}

		articleService.doModify(memberId, id, title, body);

		req.setAttribute("alertMsg", id + "번 게시물이 수정되었습니다.");
		req.setAttribute("replaceUrl", String.format("detail?id=%d", id));

		return "common/redirect";
	}

	public String doDelete(HttpServletRequest req, HttpServletResponse resp) {
		int memberId = Integer.parseInt(req.getParameter("memberId"));
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = Container.articleService.getForPrintArticle(id);

		articleService.delete(id);

		req.setAttribute("alertMsg", id + "번 게시물이 삭제되었습니다.");
		req.setAttribute("replaceUrl", String.format("list?boardId=%d", article.getBoardId()));

		return "common/redirect";
	}

}
