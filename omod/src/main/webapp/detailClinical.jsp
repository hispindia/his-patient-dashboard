<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/headerMinimal.jsp" %>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/moduleResources/patientdashboard/styles/common.css" />
<span class="boxHeader">Visit Detail</span>
<table class="box" >
	<tr>
	<td><strong>Internal referral:</strong> ${internal}</td>
	</tr>
	<tr>
	<td><strong>External referral:</strong>  ${external}</td>
	</tr>
	<tr>
	<td><strong>VisitOutCome:</strong>  ${visitOutCome} <c:if test="${not empty otherValueOfVisit}">- ${otherValueOfVisit}</c:if></td>
	</tr>
</table>
