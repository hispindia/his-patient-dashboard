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
<tr align="center">
	<th><spring:message code="patientdashboard.clinicalSummary.dateOfVisit"/></th>
	<th><spring:message code="patientdashboard.clinicalSummary.viewVisitDetails"/></th>
	<th><spring:message code="patientdashboard.clinicalSummary.vitalStatistics"/></th>
	<th><spring:message code="patientdashboard.clinicalSummary.symptomlDetails"/></th>
</tr>

<c:forEach items="${clinicalSummaries}" var="clinicalSummary" varStatus="varStatus">
<tr align="center" class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
    <td><openmrs:formatDate date="${clinicalSummary.dateOfVisit}" type="textbox"/></td>
	<td><a href="#" onclick="DASHBOARD.detailClinical('${ clinicalSummary.id}');"><small>View details</small></a> </td>
	<td><a href="#" onclick="DASHBOARD.vitalStatistics('${ clinicalSummary.id}','${ clinicalSummary.id}');"><small>View details</small></a> </td>
	<td><a href="#" onclick="DASHBOARD.symptomlDetails('${ clinicalSummary.id}');"><small>View details</small></a> </td>
	</tr>
</c:forEach>
</table>
</c:when>
</c:choose>