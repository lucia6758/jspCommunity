<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/myPage.css" />

<section class="myPage con-min-width">
	<div class="myPage-box con padding-0-10">
		<h1 class="flex flex-jc-c">${pageTitle}</h1>
		<script>
		let checkModifyForm_submited = false;
		
		function checkModifyForm_submit(form) {
		  if (checkModifyForm_submited) {
		    alert("처리중입니다.");
		    return;
		  }
		  
		  form.loginPw.value = form.loginPw.value.trim();

		  if(form.loginPw.value.length > 0) {
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
		  
		  if (form.loginPw.value.length > 0){
		  	form.loginPwReal.value = sha256(form.loginPw.value);
		  	form.loginPw.value = "";
			form.loginPwConfirm.value = "";	  
		  }
		  
		  
		  form.submit();
		  checkModifyForm_submited = true;
		}
		</script>
		<form action="doModify" method="POST"
			onsubmit="checkModifyForm_submit(this); return false;">
			<input type="hidden" name="loginPwReal" />
			<table>
				<colgroup>
					<col width="150">
				</colgroup>
				<tr>
					<th>
						<span>아이디</span>
					</th>
					<td>
						<div>${loginedMember.loginId}</div>
					</td>
					<td>
				</tr>
				<tr>
					<th>
						<span>비밀번호</span>
					</th>
					<td>
						<div>
							<input type="password" name="loginPw" placeholder="Password"
								maxlength="50">
						</div>
					</td>

				</tr>
				<tr>
					<th>
						<span>비밀번호 확인</span>
					</th>
					<td>
						<div>
							<input type="password" name="loginPwConfirm"
								placeholder="Password Confirm" maxlength="50">
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>이름</span>
					</th>
					<td>
						<div>
							<input type="text" name="name" value="${loginedMember.name}" />
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>닉네임</span>
					</th>
					<td>
						<div>
							<input type="text" name="nickname"
								value="${loginedMember.nickname}" />
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span>이메일</span>
					</th>
					<td>
						<div>
							<input type="email" name="email" value="${loginedMember.email}" />
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
								value="${loginedMember.cellphoneNo}" />
						</div>
					</td>
				</tr>
			</table>
			<div class="btn-wrap flex flex-jc-c">
				<input type="submit" value="회원정보 변경" />
			</div>
		</form>
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>