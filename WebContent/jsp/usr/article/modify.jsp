<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name} 게시물 수정" />
<%@ include file="../../part/head.jspf"%>
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="article-modify con-min-width">
	<div class="con">
		<script>
		let checkModifyForm_submited = false;
		function checkModifyForm_submit(form) {
		  if (checkModifyForm_submited) {
		    alert("처리중입니다.");
		    return;
		  }
		
		  form.title.value = form.title.value.trim();
		  if (form.title.value == "") {
		    alert("제목을 입력해주세요");
		    form.title.focus();
		    return;
		  }
		
		  const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
		  const body = editor.getMarkdown().trim();
		  
		  if (body.length == 0) {
		    alert("내용을 입력해주세요");
		    editor.focus();
		    return;
		  }
		  form.body.value = body;
		
		  form.submit();
		  checkModifyForm_submited = true;
		}
		</script>
		<form action="doModify" method="POST"
			onsubmit="checkModifyForm_submit(this); return false;">
			<input type="hidden" name="id" value="${article.id}">
			<input type="hidden" name="body" />
			<div>
				제목
				<input type="text" name="title" placeholder="제목을 입력해주세요"
					value="${article.title}" maxlength="50">
			</div>
			<hr />
			<div>
				내용
				<script type="text/x-template">${article.body}</script>
				<div class="toast-ui-editor"></div>
			</div>
			<br>
			<div>
				<input type="submit" value="수정">
				<button type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>