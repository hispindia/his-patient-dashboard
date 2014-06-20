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
<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="" otherwise="/login.htm"
	redirect="index.htm" />
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="includes/js_css.jsp"%>
<style type="text/css">
.classname {
	-webkit-border-top-left-radius:4px;
	-moz-border-radius-topleft:4px;
	border-top-left-radius:4px;
	-webkit-border-top-right-radius:4px;
	-moz-border-radius-topright:4px;
	border-top-right-radius:4px;
	-webkit-border-bottom-right-radius:4px;
	-moz-border-radius-bottomright:4px;
	border-bottom-right-radius:4px;
	-webkit-border-bottom-left-radius:4px;
	-moz-border-radius-bottomleft:4px;
	border-bottom-left-radius:4px;
	text-indent:0;
	border:1px solid #dcdcdc;
	display:inline-block;
	font-family:arial;
	font-size:15px;
	font-weight:bold;
	font-style:normal;
	height:30px;
	line-height:30px;
	width:150px;
	text-decoration:none;
	text-align:center;
}
.classname:hover{
	background-color:#FFDD57;
}

.classname:active {
	position:relative;
	top:1px;
	cursor : pointer;
	background-color:#FFDD57;
}
</style>

<script type="text/javascript">
	jQuery(document).ready(
			function() {
			
			var history = document.getElementById("patientHistory");
history.style.display="none";

				jQuery('#lastMenstrualPeriod').datepicker({
					yearRange : 'c-100:c+100',
					dateFormat : 'dd/mm/yy',
					changeMonth : true,
					changeYear : true
				});
				jQuery("#calendarButton").click(function() {
					jQuery("#lastMenstrualPeriod").datepicker("show");
				});
				if (StringUtils.isBlank(jQuery("#bloodGroup").val())) {
				jQuery("#rhesusFactor").attr("disabled", "disabled");
				}
                else{
              jQuery("#rhesusFactor").removeAttr("disabled");
			}
			    if("${patient.gender }"=="M"){
			    jQuery("#lastMenstrualPeriod").attr("disabled", "disabled");
			    jQuery("#calendarButton").hide();
			    };

});
</script>
<script type="text/javascript">
function validate(){
var intRegex=/^(?:[1-9]\d*(?:\.\d\d?)?|0\.[1-9]\d?|0\.0[1-9])$/;

if(!StringUtils.isBlank(jQuery("#weight").val())) {
      if (!jQuery("#weight").val().match(intRegex)) {
	  alert("Please enter weight in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#height").val())) {
      if (!jQuery("#height").val().match(intRegex)) {
	  alert("Please enter height in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#mua").val())) {
      if (!jQuery("#mua").val().match(intRegex)) {
	  alert("Please enter MUA Circumference in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#chest").val())) {
      if (!jQuery("#chest").val().match(intRegex)) {
	  alert("Please enter Chest Circumference in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#abdominal").val())) {
      if (!jQuery("#abdominal").val().match(intRegex)) {
	  alert("Please enter Chest Circumference in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#temperature").val())) {
      if (!jQuery("#temperature").val().match(intRegex)) {
	  alert("Please enter temperature in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#sbp").val())) {
      if (!jQuery("#sbp").val().match(intRegex)) {
	  alert("Please enter Systolic B.P in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#dbp").val())) {
      if (!jQuery("#dbp").val().match(intRegex)) {
	  alert("Please enter Diastolic B.P in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#resRate").val())) {
      if (!jQuery("#resRate").val().match(intRegex)) {
	  alert("Please enter Respiratory Rate in correct format");
	  return false;
	  }
}

if(!StringUtils.isBlank(jQuery("#pulseRate").val())) {
      if (!jQuery("#pulseRate").val().match(intRegex)) {
	  alert("Please enter Pulse Rate in correct format");
	  return false;
	  }
}

if (StringUtils.isBlank(jQuery("#opd").val())) {
				alert("Please select Room to visit");
				return false;
			}
			
jQuery("#rhesusFactor").removeAttr("disabled");
jQuery("#lastMenstrualPeriod").removeAttr("disabled");
}
</script>
<script type="text/javascript">
function enableAndDisable(){
jQuery("#bloodGroup").click(function() {
				if (StringUtils.isBlank(jQuery("#bloodGroup").val())) {
				jQuery("#rhesusFactor").attr("disabled", "disabled");
				}
				else if (jQuery("#bloodGroup").val()=="Not Known"){
				jQuery("#rhesusFactor").attr("disabled", "disabled");
				}
                else{
              jQuery("#rhesusFactor").removeAttr("disabled");
			}
		});
}
</script>

