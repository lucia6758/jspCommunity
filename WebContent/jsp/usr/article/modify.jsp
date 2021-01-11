<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int memberId = (int) request.getAttribute("memberId");
int id = (int) request.getAttribute("id");
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
		<input type="text" name="title" placeholder="수정할 제목을 입력해주세요" maxlength="100">
		<hr />
		<textarea name="body" placeholder="내용을 입력해주세요" maxlength="1000"></textarea>
		<br>
		<input type="submit" value="전송">
	</form>
</body>
</html>