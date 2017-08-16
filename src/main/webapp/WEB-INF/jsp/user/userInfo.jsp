<%--
  Created by IntelliJ IDEA.
  User: fx
  Date: 2017/7/26
  Time: 下午5:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户详情</title>
    <%@include file="../common/import.jsp" %>
</head>
<body>
<div class="container" style="box-shadow: 0 0 1px #666;">
    <a href="${pageContext.request.contextPath}/index.jsp">
        <img src="${pageContext.request.contextPath}/resources/imgs/logo.png" class="img-responsive" alt="安徽大学">
    </a><br>
    <div class="row">
        <div class="col-md-2">
            <div class="info">
                <img alt="headimg" src="<c:url value="${info.headimg}"/>" class="img-thumbnail">
            </div>
        </div>
        <div class="col-md-8">
            <h3>
                ID:${info.uid}<br>
                昵称:${info.username}
            </h3>
        </div>
    </div>
    <%@include file="../common/foot.jsp" %>
</div>
</body>
</html>
