<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="로그인" />
<%@ include file="../../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/login.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>
<section class="login con-min-width">
	<script>
	let checkLoginForm_submited = false;
	function checkLoginForm_submit(form) {
	  if (checkLoginForm_submited) {
	    alert("처리중입니다.");
	    return;
	  }
	
	  form.loginId.value = form.loginId.value.trim();
	  if (form.loginId.value == "") {
	    alert("아이디를 입력해주세요");
	    form.loginId.focus();
	    return;
	  }
	
	  form.loginPw.value = form.loginPw.value.trim();
	  if (form.loginPw.value == "") {
	    alert("비밀번호를 입력해주세요");
	    form.loginPw.focus();
	    return;
	  }
	  
	  form.loginPwReal.value = sha256(form.loginPw.value);
	  form.loginPw.value = "";
	
	  form.submit();
	  checkLoginForm_submited = true;
	}
	</script>
	<div class="con">
		<form action="doLogin" method="POST"
			onsubmit="checkLoginForm_submit(this); return false;">
			<input type="hidden" name="loginPwReal" />
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
				<div class="login-btn">
					<input class="submit" type="submit" value="로그인" />
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
			<div>
				<div class="forget">
					<a href="findLoginId">아이디 찾기</a>
				</div>
			</div>
		</form>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>