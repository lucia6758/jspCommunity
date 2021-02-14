<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/main.css" />

<div class="main-home con-min-width">
	<section class="home_photo con">
		<div>
			<img
				src="https://images.unsplash.com/photo-1504204267155-aaad8e81290d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80"
				alt="green">
		</div>
	</section>

	<section class="lastest_article con">
		<div class="flex flex-jc-a flex-ai-c">
			<div class="freeboard">
				<span>자유게시판 최신글</span>
				<table>
					<colgroup>
						<col width="70%"></col>
						<col width="30%"></col>
					</colgroup>
					<tbody>
						<c:forEach items="${articles}" var="article">
							<tr>
								<td>
									<a href="../article/detail?id=${article.id}">${article.title}</a>
								</td>
								<td class="writer">${article.extra__writer}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="popularArticles">
				<span>인기글</span>
				<table>
					<colgroup>
						<col width="70%"></col>
						<col width="30%"></col>
					</colgroup>
					<tbody>
						<c:forEach items="${popularArticles}" var="article">
							<tr>
								<td>
									<a href="../article/detail?id=${article.id}">${article.title}</a>
								</td>
								<td class="writer">${article.extra__writer}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>
</div>



<%@ include file="../../part/foot.jspf"%>