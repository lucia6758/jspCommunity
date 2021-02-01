<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${board.name} 글쓰기" />
<%@ include file="../../part/head.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/write.css" />
<section class="pageTitle con-min-width">
	<h1 class="con">${pageTitle}</h1>
</section>

<section class="article-write con-min-width">
	<div class="con">
		<script>
		let checkWriteForm_submited = false;
		function checkWriteForm_submit(form) {
		  if (checkWriteForm_submited) {
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
		  checkWriteForm_submited = true;
		}
		</script>
		<form action="doWrite" method="POST" onsubmit="checkWriteForm_submit(this); return false;">
			<input type="hidden" name="boardId" value="${board.id}" />
			<input type="hidden" name="body" />
			<div>
				<div>
					<input type="text" name="title" placeholder="제목을 입력해주세요"
						maxlength="50">
				</div>
				<hr />
				<div>
					<script type="text/x-template"></script>
					<div class="toast-ui-editor"></div>
				</div>
				<br>
				<div class="btn-wrap flex flex-jc-c">
					<input class="submit" type="submit" value="작성">
					<button type="button" onclick="history.back();">취소</button>
				</div>
			</div>
		</form>
	</div>
</section>

<%@ include file="../../part/foot.jspf"%>