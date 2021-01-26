<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/login.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>
<section class="login con-min-width">
	<script>
	let doFindLoginIdForm_submited = false;
	function doFindLoginIdForm_submit(form) {
	  if (doFindLoginIdForm_submited) {
	    alert("처리중입니다.");
	    return;
	  }
	
	  form.name.value = form.name.value.trim();
	  if (form.name.value == "") {
	    alert("이름을 입력해주세요");
	    form.name.focus();
	    return;
	  }
	
	  form.email.value = form.email.value.trim();
	  if (form.email.value == "") {
	    alert("이메일을 입력해주세요");
	    form.email.focus();
	    return;
	  }
	
	  form.submit();
	  doFindLoginIdForm_submited = true;
	}
	</script>
	<div class="con">
		<form action="doFindLoginId" method="POST"
			onsubmit="doFindLoginIdForm_submit(this); return false;">
			<div>
				<div>이름</div>
				<div>
					<input type="text" name="name" placeholder="Name" maxlength="30">
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
					<input class="submit" type="submit" value="아이디찾기" />
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</form>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>