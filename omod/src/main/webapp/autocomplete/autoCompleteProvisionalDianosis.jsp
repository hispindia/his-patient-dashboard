<%@ include file="/WEB-INF/template/include.jsp" %>
<c:choose>
<c:when test="${not empty diagnosis}">
[<c:forEach items="${diagnosis}" var="diagn" varStatus="loop">{"id":${diagn.conceptId} , "label":"${diagn.name}" }${!loop.last ? ',' : ''}</c:forEach>]
</c:when>
</c:choose>