
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
<script type="text/javascript">
	jQuery(document).ready(
			function() {
			
			$("#editableDiv").hide();
			$("#editPatientButton").show();
			$("#resetButton").hide();
			
			if('${hasEditPrivilige}'=="no")
			{
			$("#editableDiv").hide();
			$("#resetButton").hide();
			$("#editPatientButton").hide();
			}
			
});

function showEditableDiv()
{
	$("#editableDiv").show();
	$("#unEditableDiv").hide();
	$("#editPatientButton").hide();
	$("#resetButton").show();
}

function reset()
{
	$("#unEditableDiv").show();
	$("#editableDiv").hide();
	$("#resetButton").hide();
	$("#editPatientButton").show();
}



</script>

<script  type="text/JavaScript">

		$(function () {

						$("input[name=existingIllnessProblem]").attr("disabled", "disabled");
						$("input[name=existingIllnessLong]").attr("disabled", "disabled");
						$("input[name=existingIllnessProgress]").attr("disabled", "disabled");
						$("input[name=existingIllnessRecord]").attr("disabled", "disabled");
						$("input[name=chronicIllnessProblem]").attr("disabled", "disabled");
						$("input[name=chronicIllnessOccure]").attr("disabled", "disabled");
						$("input[name=chronicIllnessOutcome]").attr("disabled", "disabled");
						$("input[name=chronicIllnessRecord]").attr("disabled", "disabled");
						$("input[name=previousAdmissionWhen]").attr("disabled", "disabled");
						$("input[name=previousAdmissionProblem]").attr("disabled", "disabled");
						$("input[name=previousAdmissionOutcome]").attr("disabled", "disabled");
						$("input[name=previousAdmissionRecord]").attr("disabled", "disabled");
						$("input[name=previousInvestigationWhen]").attr("disabled", "disabled");
						$("input[name=previousInvestigationProblem]").attr("disabled", "disabled");
						$("input[name=previousInvestigationOutcome]").attr("disabled", "disabled");
						$("input[name=previousInvestigationRecord]").attr("disabled", "disabled");
						$("input[name=medicationName]").attr("disabled", "disabled");
						$("input[name=medicationPeriod]").attr("disabled", "disabled");
						$("input[name=medicationReason]").attr("disabled", "disabled");
						$("input[name=medicationRecord]").attr("disabled", "disabled");
						$("input[name=sensitiveMedicationName]").attr("disabled", "disabled");
						$("input[name=sensitiveMedicationSymptom]").attr("disabled", "disabled");
						jQuery("#invasiveContraceptionName").attr("disabled", "disabled");
						$("input[name=fatherDeathCause]").attr("disabled", "disabled");
						$("input[name=fatherDeathAge]").attr("disabled", "disabled");
						$("input[name=motherDeathCause]").attr("disabled", "disabled");
						$("input[name=motherDeathAge]").attr("disabled", "disabled");
						$("input[name=siblingDeathCause]").attr("disabled", "disabled");
						$("input[name=siblingDeathAge]").attr("disabled", "disabled");
						$("input[name=smokeItem]").attr("disabled", "disabled");
						$("input[name=smokeAverage]").attr("disabled", "disabled");
						$("input[name=alcoholItem]").attr("disabled", "disabled");
						$("input[name=alcoholAverage]").attr("disabled", "disabled");						
						$("input[name=drugItem]").attr("disabled", "disabled");
						$("input[name=drugAverage]").attr("disabled", "disabled");
						$("input[name=exposedHivFactor]").attr("disabled", "disabled");
						$("input[name=otherHelp]").attr("disabled", "disabled");
						
		
		
				var existingIllness = function (element) {
					if(element.value == "No") {
						$("input[name=existingIllnessProblem]").attr("disabled", "disabled");
						jQuery("#existingIllnessProblem").val("");
						$("input[name=existingIllnessLong]").attr("disabled", "disabled");
						jQuery("#existingIllnessLong").val("");
						$("input[name=existingIllnessProgress]").attr("disabled", "disabled");
						jQuery("#existingIllnessProgress").val("");
						$("input[name=existingIllnessRecord]").attr("disabled", "disabled");
						jQuery("#existingIllnessRecord").val("");
					}
					else {
					if( ${visitStatus =='New Patient'}  )
						{
						$("input[name=existingIllnessProblem]").removeAttr("disabled");
						$("input[name=existingIllnessLong]").removeAttr("disabled");
						$("input[name=existingIllnessProgress]").removeAttr("disabled");
						$("input[name=existingIllnessRecord]").removeAttr("disabled");
						}
						else 
						{	
							$("input[name=existingIllnessProblem]").removeAttr("disabled");
							$("input[name=existingIllnessLong]").removeAttr("disabled");
							$("input[name=existingIllnessProgress]").removeAttr("disabled");
							$("input[name=existingIllnessRecord]").removeAttr("disabled");
						}
					}
				};

				var chronicIllness = function (element) {
					if(element.value == "No") {
						$("input[name=chronicIllnessProblem]").attr("disabled", "disabled");
						jQuery("#chronicIllnessProblem").val("");
						$("input[name=chronicIllnessOccure]").attr("disabled", "disabled");
						jQuery("#chronicIllnessOccure").val("");
						$("input[name=chronicIllnessOutcome]").attr("disabled", "disabled");
						jQuery("#chronicIllnessOutcome").val("");
						$("input[name=chronicIllnessRecord]").attr("disabled", "disabled");
						jQuery("#chronicIllnessRecord").val("");
					}
					else {
						if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=chronicIllnessProblem]").removeAttr("disabled");
							$("input[name=chronicIllnessOccure]").removeAttr("disabled");
							$("input[name=chronicIllnessOutcome]").removeAttr("disabled");
							$("input[name=chronicIllnessRecord]").removeAttr("disabled");
						}
						else
						{
							$("input[name=chronicIllnessProblem]").removeAttr("disabled");
							$("input[name=chronicIllnessOccure]").removeAttr("disabled");
							$("input[name=chronicIllnessOutcome]").removeAttr("disabled");
							$("input[name=chronicIllnessRecord]").removeAttr("disabled");
						}
					}
				};
				
				var previousAdmission = function (element) {
					if(element.value == "No") {
						$("input[name=previousAdmissionWhen]").attr("disabled", "disabled");
						jQuery("#previousAdmissionWhen").val("");
						$("input[name=previousAdmissionProblem]").attr("disabled", "disabled");
						jQuery("#previousAdmissionProblem").val("");
						$("input[name=previousAdmissionOutcome]").attr("disabled", "disabled");
						jQuery("#previousAdmissionOutcome").val("");
						$("input[name=previousAdmissionRecord]").attr("disabled", "disabled");
						jQuery("#previousAdmissionRecord").val("");
					}
					else {
						if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=previousAdmissionWhen]").removeAttr("disabled");
							$("input[name=previousAdmissionProblem]").removeAttr("disabled");
							$("input[name=previousAdmissionOutcome]").removeAttr("disabled");
							$("input[name=previousAdmissionRecord]").removeAttr("disabled");
						}
						else
						{
							$("input[name=previousAdmissionWhen]").removeAttr("disabled");
							$("input[name=previousAdmissionProblem]").removeAttr("disabled");
							$("input[name=previousAdmissionOutcome]").removeAttr("disabled");
							$("input[name=previousAdmissionRecord]").removeAttr("disabled");
						}
					}
				};

				var previousInvestigation = function (element) {
					if(element.value == "No") {
						$("input[name=previousInvestigationWhen]").attr("disabled", "disabled");
						jQuery("#previousInvestigationWhen").val("");
						$("input[name=previousInvestigationProblem]").attr("disabled", "disabled");
						jQuery("#previousInvestigationProblem").val("");
						$("input[name=previousInvestigationOutcome]").attr("disabled", "disabled");
						jQuery("#previousInvestigationOutcome").val("");
						$("input[name=previousInvestigationRecord]").attr("disabled", "disabled");
						jQuery("#previousInvestigationRecord").val("");
					}
					else {
						if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=previousInvestigationWhen]").removeAttr("disabled"); 
							$("input[name=previousInvestigationProblem]").removeAttr("disabled"); 
							$("input[name=previousInvestigationOutcome]").removeAttr("disabled"); 
							$("input[name=previousInvestigationRecord]").removeAttr("disabled");
						}
						else 
						{
							$("input[name=previousInvestigationWhen]").removeAttr("disabled"); 
							$("input[name=previousInvestigationProblem]").removeAttr("disabled");
							$("input[name=previousInvestigationOutcome]").removeAttr("disabled"); 
							$("input[name=previousInvestigationRecord]").removeAttr("disabled") ;
						}
					}
				};

				var currentMedication = function (element) {
					if(element.value == "No") {
						$("input[name=medicationName]").attr("disabled", "disabled");
						jQuery("#medicationName").val("");
						$("input[name=medicationPeriod]").attr("disabled", "disabled");
						jQuery("#medicationPeriod").val("");
						$("input[name=medicationReason]").attr("disabled", "disabled");
						jQuery("#medicationReason").val("");
						$("input[name=medicationRecord]").attr("disabled", "disabled");
						jQuery("#medicationRecord").val("");
					}
					else {
						if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=medicationName]").removeAttr("disabled");
							$("input[name=medicationPeriod]").removeAttr("disabled");
							$("input[name=medicationReason]").removeAttr("disabled");
							$("input[name=medicationRecord]").removeAttr("disabled");
						}
						else
						{
							$("input[name=medicationName]").removeAttr("disabled");
							$("input[name=medicationPeriod]").removeAttr("disabled");
							$("input[name=medicationReason]").removeAttr("disabled");
							$("input[name=medicationRecord]").removeAttr("disabled");
						}
					}
				};

				var sensitiveMedication = function (element) {
					if(element.value == "No") {
						$("input[name=sensitiveMedicationName]").attr("disabled", "disabled");
						jQuery("#sensitiveMedicationName").val("");
						$("input[name=sensitiveMedicationSymptom]").attr("disabled", "disabled");
						jQuery("#sensitiveMedicationSymptom").val("");
					}
					else {
						if( ${visitStatus =='New Patient'}  ){
							$("input[name=sensitiveMedicationName]").removeAttr("disabled");
							$("input[name=sensitiveMedicationSymptom]").removeAttr("disabled");
						}
						else
						{
							$("input[name=sensitiveMedicationName]").removeAttr("disabled");
							$("input[name=sensitiveMedicationSymptom]").removeAttr("disabled");
						}
					}
				};
				
				var invasiveContraception = function (element) {
					if(element.value == "No") 
					{
				
						jQuery("#invasiveContraceptionName").attr("disabled", "disabled");
						jQuery("#invasiveContraceptionName").val("");
					}
					else
					{
						if( ${visitStatus =='New Patient'}  )
						{
							jQuery("#invasiveContraceptionName").removeAttr("disabled");
						}
						else
						{
							jQuery("#invasiveContraceptionName").removeAttr("disabled");
						
						}
					}
				};


				var fatherStatus = function (element) {
					if(element.value == "Alive") {
						$("input[name=fatherDeathCause]").attr("disabled", "disabled");
						jQuery("#fatherDeathCause").val("");
						$("input[name=fatherDeathAge]").attr("disabled", "disabled");
						jQuery("#fatherDeathAge").val("");
					}
					else {
					if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=fatherDeathCause]").removeAttr("disabled");
							$("input[name=fatherDeathAge]").removeAttr("disabled");	
						}
						else
						{
							$("input[name=fatherDeathCause]").removeAttr("disabled");
							$("input[name=fatherDeathAge]").removeAttr("disabled");
						}
					}
				};
				
				var motherStatus = function (element) {
					if(element.value == "Alive") {
						$("input[name=motherDeathCause]").attr("disabled", "disabled");
						jQuery("#motherDeathCause").val("");
						$("input[name=motherDeathAge]").attr("disabled", "disabled");
						jQuery("#motherDeathAge").val("");
					}
					else {
					if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=motherDeathCause]").removeAttr("disabled");
							$("input[name=motherDeathAge]").removeAttr("disabled");	
						}
						else
						{
							$("input[name=motherDeathCause]").removeAttr("disabled");
							$("input[name=motherDeathAge]").removeAttr("disabled");
						}
					}
				};
				
				var siblingStatus = function (element) {
					if(element.value == "Alive") {
						$("input[name=siblingDeathCause]").attr("disabled", "disabled");
						jQuery("#siblingDeathCause").val("");
						$("input[name=siblingDeathAge]").attr("disabled", "disabled");	
						jQuery("#siblingDeathAge").val("");
					}
					else {
						if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=siblingDeathCause]").removeAttr("disabled");
							$("input[name=siblingDeathAge]").removeAttr("disabled");	
						}
						else
						{
							$("input[name=siblingDeathCause]").removeAttr("disabled");
							$("input[name=siblingDeathAge]").removeAttr("disabled");	
						}
					}
				};

				var smoke = function (element) {
					if(element.value == "No") {
						$("input[name=smokeItem]").attr("disabled", "disabled");
						jQuery("#smokeItem").val("");
						$("input[name=smokeAverage]").attr("disabled", "disabled");	
						jQuery("#smokeAverage").val("");
					}
					else {
					if( ${visitStatus =='New Patient'}  )
					{
						$("input[name=smokeItem]").removeAttr("disabled");
						$("input[name=smokeAverage]").removeAttr("disabled");						
					}
					else
					{	
						$("input[name=smokeItem]").removeAttr("disabled");
						$("input[name=smokeAverage]").removeAttr("disabled");						
					}
					}
				};

				var alcohol = function (element) {
					if(element.value == "No") {
						$("input[name=alcoholItem]").attr("disabled", "disabled");
						jQuery("#alcoholItem").val("");
						$("input[name=alcoholAverage]").attr("disabled", "disabled");	
						jQuery("#alcoholAverage").val("");
					}
					else {
						if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=alcoholItem]").removeAttr("disabled");
							$("input[name=alcoholAverage]").removeAttr("disabled");						
						}
						else
						{
							$("input[name=alcoholItem]").removeAttr("disabled");
							$("input[name=alcoholAverage]").removeAttr("disabled");						
						}
					}
				};

				var drug = function (element) {
					if(element.value == "No") {
						$("input[name=drugItem]").attr("disabled", "disabled");
						jQuery("#drugItem").val("");
						$("input[name=drugAverage]").attr("disabled", "disabled");	
						jQuery("#drugAverage").val("");
					}
					else 
					{
						if( ${visitStatus =='New Patient'}  )
						{
							$("input[name=drugItem]").removeAttr("disabled");
							$("input[name=drugAverage]").removeAttr("disabled");						
						}
						else
						{
							$("input[name=drugItem]").removeAttr("disabled");
							$("input[name=drugAverage]").removeAttr("disabled");						
						}
					}
				};

				var exposedHiv = function (element) {
					if(element.value == "No") {
						$("input[name=exposedHivFactor]").attr("disabled", "disabled");
						jQuery("#exposedHivFactor").val("");
					}
					else {
					if( ${visitStatus =='New Patient'}  )
					{
						$("input[name=exposedHivFactor]").removeAttr("disabled");
					}
					else
					{
						$("input[name=exposedHivFactor]").removeAttr("disabled");
					}
					}
				};
				
				var familyHelp = function (element) {
					if(element.value == "Yes") {
						$("input[name=otherHelp]").attr("disabled", "disabled");
						jQuery("#otherHelp").val("");
					}
					else {
					if( ${visitStatus =='New Patient'}  )
					{
						$("input[name=otherHelp]").removeAttr("disabled");
					}
					else
					{
						$("input[name=otherHelp]").removeAttr("disabled");
					}
					}
				};
				
				
				$(":radio[name=existingIllness]").click(function () {existingIllness(this);	}).filter(":checked").each(function () { existingIllness(this); });
				$(":radio[name=chronicIllness]").click(function () {chronicIllness(this);	}).filter(":checked").each(function () { chronicIllness(this); });				
				$(":radio[name=previousAdmission]").click(function () {previousAdmission(this);	}).filter(":checked").each(function () { previousAdmission(this); });				
				$(":radio[name=previousInvestigation]").click(function () {previousInvestigation(this);	}).filter(":checked").each(function () { previousInvestigation(this); });				

				$(":radio[name=currentMedication]").click(function () {currentMedication(this);	}).filter(":checked").each(function () { currentMedication(this); });				
				$(":radio[name=sensitiveMedication]").click(function () {sensitiveMedication(this);	}).filter(":checked").each(function () { sensitiveMedication(this); });				
				$(":radio[name=invasiveContraception]").click(function () {invasiveContraception(this);	}).filter(":checked").each(function () { invasiveContraception(this); });				
	
				$(":radio[name=fatherStatus]").click(function () {fatherStatus(this);	}).filter(":checked").each(function () { fatherStatus(this); });				
				$(":radio[name=motherStatus]").click(function () {motherStatus(this);	}).filter(":checked").each(function () { motherStatus(this); });
				$(":radio[name=siblingStatus]").click(function () {siblingStatus(this);	}).filter(":checked").each(function () { siblingStatus(this); });				

				$(":radio[name=smoke]").click(function () {smoke(this);	}).filter(":checked").each(function () { smoke(this); });				
				$(":radio[name=alcohol]").click(function () {alcohol(this);	}).filter(":checked").each(function () { alcohol(this); });				
				$(":radio[name=drug]").click(function () {drug(this);	}).filter(":checked").each(function () { drug(this); });				
				$(":radio[name=exposedHiv]").click(function () {exposedHiv(this);	}).filter(":checked").each(function () { exposedHiv(this); });				
				$(":radio[name=familyHelp]").click(function () {familyHelp(this);	}).filter(":checked").each(function () { familyHelp(this); });				
	
			});
			

		</script>
		
