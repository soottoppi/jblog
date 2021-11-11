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
	var updateCategory = {
		init : function() {
			window.addEventListener("load", this.onWindowLoad.bind(this));
		},
		onClicked : function(e) {
			var pattern = /\s/g;
			var name = document.getElementsByName("name")[0].value;
			var desc = document.getElementsByName("description")[0].value;
			if( name.replace(pattern, '').length == 0  || desc.replace(pattern,'').length == 0){
				e.preventDefault();
				alert("카테고리명 또는 설명을 입력하세요");
				return false;
			} else if(name === '미분류'){
				e.preventDefault();
				alert("미분류는 입력하실 수 없습니다");
				return false;
			}
		},
		onWindowLoad : function(){
			var el = document.getElementById("changeCategory");
			el.addEventListener("click", this.onClicked);
		}
	}
	updateCategory.init();
</script>
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<div id="wrapper">
			<div id="content" class="full-screen">
				<c:import url="/WEB-INF/views/includes/admin-menu.jsp" />
				<table class="admin-cat">
					<tr>
						<th>번호</th>
						<th>카테고리명</th>
						<th>포스트 수</th>
						<th>설명</th>
						<th>삭제</th>
					</tr>
					
					<c:set var='count' value='${fn:length(list) }' />
					<c:set var='newline' value='\n' />
					
					<c:forEach items='${list }' var='vo' varStatus='status'>
						<tr>
							<td>${status.index + 1}</td>
							<td>${vo.name }</td>
							<td>${vo.count }</td>
							<td>${vo.description }</td>
							<c:if test="${vo.count == 0 && vo.name != '미분류'}">
								<td>
									<form  action="${pageContext.request.contextPath}/${authUser.id}/admin/category/delete" method="post" >
										<input type='hidden' name="no" value="${vo.no }">
										<input type="image"  src="${pageContext.request.contextPath}/assets/images/delete.jpg">
									</form>
								</td>
							</c:if>
							<c:if test="${vo.count > 0 || vo.name == '미분류'}">
								<td></td>
							</c:if>
						</tr>
					</c:forEach>
				</table>

				<h4 class="n-c">새로운 카테고리 추가</h4>
				
				<form action="${pageContext.request.contextPath}/${authUser.id}/admin/category" method="post" >
					<table id="admin-cat-add">
						<tr>
							<td class="t">카테고리명</td>
							<td><input type="text" name="name"></td>
						</tr>
						<tr>
							<td class="t">설명</td>
							<td><input type="text" name="description"></td>
						</tr>
						<tr>
							<td class="s">&nbsp;</td>
							<td><input id="changeCategory" type="submit" value="카테고리 추가"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>