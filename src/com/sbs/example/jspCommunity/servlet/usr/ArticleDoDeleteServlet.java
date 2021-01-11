package com.sbs.example.jspCommunity.servlet.usr;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.mysqlutil.MysqlUtil;

@WebServlet("/usr/article/doDelete")
public class ArticleDoDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		if (req.getParameter("memberId") == null) {
			resp.getWriter().append("memberId를 입력해주세요.");
			return;
		}
		if (req.getParameter("id") == null) {
			resp.getWriter().append("삭제할 게시물의 id를 입력해주세요.");
			return;
		}

		int memberId = Integer.parseInt(req.getParameter("memberId"));
		int id = Integer.parseInt(req.getParameter("id"));

		MysqlUtil.setDBInfo("localhost", "sbsst", "sbs123414", "jspCommunity");

		Container.articleService.delete(id);

		MysqlUtil.closeConnection();

		req.setAttribute("id", id);

		RequestDispatcher rd = req.getRequestDispatcher("/jsp/usr/article/doDelete.jsp");
		rd.forward(req, resp);
	}

}
