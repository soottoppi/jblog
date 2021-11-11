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
	var updateWrite = {
		init : function() {
			window.addEventListener("load", this.onWindowLoad.bind(this));
		},
		onClicked : function(e) {
			var pattern = /\s/g;
			var title = document.getElementsByName("title")[0].value;
			var contents = document.getElementsByName("contents")[0].value;
			if( title.replace(pattern, '').length == 0  || contents.replace(pattern,'').length == 0 ){
				e.preventDefault();
				alert("제목 또는 내용을 입력하세요");
				return false;
			}
		},
		onWindowLoad : function(){
			var el = document.getElementById("changeWrite");
			el.addEventListener("click", this.onClicked);
		}
	}
	updateWrite.init();
</script>
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<div id="wrapper">
			<div id="content" class="full-screen">
				<c:import url="/WEB-INF/views/includes/admin-menu.jsp" />
				<form action="${pageContext.request.contextPath}/${authUser.id}/admin/write" method="post">
					<table class="admin-cat-write">
						<tr>
							<td class="t">제목</td>
							<td><input type="text" size="60" name="title">
							<select name="categoryNo" >
								<c:forEach items='${list }' var='vo' varStatus='status'>
									<option value="${vo.no }">${vo.name }</option>
								</c:forEach>
							</select></td>
						</tr>
						<tr>
							<td class="t">내용</td>
							<td><textarea name="contents"></textarea></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td class="s"><input id="changeWrite" type="submit" value="포스트하기"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>