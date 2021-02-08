<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
const alertMsg = '<%=request.getAttribute("alertMsg")%>'.trim();

if(alertMsg) {
	alert(alertMsg);
}

const historyBack = '<%=request.getAttribute("historyBack")%>' == 'true';

if(historyBack){
	history.back();
}

const replaceUrl = '<%=request.getAttribute("replaceUrl")%>'.trim();

if(replaceUrl){
	location.replace(replaceUrl);
}
</script>