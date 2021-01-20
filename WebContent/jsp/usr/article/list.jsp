<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../../part/head.jspf"%>
<section class="pageTitle">
	<h1>${pageTitle}</h1>
</section>

<c:forEach items="${articles}" var="article">
	<div>
		번호 : ${article.id}
		<br />
		작성날짜 : ${article.regDate}
		<br />
		작성자 : ${article.extra__writer}
		<br />
		제목 :
		<a href="detail?id=${article.id}">${article.title}</a>
		<hr />
	</div>
</c:forEach>
<div>
	<a href="write?memberId=1&boardId=${param.boardId}">글쓰기</a>
</div>
<%@ include file="../../part/foot.jspf"%>