<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name} 게시물 상세페이지" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/detail.css" />
<section class="pageTitle con-min-width padding-0-10">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="article-detail con-min-width padding-0-10">
	<div class="con">
		<div class="detail-title">${article.title}</div>
		<div class="detail-info flex">
			<div>번호 : ${article.id}</div>
			<div>작성자 : ${article.extra__writer}</div>
			<div>작성일 : ${article.regDate}</div>
			<div>수정일 : ${article.updateDate}</div>
			<div>조회수 : ${article.hitsCount+1}</div>
		</div>
		<script type="text/x-template">${article.body}</script>
		<div class="detail-body toast-ui-viewer"></div>
		<div class="detail-reply">
			<form action="../reply/doWrite" method="POST">
				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${param.id}" />
				<div>
					<input type="text" name="body" placeholder="댓글을 입력해주세요" />
					<input type="submit" value="등록" />
				</div>
			</form>
			<div class="showReply">
				<table>
					<colgroup>
						<col width="150"></col>
						<col width=""></col>
						<col width="150"></col>
						<col width="30"></col>
					</colgroup>
					<c:forEach items="${replies}" var="reply">
						<tr>
							<td>${reply.extra__writer}</td>
							<td>${reply.body}</td>
							<td>${reply.regDate}</td>
							<td class="flex">
								<a href="../reply/modify?id=${reply.id}">
									<i class="fas fa-edit"></i>
								</a>
								<a href="../reply/doDelete?id=${reply.id}">
									<i class="fas fa-trash-alt"></i>
								</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="btn-wrap flex flex-jc-e">
			<c:if test="${sessionScope.loginedMemberId == article.memberId}">
				<a href="modify?memberId=1&id=${article.id}">수정</a>
				<a onclick="if (confirm('정말 삭제하시겠습니까?') == false) {return false;}"
					href="doDelete?memberId=1&id=${article.id}">삭제</a>
			</c:if>
			<a href="list?boardId=${article.boardId}">목록</a>
		</div>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>
