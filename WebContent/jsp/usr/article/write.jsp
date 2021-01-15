<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.sbs.example.jspCommunity.dto.Board"%>
<%
int memberId = (int) request.getAttribute("memberId");
Board board = (Board) request.getAttribute("board");
String pageTitle = board.getName() + " 게시물 작성";
%>
<%@ include file="../../part/head.jspf" %>
	<h1>게시물 작성</h1>

	<form action="doWrite" method="POST">
		<input type="hidden" name="memberId" value=<%=memberId%>>
		<input type="hidden" name="boardId" value=<%=board.getId()%>>
		<div>
			<div>
				<input type="text" name="title" placeholder="제목을 입력해주세요"
					maxlength="50">
			</div>
			<hr />
			<div>
				<textarea name="body" placeholder="내용을 입력해주세요" maxlength="5000"></textarea>
			</div>
			<br>
			<div>
				<input type="submit" value="작성">
				<button type="button" onclick="history.back();">취소</button>
			</div>

		</div>
	</form>
<%@ include file="../../part/foot.jspf" %>