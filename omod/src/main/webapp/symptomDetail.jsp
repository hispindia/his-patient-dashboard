
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
<span class="boxHeader">Symptom Detail</span>
<table class="box">
	<c:choose>
		<c:when test="${not empty al}">
			<c:forEach items="${al}" var="a">
				<tr>
					<td bgcolor="red">${a}</td>
				</tr>
				<c:forEach items="${syptomquestionanswer[a]}" var="sqa">
					<tr>
						<td><font font-size: 1pt>${sqa.questionConcept.name}</font></td>
						<td><font font-size: 1pt>${questionanswer[sqa]}</font></td>
					</tr>
				</c:forEach>
			</c:forEach>
		</c:when>
	</c:choose>
</table>
