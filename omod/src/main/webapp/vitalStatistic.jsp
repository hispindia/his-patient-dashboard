
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
<span class="boxHeader">Vital statistics Detail</span>
<table class="box">
	<tr>

	<tr>
		<td>Weight (Kg)</td>
						<td><input type="text" id="weight" name="weight" size="11"
			value="${opdPatientQueueLog.triageDataId.weight}" readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Height (cm)</td>
						<td><input type="text" id="height" name="height" size="11"
			value="${opdPatientQueueLog.triageDataId.height}" readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>MUA Circumference(cm)</td>
						<td><input type="text" id="mua" name="mua" size="11"
			value="${opdPatientQueueLog.triageDataId.mua}" readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Chest Circumference(cm)</td>
						<td><input type="text" id="chest" name="chest" size="11"
			value="${opdPatientQueueLog.triageDataId.chest}" readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Abdominal Circumference(cm)</td>
						<td><input type="text" id="abdominal" name="abdominal"
			size="11" value="${opdPatientQueueLog.triageDataId.abdominal}"
			readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Temperature (degree C)</td>
						<td><input type="text" id="temperature" name="temperature"
			size="11" value="${opdPatientQueueLog.triageDataId.temperature}"
			readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Systolic B.P</td>
						<td><input type="text" id="sbp" name="sbp" size="11"
			value="${opdPatientQueueLog.triageDataId.systolic}" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>Diastolic B.P</td>
						<td><input type="text" id="dbp" name="dbp" size="11"
			value="${opdPatientQueueLog.triageDataId.daistolic}" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>Respiratory Rate</td>
						<td><input type="text" id="resRate" name="resRate" size="11"
			value="${opdPatientQueueLog.triageDataId.respiratoryRate}"
			readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Pulse Rate</td>
						<td><input type="text" id="pulseRate" name="pulseRate"
			size="11" value="${opdPatientQueueLog.triageDataId.pulsRate}"
			readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Blood Group</td>
						<td><input type="text" id="bloodGroup" name="bloodGroup"
			size="11" value="${opdPatientQueueLog.triageDataId.bloodGroup}"
			readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Rhesus Factor</td>
						<td><input type="text" id="rhesusFactor" name="rhesusFactor"
			size="11" value="${opdPatientQueueLog.triageDataId.rhesusFactor}"
			readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>Last Menstrual Period</td>
						<td><input type="text" id="lastMenstrualPeriod"
			name="lastMenstrualPeriod" size="11" value="${opdPatientQueueLog.triageDataId.lastMenstrualDate}"
			readonly="readonly">
		</td>
					</tr>
					<tr>
						<td>PITCT</td>
						<td><input type="text" id="pitct" name="pitct" size="11"
			value="${opdPatientQueueLog.triageDataId.pitct}" readonly="readonly">
						</td></tr>
	

</table>
