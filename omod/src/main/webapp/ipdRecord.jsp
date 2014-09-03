
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

<b class="boxHeader">Admission Details</b>
<table class="box"  width="100%">
	<tr align="center">
		<th><spring:message code="patientdashboard.dateOfAdmission"/></th>
		<th width="340"><spring:message code="patientdashboard.details"/></th>
		<th width="280"></th>
		<th width="300"></th>
		<th width="390"></th>
	</tr>
	<c:choose>
	  <c:when test="${not empty currentAdmission}">
			<tr align="center">
				<td><openmrs:formatDate date="${currentAdmission.admissionDate}" type="textbox"/></td>
				<td><a href="#" onclick="DASHBOARD.detailIPDClinical('${ currentAdmission.ipdEncounter.encounterId}');"><small>View details</small></a></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
	</c:when>
	<c:otherwise>
				<tr align="center"><td>No data</td></tr>
	</c:otherwise>
	</c:choose>
</table>

<br />

<b class="boxHeader">Previous Admission</b>
<table class="box" width="100%">
	<tr align="center">
		<th><spring:message code="patientdashboard.dateOfAdmission" />
		</th>
		<th><spring:message code="patientdashboard.dateOfDischarge" />
		</th>
		<th><spring:message code="patientdashboard.finalDiagnosis" />
		</th>
		<th><spring:message code="patientdashboard.finalProcedures" />
		</th>
		<th><spring:message code="patientdashboard.admissionOutcome" />
		</th>
	</tr>
	<c:choose>
		<c:when test="${not empty records}">
			<c:forEach items="${records}" var="record" varStatus="varStatus">
				<tr align="center"
					class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
					<td><openmrs:formatDate date="${record.admissionDate}"
							type="textbox" />
					</td>
					<td><openmrs:formatDate date="${record.dischargeDate}"
							type="textbox" />
					</td>
					<td>${record.diagnosis }</td>
					<td>${record.procedures }</td>
					<td>${record.admissionOutcome }</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr align="center">
				<td>No data</td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>

