<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/myPage.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="myPage con-min-width">
	<div class="con">
		<div>
			<div>아이디: ${member.loginId}</div>
			<div>이름 : ${member.name}</div>
			<div>닉네임 : ${member.nickname}</div>
			<div>가입일: ${member.regDate}</div>
			<div>이메일 : ${member.email}</div>
			<div>전화번호 : ${member.cellphoneNo}</div>
		</div>
		<div class="myPage-btn">
			<button type="button" onclick="">수정</button>
		</div>
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>