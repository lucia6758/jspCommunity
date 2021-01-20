<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="회원 리스트" />
<%@ include file="../../part/head.jspf"%>
<section class="pageTitle">
	<h1>${pageTitle}</h1>
</section>
<c:forEach var="member" items="${members}">
	<div>
		번호 : ${member.id}
		<br />
		이름 : ${member.name}
		<br />
		닉네임 : ${member.nickname}
		<hr />
	</div>
</c:forEach>
<%@ include file="../../part/foot.jspf"%>