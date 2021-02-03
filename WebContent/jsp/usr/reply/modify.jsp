<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name} 게시물 수정" />
<%@ include file="../../part/head.jspf"%>
<section class="pageTitle con-min-width padding-0-10">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="reply-modify con-min-width padding-0-10">
	<div class="con">
		<script>
		let checkModifyForm_submited = false;
		function checkModifyForm_submit(form) {
		  if (checkModifyForm_submited) {
		    alert("처리중입니다.");
		    return;
		  }
		  
		  if (form.body.value.length == 0) {
		    alert("내용을 입력해주세요");
		    form.body.focus();
		    return;
		  }
		
		  form.submit();
		  checkModifyForm_submited = true;
		}
		</script>
		<form action="doModify" method="POST"
			onsubmit="checkModifyForm_submit(this); return false;">
			<input type="hidden" name="id" value="${reply.id}">
			<div>
				<input type="text" name="body" placeholder="내용을 입력해주세요"
					value="${reply.body}">
			</div>			
			<br>
			<div class="btn-wrap flex flex-jc-c">
				<input type="submit" value="수정">
				<button type="button" onclick="history.back();">취소</button>
			</div>
		</form>
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>