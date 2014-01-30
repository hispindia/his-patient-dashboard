<%--
 *  Copyright 2012 Society for Health Information Systems Programmes, India (HISP India)
 *
 *  This file is part of Dms module.
 *
 *  Dms module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  Dms module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dms module.  If not, see <http://www.gnu.org/licenses/>.
 *
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="" otherwise="/login.htm"
	redirect="index.htm" />
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="includes/js_css.jsp"%>
<script type="text/javascript">
	jQuery(document).ready(
			function() {
				jQuery('#lastMenstrualPeriod').datepicker({
					yearRange : 'c-100:c+100',
					dateFormat : 'dd/mm/yy',
					changeMonth : true,
					changeYear : true
				});
				jQuery("#calendarButton").click(function() {
					jQuery("#lastMenstrualPeriod").datepicker("show");
				});
});
</script>
<script type="text/javascript">
function validate(){
if (StringUtils.isBlank(jQuery("#opd").val())) {
				alert("Please select Room to visit");
				return false;
			}
}
</script>
<b class="boxHeader">Triage Form</b>
<div class="box">
	<table cellspacing="10" width="100%">
		<tr>
			<td width="40%"><b>Patient ID:</b>
				${patient.patientIdentifier.identifier}</td>
			<td width="30%"><c:if test="${not empty admittedStatus }">
					<span style="background-color: red; color: white">Admitted
						patient</span>
				</c:if></td>
			<td width="30%"><b>Location:</b> ${opd.name }</td>
		</tr>
		<tr>
			<td width="40%"><b>Name:</b>
				${patient.givenName}&nbsp;&nbsp;${patient.middleName}&nbsp;&nbsp;
				${patient.familyName}</td>
			<td width="30%"><b>Age:</b> ${age }</td>
			<td width="30%"><b>Gender:</b> ${patient.gender }</td>
		</tr>
		<%-- ghanshyam 16-06-2012 Bug #44 OPD Dashboard/ Patient category,PatientTemporary category is not being displayed --%>
		<%-- ghanshyam 27-02-2013 Feedback #966[Billing]Add Paid Bill/Add Free Bill for Bangladesh module(remove category from registration,OPD,IPD,Inventory) --%>
		<tr>
			<%--
			<td width="40%"><b>Patient category:</b> ${patientCategory} - <c:forEach
					items="${observation}" var="observation">
			${observation.valueText} 
		</c:forEach>
			</td>
			--%>
			<td width="30%"><b>Age category:</b> ${ageCategory }</td>
			<td width="30%"><b>Referral:</b> <!-- June 20th 2012 - Thai Chuong supported for issue #45 -->
				<c:choose>
					<c:when
						test="${referredType.class.name == 'org.openmrs.ConceptName'}">
					${referredType}
				</c:when>
					<c:otherwise>
					${referral.name }	
				</c:otherwise>
				</c:choose></td>

		</tr>
	</table>
	<form id="triageForm" method="POST"
		onsubmit="javascript:return validate();">
		<table>
			<tr>
				<td>Weight (Kg)</td>
				<td><input type="text" id="weight" name="weight" size="8">
				</td>
			</tr>
			<tr>
				<td>Height (cm)</td>
				<td><input type="text" id="height" name="height" size="8">
				</td>
			</tr>
			<tr>
				<td>Temperature (degree C)</td>
				<td><input type="text" id="temperature" name="temperature"
					size="8"></td>
			</tr>
			<tr>
				<td>Systolic B.P</td>
				<td><input type="text" id="sbp" name="sbp" size="8"></td>
			</tr>
			<tr>
				<td>Diastolic B.P</td>
				<td><input type="text" id="dbp" name="dbp" size="8"></td>
			</tr>
			<tr>
				<td>Respiratory Rate</td>
				<td><input type="text" id="resRate" name="resRate" size="8">
				</td>
			</tr>
			<tr>
				<td>Pulse Rate</td>
				<td><input type="text" id="pulseRate" name="pulseRate" size="8">
				</td>
			</tr>
			<tr>
				<td>Blood Group</td>
				<td><select id="bloodGroup" name="bloodGroup"
					style="width: 278px;">
						<option value="NotEntered">-Please select-</option>
						<option value="O">O</option>
						<option value="A">A</option>
						<option value="B">B</option>
						<option value="AB">AB</option>
						<option value="Not Known">Not Known</option>
				</select></td>
			</tr>
			<tr>
				<td>Last Menstrual Period</td>
				<td><input type="text" id="lastMenstrualPeriod"
					name="lastMenstrualPeriod" size="8"> <img
					id="calendarButton"
					src="${pageContext.request.contextPath}/moduleResources/patientdashboard/calendar.gif" />
				</td>
			</tr>
			<tr>
				<td>Rhesus Factor</td>
				<td><select id="rhesusFactor" name="rhesusFactor"
					style="width: 278px;">
						<option value="NotEntered">-Please select-</option>
						<option value="+">Positive (+)</option>
						<option value="-">Negative (-)</option>
						<option value="Not Known">Not Known</option>
				</select></td>
			</tr>
			<tr>
				<td>PITCT</td>
				<td><select id="pitct" name="pitct" style="width: 278px;">
						<option value="NotEntered">-Please select-</option>
						<option value="Reactive">Reactive</option>
						<option value="NonReactive">Non-Reactive</option>
						<option value="NotKnown">Not Known</option>
				</select></td>
			</tr>
			<tr>
				<td>Room to Visit(*):</td>
				<td><select id="opd" name="opd" style="width: 278px;"><option
							value="">-Please select-</option>
						<c:forEach items="${listOPD}" var="opd">
							<option value="${opd.answerConcept.id }"
								<c:if test="${opdId == opd.answerConcept.id  }">selected="selected"</c:if>>${opd.answerConcept.name}</option>
						</c:forEach>
				</select>
				</td>
			</tr>
			<tr></tr>
			<tr>
				<td><input type="submit" value="Save"></td>
				<td><input type="button" value="Reset"
					onclick="window.location.href=window.location.href"></td>
			</tr>
		</table>
	</form>
</div>

<%@ include file="/WEB-INF/template/footer.jsp"%>