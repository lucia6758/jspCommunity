<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../../part/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/join.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>
<section class="member-join con-min-width">
	<script>
	let checkJoinForm_submited = false;
	let checkJoinForm_checkedLoginId = "";
	
	function checkJoinForm_checkLoginIdDup(el){
		const from = $(el).closest('form').get(0);
		const loginId = from.loginId.value;
		
		from.loginId.value = from.loginId.value.trim();
	  if (from.loginId.value == "") {
	    alert("아이디를 입력해주세요");
	    from.loginId.focus();
	    return;
	  }
		
		$.get(
			"getLoginIdDup",
			{
				loginId
			},
			function(data) {
				if ( data.msg ) {
					alert(data.msg);
				}
				if ( data.resultCode.substr(0,2) == "S-" ) {
					checkJoinForm_checkedLoginId = data.loginId;
				}
			},
			"json"
		); 
	}
	
	function checkJoinForm_submit(form) {
	  if (checkJoinForm_submited) {
	    alert("처리중입니다.");
	    return;
	  }
	
	  form.loginId.value = form.loginId.value.trim();
	  if (form.loginId.value == "") {
	    alert("아이디를 입력해주세요");
	    form.loginId.focus();
	    return;
	  }
	  
	  if ( form.loginId.value != checkJoinForm_checkedLoginId ) {
			alert('아이디 중복확인을 해주세요.');
			form.btnLoginIdDupCheck.focus();
			return false;
		}
	
	  form.loginPw.value = form.loginPw.value.trim();
	  if (form.loginPw.value == "") {
	    alert("비밀번호를 입력해주세요");
	    form.loginPw.focus();
	    return;
	  }
	
	  form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
	  if (form.loginPwConfirm.value == "") {
	    alert("비밀번호 확인을 입력해주세요");
	    form.loginPwConfirm.focus();
	    return;
	  }
	  if (form.loginPw.value != form.loginPwConfirm.value) {
	    alert("비밀번호가 일치하지 않습니다");
	    form.loginPwConfirm.focus();
	    return;
	  }
	
	  form.name.value = form.name.value.trim();
	  if (form.name.value == "") {
	    alert("이름을 입력해주세요");
	    form.name.focus();
	    return;
	  }
	
	  form.nickname.value = form.nickname.value.trim();
	  if (form.nickname.value == "") {
	    alert("별명을 입력해주세요");
	    form.nickname.focus();
	    return;
	  }
	
	  form.email.value = form.email.value.trim();
	  if (form.email.value == "") {
	    alert("이메일을 입력해주세요");
	    form.email.focus();
	    return;
	  }
	  
	  form.cellphoneNo.value = form.cellphoneNo.value.trim();
	  if (form.cellphoneNo.value == "") {
	    alert("핸드폰 번호를 입력해주세요");
	    form.cellphoneNo.focus();
	    return;
	  }
	  
	  form.loginPwReal.value = sha256(form.loginPw.value);
	  form.loginPw.value = "";
	  form.loginPwConfirm.value = "";
	  
	  form.submit();
	  checkJoinForm_submited = true;
	}
	</script>
	<div class="con">
		<form action="doJoin" method="POST"
			onsubmit="checkJoinForm_submit(this); return false;">
			<input type="hidden" name="loginPwReal"/>
			<div>
				<div>아이디</div>
				<div>
					<input type="text" name="loginId" placeholder="ID" maxlength="30">
					<button type="button" name="btnLoginIdDupCheck"
						onclick="checkJoinForm_checkLoginIdDup(this);">중복확인</button>
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
				<div>비밀번호 확인</div>
				<div>
					<input type="password" name="loginPwConfirm"
						placeholder="Password Confirm" maxlength="50">
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
			<div>
				<div>핸드폰 번호</div>
				<div>
					<input type="tel" name="cellphoneNo" placeholder="Cellphone Number"
						maxlength="20">
				</div>
			</div>
			<hr>
			<div>
				<div>
					<input class="submit" type="submit" value="가입" />
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</form>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>