<%--@elvariable id="user" type="com.fx.entity.User"--%>
<%--
  Created by IntelliJ IDEA.
  User: fx
  Date: 2017/7/25
  Time: 下午12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主页</title>
    <%@include file="../common/import.jsp" %>
</head>
<body>
<div class="container" style="box-shadow: 0 0 1px #666;">
    <%@include file="../common/head.jsp" %>
    <div class="row">
        <div class="col-md-8">
            <c:forEach var="t" items="${articlePageBean.list}">
                <c:if test="${t.status eq 1 or t.status eq 3}">
                    <div class="page-header">
                        <h4>
                            <span class="label label-primary">置顶</span>
                            <c:if test="${t.status eq 3}">
                                <span class="label label-danger">精</span>
                            </c:if>
                            <%@include file="../common/articleData.jsp" %>
                        </h4>
                    </div>
                </c:if>
            </c:forEach>
            <c:forEach var="t" items="${articlePageBean.list}">
                    <c:if test="${t.status ne 1 and t.status ne 3}">
                        <div class="page-header">
                            <h4>
                                <c:if test="${t.status eq 2}">
                                    <span class="label label-danger">精</span>
                                </c:if>
                                <%@include file="../common/articleData.jsp" %>
                            </h4>
                        </div>
                    </c:if>
            </c:forEach>
            <div style="float:right;">
                <a href="${pageContext.request.contextPath}/article/list/${articlePageBean.currentPage==1?1:articlePageBean.currentPage-1}">
                    上一页
                </a>
                第${articlePageBean.currentPage}页/共${articlePageBean.totalPage}页
                <a href="${pageContext.request.contextPath}/article/list/${articlePageBean.currentPage==articlePageBean.totalPage?articlePageBean.totalPage:articlePageBean.currentPage+1}">
                    下一页
                </a>
            </div>
            <c:choose>
                <%--@elvariable id="user" type="com.fx.entity.User"--%>
                <c:when test="${!empty user}">
                    <div style="padding-top: 200px;">
                        <input type="text" class="form-control" maxlength="50" id="title" placeholder="输入帖子标题"><br>
                        <div id="content" style="height:240px;"></div>
                        <br>
                        <button type="button" class="btn btn-primary" id="addbtn" onclick="doClick()"
                                style="float: right;">发布
                        </button>
                        <input type="text" class="form-control" maxlength="20" id="lable" placeholder="#输入帖子标签#"
                               style="width: 200px;float: right;"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <center>
                        <h3>登陆后才可进行发帖！</h3>
                    </center>
                </c:otherwise>
            </c:choose>
            <%@include file="../common/foot.jsp" %>
        </div>
        <div class="col-md-4">
            <div style="padding-top: 120px;">
                <center>
                    <c:choose>
                        <%--@elvariable id="user" type="com.fx.entity.User"--%>
                        <c:when test="${empty user}">
                            <img src="<c:url value="/resources/imgs/head.png"/>" class="img-circle" data-toggle="modal"
                                 data-target="#myModal"><br><br>
                            用户名：
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#myModal">未登录</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/manager/${user.uid}" target="_blank">
                                <img alt="${user.username}" src="<c:url value="${user.headimg }"/>" class="img-circle"
                                     style="width: 224px;height: 224px;">
                            </a>
                            <br><br>用户名：
                            ${user.username}
                            <br><a href="<c:url value="/user/exit"/>">安全退出</a>
                        </c:otherwise>
                    </c:choose>
                </center>
            </div>
            <%@include file="../common/login.jsp" %>
        </div>
    </div>
</div>
<script type="text/javascript">
    function doClick() {
        var content = editor.$txt.html();
        var url = "${pageContext.request.contextPath}/article/add";
        var params = {
            title: $('#title').val(),
            content: content,
            uid: '${user.uid}',
            lable: $('#lable').val()
        };
        $.ajax({
            'url': url,
            'data': params,
            'contentType': "application/x-www-form-urlencoded; charset=utf-8",
            'type': 'POST',
            'success': function (data) {
                alert(data.data);
                location.href = "${pageContext.request.contextPath}/article/list/1";
            },
            'error': function () {
                alert("发帖失败！");
            }
        });
    }

    function regist() {
        var url = "${pageContext.request.contextPath}/user/regist";
        var params = {
            username: $('#username').val(),
            password: $('#password').val()
        };
        $.post(url, params, function (data) {
            alert(data.data);
        }, "json");
    }

    function login() {
        var url = "${pageContext.request.contextPath}/user/login";
        var params = {
            username: $('#username').val(),
            password: $('#password').val()
        };
        $.post(url, params, function (data) {
            alert(data.data);
            location.href = "${pageContext.request.contextPath}/article/list/1";
        }, "json");
    }
</script>
<input id="context" type="hidden" value="${pageContext.request.contextPath}">
<%@include file="../common/editor.jsp" %>
</body>
</html>
