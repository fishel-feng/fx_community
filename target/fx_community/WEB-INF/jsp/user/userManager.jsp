<%--
  Created by IntelliJ IDEA.
  User: fx
  Date: 2017/7/26
  Time: 下午2:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人信息</title>
    <%@include file="../common/import.jsp" %>
</head>
<body>
<div class="container" style="box-shadow: 0 0 1px #666;">
    <a href="${pageContext.request.contextPath}/index.jsp">
        <img src="${pageContext.request.contextPath}/resources/imgs/logo.png" class="img-responsive" alt="安徽大学">
    </a><br>
    <c:choose>
        <%--@elvariable id="user" type="com.fx.entity.User"--%>
        <c:when test="${user.uid eq u.uid}">
            <div class="row">
                <div class="col-md-2">
                    <div class="info">
                        <img alt="headimg" src="<c:url value="${u.headimg}"/>" class="img-thumbnail">
                        <center>
                            <h3>ID:${u.uid}</h3>
                        </center>
                    </div>
                </div>
                <div class="col-md-8">
                    <h3>
                        昵称：${u.username}<br><br>
                        <input type="password" id="password" class="form-control" placeholder="请输入新密码">
                        <button class="btn btn-primary" type="button" onclick="updatePassword()" style="float: right;">
                            修改密码
                        </button>
                    </h3>
                    <div class="form-group">
                        <form action="${pageContext.request.contextPath}/user/headimg/${u.uid}"
                              enctype="multipart/form-data" method="post">
                            <input type="file" id="imgUpload" name="file" accept="image/*"><br>
                            <button class="btn btn-success" type="submit">修改头像</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="myArticle">
                <c:choose>
                    <c:when test="${empty articleList}">
                        <br>
                        <h3>未发表过任何贴子!</h3>
                    </c:when>
                    <c:otherwise>
                        <h3>发表过的贴子</h3>
                        <table class="table table-hover">
                            <c:forEach var="a" items="${articleList}">
                                <tr>
                                    <td>
                                        <span class="glyphicon glyphicon-tag" aria-hidden="true"></span>
                                        <a href="<c:url value="${pageContext.request.contextPath}/article/details/${a.aid}"/>"
                                           target="_blank">
                                            <c:out value="${a.title}"/>
                                        </a>
                                        <div style="float: right;">
                                            <fmt:formatDate value="${a.date}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                            <button type="button" class="btn btn-danger"
                                                    onclick="deleteArticle(${a.aid})">删除
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>
        <c:when test="${empty user}">
            <center>
                <br><br>
                <h3>请登录后再查询！</h3><br><br><br>
            </center>
        </c:when>
        <c:otherwise>
            <center>
                <br><br>
                <h3>不能修改他人信息！</h3><br><br><br>
            </center>
        </c:otherwise>
    </c:choose>
</div>
<%@include file="../common/foot.jsp" %>
<script type="text/javascript">
    function deleteArticle(aid) {
        $.get("${pageContext.request.contextPath}/article/delete/" + aid, function (data) {
            alert(data.data);
        }, "json");
        location.href = "${pageContext.request.contextPath}/user/manager/${u.uid}"
    }

    function updatePassword() {
        var url = "${pageContext.request.contextPath}/user/updatePassword/${u.uid}";
        var params = {
            password: $('#password').val(),
        };
        $.post(url, params, function (data) {
            alert(data.data);
        }, "json");
    }
</script>
</body>
</html>
