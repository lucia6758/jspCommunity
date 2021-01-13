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
		<%=article.getId()%>
		<br />
		작성날짜 :
		<%=article.getRegDate()%>
		<br />
		수정날짜 :
		<%=article.getUpdateDate()%>
		<br />
		게시판 :
		<%=article.getExtra__boardName()%>
		<br />
		작성자 :
		<%=article.getExtra__writer()%>
		<br />
		조회수 :
		<%=article.getHitsCount()%>
		<br />
		제목 :
		<%=article.getTitle()%>
		<br />
		내용 :
		<%=article.getBody()%>
	</div>
	<hr />
	<div>
		<a href="list?boardId=<%=article.getBoardId()%>">목록</a>
		<a href="modify?memberId=1&id=<%=article.getId()%>">수정</a>
		<a href="delete?memberId=1&id=<%=article.getId()%>">삭제</a>
	</div>
	
</body>
</html>