<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../../part/head.jspf"%>
<section class="pageTitle">
	<h1>${pageTitle}</h1>
</section>
<div>
	<div>회원번호 : ${member.id}</div>
	<div>아이디: ${member.loginId}</div>
	<div>이름 : ${member.name}</div>
	<div>닉네임 : ${member.nickname}</div>
	<div>가입일: ${member.regDate}</div>
	<div>이메일 : ${member.email}</div>
	<div>전화번호 : ${member.cellphoneNo}</div>
</div>
<%@ include file="../../part/foot.jspf"%>