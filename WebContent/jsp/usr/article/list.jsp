<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.Article"%>
<%@ page import="com.sbs.example.jspCommunity.dto.Board"%>
<%
Board board = (Board) request.getAttribute("board");
List<Article> articles = (List<Article>) request.getAttribute("articles");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title><%=board.getName()%> 게시물 리스트
</title>
</head>
<body>
	<h1><%=board.getName()%> 게시물 리스트</h1>
	<div>
		<a href="write?memberId=1&boardId=<%=request.getParameter("boardId")%>">글쓰기</a>
	</div>
	<%
	for (Article article : articles) {
	%>
	<div>
		번호 :
		<%=article.getId()%>
		<br />
		작성날짜 :
		<%=article.getRegDate()%>
		<br />
		수정날짜 :
		<%=article.getUpdateDate()%>
		<br />
		작성자 :
		<%=article.getExtra__writer()%>
		<br />
		제목 :
		<a href="detail?id=<%=article.getId()%>"><%=article.getTitle()%></a>
		<hr />
	</div>
	<%
	}
	%>
</body>
</html>