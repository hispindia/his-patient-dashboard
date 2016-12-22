
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
<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/moduleResources/patientdashboard/styles/common.css" />
<span class="boxHeader">Vital Statistics Details</span>
<table class="box">
	<tr>
		<td><strong>Weight (Kg)</strong></td>
		<td>${weight}</td>
	</tr>
	<tr>
		<td><strong>Height (cm)</strong></td>
		<td>${height}</td>
	</tr>
	<tr>
		<td><strong>BMI</strong></td>
		<td>${bmi}</td>
	</tr>
   <tr>
		<td><strong>Temperature(F)</strong></td>
		<td>${temp}</td>
	</tr>
	<tr>
		<td><strong>B.P</strong></td>
		<td><c:choose>
		<c:when test="${not empty sbp && not empty dbp}">
		${sbp}/${dbp}
		</c:when>
		<c:otherwise>
		<td></td>
		</c:otherwise>
		</c:choose></td>
	</tr>
	
	<tr>
		<td><strong>Pulse Rate(/min)</strong></td>
		<td>${pulserate}</td>
	</tr>
	<tr>
		<td><strong>LMP</strong></td>
		<td>${lmp}</td>
	</tr>
</table>
