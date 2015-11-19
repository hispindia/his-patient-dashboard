
<%--
 *  Copyright 2014 Society for Health Information Systems Programmes, India (HISP India)
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
<%@page import="org.openmrs.ConceptAnswer"%>
<%@page import="org.openmrs.ConceptName"%>
<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="View PatientDashboard"
	otherwise="/login.htm" redirect="index.htm" />
	<div class="box">
		<table cellspacing="5" width="10%">
			<c:choose>
				<c:when test="${not empty al}">
					<c:forEach items="${al}" var="a">
						<tr id="${a}">
							<td bgcolor="red">${ exminationname[a]}</td>
							<td><input type="hidden" name="exminationIdList" value="${a}"/></td>
						</tr>
						<c:forEach items="${ exminationquestionanswer[a]}" var="sqa">
							<tr>
								<td><font font-size: 1pt>${sqa.answerConcept.name}</font></td>
								<c:choose>
								<c:when test="${not empty  exminationquestionanswer2[sqa.answerConcept.conceptId]}">
								<c:forEach items="${ exminationquestionanswer2[sqa.answerConcept.conceptId]}" var="ac">
								<c:choose>
								<c:when test="${(ac.answerConcept.datatype.name == 'Text')}">
								
								<td><input type="hidden" name="${a}" id="${a}" value="${a}"/></td>
								<td align="top"><font font-size: 0.5pt><label>${ac.answerConcept.name}</label><input type="text" id="${a}:${sqa.answerConcept.conceptId}:${ac.answerConcept.conceptId}" name="${a}:${sqa.answerConcept.conceptId}"></input></font></td>
								</c:when>
								<c:otherwise>
								
								<td><input type="hidden" name="${a}" id="${a}" value="${a}"/></td>
								<td><font font-size: 0.5pt><input type="radio" id="${a}:${sqa.answerConcept.conceptId}:${ac.answerConcept.conceptId}" name="${a}:${sqa.answerConcept.conceptId}:radioOption"> ${ac.answerConcept.name}</input></font></td>
								</c:otherwise>
								</c:choose>
								</c:forEach>
								</c:when>
								<c:when test="${(sqa.answerConcept.datatype.name == 'Text')}">
								
								<td><input type="hidden" name="${a}" id="${a}" value="${a}"/></td>
								<label for="display-name">
								<td align="top"><font font-size:  0.5pt><input type="text" id="${a}:${sqa.answerConcept.conceptId}:${ac.answerConcept.conceptId}" name="${a}:${sqa.answerConcept.conceptId}">${ac.answerConcept.name}</input></font></td>
								</c:when>
								<c:otherwise>
								<td><input type="hidden" name="${a}" id="${a}" value="${a}"/></td>
								<td><input type="radio" id="${a}:${sqa.answerConcept.conceptId}:textFieldQues" name="${a}:${sqa.answerConcept.conceptId}:textFieldQues" size="8"></td>
								</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
	</div>
	