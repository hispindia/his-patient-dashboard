
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
		<td>${opdPatientQueueLog.triageDataId.weight}</td>
	</tr>
	<tr>
		<td><strong>Height (cm)</strong></td>
		<td>${opdPatientQueueLog.triageDataId.height}</td>
	</tr>
	<tr>
		<td><strong>MUA Circumference(cm)</strong></td>
		<td>${opdPatientQueueLog.triageDataId.mua}</td>
	</tr>
	<tr>
		<td><strong>Chest Circumference(cm)</strong></td>
		<td>${opdPatientQueueLog.triageDataId.chest}</td>
	</tr>
	<tr>
		<td><strong>Abdominal Circumference(cm)</strong></td>
		<td>${opdPatientQueueLog.triageDataId.abdominal}</td>
	</tr>
	<tr>
		<td><strong>Temperature (degree C)</strong></td>
		<td>${opdPatientQueueLog.triageDataId.temperature}</td>
	</tr>
	<tr>
		<td><strong>Systolic B.P</strong></td>
		<td>${opdPatientQueueLog.triageDataId.systolic}</td>
	</tr>
	<tr>
		<td><strong>Diastolic B.P</strong></td>
		<td>${opdPatientQueueLog.triageDataId.daistolic}</td>
	</tr>
	<tr>
		<td><strong>Respiratory Rate</strong></td>
		<td>${opdPatientQueueLog.triageDataId.respiratoryRate}</td>
	</tr>
	<tr>
		<td><strong>Pulse Rate</strong></td>
		<td>${opdPatientQueueLog.triageDataId.pulsRate}</td>
	</tr>
	<tr>
		<td><strong>Blood Group</strong></td>
		<td>${opdPatientQueueLog.triageDataId.bloodGroup}</td>
	</tr>
	<tr>
		<td><strong>Rhesus Factor</strong></td>
		<td>${opdPatientQueueLog.triageDataId.rhesusFactor}</td>
	</tr>
	<tr>
		<td><strong>Last Menstrual Period</strong></td>
		<td>${opdPatientQueueLog.triageDataId.lastMenstrualDate}</td>
	</tr>
	<tr>
		<td><strong>PITCT</strong></td>
		<td>${opdPatientQueueLog.triageDataId.pitct}</td>
	</tr>

</table>
