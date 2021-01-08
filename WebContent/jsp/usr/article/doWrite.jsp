<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.Article"%>
<%
int id = (int) request.getAttribute("id");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>게시물 작성</title>
</head>
<body>
	<h1>게시물 작성 내용</h1>
	
	<div>
		<%=id %>번 글이 작성되었습니다.
		<hr />
	</div>
	
</body>
</html>