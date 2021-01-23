<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name} 게시물 상세페이지" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/detail.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="article-detail con-min-width">
	<div class="con">
		<div class="detail-title">${article.title}</div>
		<div class="detail-info flex">
			<div>번호 : ${article.id}</div>
			<div>작성자 : ${article.extra__writer}</div>
			<div>작성일 : ${article.regDate}</div>
			<div>수정일 : ${article.updateDate}</div>
			<div>조회수 : ${article.hitsCount}</div>
		</div>
		<div class="detail-body">${article.body}</div>
		<div class="detail-btn">
			<a href="list?boardId=${article.boardId}">목록</a>
			<c:if test="${sessionScope.loginedMemberId == article.memberId }">
				<a href="modify?memberId=1&id=${article.id}">수정</a>
				<a onclick="if (confirm('정말 삭제하시겠습니까?') == false) {return false;}"
					href="doDelete?memberId=1&id=${article.id}">삭제</a>
			</c:if>
		</div>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>
