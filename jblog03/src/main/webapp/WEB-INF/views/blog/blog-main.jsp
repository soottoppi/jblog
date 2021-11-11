<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<html>	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<h4>${postVo.title }</h4>
					<p>
						${postVo.contents }
					<p>
				</div>
				<ul class="blog-list">
					<c:if test="${not empty postList}">
						<c:forEach items='${postList }'  var='vo' >
						<li>
							<a href="${pageContext.request.contextPath}/${id}/${vo.categoryNo }/${vo.no }">${vo.title }</a> <span>${vo.regDate }</span>
						</li>
						</c:forEach>
					</c:if>
					<c:if test="${empty postList}">
						<li></li>
					</c:if>
				</ul>
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">
				<img style="margin-top: 10px" src="${pageContext.request.contextPath}${blog.logo}">
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
				<c:forEach items='${categoryList }'  var='vo' >
					<li>
						<a href="${pageContext.request.contextPath}/${id}/${vo.no }">${vo.name }</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>