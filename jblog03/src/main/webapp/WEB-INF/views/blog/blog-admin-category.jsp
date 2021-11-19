<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> <%@ page
language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>JBlog</title>
        <Link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css"/>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
        <script src="${pageContext.request.contextPath }/assets/js/jquery/admin-menu.js" type="text/javascript"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/ejs/ejs.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <script> 
		var categoryListItemEJS = new EJS({
			url: "${pageContext.request.contextPath }/assets/js/jquery/ejs/categoryListItem-template.ejs",
            	});

            	var categoryItemEJS = new EJS({
                	url: "${pageContext.request.contextPath }/assets/js/jquery/ejs/categoryItem-template.ejs",
            	});

		// category list를 가져오는 작업, Controller에서 foward되어 view가 그려질 때 실행
		var fetch = function () {
            var url="${pageContext.request.contextPath }/api/${authUser.id}/admin/category";

			$.ajax({
				url: url,
				dataType: "json",
				type: "get",
				success: function (response) {
	                        console.log(response);
	
	                        var html = categoryListItemEJS.render(response);
	                        $("#admin-cat tbody").append(html);
	                    },
	                });
        };

        $(function () {
            $("#addCategory").submit(function (event) {
                // 이부분 수정하기
                event.preventDefault();
                console.log("addCategory!");
                var pattern = /\s/g;
                var name = document.getElementsByName("name")[0].value;
                var desc =
                    document.getElementsByName("description")[0].value;
                if (
                    name.replace(pattern, "").length == 0 ||
                    desc.replace(pattern, "").length == 0
                ) {
                    alert("카테고리명 또는 설명을 입력하세요");
                    return;
                } else if (name === "미분류") {
                    alert("미분류는 입력하실 수 없습니다");
                    return;
                }

                vo = {};
                vo.name = $("#input-name").val();
                vo.description = $("#input-description").val();
                console.log(vo);

                var url =
                    "${pageContext.request.contextPath }/api/${authUser.id}/admin/category";

                $.ajax({
                    url: url,
                    dataType: "json",
                    type: "post",
                    contentType: "application/json",
                    data: JSON.stringify(vo),
                    success: function (response) {
                        console.log(response);

                        var html = categoryItemEJS.render(response);
                        console.log(html);
                        $("#admin-cat tbody").append(html);
                    },
                    error: function (xhr, code, message) {
                        console.error(message);
                    },
                });
            }),

            $(document).on(
                "click",
                ".del",
                function (event) {
                    event.preventDefault();
                    
                    var no = $(this).nextAll(".del-cat-no").val();
                    var url = "${pageContext.request.contextPath }/api/${authUser.id}/admin/category/delete";
                    console.log(url);

                    $.ajax({
                        url: url,
                        type: "post",
                        dataType: "json",
                        data: "no=" + no,
                        success: function (response) {
                            console.log(response);
                            if (response.data == -1) {
                                return;
                            }

                            // 삭제가 된 경우
                            $(
                                "#admin-cat tbody tr[data-no=" + response.data + "]"
                            ).remove();
                        },
                    });
                }
            ),

            fetch();
        });

        
        </script>
        <c:set var="count" value="${fn:length(list) }" />
        <c:set var="newline" value="\n" />
    </head>
    <body>
        <div id="container">
            <c:import url="/WEB-INF/views/includes/header.jsp" />
            <div id="wrapper">
                <div id="content" class="full-screen">
                    <c:import url="/WEB-INF/views/includes/admin-menu.jsp" />
                    <table id="admin-cat" class="admin-cat">
                        <tr>
                            <th>번호</th>
                            <th>카테고리명</th>
                            <th>포스트 수</th>
                            <th>설명</th>
                            <th>삭제</th>
                        </tr>
                    </table>

                    <h4 class="n-c">새로운 카테고리 추가</h4>

                    <form
                        id="addCategory"
                        action="${pageContext.request.contextPath}/api/${authUser.id}/admin/category"
                        method="post"
                    >
                        <table id="admin-cat-add">
                            <tr>
                                <td class="t">카테고리명</td>
                                <td>
                                    <input
                                        id="input-name"
                                        type="text"
                                        name="name"
                                    />
                                </td>
                            </tr>
                            <tr>
                                <td class="t">설명</td>
                                <td>
                                    <input
                                        id="input-description"
                                        type="text"
                                        name="description"
                                    />
                                </td>
                            </tr>
                            <tr>
                                <td class="s">&nbsp;</td>
                                <td>
                                    <input
                                        type="submit"
                                        value="카테고리 추가"
                                    />
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
            <c:import url="/WEB-INF/views/includes/footer.jsp" />
        </div>
    </body>
</html>
