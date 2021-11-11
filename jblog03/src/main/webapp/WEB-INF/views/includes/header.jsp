<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div id="header">
	<h1 id="blogTitle" >${blog.title}</h1>
	<ul>
		<c:if test="${empty authUser}">
			<li><a href="${pageContext.request.contextPath}/user/login">로그인</a></li>
		</c:if>
		<c:if test="${not empty authUser}">
			<li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
			
			<c:if test="${authUser.id == id}">
				<li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/basic">블로그 관리</a></li>
			</c:if>
		</c:if>
		
	</ul>
</div>