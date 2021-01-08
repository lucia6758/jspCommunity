package com.sbs.example.jspCommunity.servlet.usr;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.mysqlutil.MysqlUtil;

@WebServlet("/usr/article/doWrite")
public class ArticleWriteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		if (req.getParameter("memberId") == null) {
			resp.getWriter().append("memberId를 입력해주세요.");
			return;
		}
		if (req.getParameter("title") == null) {
			resp.getWriter().append("제목을 입력해주세요.");
			return;
		}
		if (req.getParameter("body") == null) {
			resp.getWriter().append("내용을 입력해주세요.");
			return;
		}
		if (req.getParameter("boardId") == null) {
			resp.getWriter().append("boardId를 입력해주세요.");
			return;
		}

		int memberId = Integer.parseInt(req.getParameter("memberId"));
		String title = req.getParameter("title");
		String body = req.getParameter("body");
		int boardId = Integer.parseInt(req.getParameter("boardId"));

		MysqlUtil.setDBInfo("localhost", "sbsst", "sbs123414", "jspCommunity");

		int id = Container.articleService.doWrite(memberId, title, body, boardId);

		MysqlUtil.closeConnection();

		req.setAttribute("id", id);

		RequestDispatcher rd = req.getRequestDispatcher("/jsp/usr/article/doWrite.jsp");
		rd.forward(req, resp);
	}

}
