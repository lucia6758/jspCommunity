<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.sbs.example.jspCommunity.dto.Article"%>
<%
int memberId = (int) request.getAttribute("memberId");
int id = (int) request.getAttribute("id");
Article article = (Article) request.getAttribute("article");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>게시물 수정</title>
</head>
<body>
	<h1>게시물 수정</h1>

	<form action="/jspCommunity/usr/article/doModify">
		<input type="hidden" name="memberId" value=<%=memberId %>>
		<input type="hidden" name="id" value=<%=id %>>
		<input type="text" name="title" value=<%=article.title %> maxlength="100">
		<hr />
		<textarea name="body" maxlength="1000"><%=article.body %></textarea>
		<br>
		<input type="submit" value="수정">
	</form>
</body>
</html>