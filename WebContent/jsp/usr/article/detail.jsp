<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.sbs.example.jspCommunity.dto.Article"%>
<%
Article article = (Article) request.getAttribute("article");
String pageTitle = "게시물 상세페이지";
%>
<%@ include file="../../part/head.jspf" %>
	<h1><%=pageTitle%></h1>
	
	<div>
		번호 :
		<%=article.getId()%>
		<br />
		작성날짜 :
		<%=article.getRegDate()%>
		<br />
		수정날짜 :
		<%=article.getUpdateDate()%>
		<br />
		게시판 :
		<%=article.getExtra__boardName()%>
		<br />
		작성자 :
		<%=article.getExtra__writer()%>
		<br />
		조회수 :
		<%=article.getHitsCount()%>
		<br />
		제목 :
		<%=article.getTitle()%>
		<br />
		내용 :
		<%=article.getBody()%>
	</div>
	<hr />
	<div>
		<a href="list?boardId=<%=article.getBoardId()%>">목록</a>
		<a href="modify?memberId=1&id=<%=article.getId()%>">수정</a>
		<a onclick="if (confirm('정말 삭제하시겠습니까?') == false) {return false;}" href="doDelete?memberId=1&id=<%=article.getId()%>">삭제</a>
	</div>
	<%@ include file="../../part/foot.jspf" %>
	