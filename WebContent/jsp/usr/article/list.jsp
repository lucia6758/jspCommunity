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
		<div class="articlesCount">게시물 수 : ${totalCount}</div>
		<div>
			<script>
			let checkSearchForm_submited = false;
			function checkSearchForm_submit(form) {
			  if (checkSearchForm_submited) {
			    alert("처리중입니다.");
			    return;
			  }
			
			  form.searchKeyword.value = form.searchKeyword.value.trim();
			  if (form.searchKeyword.value == "") {
			    alert("검색어를 입력해주세요");
			    form.searchKeyword.focus();
			    return;
			  }
			  
			  form.submit();
			  checkSearchForm_submited = true;
			}
			</script>
			<form onsubmit="checkSearchForm_submit(this); return false">
				<input type="hidden" name="boardId" value="${param.boardId}" />
				<select name="searchKeywordType">
					<option value="title">제목</option>
					<option value="body">본문</option>
					<option value="titleAndBody">제목+본문</option>
				</select>
				<script>
				const param_searchKeywordType = '${param.searchKeywordType}';
				
				if(param_searchKeywordType) {
				$('select[name="searchKeywordType"]').val(param_searchKeywordType);
				}
				</script>
				<input type="text" value="${param_searchKeyword}"
					name="searchKeyword" placeholder="검색어를 입력해주세요" />
				<input type="submit" value="검색" />
			</form>
		</div>
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
		<div class="list-paging flex flex-jc-c">
			<c:if test="${pageBeforeBtnNeedToShow}">
				<a
					href="?boardId=${param.boardId}&page=${pageBefore}&searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}">이전</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
				<c:set var="aClass" value="${currentPage == i ? 'currentPage' : ''}" />
				<c:set var="aUrl"
					value="?boardId=${param.boardId}&page=${i}&searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}" />
				<a class="${aClass}" href="${aUrl}">${i}</a>
			</c:forEach>
			<c:if test="${pageAfterBtnNeedToShow}">
				<a
					href="?boardId=${param.boardId}&page=${pageAfter}&searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}">다음</a>
			</c:if>
		</div>
		<div class="write-btn flex flex-jc-e">
			<a href="write?memberId=1&boardId=${param.boardId}">글쓰기</a>
		</div>
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>