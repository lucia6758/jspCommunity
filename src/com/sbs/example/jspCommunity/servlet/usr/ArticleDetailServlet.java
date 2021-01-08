package com.sbs.example.jspCommunity.servlet.usr;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.mysqlutil.MysqlUtil;

@WebServlet("/usr/article/detail")
public class ArticleDetailServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		if (req.getParameter("id") == null) {
			resp.getWriter().append("id를 입력해주세요.");
			return;
		}

		int id = Integer.parseInt(req.getParameter("id"));

		MysqlUtil.setDBInfo("localhost", "sbsst", "sbs123414", "jspCommunity");

		ArticleService articleService = Container.articleService;
		Article article = articleService.getForPrintArticle(id);

		MysqlUtil.closeConnection();

		req.setAttribute("article", article);

		RequestDispatcher rd = req.getRequestDispatcher("/jsp/usr/article/detail.jsp");
		rd.forward(req, resp);
	}

}
