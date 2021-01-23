<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name}" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/list.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="article-list con-min-width">
	<div class="con">
		<ul class="list_top flex">
			<li class="list_id">번호</li>
			<li class="list_title">제목</li>
			<li class="list_writer">작성자</li>
			<li class="list_date">작성일</li>
		</ul>
		<c:forEach items="${articles}" var="article">
			<ul class="list_article flex">
				<li class="list_id">${article.id}</li>
				<li class="list_title">
					<a href="detail?id=${article.id}">${article.title}</a>
				</li>
				<li class="list_writer">${article.extra__writer}</li>
				<li class="list_date">${article.regDate}</li>
			</ul>
		</c:forEach>
		<div class="write-btn flex flex-jc-e">
			<a href="write?memberId=1&boardId=${param.boardId}">글쓰기</a>
		</div>
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>