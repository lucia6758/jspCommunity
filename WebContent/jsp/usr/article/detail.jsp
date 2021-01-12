<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.Article"%>
<%
Article article = (Article) request.getAttribute("article");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>게시물 상세</title>
</head>
<body>
	<h1>게시물 상세</h1>
	
	<div>
		번호 :
		<%=article.id%>
		<br />
		작성날짜 :
		<%=article.regDate%>
		<br />
		수정날짜 :
		<%=article.updateDate%>
		<br />
		게시판 :
		<%=article.extra__boardName%>
		<br />
		작성자 :
		<%=article.extra__writer%>
		<br />
		조회수 :
		<%=article.hitsCount%>
		<br />
		제목 :
		<%=article.title%>
		<br />
		내용 :
		<%=article.body%>
	</div>
	<hr />
	<div>
		<a href="list?boardId=<%=article.boardId%>">목록</a>
		<a href="modify?memberId=1&id=<%=article.id%>">수정</a>
		<a href="delete?memberId=1&id=<%=article.id%>">삭제</a>
	</div>
	
</body>
</html>