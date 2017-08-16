<%--@elvariable id="t" type="com.fx.entity.Article"--%>
<%--
  Created by IntelliJ IDEA.
  User: fx
  Date: 2017/7/25
  Time: 下午5:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<a href="${pageContext.request.contextPath}/article/details/${t.aid}" target="_blank">
    <c:out value="${t.title}"/>
</a>
<div style="float: right;">
    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
    <a href="${pageContext.request.contextPath}/user/info/${t.user.uid}" target="_blank">${t.user.username}</a>
</div>
<br/>
</h4>
<c:if test="${!empty t.lable}">
    <span class="label label-success">#${t.lable}#</span>
</c:if>
<p style="float: right;">
    <fmt:formatDate value="${t.date}" pattern="yyyy-MM-dd HH:mm:ss"/>
</p>
<br>