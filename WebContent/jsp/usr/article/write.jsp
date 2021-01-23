<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name} 게시물 작성" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/write.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="article-write con-min-width">
	<div class="con">
		<form action="doWrite" method="POST">
			<input type="hidden" name="boardId" value="${board.id}">
			<div>
				<div>
					제목 <input type="text" name="title" placeholder="제목을 입력해주세요"
						maxlength="50">
				</div>
				<hr />
				<div>
					내용 <textarea name="body" placeholder="내용을 입력해주세요" maxlength="5000"></textarea>
				</div>
				<br>
				<div>
					<input class="submit" type="submit" value="작성">
					<button type="button" onclick="history.back();">취소</button>
				</div>
			</div>
		</form>
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>