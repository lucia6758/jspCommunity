<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="로그인" />
<%@ include file="../../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/login.css" />
<section class="login con-min-width padding-0-10">
	<script>
		$(function() {
			$(".enAndNum").keyup(function(event) {
				if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
					let inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^a-z0-9]/gi, ''));
				}
			});
		});

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
	<div class="login-box con">
		<h1 class="flex flex-jc-c">${pageTitle}</h1>
		<form class="con" action="doLogin" method="POST"
			onsubmit="checkLoginForm_submit(this); return false;">
			<input type="hidden" name="loginPwReal" />
			<input type="hidden" name="afterLoginUrl"
				value="${param.afterLoginUrl}" />
			<table>
				<colgroup>
					<col width="100">
				</colgroup>
				<tbody>
					<tr>
						<th>
							<span> 아이디 </span>
						</th>
						<td>
							<div>
								<input class="enAndNum" type="text" name="loginId"
									placeholder="ID" maxlength="15" autocomplete="off">
							</div>
						</td>
					</tr>
					<tr>
						<th>
							<span> 비밀번호 </span>
						</th>
						<td>
							<div>
								<input class="enAndNum" type="password" name="loginPw" placeholder="Password"
									maxlength="20">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn-wrap flex flex-jc-c">
				<input class="submit" type="submit" value="로그인" />
			</div>
			<div class="forget flex flex-jc-c">
				<a href="findLoginId">아이디 찾기</a>
				<span>/</span>
				<a href="findLoginPw">비밀번호 찾기</a>
			</div>
		</form>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>