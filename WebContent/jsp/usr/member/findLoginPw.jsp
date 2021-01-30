<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="비밀번호 찾기" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/login.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>
<section class="login con-min-width">
	<script>
	let doFindLoginPwForm_submited = false;
	function doFindLoginPwForm_submit(form) {
	  if (doFindLoginPwForm_submited) {
	    alert("처리중입니다.");
	    return;
	  }
	
	  form.loginId.value = form.loginId.value.trim();
	  if (form.loginId.value == "") {
	    alert("아이디를 입력해주세요");
	    form.loginId.focus();
	    return;
	  }
	
	  form.email.value = form.email.value.trim();
	  if (form.email.value == "") {
	    alert("이메일을 입력해주세요");
	    form.email.focus();
	    return;
	  }
	
	  form.submit();
	  doFindLoginPwForm_submited = true;
	}
	</script>
	<div class="con">
		<form action="doFindLoginPw" method="POST"
			onsubmit="doFindLoginPwForm_submit(this); return false;">
			<div>
				<div>아이디</div>
				<div>
					<input type="text" name="loginId" placeholder="ID" maxlength="30">
				</div>
			</div>
			<div>
				<div>이메일</div>
				<div>
					<input type="email" name="email" placeholder="E-mail address"
						maxlength="50">
				</div>
			</div>
			<div>
				<div class="find-btn">
					<input class="submit" type="submit" value="비밀번호 찾기" />
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</form>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>