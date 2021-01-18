<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../../part/head.jspf"%>
<h1>${pageTitle}</h1>

<form name="join" action="doJoin" method="POST" onsubmit="return checkForm();">
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

<script>
function checkForm(){
  if(join.loginId.value==""){
    alert("아이디를 입력해주세요");
    join.loginId.focus();
    return false;
  }
  else if(join.loginPw.value==""){
    alert("비밀번호를 입력해주세요");
    join.loginPw.focus();
    return false;
  }
  else if(join.name.value==""){
    alert("이름을 입력해주세요");
    join.name.focus();
    return false;
  }
  else if(join.nickname.value==""){
    alert("별명을 입력해주세요");
    join.nickname.focus();
    return false;
  }
  else if(join.email.value==""){
    alert("이메일을 입력해주세요");
    join.email.focus();
    return false;
  }
  return true;
}
</script>