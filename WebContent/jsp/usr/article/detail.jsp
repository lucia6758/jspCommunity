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
			<table>
				<colgroup>
					<col width=200px>
					<col width=400px>
					<col width=200px>
				</colgroup>
				<tr>
					<td>번호 : ${article.id}</td>
					<td>작성일 : ${article.regDate}</td>
					<td>조회수 : ${article.hitsCount+1}</td>
				</tr>
				<tr>
					<td>작성자: ${article.extra__writer}</td>
					<td>수정일 : ${article.updateDate}</td>
					<td>
						<i class="far fa-grin-hearts"></i>
						${article.extra__likeOnlyPoint}
						<i class="far fa-frown"></i>
						${article.extra__dislikeOnlyPoint}
					</td>
				</tr>
			</table>
		</div>
		<script type="text/x-template">${article.body}</script>
		<div class="detail-body toast-ui-viewer"></div>
		<div class="detail-like flex flex-jc-c">
			<c:if test="${article.extra.actorCanLike}">
				<a class="like-btn"
					href="../like/doLike?relTypeCode=article&relId=${article.id}&redirectUrl=${encodedCurrentUrl}"
					onclick="if ( !confirm('좋아요를 누르시겠습니까?') ) return false;">
					<span>😍</span>
					<span>좋아요</span>
				</a>
			</c:if>
			<c:if test="${article.extra.actorCanCancelLike}">
				<a class="like-btn"
					href="../like/doCancelLike?relTypeCode=article&relId=${article.id}&redirectUrl=${encodedCurrentUrl}"
					onclick="if ( !confirm('좋아요를 취소하시겠습니까?') ) return false;">
					<span>😍</span>
					<span>좋아요 취소</span>
				</a>
			</c:if>
			<c:if test="${article.extra.actorCanDislike}">
				<a class="dislike-btn"
					href="../like/doDislike?relTypeCode=article&relId=${article.id}&redirectUrl=${encodedCurrentUrl}"
					onclick="if ( !confirm('싫어요를 누르시겠습니까?') ) return false;">
					<span>🙁</span>
					<span>싫어요</span>
				</a>
			</c:if>
			<c:if test="${article.extra.actorCanCancelDislike}">
				<a class="dislike-btn"
					href="../like/doCancelDislike?relTypeCode=article&relId=${article.id}&redirectUrl=${encodedCurrentUrl}"
					onclick="if ( !confirm('싫어요를 취소하시겠습니까?') ) return false;">
					<span>🙁</span>
					<span>싫어요 취소</span>
				</a>
			</c:if>
		</div>
		<div class="detail-reply">
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
							<td class="reply-regDate">${reply.regDate}</td>
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
			<c:if test="${isLogined == false}">
			<span><i class="fas fa-exclamation-circle"></i> 로그인 후에 댓글을 작성할 수 있습니다.</span>
			</c:if>
			<c:if test="${isLogined}">
				<form action="../reply/doWrite" method="POST">
					<input type="hidden" name="relTypeCode" value="article" />
					<input type="hidden" name="relId" value="${param.id}" />
					<div>
						<input type="text" name="body" placeholder="댓글을 입력해주세요" />
						<input type="submit" value="등록" />
					</div>
				</form>
			</c:if>
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
