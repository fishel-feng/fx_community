<%--
  Created by IntelliJ IDEA.
  User: fx
  Date: 2017/7/25
  Time: 下午1:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>搜索结果</title>
    <%@include file="common/import.jsp" %>
</head>
<body>
<div class="container" style="box-shadow: 0 0 1px #666;">
    <%@include file="common/head.jsp" %>
    <br>
    <h4>查询关键字:"${key}",共查到${fn:length(resultList)}篇帖子！</h4>
    <table class="table table-hover">
        <c:forEach var="s" items="${resultList}">
            <tr>
                <td>
                    <span class="glyphicon glyphicon-tag" aria-hidden="true"></span>
                    <a href="${pageContext.request.contextPath}/article/details/${s.aid}" target="_blank">
                        <c:out value="${s.title}"/>
                    </a>
                    <div style="float: right;">
                        <fmt:formatDate value="${s.date}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>
    <%@include file="common/foot.jsp" %>
</div>
</body>
</html>