<style>
#unEditableDiv {
    background-color:#eeeeee;
}
</style>

<table width="100%">
<tr>
 <td width="100%" align="right">
  <div id="preveligedDiv">
 <input class="ui-button ui-widget ui-state-default ui-corner-all"
 type="button" id="editPatientButton" onclick="showEditableDiv();"
 value="Edit Details" />
 <input class="ui-button ui-widget ui-state-default ui-corner-all"
 type="button" id="resetButton" onclick="reset();"
 value="Reset" />
 </div>
 </td>
</tr>

<tr>
 <td width="100%">
<div id="unEditableDiv" >

<table width="100%">
	<tr><td width="50%"><b class="boxHeader">Past Medical and Surgical History</b></td>
		<td><b class="boxHeader"><u>&nbsp;</u></b></td>
	</tr>
	<c:choose>
		<c:when test="${existingIllness != null}">
			<tr align="left">
				<td>Any existing illness/ conditions</td>
				<td>: ${existingIllness}</td>
			</tr>
		</c:when>
	</c:choose>

	<c:choose>
		<c:when
			test="${existingIllnessProblem != null && existingIllnessProblem != ''}">
			<tr align="left">
				<td>&nbsp;&nbsp;What is the problem?</td>
				<td>: ${existingIllnessProblem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${existingIllnessLong != null  && existingIllnessLong != ''}">
			<tr align="left">
				<td>&nbsp;&nbsp;How long have you had it?</td>
				<td>: ${existingIllnessLong}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${existingIllnessProgress != null  && existingIllnessProgress != ''}">
			<tr align="left">
				<td>&nbsp;&nbsp;How is your progress?</td>
				<td>: ${existingIllnessProgress}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${existingIllnessRecord != null  && existingIllnessRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${existingIllnessRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${chronicIllness != null  && chronicIllness != ''}">

			<tr align="left">
				<td>Suffered from any chronic illness?</td>
				<td>: ${chronicIllness}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${chronicIllnessProblem != null  && chronicIllnessProblem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is the problem?</td>
				<td>: ${chronicIllnessProblem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${chronicIllnessOccure != null  && chronicIllnessOccure != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;When did it occur?</td>
				<td>: ${chronicIllnessOccure}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${chronicIllnessOutcome != null  && chronicIllnessOutcome != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the outcome?</td>
				<td>: ${chronicIllnessOutcome}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${chronicIllnessRecord != null && chronicIllnessRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${chronicIllnessRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${previousAdmission != null && previousAdmission != ''}">

			<tr align="left">
				<td>Any previous hospital admissions?</td>
				<td>: ${previousAdmission}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousAdmissionWhen != null && previousAdmissionWhen != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;When was this?</td>
				<td>: ${previousAdmissionWhen}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousAdmissionProblem != null && previousAdmissionProblem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the problem?</td>
				<td>: ${previousAdmissionProblem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousAdmissionOutcome != null && previousAdmissionOutcome != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the outcome?</td>
				<td>: ${previousAdmissionOutcome}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousAdmissionRecord != null && previousAdmissionRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${previousAdmissionRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigation != null && previousInvestigation != ''}">

			<tr align="left">
				<td>Any previous operations/ investigations?</td>
				<td>: ${previousInvestigation}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigationWhen != null && previousInvestigationWhen != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;When was this?</td>
				<td>: ${previousInvestigationWhen}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigationProblem != null && previousInvestigationProblem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the problem?</td>
				<td>: ${previousInvestigationProblem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigationOutcome != null  && previousInvestigationOutcome != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the outcome?</td>
				<td>: ${previousInvestigationOutcome}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigationRecord != null && previousInvestigationRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${previousInvestigationRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${ BCG!= null ||  polio!=null || DPT!=null || measles!=null || pneumococcal!=null || yellowFever!=null || tetanusFemale!=null || tetanusMale!=null}">
			<tr>
				<td>Received the following vaccinations?&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${BCG != null}">
			<tr align="left">
				<td>&nbsp;&nbsp;BCG</td>
				<td>: ${BCG}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${polio != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;3 Polio Doses</td>
				<td>: ${polio}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${DPT != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;3DPT/ Pentavalent Doses</td>
				<td>: ${DPT}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${measles != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;Measles</td>
				<td>: ${measles}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${pneumococcal != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;Pneumococcal</td>
				<td>: ${pneumococcal}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${yellowFever != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;Yellow Fever</td>
				<td>: ${yellowFever}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${tetanusFemale != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;5 Tetanus Doses (If Female)</td>
				<td>: ${tetanusFemale}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${tetanusMale != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;3 Tetanus Doses (If Male)</td>
				<td>: ${tetanusMale}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${otherVaccinations != null  && otherVaccinations != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Other</td>
				<td>: ${otherVaccinations}</td>
			</tr>
		</c:when>
	</c:choose>

<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr><td><b class="boxHeader">Drug History</b></td>
				<td><b class="boxHeader"><u>&nbsp;</u></b></td>
				</tr>
	<c:choose>
		<c:when
			test="${currentMedication != null  && currentMedication != ''}">

			<tr align="left">
				<td>Current Medications</td>
				<td>: ${currentMedication}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${medicationName != null  && medicationName != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is the medication?</td>
				<td>: ${medicationName}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${medicationPeriod != null  && medicationPeriod != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;For how long it has been taken?</td>
				<td>: ${medicationPeriod}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${medicationReason != null  && medicationReason != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Why is it being taken?</td>
				<td>: ${medicationReason}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${medicationRecord != null  && medicationRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${medicationRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${sensitiveMedication != null  && sensitiveMedication != ''}">

			<tr align="left">
				<td>Any medication you are sensitive to?</td>
				<td>: ${sensitiveMedication}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${sensitiveMedicationName != null  && sensitiveMedicationName != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is the medication?</td>
				<td>: ${sensitiveMedicationName}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${sensitiveMedicationSymptom != null  && sensitiveMedicationSymptom != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What are the symptoms you experience?</td>
				<td>: ${sensitiveMedicationSymptom}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${invasiveContraception != null  && invasiveContraception != ''}">

			<tr align="left">
				<td>Are you using any invasive contraception?</td>
				<td>: ${invasiveContraception}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${invasiveContraceptionName != null  && invasiveContraceptionName != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Which one?</td>
				<td>: ${invasiveContraceptionName}</td>
			</tr>
		</c:when>
	</c:choose>



<tr>
		<td>&nbsp;</td>
	</tr>
	
	
	<tr><td><b class="boxHeader">Family History</b></td>
				<td><b class="boxHeader"><u>&nbsp;</u></b></td>
				</tr>
	<c:choose>
		<c:when test="${fatherStatus != null  && fatherStatus != ''}">

			<tr align="left">

				<td>Status of father</td>
				<td>: ${fatherStatus}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${fatherDeathCause != null  && fatherDeathCause != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the cause of death?</td>
				<td>: ${fatherDeathCause}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${fatherDeathAge != null  && fatherDeathAge != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;How old were they?</td>
				<td>: ${fatherDeathAge}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${motherStatus != null  && motherStatus != ''}">

			<tr align="left">

				<td>Status of mother</td>
				<td>: ${motherStatus}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${motherDeathCause != null  && motherDeathCause != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the cause of death?</td>
				<td>: ${motherDeathCause}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${motherDeathAge != null  && motherDeathAge != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;How old were they?</td>
				<td>: ${motherDeathAge}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${siblingStatus != null  && siblingStatus != ''}">

			<tr align="left">
				<td>Status of siblings</td>
				<td>: ${siblingStatus}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${siblingDeathCause != null  && siblingDeathCause != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the cause of death?</td>
				<td>: ${siblingDeathCause}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${siblingDeathAge != null  && siblingDeathAge != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;How old were they?</td>
				<td>: ${siblingDeathAge}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${familyIllnessHistory != null  && familyIllnessHistory != ''}">

			<tr align="left">
				<td>Any family history of the following illness?</td>
				<td>: ${familyIllnessHistory}</td>
			</tr>
		</c:when>
	</c:choose>
	
<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr><td><b class="boxHeader">Personal History</b></td>
				<td><b class="boxHeader"><u>&nbsp;</u></b></td>
				</tr>
	<c:choose>
		<c:when test="${smoke != null  && smoke != ''}">

			<tr align="left">
				<td>Do you smoke?</td>
				<td>: ${smoke}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${smokeItem != null  && smokeItem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What do you smoke?</td>
				<td>: ${smokeItem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${smokeAverage != null  && smokeAverage != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is your average in a day?</td>
				<td>: ${smokeAverage}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${alcohol != null  && alcohol != ''}">

			<tr align="left">
				<td>Do you drink alcohol?</td>
				<td>: ${alcohol}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${alcoholItem != null  && alcoholItem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What alcohol do you drink?</td>
				<td>: ${alcoholItem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${alcoholAverage != null  && alcoholAverage != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is your average in a day?</td>
				<td>: ${alcoholAverage}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${drug != null  && drug != ''}">

			<tr align="left">
				<td>Do you take any recreational drugs?</td>
				<td>: ${drug}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${drugItem != null  && drugItem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What drugs do you take?</td>
				<td>: ${drugItem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${drugAverage != null  && drugAverage != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is your average in a day?</td>
				<td>: ${drugAverage}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${hivStatus != null  && hivStatus != ''}">

			<tr align="left">
				<td>Are you aware of your current HIV Status</td>
				<td>: ${hivStatus}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${exposedHiv != null  && exposedHiv != ''}">

			<tr align="left">
				<td>Have you been exposed to any HIV/ AIDS factor in the past
					year, or since your last HIV Test?</td>
				<td>: ${exposedHiv}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${exposedHivFactor != null  && exposedHivFactor != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Which factors?</td>
				<td>: ${exposedHivFactor}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${familyHelp != null  && familyHelp != ''}">

			<tr align="left">
				<td>Any close member in the family who can support during
					illness?</td>
				<td>: ${familyHelp}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${otherHelp != null  && otherHelp != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Who else can support you during illness?</td>
				<td>: ${otherHelp}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${incomeSource != null  && incomeSource != ''}">

			<tr align="left">
				<td>Do you have a regular source of income?</td>
				<td>: ${incomeSource}</td>
			</tr>
		</c:when>
	</c:choose>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</div> <!-- end of unEditableDiv -->
</td>
</tr>
<tr>
<td width="100%">
<div id="editableDiv">
<form id="patientHistory"  method="post" action="patientHistory.htm?patientId=${patientId}&opdId=${opdId}&visitStatus=${visitStatus}&queueId=${queueId}">

<table id="patientHistory" width="100%">
				<tr><td width="50%"><b class="boxHeader">Past Medical and Surgical History</b></td>
				<td><b class="boxHeader"><u>&nbsp;</u></b></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any existing illness/ conditions? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${existingIllness == 'Yes'}">
						<input type="radio" id="existingIllness" name="existingIllness" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="existingIllness" name="existingIllness"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${existingIllness  == 'No' || existingIllness  == '' ||  existingIllness  == null}">
						<input type="radio" id="existingIllness" name="existingIllness"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="existingIllness" name="existingIllness" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the problem?</td>
					<td><input type="text" id="existingIllnessProblem" name="existingIllnessProblem" value="${existingIllnessProblem}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How long have you had it?</td>
					<td><input type="text" id="existingIllnessLong" name="existingIllnessLong" value="${existingIllnessLong}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How is your progress?</td>
					<td><input type="text" id="existingIllnessProgress" name="existingIllnessProgress" value="${existingIllnessProgress}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="existingIllnessRecord" name="existingIllnessRecord" value="${existingIllnessRecord}" size="50"></td>
				</tr>
				
				<tr><td>&nbsp;</td></tr>

				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Suffered from any chronic illness? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${chronicIllness == 'Yes'}">
						<input type="radio" id="chronicIllness" name="chronicIllness" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="chronicIllness" name="chronicIllness"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${chronicIllness  == 'No' || chronicIllness  == '' ||  chronicIllness  == null}">
						<input type="radio" id="chronicIllness" name="chronicIllness"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="chronicIllness" name="chronicIllness" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the problem?</td>
					<td><input type="text" id="chronicIllnessProblem" name="chronicIllnessProblem" value="${chronicIllnessProblem}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When did it occur?</td>
					<td><input type="text" id="chronicIllnessOccure" name="chronicIllnessOccure" value="${chronicIllnessOccure}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the outcome?</td>
					<td><input type="text" id="chronicIllnessOutcome" name="chronicIllnessOutcome" value="${chronicIllnessOutcome}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="chronicIllnessRecord" name="chronicIllnessRecord" value="${chronicIllnessRecord}" size="50"></td>
				</tr>
				
				<tr><td>&nbsp;</td></tr>

				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any previous hospital admissions?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${previousAdmission == 'Yes'}">
						<input type="radio" id="previousAdmission" name="previousAdmission" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="previousAdmission" name="previousAdmission"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${previousAdmission  == 'No' || previousAdmission  == '' ||  previousAdmission  == null}">
						<input type="radio" id="previousAdmission" name="previousAdmission"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="previousAdmission" name="previousAdmission" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>	
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When was this?</td>
					<td><input type="text" id="previousAdmissionWhen" name="previousAdmissionWhen" value="${previousAdmissionWhen}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the problem?</td>
					<td><input type="text" id="previousAdmissionProblem" name="previousAdmissionProblem" value="${previousAdmissionProblem}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the outcome?</td>
					<td><input type="text" id="previousAdmissionOutcome" name="previousAdmissionOutcome" value="${previousAdmissionOutcome}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="previousAdmissionRecord" name="previousAdmissionRecord" value="${previousAdmissionRecord}" size="50"></td>
				</tr>
				
				<tr><td>&nbsp;</td></tr>

				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any previous operations/ investigations?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${previousInvestigation == 'Yes'}">
						<input type="radio" id="previousInvestigation" name="previousInvestigation" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="previousInvestigation" name="previousInvestigation"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${previousInvestigation  == 'No' || previousInvestigation  == '' || previousInvestigation  == null}">
						<input type="radio" id="previousInvestigation" name="previousInvestigation"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="previousInvestigation" name="previousInvestigation" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When was this?</td>
					<td><input type="text" id="previousInvestigationWhen" name="previousInvestigationWhen" value="${previousInvestigationWhen}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the problem?</td>
					<td><input type="text" id="previousInvestigationProblem" name="previousInvestigationProblem" value="${previousInvestigationProblem}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the outcome?</td>
					<td><input type="text" id="previousInvestigationOutcome" name="previousInvestigationOutcome" value="${previousInvestigationOutcome}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="previousInvestigationRecord" name="previousInvestigationRecord" value="${previousInvestigationRecord}" size="50"></td>
				</tr>								

				<tr><td>&nbsp;</td></tr>

				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Received the following vaccinations?&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BCG?</td>
					<td>
						<c:if test="${BCG == 'Yes'}">
							<input type="radio" id="BCG" name="BCG" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							<input type="radio" id="BCG" name="BCG"   value="No">No &nbsp;&nbsp;&nbsp;
							<input type="radio" id="BCG" name="BCG"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:if>
							<c:if test="${BCG  == 'No'}">
							<input type="radio" id="BCG" name="BCG"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
							<input type="radio" id="BCG" name="BCG" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
							<input type="radio" id="BCG" name="BCG"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:if>
							<c:if test="${BCG  == 'Not Sure' || BCG  == '' || BCG  == null}">
							<input type="radio" id="BCG" name="BCG"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
							<input type="radio" id="BCG" name="BCG" value="No"  value="No">No &nbsp;&nbsp;&nbsp;
							<input type="radio" id="BCG" name="BCG"   checked="checked">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 Polio Doses?</td>
					<td>
						<c:if test="${polio == 'Yes'}">
						<input type="radio" id="polio" name="polio" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="polio" name="polio"   value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="polio" name="polio"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${polio  == 'No'}">
						<input type="radio" id="polio" name="polio"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="polio" name="polio" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="polio" name="polio"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${polio  == 'Not Sure' || polio  == '' || polio  == null}">
						<input type="radio" id="polio" name="polio"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="polio" name="polio" value="No"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="polio" name="polio"   checked="checked">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>				
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3DPT/ Pentavalent Doses?</td>
					<td>
						<c:if test="${DPT == 'Yes'}">
						<input type="radio" id="DPT" name="DPT" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="DPT" name="DPT"   value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="DPT" name="DPT"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${DPT  == 'No'}">
						<input type="radio" id="DPT" name="DPT"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="DPT" name="DPT" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="DPT" name="DPT"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${DPT  == 'Not Sure' || DPT  == '' || DPT  == null}">
						<input type="radio" id="DPT" name="DPT"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="DPT" name="DPT" value="No"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="DPT" name="DPT"   checked="checked">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>					
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Measles?</td>
					<td>
						<c:if test="${measles == 'Yes'}">
						<input type="radio" id="measles" name="measles" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="measles" name="measles"   value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="measles" name="measles"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${measles  == 'No'}">
						<input type="radio" id="measles" name="measles"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="measles" name="measles" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="measles" name="measles"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${measles  == 'Not Sure' || measles  == '' || measles  == null}">
						<input type="radio" id="measles" name="measles"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="measles" name="measles" value="No"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="measles" name="measles"   checked="checked">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>				
					</td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pneumococcal?</td>
					<td>
						<c:if test="${pneumococcal == 'Yes'}">
						<input type="radio" id="pneumococcal" name="pneumococcal" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="pneumococcal" name="pneumococcal"   value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="pneumococcal" name="pneumococcal"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${pneumococcal  == 'No'}">
						<input type="radio" id="pneumococcal" name="pneumococcal"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="pneumococcal" name="pneumococcal" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="pneumococcal" name="pneumococcal"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${pneumococcal  == 'Not Sure' || pneumococcal  == '' || pneumococcal  == null}">
						<input type="radio" id="pneumococcal" name="pneumococcal"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="pneumococcal" name="pneumococcal" value="No"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="pneumococcal" name="pneumococcal"   checked="checked">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>	
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yellow Fever?</td>
					<td>
						<c:if test="${yellowFever == 'Yes'}">
						<input type="radio" id="yellowFever" name="yellowFever" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="yellowFever" name="yellowFever"   value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="yellowFever" name="yellowFever"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${yellowFever  == 'No'}">
						<input type="radio" id="yellowFever" name="yellowFever"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="yellowFever" name="yellowFever" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="yellowFever" name="yellowFever"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${yellowFever  == 'Not Sure' || yellowFever  == '' || yellowFever  == null}">
						<input type="radio" id="yellowFever" name="yellowFever"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="yellowFever" name="yellowFever" value="No"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="yellowFever" name="yellowFever"   checked="checked">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>	
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5 Tetanus Doses (If Female)?</td>
					<td>
						<c:if test="${tetanusFemale == 'Yes'}">
							<input type="radio" id="tetanusFemale" name="tetanusFemale" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							<input type="radio" id="tetanusFemale" name="tetanusFemale"   value="No">No &nbsp;&nbsp;&nbsp;
							<input type="radio" id="tetanusFemale" name="tetanusFemale"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:if>
							<c:if test="${tetanusFemale  == 'No'}">
							<input type="radio" id="tetanusFemale" name="tetanusFemale"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
							<input type="radio" id="tetanusFemale" name="tetanusFemale" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
							<input type="radio" id="tetanusFemale" name="tetanusFemale"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:if>
							<c:if test="${tetanusFemale  == 'Not Sure' || tetanusFemale  == '' || tetanusFemale  == null}">
							<input type="radio" id="tetanusFemale" name="tetanusFemale"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
							<input type="radio" id="tetanusFemale" name="tetanusFemale" value="No"  value="No">No &nbsp;&nbsp;&nbsp;
							<input type="radio" id="tetanusFemale" name="tetanusFemale"   checked="checked">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>	
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 Tetanus Doses (If Male)?</td>
					<td>
						<c:if test="${tetanusMale == 'Yes'}">
						<input type="radio" id="tetanusMale" name="tetanusMale" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusMale" name="tetanusMale"   value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusMale" name="tetanusMale"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${tetanusMale  == 'No'}">
						<input type="radio" id="tetanusMale" name="tetanusMale"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusMale" name="tetanusMale" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusMale" name="tetanusMale"   value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${tetanusMale  == 'Not Sure' || tetanusMale  == '' || tetanusMale  == null}">
						<input type="radio" id="tetanusMale" name="tetanusMale"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusMale" name="tetanusMale" value="No"  value="No">No &nbsp;&nbsp;&nbsp;
						<input type="radio" id="tetanusMale" name="tetanusMale"   checked="checked">Not Sure &nbsp;&nbsp;&nbsp;
						</c:if>	
					</td>
				</tr>

				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other?</td>
					<td>
						<input name="otherVaccinations" id="otherVaccinations" value="${otherVaccinations}" size="50" type="text">
					</td>
				</tr>								
				<tr><td>&nbsp;</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td><b class="boxHeader">Drug History</b></td>
				<td><b class="boxHeader"><u>&nbsp;</u></b></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Current medications? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${currentMedication == 'Yes'}">
						<input type="radio" id="currentMedication" name="currentMedication" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="currentMedication" name="currentMedication"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${currentMedication  == 'No' || currentMedication  == '' || currentMedication  == null}">
						<input type="radio" id="currentMedication" name="currentMedication"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="currentMedication" name="currentMedication" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the medication?</td>
					<td><input type="text" id="medicationName" name="medicationName" value="${medicationName}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For how long it has been taken?</td>
					<td><input type="text" id="medicationPeriod" name="medicationPeriod" value="${medicationPeriod}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Why is it being taken?</td>
					<td><input type="text" id="medicationReason" name="medicationReason" value="${medicationReason}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Where are the Medical Records?</td>
					<td><input type="text" id="medicationRecord" name="medicationRecord" value="${medicationRecord}" size="50"></td>
				</tr>
				
								<tr><td>&nbsp;</td></tr>
								
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any medication you are sensitive to? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${sensitiveMedication == 'Yes'}">
						<input type="radio" id="sensitiveMedication" name="sensitiveMedication" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="sensitiveMedication" name="sensitiveMedication"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${sensitiveMedication  == 'No' || sensitiveMedication == '' || sensitiveMedication  == null}">
						<input type="radio" id="sensitiveMedication" name="sensitiveMedication"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="sensitiveMedication" name="sensitiveMedication" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the medication?</td>
					<td><input type="text" id="sensitiveMedicationName" name="sensitiveMedicationName" value="${sensitiveMedicationName}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What are the symptoms you experience?</td>
					<td><input type="text" id="sensitiveMedicationSymptom" name="sensitiveMedicationSymptom" value="${sensitiveMedicationSymptom}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Are you using any invasive contraception? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${invasiveContraception == 'Yes'}">
						<input type="radio" id="invasiveContraception" name="invasiveContraception" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="invasiveContraception" name="invasiveContraception"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${invasiveContraception  == 'No' || invasiveContraception  == '' || invasiveContraception  == null}">
						<input type="radio" id="invasiveContraception" name="invasiveContraception"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="invasiveContraception" name="invasiveContraception" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the medication?</td>
					<td>
						 <c:choose> 
							<c:when test="${invasiveContraceptionName != ''}">	
								 <c:choose> 
								<c:when test="${invasiveContraceptionName != null}"> 
									<input type="text" id="invasiveContraceptionName" name="invasiveContraceptionName" value="${invasiveContraceptionName}">
								</c:when> 

								<c:otherwise> 
								<select id="invasiveContraceptionName" name="invasiveContraceptionName">
										<option value=""></option>
										<option value="Oral Pills">Oral Pills</option>
										<option value="IUD">IUD</option>
										<option value="Injectable Hormones">Injectable Hormones</option>
										<option value="Gels">Gels</option>
										<option value="Others">Others</option>
								</select>
								</c:otherwise> 
								 </c:choose> 		
							</c:when>
								<c:otherwise> 
									<select id="invasiveContraceptionName" name="invasiveContraceptionName">
										<option value=""></option>
										<option value="Oral Pills">Oral Pills</option>
										<option value="IUD">IUD</option>
										<option value="Injectable Hormones">Injectable Hormones</option>
										<option value="Gels">Gels</option>
										<option value="Others">Others</option>
								</select>
								</c:otherwise> 
							
							</c:choose>
					</td>
				</tr>

				<tr><td>&nbsp;</td></tr>
				<tr><td>&nbsp;</td></tr>

				<tr><td><b class="boxHeader">Family History</b></td>
				<td><b class="boxHeader"><u>&nbsp;</u></b></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Status of father? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${fatherStatus == 'Alive'  || fatherStatus  == '' || fatherStatus  == null}">
						<input type="radio" id="fatherStatus" name="fatherStatus" checked="checked" value="Alive">Alive &nbsp;&nbsp;&nbsp;
						<input type="radio" id="fatherStatus" name="fatherStatus"   value="Dead">Dead &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${fatherStatus  == 'Dead'}">
						<input type="radio" id="fatherStatus" name="fatherStatus" value="Alive">Alive &nbsp;&nbsp;&nbsp;
						<input type="radio" id="fatherStatus" name="fatherStatus" checked="checked"  value="Dead">Dead &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the cause of death?</td>
					<td><input type="text" id="fatherDeathCause" name="fatherDeathCause" value="${fatherDeathCause}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How old were they?</td>
					<td><input type="text" id="fatherDeathAge" name="fatherDeathAge" value="${fatherDeathAge}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Status of mother? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${motherStatus == 'Alive'  || motherStatus  == '' || motherStatus  == null}">
						<input type="radio" id="motherStatus" name="motherStatus" checked="checked" value="Alive">Alive &nbsp;&nbsp;&nbsp;
						<input type="radio" id="motherStatus" name="motherStatus"   value="Dead">Dead &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${motherStatus  == 'Dead'}">
						<input type="radio" id="motherStatus" name="motherStatus" value="Alive">Alive &nbsp;&nbsp;&nbsp;
						<input type="radio" id="motherStatus" name="motherStatus" checked="checked"  value="Dead">Dead &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the cause of death?</td>
					<td><input type="text" id="motherDeathCause" name="motherDeathCause" value="${motherDeathCause}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How old were they?</td>
					<td><input type="text" id="motherDeathAge" name="motherDeathAge" value="${motherDeathAge}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Status of siblings? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${siblingStatus == 'Alive' || siblingStatus  == '' || siblingStatus  == null}">
						<input type="radio" id="siblingStatus" name="siblingStatus" checked="checked" value="Alive">Alive &nbsp;&nbsp;&nbsp;
						<input type="radio" id="siblingStatus" name="siblingStatus"   value="Dead">Dead &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${siblingStatus  == 'Dead' }">
						<input type="radio" id="siblingStatus" name="siblingStatus"  value="Alive">Alive &nbsp;&nbsp;&nbsp;
						<input type="radio" id="siblingStatus" name="siblingStatus" checked="checked"  value="Dead">Dead &nbsp;&nbsp;&nbsp;
						</c:if>					
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What was the cause of death?</td>
					<td><input type="text" id="siblingDeathCause" name="siblingDeathCause" value="${siblingDeathCause}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;How old were they?</td>
					<td><input type="text" id="siblingDeathAge" name="siblingDeathAge" value="${siblingDeathAge}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;Any family history of the following illness?</td>
					<td>
						<select id="familyIllnessHistory" name="familyIllnessHistory" >
							<option value="${familyIllnessHistory}">${familyIllnessHistory}</option>
							<option value="Hypertension">Hypertension</option>
							<option value="Tuberculosis">Tuberculosis</option>
							<option value="Stroke">Stroke</option>
							<option value="Sudden Death">Sudden Death</option>
							<option value="Asthma">Asthma</option>
							<option value="Diabetes">Diabetes</option>
							<option value="Others">Others</option>
							<option value="None">None</option>
						</select>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>&nbsp;</td></tr>

				<tr><td><b class="boxHeader">Personal and Social History</b></td>
				<td><b class="boxHeader"><u>&nbsp;</u></b></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you smoke? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${smoke == 'Yes'}">
						<input type="radio" id="smoke" name="smoke" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="smoke" name="smoke"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${smoke  == 'No' || smoke  == '' || smoke  == null}">
						<input type="radio" id="smoke" name="smoke"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="smoke" name="smoke" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What do you smoke?</td>
					<td><input type="text" id="smokeItem" name="smokeItem" value="${smokeItem}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is your average in a day?</td>
					<td><input type="text" id="smokeAverage" name="smokeAverage" value="${smokeAverage}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you drink alcohol?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${alcohol == 'Yes'}">
						<input type="radio" id="alcohol" name="alcohol" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="alcohol" name="alcohol"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${alcohol  == 'No' || alcohol  == '' || alcohol  == null}">
						<input type="radio" id="alcohol" name="alcohol"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="alcohol" name="alcohol" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What alcohol do you drink?</td>
					<td><input type="text" id="alcoholItem" name="alcoholItem" value="${alcoholItem}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is your average in a day?</td>
					<td><input type="text" id="alcoholAverage" name="alcoholAverage" value="${alcoholAverage}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you take any recreational drugs?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${drug == 'Yes'}">
						<input type="radio" id="drug" name="drug" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="drug" name="drug"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${drug  == 'No' || drug  == '' || drug  == null}">
						<input type="radio" id="drug" name="drug"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="drug" name="drug" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What drugs do you take?</td>
					<td><input type="text" id="drugItem" name="drugItem" value="${drugItem}" size="50"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is your average in a day?</td>
					<td><input type="text" id="drugAverage" name="drugAverage" value="${drugAverage}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Are you aware of your current HIV status?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${hivStatus == 'Yes'}">
						<input type="radio" id="hivStatus" name="hivStatus" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="hivStatus" name="hivStatus"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${hivStatus  == 'No' || hivStatus  == '' || hivStatus  == null}">
						<input type="radio" id="hivStatus" name="hivStatus"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="hivStatus" name="hivStatus" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>						
					</td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Have you been exposed to any HIV/ AIDS factor in the past year, or since your last HIV Test?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${exposedHiv == 'Yes'}">
						<input type="radio" id="exposedHiv" name="exposedHiv" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="exposedHiv" name="exposedHiv"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${exposedHiv  == 'No' || exposedHiv  == '' || exposedHiv  == null}">
						<input type="radio" id="exposedHiv" name="exposedHiv"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="exposedHiv" name="exposedHiv" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>					
					</td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Which factors?</td>
					<td><input type="text" id="exposedHivFactor" name="exposedHivFactor" value="${exposedHivFactor}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any close member in the family who can support during illness?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${familyHelp == 'Yes'}">
						<input type="radio" id="familyHelp" name="familyHelp" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="familyHelp" name="familyHelp"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${familyHelp  == 'No' || familyHelp  == '' || familyHelp  == null}">
						<input type="radio" id="familyHelp" name="familyHelp"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="familyHelp" name="familyHelp" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>						
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Who else can support you during illness?</td>
					<td><input type="text" id="otherHelp" name="otherHelp" value="${otherHelp}" size="50"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you have a regular source of income?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:if test="${incomeSource == 'Yes'}">
						<input type="radio" id="incomeSource" name="incomeSource" checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" 
						id="incomeSource" name="incomeSource"   value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${incomeSource  == 'No' || incomeSource  == '' || incomeSource  == null}">
						<input type="radio" id="incomeSource" name="incomeSource"  value="Yes">Yes &nbsp;&nbsp;&nbsp;
						<input type="radio" id="incomeSource" name="incomeSource" checked="checked"  value="No">No &nbsp;&nbsp;&nbsp;
						</c:if>
					</td>
				</tr>
			
			<tr><td>&nbsp;</td></tr>
			<tr>
			<td>&nbsp;</td>
			<td>
				<input class="ui-button ui-widget ui-state-default ui-corner-all"  id="saveButton" type="submit" value="Update details" />
			</td>
			</tr>
</table>
</form>
</div> <!-- end of editableDiv -->
</td>
</tr>
</table>

