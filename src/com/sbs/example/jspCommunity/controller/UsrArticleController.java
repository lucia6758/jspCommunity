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

public class UsrArticleController extends Controller {
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
		int id = Util.getAsInt(req.getParameter("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "게시물 번호를 입력해주세요.");
		}

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			return msgAndBack(req, id + "번 게시물이 존재하지 않습니다.");
		}

		articleService.increaseHitsCount(id);

		req.setAttribute("article", article);

		return "usr/article/detail";
	}

	public String write(HttpServletRequest req, HttpServletResponse resp) {
		int boardId = Util.getAsInt(req.getParameter("boardId"), 0);

		if (boardId == 0) {
			return msgAndBack(req, "게시판 번호를 입력해주세요.");
		}

		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return msgAndBack(req, boardId + "번 게시판이 존재하지 않습니다.");
		}

		req.setAttribute("board", board);

		return "usr/article/write";
	}

	public String doWrite(HttpServletRequest req, HttpServletResponse resp) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		String title = req.getParameter("title");
		String body = req.getParameter("body");
		int boardId = Util.getAsInt(req.getParameter("boardId"), 0);

		if (Util.isEmpty(title)) {
			return msgAndBack(req, "제목을 입력해주세요.");
		}

		if (Util.isEmpty(body)) {
			return msgAndBack(req, "내용을 입력해주세요.");
		}

		if (boardId == 0) {
			return msgAndBack(req, "게시판 번호를 입력해주세요.");
		}

		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return msgAndBack(req, boardId + "번 게시판이 존재하지 않습니다.");
		}

		int id = articleService.doWrite(loginedMemberId, title, body, boardId);

		return magAndReplace(req, id + "번 게시물이 생성되었습니다.", String.format("detail?id=%d", id));
	}

	public String modify(HttpServletRequest req, HttpServletResponse resp) {
		int id = Util.getAsInt(req.getParameter("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "게시물 번호를 입력해주세요.");
		}

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			return msgAndBack(req, id + "번 게시물이 존재하지 않습니다.");
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (article.getMemberId() != loginedMemberId) {
			return msgAndBack(req, "수정할 권한이 없습니다.");
		}

		req.setAttribute("article", article);

		return "usr/article/modify";
	}

	public String doModify(HttpServletRequest req, HttpServletResponse resp) {
		int id = Util.getAsInt(req.getParameter("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "게시물 번호를 입력해주세요.");
		}

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			return msgAndBack(req, id + "번 게시물이 존재하지 않습니다.");
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (article.getMemberId() != loginedMemberId) {
			return msgAndBack(req, "수정할 권한이 없습니다.");
		}

		String title = req.getParameter("title");
		String body = req.getParameter("body");

		if (Util.isEmpty(title)) {
			return msgAndBack(req, "제목을 입력해주세요.");
		}

		if (Util.isEmpty(body)) {
			return msgAndBack(req, "내용을 입력해주세요.");
		}

		Map<String, Object> modifyArgs = new HashMap<>();
		modifyArgs.put("id", id);
		modifyArgs.put("title", title);
		modifyArgs.put("body", body);

		articleService.doModify(modifyArgs);

		return magAndReplace(req, id + "번 게시물이 수정되었습니다.", String.format("detail?id=%d", id));
	}

	public String doDelete(HttpServletRequest req, HttpServletResponse resp) {
		int id = Util.getAsInt(req.getParameter("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "게시물 번호를 입력해주세요.");
		}

		Article article = Container.articleService.getForPrintArticle(id);

		if (article == null) {
			return msgAndBack(req, id + "번 게시물이 존재하지 않습니다.");
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (article.getMemberId() != loginedMemberId) {
			return msgAndBack(req, "삭제할 권한이 없습니다.");
		}

		articleService.delete(id);

		return magAndReplace(req, id + "번 게시물이 삭제되었습니다.", String.format("list?boardId=%d", article.getBoardId()));
	}

}
