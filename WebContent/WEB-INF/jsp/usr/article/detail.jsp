<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="${article.extra__boardName}" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/detail.css" />
<section class="pageTitle con-min-width padding-0-10">
	<h1 class="con">${pageTitle}</h1>
</section>

<script>
function modifyReply(form){
	form.body.value = form.body.value.trim();
	if (form.body.value.length == 0) {
		    alert("내용을 입력해주세요");
		    form.body.focus();
		    return;
	}
		  
	let $div = $(form).closest('div.reply1');
		  
	$div.attr('data-modify-mode', 'off');
		  
	let newBody = form.body.value;
	let id = parseInt(form.id.value);
		  
	$.post('../reply/doModify', {
		id: id,
		body: newBody
	}, function(data){
		if(data.resultCode.substr(0,2) == 'S-'){
		  	$div.find('>.modify-mode-invisible').empty().append(newBody);
		 } else {
		  	alert(data.msg);
		  	}
		 }, 'json');
}

function replyModifyMode_off(el) {
	let $div = $(el).closest('div.reply1');
	
	$div.attr('data-modify-mode', 'off');
}

function replyModifyMode_on(el) {
	let $div = $(el).closest('div.reply1');
	let body = $div.find('>.modify-mode-invisible').html().trim();
	
	$div.find('>.modify-mode-visible > form > input[type="text"]').val(body);
	
	$div.attr('data-modify-mode', 'on');
	$div.siblings('[data-modify-mode="on"]').attr('data-modify-mode', 'off');
}

</script>
<section class="article-detail con-min-width padding-0-10">
	<div class="con">
		<div class="detail-title">${article.title}</div>
		<div class="detail-info visible-md-up flex">
			<table>
				<colgroup>
					<col width=200px>
					<col width=300px>
					<col width=200px>
				</colgroup>
				<tr>
					<td>번호 : ${article.id}</td>
					<td>
						작성일 :
						<fmt:parseDate value="${article.regDate}" var="regDate"
							pattern="yyyy-MM-dd HH:mm:ss" />
						<fmt:formatDate value="${regDate}" pattern="yyyy.MM.dd HH:mm" />
					</td>
					<td>조회수 : ${article.hitsCount+1}</td>
				</tr>
				<tr>
					<td>작성자: ${article.extra__writer}</td>
					<td>
						수정일 :
						<fmt:parseDate value="${article.updateDate}" var="updateDate"
							pattern="yyyy-MM-dd HH:mm:ss" />
						<fmt:formatDate value="${updateDate}" pattern="yyyy.MM.dd HH:mm" />
					</td>
					<td>
						<i class="far fa-grin-hearts"></i>
						${article.extra__likeOnlyPoint}
						<i class="far fa-frown"></i>
						${article.extra__dislikeOnlyPoint}
					</td>
				</tr>
			</table>
		</div>
		<div class="detail-info-mobile visible-sm-down">
			<div>${article.extra__writer}</div>
			<div>
				<fmt:formatDate value="${regDate}" pattern="yyyy.MM.dd HH:mm" />
			</div>
			<div>
				<span>
					<i class="far fa-eye"></i>
					${article.hitsCount+1}
				</span>
				<span>
					<i class="far fa-grin-hearts"></i>
					${article.extra__likeOnlyPoint}
				</span>
				<span>
					<i class="far fa-frown"></i>
					${article.extra__dislikeOnlyPoint}
				</span>
			</div>
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
			<div class="replyCnt flex">
				<span>댓글 ${article.extra__replyCount}</span>
			</div>
			<div class="showReply">
				<c:forEach items="${replies}" var="reply">
					<div class="reply1" data-modify-mode="off">
						<div>
							<span class="reply-writer">${reply.extra__writer}</span>
						</div>
						<div class="modify-mode-invisible">${reply.body}</div>
						<div class="modify-mode-visible">
							<form action="doModify" method="POST"
								onsubmit="modifyReply(this); return false;">
								<input type="hidden" name="id" value="${reply.id}">
								<div>
									<input type="text" name="body" placeholder="내용을 입력해주세요"
										value="${reply.body}">
								</div>
								<br>
								<div class="btn-wrap flex flex-jc-c">
									<input type="submit" value="수정">
									<a href="javascript:;" onclick="replyModifyMode_off(this);">취소</a>
								</div>
							</form>
						</div>
						<div class="modify-mode-invisible">
							<span class="reply-regDate">
								<fmt:parseDate value="${reply.regDate}" var="replyRegDate"
									pattern="yyyy-MM-dd HH:mm:ss" />
								<fmt:formatDate value="${replyRegDate}"
									pattern="yyyy.MM.dd HH:mm" />
							</span>
							<c:if test="${sessionScope.loginedMemberId == reply.memberId}">
								<a href="javascript:;" onclick="replyModifyMode_on(this);">
									<i class="fas fa-edit"></i>
								</a>
								<a
									onclick="if (confirm('정말 삭제하시겠습니까?') == false) {return false;}"
									href="../reply/doDelete?id=${reply.id}">
									<i class="fas fa-trash-alt"></i>
								</a>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
			<c:if test="${isLogined == false}">
				<span>
					<i class="fas fa-exclamation-circle"></i>
					로그인 후에 댓글을 작성할 수 있습니다.
				</span>
			</c:if>
			<c:if test="${isLogined}">
				<form action="../reply/doWrite" method="POST">
					<input type="hidden" name="relTypeCode" value="article" />
					<input type="hidden" name="relId" value="${param.id}" />
					<table>
						<colgroup>
							<col width="" />
							<col width="45" />
						</colgroup>
						<tr>
							<td>
								<input type="text" name="body" placeholder="댓글을 입력해주세요" />
							</td>
							<td>
								<input type="submit" value="등록" />
							</td>
						</tr>
					</table>
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
