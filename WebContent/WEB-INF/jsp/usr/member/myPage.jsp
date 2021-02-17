<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/myPage.css" />

<section class="pageTitle con-min-width padding-0-10">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="myPage con-min-width padding-0-10">
	<div class="memberInfo con">
		<table>
			<colgroup>
				<col width="120">
			</colgroup>
			<tr>
				<th>
					<span>아이디</span>
				</th>
				<td>
					<div>${loginedMember.loginId}</div>
				</td>
				<td>
			</tr>
			<tr>
				<th>
					<span>이름</span>
				</th>
				<td>
					<div>${loginedMember.name}</div>
				</td>
			</tr>
			<tr>
				<th>
					<span>닉네임</span>
				</th>
				<td>
					<div>${loginedMember.nickname}</div>
				</td>
			</tr>
			<tr>
				<th>
					<span>이메일</span>
				</th>
				<td>
					<div>${loginedMember.email}</div>
				</td>
			</tr>
			<tr>
				<th>
					<span>핸드폰 번호</span>
				</th>
				<td>
					<div>${loginedMember.cellphoneNo}</div>
				</td>
			</tr>
			<tr>
				<th>
					<span>가입 날짜</span>
				</th>
				<td>
					<div>
						<fmt:parseDate value="${loginedMember.regDate}" var="dateFmt"
							pattern="yyyy-MM-dd HH:mm:ss" />
						<fmt:formatDate value="${dateFmt}" pattern="yyyy.MM.dd" />
					</div>
				</td>
			</tr>
		</table>
		<div class="flex flex-jc-c"><a class="modify-btn" href="../member/modify">회원정보수정</a></div>
	</div>
	<div class="myArticle-list con padding-0-10">
		<h3>작성한 글</h3>
		<div class="articlesCount flex flex-jc-e">게시물 수 : ${totalCount}</div>
		<table>
			<colgroup>
				<col width="60" />
				<col width="" />
				<col width="150" />
				<col width="100" />
				<col width="60" />
				<col width="60" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
					<th>추천수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${articles}" var="article">
					<tr>
						<td>${article.id}</td>
						<td class="list-title flex">
							<a href="detail?id=${article.id}">${article.title}</a>
							<span>${article.extra__replyCount}</span>
						</td>
						<td>${article.extra__writer}</td>
						<td>
							<fmt:parseDate value="${article.regDate}" var="dateFmt"
								pattern="yyyy-MM-dd HH:mm:ss" />
							<fmt:formatDate value="${dateFmt}" pattern="MM.dd HH:mm" />
						</td>
						<td>${article.hitsCount}</td>
						<td>${article.extra__likePoint}</td>
						<td class="visible-sm-down">
							<div class="flex">
								<span class="list-id--mobile">${article.id}</span>
								<a href="../article/detail?id=${article.id}"
									class="list-title--mobile flex-grow-1">${article.title}</a>
								<span class="list-reply--moblie flex flex-jc-e">${article.extra__replyCount}</span>
							</div>
							<div class="list-articleInfo--mobile flex">
								<span class="list-writer--mobile">${article.extra__writer}</span>
								<span class="vertical">|</span>
								<span class="list-reg-date--mobile">
									<fmt:formatDate value="${dateFmt}" pattern="MM.dd HH:mm" />
								</span>
								<span class="vertical">|</span>
								<span>조회 ${article.hitsCount}</span>
								<span class="vertical">|</span>
								<span>추천 ${article.extra__likePoint}</span>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${empty articles}">
			<div class="empty-list">
				<span class="flex flex-jc-c">
					<i class="fas fa-exclamation-circle"></i>
					등록된 게시물이 없습니다
				</span>
			</div>
		</c:if>
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
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>