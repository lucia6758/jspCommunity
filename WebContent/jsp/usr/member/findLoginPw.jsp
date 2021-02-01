<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="비밀번호 찾기" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/find.css" />
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
	<div class="find-box con">
		<h1 class="flex flex-jc-c">${pageTitle}</h1>
		<form action="doFindLoginPw" method="POST"
			onsubmit="doFindLoginPwForm_submit(this); return false;">
			<table>
				<tr>
					<th>
						<span>아이디</span>
					</th>
					<td>
						<div>
							<input type="text" name="loginId" placeholder="ID" maxlength="30">
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>이메일</span>
					</th>
					<td>
						<div>
							<input type="email" name="email" placeholder="E-mail address"
								maxlength="50">
						</div>
					</td>
				</tr>
			</table>
			<div class="btn-wrap flex flex-jc-c">
				<input class="submit" type="submit" value="비밀번호 찾기" />
				<button type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>