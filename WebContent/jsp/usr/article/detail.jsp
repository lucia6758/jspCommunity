<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name} 게시물 상세페이지" />
<%@ include file="../../part/head.jspf"%>
<section class="pageTitle">
	<h1>${pageTitle}</h1>
</section>

<div>
	번호 : ${article.id}
	<br />
	작성날짜 : ${article.regDate}
	<br />
	수정날짜 : ${article.updateDate}
	<br />
	작성자 : ${article.extra__writer}
	<br />
	조회수 : ${article.hitsCount}
	<br />
	제목 : ${article.title}
	<br />
	내용 : ${article.body}
</div>
<hr />
<div>
	<a href="list?boardId=${article.boardId}">목록</a>
	<c:if test="${sessionScope.loginedMemberId == article.memberId }">
		<a href="modify?memberId=1&id=${article.id}">수정</a>
		<a onclick="if (confirm('정말 삭제하시겠습니까?') == false) {return false;}"
			href="doDelete?memberId=1&id=${article.id}">삭제</a>
	</c:if>
</div>
<%@ include file="../../part/foot.jspf"%>
