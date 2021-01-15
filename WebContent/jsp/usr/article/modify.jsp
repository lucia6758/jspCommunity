<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.sbs.example.jspCommunity.dto.Article"%>
<%
int memberId = (int) request.getAttribute("memberId");
int id = (int) request.getAttribute("id");
Article article = (Article) request.getAttribute("article");
String pageTitle = "게시물 수정";
%>
<%@ include file="../../part/head.jspf" %>
	<h1><%=pageTitle%></h1>

	<form action="doModify" method="POST">
		<input type="hidden" name="memberId" value=<%=memberId%>>
		<input type="hidden" name="id" value=<%=id%>>
		<input type="text" name="title" placeholder="제목을 입력해주세요" value=<%=article.getTitle()%>
			maxlength="50">
		<hr />
		<textarea name="body" placeholder="내용을 입력해주세요" maxlength="1000"><%=article.getBody()%></textarea>
		<br>
		<input type="submit" value="수정">
		<button type="button" onclick="history.back();">뒤로가기</button>
	</form>
<%@ include file="../../part/foot.jspf" %>