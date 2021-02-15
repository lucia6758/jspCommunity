<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/join.css" />

<section class="member-join con-min-width padding-0-10">
	<script>
	$(function() {
		$(".enAndNum").keyup(function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				let inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^a-z0-9]/gi, ''));
			}
		});
	});
	
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
	  
	  if(from.loginId.value.length < 5 || from.loginId.value.length > 15){
		  alert("아이디를 5자이상 15자 이하로 입력해주세요.");
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
				if ( data.success ) {
					checkJoinForm_checkedLoginId = data.body.loginId;
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
	  
	  let loginPwCheck =  /^.*(?=.{8,12})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	  if(form.loginPw.value.length < 5 || form.loginPw.value.length > 20){
		  alert("비밀번호를 5자이상 20자 이하로 입력해주세요.");
		  form.loginIdPw.focus();
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
	<div class="join-box con">
		<h1 class="flex flex-jc-c">${pageTitle}</h1>
		<form action="doJoin" method="POST"
			onsubmit="checkJoinForm_submit(this); return false;">
			<input type="hidden" name="loginPwReal" />
			<table>
				<colgroup>
					<col width="100">
				</colgroup>
				<tr>
					<th>
						<span>아이디</span>
					</th>
					<td>
						<div class="flex">
							<input class="enAndNum" type="text" name="loginId"
								placeholder="5~15자 사이의 영문이나 숫자" maxlength="15">
							<div class="btn-wrap dup-btn">
								<button type="button" name="btnLoginIdDupCheck"
									onclick="checkJoinForm_checkLoginIdDup(this);">중복확인</button>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>비밀번호</span>
					</th>
					<td>
						<div>
							<input class="enAndNum" type="password" name="loginPw" placeholder="5~20자 사이의 영문이나 숫자"
								maxlength="20">
						</div>
					</td>

				</tr>
				<tr>
					<th>
						<span>비밀번호 확인</span>
					</th>
					<td>
						<div>
							<input class="enAndNum" type="password" name="loginPwConfirm"
								placeholder="비밀번호를 한번 더 입력해주세요" maxlength="20">
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>이름</span>
					</th>
					<td>
						<div>
							<input type="text" name="name" placeholder="Name" maxlength="15">
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>닉네임</span>
					</th>
					<td>
						<div>
							<input type="text" name="nickname" placeholder="Nickname"
								maxlength="30">
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>이메일</span>
					</th>
					<td>
						<div>
							<input type="email" name="email" placeholder="E-Mail address"
								maxlength="100">
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>핸드폰 번호</span>
					</th>
					<td>
						<div>
							<input type="tel" name="cellphoneNo"
								placeholder="Cellphone Number" maxlength="20">
						</div>
					</td>
				</tr>
			</table>
			<div class="btn-wrap flex flex-jc-c">
				<input class="submit" type="submit" value="가입" />
			</div>
		</form>
	</div>
</section>
<%@ include file="../../part/foot.jspf"%>