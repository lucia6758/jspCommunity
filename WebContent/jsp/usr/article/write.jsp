<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<c:set var="pageTitle" value="${board.name} 게시물 작성" />
<%@ include file="../../part/head.jspf" %>
	<h1>${pageTitle}</h1>

	<form action="doWrite" method="POST">
		<input type="hidden" name="boardId" value="${board.id}">
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