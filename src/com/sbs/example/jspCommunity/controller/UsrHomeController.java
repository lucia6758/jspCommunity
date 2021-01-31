package com.sbs.example.jspCommunity.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;

public class UsrHomeController {

	public String showMain(HttpServletRequest req, HttpServletResponse resp) {
		int boardId = 2;
		List<Article> articles = Container.articleService.getArticlesForMainByBoardId(boardId);
		
		req.setAttribute("articles", articles);

		return "usr/home/main";
	}

}
