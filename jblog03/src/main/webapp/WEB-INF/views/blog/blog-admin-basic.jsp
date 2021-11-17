<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script src="${pageContext.request.contextPath }/assets/js/jquery/admin-menu.js" type="text/javascript"></script>

<script>
var updateBasic = {
	init : function() {
		window.addEventListener("load", this.onWindowLoad.bind(this));
	},
	onClicked : function(e) {
		var pattern = /\s/g;
		var title = document.getElementsByName("title")[0].value;
		if( title.replace(pattern, '').length == 0){
			e.preventDefault();
			alert("타이틀을 입력하세요");
			return false;
		}
	},
	onWindowLoad : function(){
		// var id = document.getElementsByClassName("valid")[0].id
		var el = document.getElementById("changeBasic");
		el.addEventListener("click", this.onClicked);
	}
}
updateBasic.init();
</script>
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<div id="wrapper">
			<div id="content" class="full-screen">
				<c:import url="/WEB-INF/views/includes/admin-menu.jsp" />
				<form action="${pageContext.request.contextPath}/${authUser.id}/admin/basic" method="post" enctype="multipart/form-data">
					<table class="admin-config">
						<tr>
							<td class="t">블로그 제목</td>
							<td><input type="text" size="40" name="title" value="${blog.title }"></td>
						</tr>
						<tr>
							<td class="t">로고이미지</td>
							<td>
								<img src="${pageContext.request.contextPath }${blog.logo }">
								<input type="hidden" name="logo" value="${blog.logo}" />
							</td>
						</tr>
						<tr>
							<td class="t">&nbsp;</td>	
							<td><input type="file" name="file"></td>
						</tr>
						<tr>
							<td class="t">&nbsp;</td>
							<td class="s"><input class="valid"  id="changeBasic" type="submit" value="기본설정 변경"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>