package com.sbs.example.jspCommunity.controller.usr;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.service.ArticleService;

public class ArticleController {
	private ArticleService articleService;

	public ArticleController() {
		articleService = Container.articleService;
	}

	public String showList(HttpServletRequest req, HttpServletResponse resp) {
		int boardId = Integer.parseInt(req.getParameter("boardId"));

		List<Article> articles = articleService.getForPrintArticlesByBoardId(boardId);

		req.setAttribute("articles", articles);

		return "usr/article/list";

	}

	public String showDetail(HttpServletRequest req, HttpServletResponse resp) {
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = Container.articleService.getForPrintArticle(id);

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

		req.setAttribute("memberId", memberId);
		req.setAttribute("boardId", boardId);

		return "usr/article/write";
	}

	public String doWrite(HttpServletRequest req, HttpServletResponse resp) {
		int memberId = Integer.parseInt(req.getParameter("memberId"));
		String title = req.getParameter("title");
		String body = req.getParameter("body");
		int boardId = Integer.parseInt(req.getParameter("boardId"));

		int id = Container.articleService.doWrite(memberId, title, body, boardId);

		req.setAttribute("id", id);

		return "usr/article/doWrite";
	}

	public String modify(HttpServletRequest req, HttpServletResponse resp) {
		int memberId = Integer.parseInt(req.getParameter("memberId"));
		int id = Integer.parseInt(req.getParameter("id"));

		Article article = Container.articleService.getForPrintArticle(id);

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

		Container.articleService.doModify(memberId, id, title, body);

		req.setAttribute("id", id);

		return "usr/article/doModify";
	}

	public String doDelete(HttpServletRequest req, HttpServletResponse resp) {
		int memberId = Integer.parseInt(req.getParameter("memberId"));
		int id = Integer.parseInt(req.getParameter("id"));

		Container.articleService.delete(id);

		req.setAttribute("id", id);

		return "usr/article/doDelete";
	}

}
