<%--@elvariable id="user" type="com.fx.entity.User"--%>
<%--
  Created by IntelliJ IDEA.
  User: fx
  Date: 2017/7/26
  Time: 下午6:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>贴子内容</title>
    <%@include file="../common/import.jsp" %>
</head>
<body>
<div class="container" style="box-shadow: 0 0 1px #666;">
    <%@include file="../common/head.jsp" %>
    <div class="page-header">
        <h4><c:out value="${article.title}"/></h4>
    </div>
    <div class="row">
        <div class="panel panel-default" style="border-radius : 0;">
            <div class="panel-body">
                <div class="col-md-2">
                    <center>
                        <a href="${pageContext.request.contextPath}/user/info/${article.user.uid}" target="_blank">
                            <img alt="headimg" style="width: 111px;" src="<c:url value="${article.user.headimg}"/>"
                                 class="img-thumbnail">
                        </a><br><br>楼主 :
                        <a href="${pageContext.request.contextPath}/user/info/${article.user.uid}"
                           target="_blank">${article.user.username}</a>
                    </center>
                </div>
                <div class="col-md-8">
                    <c:out value="${article.content}" escapeXml="false"/>
                </div>
            </div>
            <h6 style="float: right;">发布时间:<fmt:formatDate value="${article.date }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</h6>
        </div>
    </div>
    <h5>共${fn:length(commentList)}条评论</h5>
    <c:forEach var="c" items="${commentList}" varStatus="status">
        <div class="row">
            <div class="panel panel-default" style="border-radius : 0;">
                <div class="panel-body">
                    <div class="col-md-2">
                        <center>
                            <a href="${pageContext.request.contextPath}/user/info/${c.uid}" target="_blank">
                                <img alt="headimg" style="width: 111px;" src="<c:url value="${c.user.headimg}"/>"
                                     class="img-thumbnail">
                            </a><br><br><c:if test="${c.uid eq article.uid }">楼主:</c:if>
                            <a href="${pageContext.request.contextPath}/user/info/${c.uid}"
                               target="_blank">${c.user.username}</a>
                        </center>
                    </div>
                    <div class="col-md-8">
                        <c:out value="${c.content}" escapeXml="false"/>
                        <br><br>
                        <hr>
                        <div class="media" id="media${c.cid}">
                            <c:forEach var="f" items="${floor}">
                                <c:if test="${f.cid eq c.cid}">
                                    <div class="media-left">
                                        <a href="${pageContext.request.contextPath}/user/info/${f.uid}" target="_blank">
                                            <img class="media-object" style="width: 34px;"
                                                 src="<c:url value="${f.user.headimg}"/>">
                                        </a>
                                    </div>
                                    <div class="media-body">
                                        <a href="${pageContext.request.contextPath}/user/info/${f.uid}"
                                           target="_blank">${f.user.username}</a>:
                                        <c:out value="${f.content}"/>
                                    </div>
                                    <br>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="replyMsg">
                    <h6 style="float: right;">${status.index+1 }楼
                        <fmt:formatDate value="${c.date}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        <a onclick="openFloorInput(${c.cid})">&nbsp;回复&nbsp;</a>
                    </h6>
                </div>
            </div>
            <br>
            <div class="floor" id="floor${c.cid }" style="display: none;width: 40%;float: right;">
                <textarea class="form-control" rows="3" id="text${c.cid }"></textarea>
                <input class="btn btn-primary" type="submit" onClick="floorReply(${c.cid })" value="回复"
                       style="float: right;">
            </div>
        </div>
    </c:forEach>
    <c:choose>
        <%--@elvariable id="user" type="com.fx.entity.User"--%>
        <c:when test="${!empty user}">
            <div style="padding-top: 300px;">
                <div id="content" style="height:240px;"></div>
                <br>
                <button type="button" class="btn btn-primary" id="addbtn" onclick="reply()" style="float: right;">回复
                </button>
            </div>
        </c:when>
        <c:otherwise>
            <center>
                <h3>登陆后才可进行回帖！</h3>
            </center>
        </c:otherwise>
    </c:choose>
    <%@include file="../common/foot.jsp" %>
    <%@include file="../common/editor.jsp" %>
</div>
<script type="text/javascript">
    function reply(){
        var url="${pageContext.request.contextPath}/comment/add";
        var params={
            content:editor.$txt.html(),
            aid:'${article.aid}',
            uid:'${user.uid}'
        };
        $.post(url,params,function (data) {
            alert(data.data);
            location.href = "${pageContext.request.contextPath}/article/details/${article.aid}";
        },"json");
    }
    function openFloorInput(num) {
        $('#floor'+num).slideToggle();
        $('#text' + num).focus();
    }
    function floorReply(num){
        var url = "${pageContext.request.contextPath}/article/floor/add";
        var content = $('#text' + num).val();
        var params = {
            cid: num,
            aid: ${article.aid},
            uid: '${user.uid}',
            content: content
        };
        $.ajax({
            'url': url,
            'data': params,
            'type': 'POST',
            'success': function (){
                var t = '<div class="media-left">' +
                    '<a href="${pageContext.request.contextPath}/user/info/${user.uid}"><img class="media-object" src="${pageContext.request.contextPath}/${user.headimg}" style="width:34px;"></a>' +
                    '</div>' +
                    '<div class="media-body">' +
                    '<a href="${pageContext.request.contextPath}/user/info/${user.uid}" target="_blank">${user.username}</a>:' + content +
                    '</div>'+'<br>';
                $('#media' + num).append(t);
                $('#text' + num).val('');
                $('#floor' + num).slideUp();
            },
            'error': function () {
                alert("回复失败！");
            }
        });
    }
</script>
</body>
</html>
