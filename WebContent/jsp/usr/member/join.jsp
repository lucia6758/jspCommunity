<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../../part/head.jspf"%>
<h1>${pageTitle}</h1>

<form action="doJoin" method="POST">
	<div>
		<div>아이디</div>
		<div>
			<input type="text" name="loginId" placeholder="ID" maxlength="30">
		</div>
	</div>
	<div>
		<div>비밀번호</div>
		<div>
			<input type="password" name="loginPw" placeholder="Password"
				maxlength="50">
		</div>
	</div>
	<div>
		<div>이름</div>
		<div>
			<input type="text" name="name" placeholder="Name" maxlength="50">
		</div>
	</div>
	<div>
		<div>별명</div>
		<div>
			<input type="text" name="nickname" placeholder="Nickname"
				maxlength="50">
		</div>
	</div>
	<div>
		<div>이메일</div>
		<div>
			<input type="email" name="email" placeholder="E-Mail address"
				maxlength="100">
		</div>
	</div>
	<hr>
	<div>
		<div>
			<input type="submit" value="가입" />
			<button type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</form>
<%@ include file="../../part/foot.jspf"%>