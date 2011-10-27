 <%--
 *  Copyright 2009 Society for Health Information Systems Programmes, India (HISP India)
 *
 *  This file is part of Patient-dashboard module.
 *
 *  Patient-dashboard module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  Patient-dashboard module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Patient-dashboard module.  If not, see <http://www.gnu.org/licenses/>.
 *
--%> 
<%@ include file="/WEB-INF/template/include.jsp" %>

<c:choose>

<c:when test="${not empty clinicalSummaries}">
<table cellpadding="5" cellspacing="0" width="100%">
<tr>
	<th><spring:message code="patientdashboard.clinicalSummary.view"/></th>
	<th><spring:message code="patientdashboard.clinicalSummary.dateOfVisit"/></th>
	<!--<th><spring:message code="patientdashboard.clinicalSummary.typeOfVisit"/></th>
	--><th><spring:message code="patientdashboard.clinicalSummary.treatingDoctor"/></th>
	<th><spring:message code="patientdashboard.clinicalSummary.diagnosis"/></th>
	<th><spring:message code="patientdashboard.clinicalSummary.procedures"/></th>
	<!-- <th><spring:message code="patientdashboard.clinicalSummary.linkedVisit"/></th> -->
</tr>

<c:forEach items="${clinicalSummaries}" var="clinicalSummary" varStatus="varStatus">
<tr class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
	<td><a href="#" onclick="DASHBOARD.detailClinical('${ clinicalSummary.id}');"><small>[Detail]</small></a> </td>
	<td><openmrs:formatDate date="${clinicalSummary.dateOfVisit}" type="textbox"/></td>
	<!--<td>${clinicalSummary.typeOfVisit}</td>
	--><td>${clinicalSummary.treatingDoctor}</td>
	<td>${clinicalSummary.diagnosis}</td>
	<td>${clinicalSummary.procedures}</td><!--
	<td>${clinicalSummary.linkedVisit}</td>
--></tr>
</c:forEach>
</table>
</c:when>
</c:choose>