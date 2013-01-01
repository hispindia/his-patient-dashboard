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



<b class="boxHeader">Current Admission</b>
<table class="box" width="100%">
	<tr align="center">
<!-- Sagar Bele Date:31-12-2012 Add procedure done in IPD record block in OPD patient-dashboard #555 -->	
		<th><spring:message code="patientdashboard.dateOfAdmission"/></th>
		<th><spring:message code="patientdashboard.treatingDoctor"/></th>
		<th><spring:message code="patientdashboard.provisionalDiagnosis"/></th>
		<th><spring:message code="patientdashboard.proceduresDone"/></th>
<!-- 		
		<th><spring:message code="patientdashboard.final/currentDiagnosis"/></th>
		<th><spring:message code="patientdashboard.surgery"/></th>
		<th><spring:message code="patientdashboard.action"/></th>
 -->	
	</tr>
	<c:choose>
		<c:when test="${not empty currentAdmission}">
			<tr align="center">
				<td><openmrs:formatDate date="${currentAdmission.admissionDate}" type="textbox"/></td>
				<td>${admitted.ipdAdmittedUser.givenName}</td>
				<td>${diagnosis}</td>				
<!-- Sagar Bele Date:31-12-2012 Add procedure done in IPD record block in OPD patient-dashboard #555 -->				
				<td>${procedure}</td>
				<!--
				<td>
					${finalDiagnosis }
				
				</td>
				<td>
					${finalProcedures }
				</td>
				<td><input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="<spring:message code="patientdashboard.addEditFinalResult"/>" onclick="ADMITTED.changeFinalResult('${currentAdmission.id}');"/>
				<c:if test="${not empty  finalDiagnosis}">
					<input type="button" value="<spring:message code="patientdashboard.discharge"/>" onclick="ADMITTED.discharge('${admitted.id}');"/>
				</c:if>
				
				</td> -->
			</tr>
		</c:when>
		<c:otherwise>
				<tr align="center"><td colspan="6">No data</td></tr>
		</c:otherwise>
	</c:choose>
</table>


<br/>

<b class="boxHeader">Previous Admission</b>
<table class="box" width="100%">
	<tr align="center">
<!-- Sagar Bele Date:31-12-2012 Add procedure done in IPD record block in OPD patient-dashboard #555 -->	
<!-- 	<th><spring:message code="patientdashboard.hospital"/></th>  -->
		<th><spring:message code="patientdashboard.dateOfAdmission"/></th>
		<th><spring:message code="patientdashboard.dateOfDischarge"/></th>
		<th><spring:message code="patientdashboard.finalDiagnosis"/></th>
		<th><spring:message code="patientdashboard.finalProcedures"/></th>
		<th><spring:message code="patientdashboard.admissionOutcome"/></th>
<!-- 	<th><spring:message code="patientdashboard.linkToD/cSummary"/></th>  -->
	</tr>
	<c:choose>
	  <c:when test="${not empty records}">
		<c:forEach items="${records}" var="record" varStatus="varStatus">
			<tr align="center" class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
<!-- 			<td>${record.hospitalName }</td>  -->
				<td><openmrs:formatDate date="${record.admissionDate}" type="textbox"/></td>
				<td><openmrs:formatDate date="${record.dischargeDate}" type="textbox"/></td>
				
				<td>${record.diagnosis }</td>
				<td>${record.procedures }</td>
				<td>${record.admissionOutcome }</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
				<tr align="center"><td colspan="7">No data</td></tr>
	</c:otherwise>
	</c:choose>
</table>