<script type="text/JavaScript">
function ShowForm () {
var history = document.getElementById("patientHistory");
var triage = document.getElementById("triageVitalData");
if (history.style.display=="inline" ) {
history.style.display="none";
triage.style.display="inline";
}
else {
history.style.display="inline";
triage.style.display="none";
}
};

function ShowVitalForm () {
var history = document.getElementById("patientHistory");
var triage = document.getElementById("triageVitalData");
if (triage.style.display=="inline" ) {
triage.style.display="none";
history.style.display="inline";
}
else {
triage.style.display="inline";
history.style.display="none";
}
}

</script>

<b class="boxHeader">Patient Detail</b>
<div class="box" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
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
				${patient.givenName}&nbsp;${fn:replace(patient.middleName,',',' ')}&nbsp;
				${patient.familyName}</td>
			<td width="30%"><b>Age:</b> ${age }</td>
			<td width="30%"><b>Gender:</b> ${patient.gender }</td>
		</tr>
			<td width="40%"><b>Age category:</b> ${ageCategory }</td>
			<td width="30%"><b>Visit Status:</b> <!-- June 20th 2012 - Thai Chuong supported for issue #45 -->
				<c:choose>
					<c:when
						test="${referredType!=null}">
					${referredType}
				</c:when>
					<c:otherwise>
					${referral.name }	
				</c:otherwise>
				</c:choose></td>
			<td width="30%"><b>Follow up:</b> <openmrs:formatDate date="${ob.valueDatetime }" /> at ${opdPatientQueueLog.opdConceptName}</td>

		</tr>
	</table>
		<br><br>
	<div id="tabs">
	<b class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
		<input name="formVitalButton" type="button" onclick="ShowVitalForm();" value="Vital Statistics" class="classname"> 
		<input name="formButton" type="button" onclick="ShowForm();" value="Patient History" class="classname">
	</b>

	<form id="triageForm" method="POST" onsubmit="javascript:return validate();">
		
		<table id="triageVitalData">
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
				<td>MUA Circumference(cm)</td>
				<td><input type="text" id="mua" name="mua" size="8">
				</td>
			</tr>
			<tr>
				<td>Chest Circumference(cm)</td>
				<td><input type="text" id="chest" name="chest" size="8"></td>
			</tr>
			<tr>
				<td>Abdominal Circumference(cm)</td>
				<td><input type="text" id="abdominal" name="abdominal" size="8"></td>
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
				<td>Last Menstrual Period</td>
				<td><input type="text" id="lastMenstrualPeriod"
					name="lastMenstrualPeriod" size="8"> <img
					id="calendarButton"
					src="${pageContext.request.contextPath}/moduleResources/patientdashboard/calendar.gif" />
				</td>
			</tr>
			<tr>
				<td>Blood Group</td>
				<td><select id="bloodGroup" name="bloodGroup"
					style="width: 278px;" onclick="enableAndDisable();">
						<option value="">-Please select-</option>
						<option value="O">O</option>
						<option value="A">A</option>
						<option value="B">B</option>
						<option value="AB">AB</option>
						<option value="Not Known">Not Known</option>
				</select></td>
			</tr>
			<tr>
				<td>Rhesus Factor</td>
				<td><select id="rhesusFactor" name="rhesusFactor"
					style="width: 278px;">
						<option value="">-Please select-</option>
						<option value="Positive (+)">Positive (+)</option>
						<option value="Negative (-)">Negative (-)</option>
						<option value="Not Known">Not Known</option>
				</select></td>
			</tr>
			<tr>
				<td>PITCT</td>
				<td><select id="pitct" name="pitct" style="width: 278px;">
						<option value="">-Please select-</option>
						<option value="Reactive">Reactive</option>
						<option value="Non-Reactive">Non-Reactive</option>
						<option value="Not Known">Not Known</option>
				</select></td>
			</tr>
			<tr>
				<td>Room to Visit *:</td>
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
		
		<table id="patientHistory">
				<tr><td><b><u>Past Medical and Surgical History</u></b></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any Existing Illness/ Conditions? &nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="existingIllness" name="existingIllness" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="existingIllness" name="existingIllness" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the problem?</td>
					<td><input type="text" id="existingIllnessProblem" name="existingIllnessProblem" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How long have you had it?</td>
					<td><input type="text" id="existingIllnessLong" name="existingIllnessLong" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How is your progress?</td>
					<td><input type="text" id="existingIllnessProgress" name="existingIllnessProgress" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="existingIllnessRecord" name="existingIllnessRecord" size="50"></td>
				</tr>
				
				<tr><td>.</td></tr>

				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Suffered from any Chronic Illness? &nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="chronicIllness" name="chronicIllness" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="chronicIllness" name="chronicIllness" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the problem?</td>
					<td><input type="text" id="chronicIllnessProblem" name="chronicIllnessProblem" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When did it occur?</td>
					<td><input type="text" id="chronicIllnessOccure" name="chronicIllnessOccure" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the outcome?</td>
					<td><input type="text" id="chronicIllnessOutcome" name="chronicIllnessOutcome" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="chronicIllnessRecord" name="chronicIllnessRecord" size="50"></td>
				</tr>
				
				<tr><td>.</td></tr>

				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any previous Hospital Admissions?&nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="previousAdmission" name="previousAdmission" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="previousAdmission" name="previousAdmission" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When was this?</td>
					<td><input type="text" id="previousAdmissionWhen" name="previousAdmissionWhen" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the problem?</td>
					<td><input type="text" id="previousAdmissionProblem" name="previousAdmissionProblem" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the outcome?</td>
					<td><input type="text" id="previousAdmissionOutcome" name="previousAdmissionOutcome" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="previousAdmissionRecord" name="previousAdmissionRecord" size="50"></td>
				</tr>
				
				<tr><td>.</td></tr>

				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any previous Operations/ Investigations?&nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="previousInvestigation" name="previousInvestigation" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="previousInvestigation" name="previousInvestigation" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When was this?</td>
					<td><input type="text" id="previousInvestigationWhen" name="previousInvestigationWhen" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the problem?</td>
					<td><input type="text" id="previousInvestigationProblem" name="previousInvestigationProblem" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the outcome?</td>
					<td><input type="text" id="previousInvestigationOutcome" name="previousInvestigationOutcome" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="previousInvestigationRecord" name="previousInvestigationRecord" size="50"></td>
				</tr>								

				<tr><td>.</td></tr>

				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Received the following vaccinations?&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BCG?</td>
					<td><input type="radio" id="BCG" name="BCG" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="BCG" name="BCG" value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="BCG" name="BCG" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 Polio Doses?</td>
					<td><input type="radio" id="polio" name="polio" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="polio" name="polio" value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="polio" name="polio" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3DPT/ Pentavalent Doses?</td>
					<td><input type="radio" id="DPT" name="DPT" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="DPT" name="DPT" value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="DPT" name="DPT" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Measles?</td>
					<td><input type="radio" id="measles" name="measles" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="measles" name="measles" value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="measles" name="measles" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pneumococcal?</td>
					<td><input type="radio" id="pneumococcal" name="pneumococcal" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="pneumococcal" name="pneumococcal" value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="pneumococcal" name="pneumococcal" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yellow Fever?</td>
					<td><input type="radio" id="yellowFever" name="yellowFever" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="yellowFever" name="yellowFever" value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="yellowFever" name="yellowFever" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5 Tetanus Doses (If Female)?</td>
					<td><input type="radio" id="tetanusMale" name="tetanusMale" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusMale" name="tetanusMale" value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusMale" name="tetanusMale" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 Tetanus Doses (If Male)?</td>
					<td><input type="radio" id="tetanusFemale" name="tetanusFemale" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusFemale" name="tetanusFemale" value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusFemale" name="tetanusFemale" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
					</td>
				</tr>

				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other?</td>
					<td><input type="text" id="otherVaccinations" name="otherVaccinations" size="50"></td>
				</tr>								

				<tr><td><b><u>Past Drug History</u></b></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Current Medications? &nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="currentMedication" name="currentMedication" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="currentMedication" name="currentMedication" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the medication?</td>
					<td><input type="text" id="medicationName" name="medicationName" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For how long it has been taken?</td>
					<td><input type="text" id="medicationPeriod" name="medicationPeriod" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Why is it being taken?</td>
					<td><input type="text" id="medicationReason" name="medicationReason" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="medicationRecord" name="medicationRecord" size="50"></td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any medication you are sensitive to? &nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="sensitiveMedication" name="sensitiveMedication" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="sensitiveMedication" name="sensitiveMedication" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the medication?</td>
					<td><input type="text" id="sensitiveMedicationName" name="sensitiveMedicationName" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What are the symptoms you experience?</td>
					<td><input type="text" id="sensitiveMedicationSymptom" name="sensitiveMedicationSymptom" size="50"></td>
				</tr>

				<tr>
					<td>&nbsp;&nbsp;&nbsp;Are you using any invasive contraception? &nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="invasiveContraception" name="invasiveContraception" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="invasiveContraception" name="invasiveContraception" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the medication?</td>
					<td><select id="invasiveContraceptionName" name="invasiveContraceptionName">
							<option value="Oral Pills">Oral Pills</option>
							<option value="IUD">IUD</option>
							<option value="Injectable Hormones">Injectable Hormones</option>
							<option value="Gels">Gels</option>
							<option value="Others">Others</option>
						</select></td>
				</tr>

				<tr><td><b><u>Family History</u></b></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Status of parents? &nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="parentStatus" name="parentStatus" value="Alive">Alive &nbsp;&nbsp;&nbsp;
						<input type="radio" id="parentStatus" name="parentStatus" value="Dead">Dead
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the cause of death?</td>
					<td><input type="text" id="parentDeathCause" name="parentDeathCause" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How old were they?</td>
					<td><input type="text" id="parentDeathAge" name="parentDeathAge" size="50"></td>
				</tr>

				<tr>
					<td>&nbsp;&nbsp;&nbsp;Status of siblings? &nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="siblingStatus" name="siblingStatus" value="Alive">Alive &nbsp;&nbsp;&nbsp;
						<input type="radio" id="siblingStatus" name="siblingStatus" value="Dead">Dead
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the cause of death?</td>
					<td><input type="text" id="siblingDeathCause" name="siblingDeathCause" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How old were they?</td>
					<td><input type="text" id="siblingDeathAge" name="siblingDeathAge" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Any family history of the following illness?</td>
					<td><select id="familyIllnessHistory" name="familyIllnessHistory">
							<option value="Hypertension">Hypertension</option>
							<option value="Tuberculosis">Tuberculosis</option>
							<option value="Stroke">Stroke</option>
							<option value="Sudden Death">Sudden Death</option>
							<option value="Asthma">Asthma</option>
							<option value="Diabetes">Diabetes</option>
							<option value="Others">Others</option>
							<option value="None">None</option>
						</select></td>
				</tr>

				<tr><td><b><u>Personal and Social History</u></b></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you smoke? &nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="smoke" name="smoke" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="smoke" name="smoke" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What do you smoke?</td>
					<td><input type="text" id="smokeItem" name="smokeItem" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is your average in a day?</td>
					<td><input type="text" id="smokeAverage" name="smokeAverage" size="50"></td>
				</tr>

				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you drink alcohol?&nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="alcohol" name="alcohol" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="alcohol" name="alcohol" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What alcohol do you drink?</td>
					<td><input type="text" id="alcoholItem" name="alcoholItem" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is your average in a day?</td>
					<td><input type="text" id="alcoholAverage" name="alcoholAverage" size="50"></td>
				</tr>

				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you take any recreational drugs?&nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="drug" name="drug" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="drug" name="drug" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What drugs do you take?</td>
					<td><input type="text" id="drugItem" name="drugItem" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is your average in a day?</td>
					<td><input type="text" id="drugAverage" name="drugAverage" size="50"></td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Are you aware of your current HIV Status?&nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="exposedHiv" name="exposedHiv" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="exposedHiv" name="exposedHiv" value="No">No
					</td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Have you been exposed to any HIV/ AIDS factor in the past year, or since your last HIV Test?&nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="hivStatus" name="hivStatus" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="hivStatus" name="hivStatus" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Which factors?</td>
					<td><input type="text" id="exposedHivFactor" name="exposedHivFactor" size="50"></td>
				</tr>

				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any close member in the family who can support during illness?&nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="familyHelp" name="familyHelp" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="familyHelp" name="familyHelp" value="No">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Who else can support you during illness?</td>
					<td><input type="text" id="otherHelp" name="otherHelp" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you have a regular source of income?&nbsp;&nbsp;&nbsp;</td>
					<td><input type="radio" id="incomeSource" name="incomeSource" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="incomeSource" name="incomeSource" value="No">No
					</td>
				</tr>
			</table>
	
	</form>
	</div>
		
</div>
<%@ include file="/WEB-INF/template/footer.jsp"%>