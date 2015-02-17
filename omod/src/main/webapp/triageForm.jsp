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

.className:AFTER{
background-color:#FF0000;
}

.classname1 {
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
	width:250px;
	text-decoration:none;
	text-align:center;
}
.classname1:hover{
	background-color:#FFDD57;
}

.classname1:active {
	position:relative;
	top:1px;
	cursor : pointer;
	background-color:#FFDD57;
}

.red
{
    background-color:red;
}
</style>

<script type="text/javascript">
	jQuery(document).ready(
			function() {
			jQuery("#opdMessgaeLbl").hide();
			var history = document.getElementById("patientHistoryDiv");
			var medical = document.getElementById("medicalDiv");
			var drug = document.getElementById("drugDiv");
			var family = document.getElementById("familyDiv");
			var personal = document.getElementById("personalDiv");
			history.style.display="none";
			medical.style.display="none";
			drug.style.display="none";
			family.style.display="none";
			personal.style.display="none";

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
	  alert("Please enter Abdominal Circumference in correct format");
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
			
 re = /^\d{1,2}\/\d{1,2}\/\d{4}$/; 
 if(jQuery("#lastMenstrualPeriod").val() != '' && !jQuery("#lastMenstrualPeriod").val().match(re)) 
 {
 alert("Invalid date format");
 jQuery("#lastMenstrualPeriod").val('');
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


var history = document.getElementById("patientHistoryDiv");
var triage = document.getElementById("triageVitalData");
var medical = document.getElementById("medicalDiv");
var drug = document.getElementById("drugDiv");
var family = document.getElementById("familyDiv");
var personal = document.getElementById("personalDiv");


if (history.style.display=="inline" ) {
history.style.display="none";
triage.style.display="inline";
medical.style.display="none";
drug.style.display="none";
family.style.display="none";
personal.style.display="none";
}
else {
history.style.display="inline";
triage.style.display="none";
medical.style.display="inline";
drug.style.display="none";
family.style.display="none";
personal.style.display="none";
}
};

function ShowVitalForm () {

var history = document.getElementById("patientHistoryDiv");
var triage = document.getElementById("triageVitalData");
var medical = document.getElementById("medicalDiv");
var drug = document.getElementById("drugDiv");
var family = document.getElementById("familyDiv");
var personal = document.getElementById("personalDiv");

if (triage.style.display=="inline" ) {
triage.style.display="none";
history.style.display="inline";
medical.style.display="inline";
drug.style.display="inline";
family.style.display="inline";
personal.style.display="inline";
}
else {
triage.style.display="inline";
history.style.display="none";
medical.style.display="none";
drug.style.display="none";
family.style.display="none";
personal.style.display="none";
}
}


function OnSelectOpd(){
if($('#opd :selected').text()=="-Please select-")
{
	$("#opdMessgaeLbl").hide();
}
else
{
	$("#opdMessgaeLbl").show();
}
}


function ShowMedicalDiv () {
var history = document.getElementById("patientHistoryDiv");
var triage = document.getElementById("triageVitalData");
var medical = document.getElementById("medicalDiv");
var drug = document.getElementById("drugDiv");
var family = document.getElementById("familyDiv");
var personal = document.getElementById("personalDiv");


history.style.display="inline";
triage.style.display="none";
medical.style.display="inline";
drug.style.display="none";
family.style.display="none";
personal.style.display="none";

};


function ShowDrugDiv () {
var history = document.getElementById("patientHistoryDiv");
var triage = document.getElementById("triageVitalData");
var medical = document.getElementById("medicalDiv");
var drug = document.getElementById("drugDiv");
var family = document.getElementById("familyDiv");
var personal = document.getElementById("personalDiv");


history.style.display="inline";
triage.style.display="none";
medical.style.display="none";
drug.style.display="inline";
family.style.display="none";
personal.style.display="none";

};


function ShowFamilyDiv () {
var history = document.getElementById("patientHistoryDiv");
var triage = document.getElementById("triageVitalData");
var medical = document.getElementById("medicalDiv");
var drug = document.getElementById("drugDiv");
var family = document.getElementById("familyDiv");
var personal = document.getElementById("personalDiv");


history.style.display="inline";
triage.style.display="none";
medical.style.display="none";
drug.style.display="none";
family.style.display="inline";
personal.style.display="none";

};


function ShowPersonalDiv () {
var history = document.getElementById("patientHistoryDiv");
var triage = document.getElementById("triageVitalData");
var medical = document.getElementById("medicalDiv");
var drug = document.getElementById("drugDiv");
var family = document.getElementById("familyDiv");
var personal = document.getElementById("personalDiv");

history.style.display="inline";
triage.style.display="none";
medical.style.display="none";
drug.style.display="none";
family.style.display="none";
personal.style.display="inline";

};



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
					else {	
						if(${existingIllnessProblem !='' && existingIllnessProblem != null} ){
							$("input[name=existingIllnessProblem]").attr("disabled", "disabled");
						}
						else{
							$("input[name=existingIllnessProblem]").removeAttr("disabled");
						}
						if(${existingIllnessLong != ''} && ${existingIllnessLong != null}){
							$("input[name=existingIllnessLong]").attr("disabled", "disabled");
						}
						else{
							$("input[name=existingIllnessLong]").removeAttr("disabled");
						}
						if(${existingIllnessProgress != ''} && ${existingIllnessProgress != null}){
							$("input[name=existingIllnessProgress]").attr("disabled", "disabled");
						}
						else{
							$("input[name=existingIllnessProgress]").removeAttr("disabled");
						}	
						if(${existingIllnessRecord != ''} && ${existingIllnessRecord != null}){
							$("input[name=existingIllnessRecord]").attr("disabled", "disabled");
						}
						else{
							$("input[name=existingIllnessRecord]").removeAttr("disabled");
						}	
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
						else{
						if(${chronicIllnessProblem != ''} && ${chronicIllnessProblem != null}){
							$("input[name=chronicIllnessProblem]").attr("disabled", "disabled");
						}
						else{
							$("input[name=chronicIllnessProblem]").removeAttr("disabled");
						}	
						
						if(${chronicIllnessOccure != ''} && ${chronicIllnessOccure != null}){
							$("input[name=chronicIllnessOccure]").attr("disabled", "disabled");
						}
						else{
							$("input[name=chronicIllnessOccure]").removeAttr("disabled");
						}	
						
						if(${chronicIllnessOutcome != ''} && ${chronicIllnessOutcome != null}){
							$("input[name=chronicIllnessOutcome]").attr("disabled", "disabled");
						}
						else{
							$("input[name=chronicIllnessOutcome]").removeAttr("disabled");
						}
						
						if(${chronicIllnessRecord != ''} && ${chronicIllnessRecord != null}){
							$("input[name=chronicIllnessRecord]").attr("disabled", "disabled");
						}
						else{
							$("input[name=chronicIllnessRecord]").removeAttr("disabled");
						}	
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
						else{
						if(${previousAdmissionWhen != ''} && ${previousAdmissionWhen != null}){
							$("input[name=previousAdmissionWhen]").attr("disabled", "disabled");
						}
						else {
							$("input[name=previousAdmissionWhen]").removeAttr("disabled");
						}	
						
						if(${previousAdmissionProblem != ''} && ${previousAdmissionProblem != null}){
							$("input[name=previousAdmissionProblem]").attr("disabled", "disabled");
						}
						else {
							$("input[name=previousAdmissionProblem]").removeAttr("disabled");
						}	
						
						if(${previousAdmissionOutcome != ''} && ${previousAdmissionOutcome != null}){
							$("input[name=previousAdmissionOutcome]").attr("disabled", "disabled");
						}
						else{
							$("input[name=previousAdmissionOutcome]").removeAttr("disabled");
						}
						if(${previousAdmissionRecord != ''} && ${previousAdmissionRecord != null}){
							$("input[name=previousAdmissionRecord]").attr("disabled", "disabled")
						}
						else {
							$("input[name=previousAdmissionRecord]").removeAttr("disabled");
						}
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
					else {
						if(${previousInvestigationProblem != ''} && ${previousInvestigationProblem != null}){
							$("input[name=previousInvestigationWhen]").attr("disabled", "disabled");
						}
						else {
							$("input[name=previousInvestigationWhen]").removeAttr("disabled"); }
						
						if(${previousInvestigationProblem != ''} && ${previousInvestigationProblem != null}){
							$("input[name=previousInvestigationProblem]").attr("disabled", "disabled");
						}
						else {
							$("input[name=previousInvestigationProblem]").removeAttr("disabled"); }
						if(${previousInvestigationOutcome != ''} && ${previousInvestigationOutcome != null})
						{
							$("input[name=previousInvestigationOutcome]").attr("disabled", "disabled");
						}
						else{
							$("input[name=previousInvestigationOutcome]").removeAttr("disabled"); 
						}
						
						if(${previousInvestigationRecord != ''} && ${previousInvestigationRecord != null})
						{
							$("input[name=previousInvestigationRecord]").attr("disabled", "disabled")
						}
						else {
							$("input[name=previousInvestigationRecord]").removeAttr("disabled") ;
						}
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
					else{
						if(${medicationName != ''} && ${medicationName != null})
						{
							$("input[name=medicationName]").attr("disabled", "disabled")
						}
						else {
							$("input[name=medicationName]").removeAttr("disabled");
						}
						if(${medicationPeriod != ''} && ${medicationPeriod != null})
						{
							$("input[name=medicationPeriod]").attr("disabled", "disabled")
						}
						else {
							$("input[name=medicationPeriod]").removeAttr("disabled");
						}
						if(${medicationReason != ''} && ${medicationReason != null})
						{
							$("input[name=medicationReason]").attr("disabled", "disabled")
						}
						else {
							$("input[name=medicationReason]").removeAttr("disabled");
						}
						if(${medicationRecord != ''} && ${medicationRecord != null})
						{
							$("input[name=medicationRecord]").attr("disabled", "disabled")
						}
						else {
							$("input[name=medicationRecord]").removeAttr("disabled");
						}
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
						else{
						if(${sensitiveMedicationName != ''} && ${sensitiveMedicationName != null})
						{
							$("input[name=sensitiveMedicationName]").attr("disabled", "disabled")
						}
						else {
						$("input[name=sensitiveMedicationName]").removeAttr("disabled");
						}
						
						if(${sensitiveMedicationSymptom != ''} && ${sensitiveMedicationSymptom != null})
						{
							$("input[name=sensitiveMedicationSymptom]").attr("disabled", "disabled")
						}
						else {
						$("input[name=sensitiveMedicationSymptom]").removeAttr("disabled");
						}
					}
					}
				};
				
				var invasiveContraception = function (element) {
					if(element.value == "No") {
				
						jQuery("#invasiveContraceptionName").attr("disabled", "disabled");
						jQuery("#invasiveContraceptionName").val("");
					}
					
					else{
						jQuery("#invasiveContraceptionName").removeAttr("disabled");
					
							
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
					if( ${visitStatus =='New Patient'}  ){
						$("input[name=fatherDeathCause]").removeAttr("disabled");
						$("input[name=fatherDeathAge]").removeAttr("disabled");	
					}
					else{
						if(${fatherDeathCause != ''} && ${fatherDeathCause != null})
						{
							$("input[name=fatherDeathCause]").attr("disabled", "disabled")
						}
						else {
							$("input[name=fatherDeathCause]").removeAttr("disabled");
						}	
						if(${fatherDeathAge != ''} && ${fatherDeathAge != null})
						{
							$("input[name=fatherDeathAge]").attr("disabled", "disabled")
						}
						else {
							$("input[name=fatherDeathAge]").removeAttr("disabled");
						}	
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
					if( ${visitStatus =='New Patient'}  ){
						$("input[name=motherDeathCause]").removeAttr("disabled");
						$("input[name=motherDeathAge]").removeAttr("disabled");	
					}
					else{
						if(${motherDeathCause != ''} && ${motherDeathCause != null})
						{
							$("input[name=motherDeathCause]").attr("disabled", "disabled")
						}
						else {
							$("input[name=motherDeathCause]").removeAttr("disabled");
						}	
						if(${motherDeathAge != ''} && ${motherDeathAge != null})
						{
							$("input[name=motherDeathAge]").attr("disabled", "disabled")
						}
						else {
							$("input[name=motherDeathAge]").removeAttr("disabled");
						}	
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
					if( ${visitStatus =='New Patient'}  ){
						$("input[name=siblingDeathCause]").removeAttr("disabled");
						$("input[name=siblingDeathAge]").removeAttr("disabled");	
					}
					else{
						if(${siblingDeathCause != ''} && ${siblingDeathCause != null})
						{
							$("input[name=siblingDeathCause]").attr("disabled", "disabled")
						}
						else {
							$("input[name=siblingDeathCause]").removeAttr("disabled");
						}
						
						if(${siblingDeathAge != ''} && ${siblingDeathAge != null})
						{
							$("input[name=siblingDeathAge]").attr("disabled", "disabled")
						}
						else {
						$("input[name=siblingDeathAge]").removeAttr("disabled");	
						}		
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
					if( ${visitStatus =='New Patient'}  ){
						$("input[name=smokeItem]").removeAttr("disabled");
						$("input[name=smokeAverage]").removeAttr("disabled");						
					}
					else{	if(${smokeItem != ''} && ${smokeItem != null})
						{
							$("input[name=smokeItem]").attr("disabled", "disabled")
						}
						else {
							$("input[name=smokeItem]").removeAttr("disabled");
						}
						if(${smokeAverage != ''} && ${smokeAverage != null})
						{
							$("input[name=smokeAverage]").attr("disabled", "disabled")
						}
						else {
						$("input[name=smokeAverage]").removeAttr("disabled");						
						}
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
					if( ${visitStatus =='New Patient'}  ){
						$("input[name=alcoholItem]").removeAttr("disabled");
						$("input[name=alcoholAverage]").removeAttr("disabled");						
					}
					else{
						if(${alcoholItem != ''} && ${alcoholItem != null})
						{
							$("input[name=alcoholItem]").attr("disabled", "disabled")
						}
						else {
						$("input[name=alcoholItem]").removeAttr("disabled");
						}
						if(${alcoholAverage != ''} && ${alcoholAverage != null})
						{
							$("input[name=alcoholAverage]").attr("disabled", "disabled")
						}
						else {
							$("input[name=alcoholAverage]").removeAttr("disabled");						
							}
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
					else {
					if( ${visitStatus =='New Patient'}  ){
						$("input[name=drugItem]").removeAttr("disabled");
						$("input[name=drugAverage]").removeAttr("disabled");						
					}
					else{
						if(${drugItem != ''} && ${drugItem != null})
						{
							$("input[name=drugItem]").attr("disabled", "disabled")
						}
						else {
							$("input[name=drugItem]").removeAttr("disabled");
							}	
						if(${drugAverage != ''} && ${drugAverage != null})
						{
							$("input[name=drugAverage]").attr("disabled", "disabled")
						}
						else {
							$("input[name=drugAverage]").removeAttr("disabled");						
						}	
					}
					}
				};

				var exposedHiv = function (element) {
					if(element.value == "No") {
						$("input[name=exposedHivFactor]").attr("disabled", "disabled");
						jQuery("#exposedHivFactor").val("");
					}
					else {
					if( ${visitStatus =='New Patient'}  ){
						$("input[name=exposedHivFactor]").removeAttr("disabled");
					}
					else{
						if(${exposedHivFactor != ''} && ${exposedHivFactor != null})
						{
							$("input[name=exposedHivFactor]").attr("disabled", "disabled")
						}
						else {
						$("input[name=exposedHivFactor]").removeAttr("disabled");
						}
					}
					}
				};
				
				var familyHelp = function (element) {
					if(element.value == "Yes") {
						$("input[name=otherHelp]").attr("disabled", "disabled");
						jQuery("#otherHelp").val("");
					}
					else {
					if( ${visitStatus =='New Patient'}  ){
						$("input[name=otherHelp]").removeAttr("disabled");
					}
					else{
					if(${otherHelp != ''} && ${otherHelp != null})
						{
							$("input[name=otherHelp]").attr("disabled", "disabled")
						}
						else {
							$("input[name=otherHelp]").removeAttr("disabled");
						}	
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
				${patient.givenName}&nbsp;${patient.familyName}&nbsp; ${fn:replace(patient.middleName,',',' ')}
				</td>
			<td width="30%"><b>Age:</b> ${age }</td>
			<td width="30%"><b>Gender:</b>
			<c:choose>
					<c:when test="${patient.gender eq 'M'}">
					Male
				</c:when>
				<c:otherwise>
					Female
				</c:otherwise>
				</c:choose>
				</td>
		</tr>
			<td width="40%"><b>Payment Category:</b> ${selectedCategory }</td>
			<td width="30%"><b>Visit Status:</b> ${visitStatus }</td>
			<td width="30%"><b>Previous Visit:</b> <openmrs:formatDate date="${ob.obsDatetime }" /> at ${opdPatientQueueLog.opdConceptName}</td>

		</tr>
	</table>
		<br><br>
	<div id="tabs">
	 <b class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
		&nbsp;<input id="vitalButton" name="formVitalButton" type="button" onclick="ShowVitalForm();" value="Vital Statistics" class="classname"> 
		<input id="patientHistoryButton"  type="button" onclick="ShowForm();" value="Patient History" class="classname">
	</b>
	

	<form id="triageForm" method="POST" onsubmit="javascript:return validate();">
		
		<table id="triageVitalData">
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>Weight (Kg)</td>
				<td><input type="text" id="weight" name="weight" size="8"  maxlength="7">
				</td>
			</tr>
			<tr>
				<td>Height (cm)</td>
				<td><input type="text" id="height" name="height" size="8"  maxlength="7">
				</td>
			</tr>
			<tr>
				<td>MUA Circumference(cm)</td>
				<td><input type="text" id="mua" name="mua" size="8"  maxlength="7">
				</td>
			</tr>
			<tr>
				<td>Chest Circumference(cm)</td>
				<td><input type="text" id="chest" name="chest" size="8"  maxlength="7"></td>
			</tr>
			<tr>
				<td>Abdominal Circumference(cm)</td>
				<td><input type="text" id="abdominal" name="abdominal" size="8"   maxlength="7"></td>
			</tr>
			<tr>
				<td>Temperature (degree C)</td>
				<td><input type="text" id="temperature" name="temperature"
					size="8"  maxlength="7"></td>
			</tr>
			<tr>
				<td>Systolic B.P</td>
				<td><input type="text" id="sbp" name="sbp" size="8"  maxlength="7"></td>
			</tr>
			<tr>
				<td>Diastolic B.P</td>
				<td><input type="text" id="dbp" name="dbp" size="8"  maxlength="7"></td>
			</tr>
			<tr>
				<td>Respiratory Rate</td>
				<td><input type="text" id="resRate" name="resRate" size="8"  maxlength="7">
				</td>
			</tr>
			<tr>
				<td>Pulse Rate</td>
				<td><input type="text" id="pulseRate" name="pulseRate" size="8" maxlength="7">
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
				<td><select id="opd" name="opd" style="width: 278px;" onChange="OnSelectOpd();"><option
							value="">-Please select-</option>
						<c:forEach items="${listOPD}" var="opd">
							<option value="${opd.answerConcept.id }"
								<c:if test="${opdId == opd.answerConcept.id  }">selected="selected"</c:if>>${opd.answerConcept.name}</option>
						</c:forEach>
				</select>
				</td>
				<td >
					<label id="opdMessgaeLbl" style="color: #FF0000;"><b> Please click on save button to move patient to next queue !!!</b></label>
				</td>
			</tr>
			<tr></tr>
			<tr>
				<td><input id="saveButton" type="submit" value="Save"></td>
				<td><input type="button" value="Reset"
					onclick="window.location.href=window.location.href"></td>
			</tr>
		</table>
		
	<div id="patientHistoryDiv">
			<table>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
				<div id="internalTabs">
				<b class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
					&nbsp;
					<input id="medicalButton" name="medicalButton" type="button" onclick="ShowMedicalDiv();" value="Medical and Surgical History" class="classname1"  > 
					<input id="drugButton" name="drugButton" type="button" onclick="ShowDrugDiv();" value="Drug History" class="classname1" >
					<input id="familyButton" name="familyButton" type="button" onclick="ShowFamilyDiv();" value="Family History" class="classname1" >
					<input id="personalButton" name="personalButton" type="button" onclick="ShowPersonalDiv();" value="Personal and Social History" class="classname1" >
				</b>
				</div>
			</td></tr>
			</table>
	</div> <!-- end of patientHistoryDiv -->
		
		<div id="medicalDiv">
			<table>
				<tr><td>&nbsp;</td></tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Any existing illness/ conditions? &nbsp;&nbsp;&nbsp;</td>
					<td>
						 <c:choose> 
							<c:when test="${existingIllness != null}"> 
								<c:if test="${existingIllness  == 'Yes'}">
								<input type="radio" id="existingIllness" name="existingIllness" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${existingIllness  == 'No'}">
								<input type="radio" id="existingIllness" name="existingIllness" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${existingIllness == null}"> 
								<input type="radio" id="existingIllness" name="existingIllness" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${existingIllness != null}"> 
								<c:if test="${existingIllness  == 'No'}">
								<input type="radio" id="existingIllness" name="existingIllness" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${existingIllness  == 'Yes'}">
								<input type="radio" id="existingIllness" name="existingIllness" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${existingIllness == null}"> 
								<input type="radio" id="existingIllness" name="existingIllness" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${chronicIllness != null}"> 
								<c:if test="${chronicIllness  == 'Yes'}">
								<input type="radio" id="chronicIllness" name="chronicIllness" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${chronicIllness  == 'No'}">
								<input type="radio" id="chronicIllness" name="chronicIllness" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${chronicIllness == null}"> 
								<input type="radio" id="chronicIllness" name="chronicIllness" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${chronicIllness != null}"> 
								<c:if test="${chronicIllness  == 'No'}">
								<input type="radio" id="chronicIllness" name="chronicIllness" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${chronicIllness  == 'Yes'}">
								<input type="radio" id="chronicIllness" name="chronicIllness" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${chronicIllness == null}"> 
								<input type="radio" id="chronicIllness" name="chronicIllness" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${previousAdmission != null}"> 
								<c:if test="${previousAdmission  == 'Yes'}">
								<input type="radio" id="previousAdmission" name="previousAdmission" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${previousAdmission  == 'No'}">
								<input type="radio" id="previousAdmission" name="previousAdmission" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${previousAdmission == null}"> 
								<input type="radio" id="previousAdmission" name="previousAdmission" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${previousAdmission != null}"> 
								<c:if test="${previousAdmission  == 'No'}">
								<input type="radio" id="previousAdmission" name="previousAdmission" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${previousAdmission  == 'Yes'}">
								<input type="radio" id="previousAdmission" name="previousAdmission" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${previousAdmission == null}"> 
								<input type="radio" id="previousAdmission" name="previousAdmission" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${previousInvestigation != null}"> 
								<c:if test="${previousInvestigation  == 'Yes'}">
								<input type="radio" id="previousInvestigation" name="previousInvestigation" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${previousInvestigation  == 'No'}">
								<input type="radio" id="previousInvestigation" name="previousInvestigation" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${previousInvestigation == null}"> 
								<input type="radio" id="previousInvestigation" name="previousInvestigation" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${previousInvestigation != null}"> 
								<c:if test="${previousInvestigation  == 'No'}">
								<input type="radio" id="previousInvestigation" name="previousInvestigation" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${previousInvestigation  == 'Yes'}">
								<input type="radio" id="previousInvestigation" name="previousInvestigation" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${previousInvestigation == null}"> 
								<input type="radio" id="previousInvestigation" name="previousInvestigation" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${BCG != null}"> 
								<c:if test="${BCG  == 'Yes'}">
								<input type="radio" id="BCG" name="BCG" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${BCG  != 'Yes'}">
								<input type="radio" id="BCG" name="BCG" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${BCG == null}"> 
								<input type="radio" id="BCG" name="BCG" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>

						<c:choose> 
							<c:when test="${BCG != null}"> 
								<c:if test="${BCG  == 'No'}">
								<input type="radio" id="BCG" name="BCG" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${BCG  != 'No'}">
								<input type="radio" id="BCG" name="BCG" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${BCG == null}"> 
								<input type="radio" id="BCG" name="BCG" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					
						<c:choose> 
							<c:when test="${BCG != null}"> 
								<c:if test="${BCG  == 'Not Sure'}">
								<input type="radio" id="BCG" name="BCG" disabled checked="checked" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${BCG  != 'Not Sure'}">
								<input type="radio" id="BCG" name="BCG" disabled value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${BCG == null}"> 
								<input type="radio" id="BCG" name="BCG" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 Polio Doses?</td>
					<td>
						<c:choose> 
							<c:when test="${polio != null}"> 
								<c:if test="${polio  == 'Yes'}">
								<input type="radio" id="polio" name="polio" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${polio  != 'Yes'}">
								<input type="radio" id="polio" name="polio" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${polio == null}"> 
								<input type="radio" id="polio" name="polio" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>

						<c:choose> 
							<c:when test="${polio != null}"> 
								<c:if test="${polio  == 'No'}">
								<input type="radio" id="polio" name="polio" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${polio  != 'No'}">
								<input type="radio" id="polio" name="polio" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${polio == null}"> 
								<input type="radio" id="polio" name="polio" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					
						<c:choose> 
							<c:when test="${polio != null}"> 
								<c:if test="${polio  == 'Not Sure'}">
								<input type="radio" id="polio" name="polio" disabled checked="checked" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${polio  != 'Not Sure'}">
								<input type="radio" id="polio" name="polio" disabled value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${polio == null}"> 
								<input type="radio" id="polio" name="polio" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>					
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3DPT/ Pentavalent Doses?</td>
					<td>
						<c:choose> 
							<c:when test="${DPT != null}"> 
								<c:if test="${DPT  == 'Yes'}">
								<input type="radio" id="DPT" name="DPT" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${DPT  != 'Yes'}">
								<input type="radio" id="DPT" name="DPT" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${DPT == null}"> 
								<input type="radio" id="DPT" name="DPT" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>

						<c:choose> 
							<c:when test="${DPT != null}"> 
								<c:if test="${DPT  == 'No'}">
								<input type="radio" id="DPT" name="DPT" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${DPT  != 'No'}">
								<input type="radio" id="DPT" name="DPT" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${DPT == null}"> 
								<input type="radio" id="DPT" name="DPT" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					
						<c:choose> 
							<c:when test="${DPT != null}"> 
								<c:if test="${DPT  == 'Not Sure'}">
								<input type="radio" id="DPT" name="DPT" disabled checked="checked" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${DPT  != 'Not Sure'}">
								<input type="radio" id="DPT" name="DPT" disabled value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${DPT == null}"> 
								<input type="radio" id="DPT" name="DPT" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>					
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Measles?</td>
					<td>
						<c:choose> 
							<c:when test="${measles != null}"> 
								<c:if test="${measles  == 'Yes'}">
								<input type="radio" id="measles" name="measles" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${measles  != 'Yes'}">
								<input type="radio" id="measles" name="measles" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${measles == null}"> 
								<input type="radio" id="measles" name="measles" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>

						<c:choose> 
							<c:when test="${measles != null}"> 
								<c:if test="${measles  == 'No'}">
								<input type="radio" id="measles" name="measles" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${measles  != 'No'}">
								<input type="radio" id="measles" name="measles" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${measles == null}"> 
								<input type="radio" id="measles" name="measles" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					
						<c:choose> 
							<c:when test="${measles != null}"> 
								<c:if test="${measles  == 'Not Sure'}">
								<input type="radio" id="measles" name="measles" disabled checked="checked" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${measles  != 'Not Sure'}">
								<input type="radio" id="measles" name="measles" disabled value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${measles == null}"> 
								<input type="radio" id="measles" name="measles" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>					
					</td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pneumococcal?</td>
					<td>
						<c:choose> 
							<c:when test="${pneumococcal != null}"> 
								<c:if test="${pneumococcal  == 'Yes'}">
								<input type="radio" id="pneumococcal" name="pneumococcal" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${pneumococcal  != 'Yes'}">
								<input type="radio" id="pneumococcal" name="pneumococcal" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${pneumococcal == null}"> 
								<input type="radio" id="pneumococcal" name="pneumococcal" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>

						<c:choose> 
							<c:when test="${pneumococcal != null}"> 
								<c:if test="${pneumococcal  == 'No'}">
								<input type="radio" id="pneumococcal" name="pneumococcal" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${pneumococcal  != 'No'}">
								<input type="radio" id="pneumococcal" name="pneumococcal" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${pneumococcal == null}"> 
								<input type="radio" id="pneumococcal" name="pneumococcal" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					
						<c:choose> 
							<c:when test="${pneumococcal != null}"> 
								<c:if test="${pneumococcal  == 'Not Sure'}">
								<input type="radio" id="pneumococcal" name="pneumococcal" disabled checked="checked" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${pneumococcal  != 'Not Sure'}">
								<input type="radio" id="pneumococcal" name="pneumococcal" disabled value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${pneumococcal == null}"> 
								<input type="radio" id="pneumococcal" name="pneumococcal" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>		
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yellow Fever?</td>
					<td>
						<c:choose> 
							<c:when test="${yellowFever != null}"> 
								<c:if test="${yellowFever  == 'Yes'}">
								<input type="radio" id="yellowFever" name="yellowFever" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${yellowFever  != 'Yes'}">
								<input type="radio" id="yellowFever" name="yellowFever" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${yellowFever == null}"> 
								<input type="radio" id="yellowFever" name="yellowFever" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>

						<c:choose> 
							<c:when test="${yellowFever != null}"> 
								<c:if test="${yellowFever  == 'No'}">
								<input type="radio" id="yellowFever" name="yellowFever" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${yellowFever  != 'No'}">
								<input type="radio" id="yellowFever" name="yellowFever" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${yellowFever == null}"> 
								<input type="radio" id="yellowFever" name="yellowFever" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					
						<c:choose> 
							<c:when test="${yellowFever != null}"> 
								<c:if test="${yellowFever  == 'Not Sure'}">
								<input type="radio" id="yellowFever" name="yellowFever" disabled checked="checked" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${yellowFever  != 'Not Sure'}">
								<input type="radio" id="yellowFever" name="yellowFever" disabled value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${yellowFever == null}"> 
								<input type="radio" id="yellowFever" name="yellowFever" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>		
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5 Tetanus Doses (If Female)?</td>
					<td>
					
						<c:choose> 
							<c:when test="${tetanusFemale != null}"> 
								<c:if test="${tetanusFemale  == 'Yes'}">
								<input type="radio" id="tetanusFemale" name="tetanusFemale" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${tetanusFemale  != 'Yes'}">
								<input type="radio" id="tetanusFemale" name="tetanusFemale" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${tetanusFemale == null}"> 
								<input type="radio" id="tetanusFemale" name="tetanusFemale" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>

						<c:choose> 
							<c:when test="${tetanusFemale != null}"> 
								<c:if test="${tetanusFemale  == 'No'}">
								<input type="radio" id="tetanusFemale" name="tetanusFemale" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${tetanusFemale  != 'No'}">
								<input type="radio" id="tetanusFemale" name="tetanusFemale" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${tetanusFemale == null}"> 
								<input type="radio" id="tetanusFemale" name="tetanusFemale" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					
						<c:choose> 
							<c:when test="${tetanusFemale != null}"> 
								<c:if test="${tetanusFemale  == 'Not Sure'}">
								<input type="radio" id="tetanusFemale" name="tetanusFemale" disabled checked="checked" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${tetanusFemale  != 'Not Sure'}">
								<input type="radio" id="tetanusFemale" name="tetanusFemale" disabled value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${tetanusFemale == null}"> 
								<input type="radio" id="tetanusFemale" name="tetanusFemale" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>		
					</td>
				</tr>	
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 Tetanus Doses (If Male)?</td>
					<td>
						<c:choose> 
							<c:when test="${tetanusMale != null}"> 
								<c:if test="${tetanusMale  == 'Yes'}">
								<input type="radio" id="tetanusMale" name="tetanusMale" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${tetanusMale  != 'Yes'}">
								<input type="radio" id="tetanusMale" name="tetanusMale" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${tetanusMale == null}"> 
								<input type="radio" id="tetanusMale" name="tetanusMale" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>

						<c:choose> 
							<c:when test="${tetanusMale != null}"> 
								<c:if test="${tetanusMale  == 'No'}">
								<input type="radio" id="tetanusMale" name="tetanusMale" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${tetanusMale  != 'No'}">
								<input type="radio" id="tetanusMale" name="tetanusMale" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${tetanusMale == null}"> 
								<input type="radio" id="tetanusMale" name="tetanusMale" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					
						<c:choose> 
							<c:when test="${tetanusMale != null}"> 
								<c:if test="${tetanusMale  == 'Not Sure'}">
								<input type="radio" id="tetanusMale" name="tetanusMale" disabled checked="checked" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${tetanusMale  != 'Not Sure'}">
								<input type="radio" id="tetanusMale" name="tetanusMale" disabled value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${tetanusMale == null}"> 
								<input type="radio" id="tetanusMale" name="tetanusMale" value="Not Sure">Not Sure &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>		
					</td>
				</tr>

				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other?</td>
					<td>
						
						<c:if test="${otherVaccinations  == '' || otherVaccinations  == null}">
					<input type="text" id="otherVaccinations" name="otherVaccinations"  value="${otherVaccinations}" size="50">
						</c:if>
						<c:if test="${otherVaccinations  != '' && otherVaccinations  != null}">
						<input type="text" id="otherVaccinations" name="otherVaccinations"  disabled value="${otherVaccinations}" size="50">
						</c:if>
					</td>
				</tr>								
				<tr><td>&nbsp;</td></tr>
				</table>
		</div><!-- end of medicalDiv -->
				
		<div id="drugDiv">
				<table>
				<tr><td>&nbsp;</td></tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Current medications? &nbsp;&nbsp;&nbsp;</td>
					<td>
					
						<c:choose> 
							<c:when test="${currentMedication != null}"> 
								<c:if test="${currentMedication  == 'Yes'}">
								<input type="radio" id="currentMedication" name="currentMedication" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${currentMedication  == 'No'}">
								<input type="radio" id="currentMedication" name="currentMedication" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${currentMedication == null}"> 
								<input type="radio" id="currentMedication" name="currentMedication" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${currentMedication != null}"> 
								<c:if test="${currentMedication  == 'No'}">
								<input type="radio" id="currentMedication" name="currentMedication" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${currentMedication  == 'Yes'}">
								<input type="radio" id="currentMedication" name="currentMedication" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${currentMedication == null}"> 
								<input type="radio" id="currentMedication" name="currentMedication" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${sensitiveMedication != null}"> 
								<c:if test="${sensitiveMedication  == 'Yes'}">
								<input type="radio" id="sensitiveMedication" name="sensitiveMedication" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${sensitiveMedication  == 'No'}">
								<input type="radio" id="sensitiveMedication" name="sensitiveMedication" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${sensitiveMedication == null}"> 
								<input type="radio" id="sensitiveMedication" name="sensitiveMedication" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${sensitiveMedication != null}"> 
								<c:if test="${sensitiveMedication  == 'No'}">
								<input type="radio" id="sensitiveMedication" name="sensitiveMedication" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${sensitiveMedication  == 'Yes'}">
								<input type="radio" id="sensitiveMedication" name="sensitiveMedication" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${sensitiveMedication == null}"> 
								<input type="radio" id="sensitiveMedication" name="sensitiveMedication" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${invasiveContraception != null}"> 
								<c:if test="${invasiveContraception  == 'Yes'}">
								<input type="radio" id="invasiveContraception" name="invasiveContraception" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${invasiveContraception  == 'No'}">
								<input type="radio" id="invasiveContraception" name="invasiveContraception" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${invasiveContraception == null}"> 
								<input type="radio" id="invasiveContraception" name="invasiveContraception" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${invasiveContraception != null}"> 
								<c:if test="${invasiveContraception  == 'No'}">
								<input type="radio" id="invasiveContraception" name="invasiveContraception" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${invasiveContraception  == 'Yes'}">
								<input type="radio" id="invasiveContraception" name="invasiveContraception" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${invasiveContraception == null}"> 
								<input type="radio" id="invasiveContraception" name="invasiveContraception" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What is the medication?</td>
					<td>
						 <c:choose> 
							<c:when test="${invasiveContraceptionName != ''}">	
								 <c:choose> 
								<c:when test="${invasiveContraceptionName != null}"> 
									<input type="text" id="invasiveContraceptionName" name="invasiveContraceptionName" disabled value="${invasiveContraceptionName}">
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
			</table>
		</div> <!-- end of drugDiv -->
				
				
		<div id="familyDiv">
			<table>
				<tr><td>&nbsp;</td></tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Status of father? &nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:choose> 
							<c:when test="${fatherStatus != null}"> 
								<c:if test="${fatherStatus  == 'Alive'}">
								<input type="radio" id="fatherStatus" name="fatherStatus" disabled checked="checked" value="Alive">Alive &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${fatherStatus  != 'Alive'}">
								<input type="radio" id="fatherStatus" name="fatherStatus" disabled value="Alive">Alive &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${fatherStatus == null}"> 
								<input type="radio" id="fatherStatus" name="fatherStatus" value="Alive">Alive &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${fatherStatus != null}"> 
								<c:if test="${fatherStatus  == 'Dead'}">
								<input type="radio" id="fatherStatus" name="fatherStatus" disabled checked="checked" value="Dead">Dead &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${fatherStatus  != 'Dead'}">
								<input type="radio" id="fatherStatus" name="fatherStatus" disabled value="Dead">Dead &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${fatherStatus == null}"> 
								<input type="radio" id="fatherStatus" name="fatherStatus" value="Dead">Dead &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${motherStatus != null}"> 
								<c:if test="${motherStatus  == 'Alive'}">
								<input type="radio" id="motherStatus" name="motherStatus" disabled checked="checked" value="Alive">Alive &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${motherStatus  != 'Alive'}">
								<input type="radio" id="motherStatus" name="motherStatus" disabled value="Alive">Alive &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${motherStatus == null}"> 
								<input type="radio" id="motherStatus" name="motherStatus" value="Alive">Alive &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${motherStatus != null}"> 
								<c:if test="${motherStatus  == 'Dead'}">
								<input type="radio" id="motherStatus" name="motherStatus" disabled checked="checked" value="Dead">Dead &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${motherStatus  != 'Dead'}">
								<input type="radio" id="motherStatus" name="motherStatus" disabled value="Dead">Dead &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${motherStatus == null}"> 
								<input type="radio" id="motherStatus" name="motherStatus" value="Dead">Dead &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${siblingStatus != null}"> 
								<c:if test="${siblingStatus  == 'Alive'}">
								<input type="radio" id="siblingStatus" name="siblingStatus" disabled checked="checked" value="Alive">Alive &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${siblingStatus  != 'Alive'}">
								<input type="radio" id="siblingStatus" name="siblingStatus" disabled value="Alive">Alive &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${siblingStatus == null}"> 
								<input type="radio" id="siblingStatus" name="siblingStatus" value="Alive">Alive &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${siblingStatus != null}"> 
								<c:if test="${siblingStatus  == 'Dead'}">
								<input type="radio" id="siblingStatus" name="siblingStatus" disabled checked="checked" value="Dead">Dead &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${siblingStatus  != 'Dead'}">
								<input type="radio" id="siblingStatus" name="siblingStatus" disabled value="Dead">Dead &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${siblingStatus == null}"> 
								<input type="radio" id="siblingStatus" name="siblingStatus" value="Dead">Dead &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>					
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
					
					 <c:choose> 
							<c:when test="${familyIllnessHistory != ''}">	
								 <c:choose> 
								<c:when test="${familyIllnessHistory != null}"> 
									<input type="text" id="familyIllnessHistory" name="familyIllnessHistory" disabled value="${familyIllnessHistory}">
								</c:when> 

								<c:otherwise> 
								<select id="familyIllnessHistory" name="familyIllnessHistory">
									<option value=""></option>
									<option value="Hypertension">Hypertension</option>
									<option value="Tuberculosis">Tuberculosis</option>
									<option value="Stroke">Stroke</option>
									<option value="Sudden Death">Sudden Death</option>
									<option value="Asthma">Asthma</option>
									<option value="Diabetes">Diabetes</option>
									<option value="Others">Others</option>
									<option value="None">None</option>
								</select>
					
								</c:otherwise> 
								 </c:choose> 		
							</c:when>
								<c:otherwise> 
								<select id="familyIllnessHistory" name="familyIllnessHistory">
									<option value=""></option>
									<option value="Hypertension">Hypertension</option>
									<option value="Tuberculosis">Tuberculosis</option>
									<option value="Stroke">Stroke</option>
									<option value="Sudden Death">Sudden Death</option>
									<option value="Asthma">Asthma</option>
									<option value="Diabetes">Diabetes</option>
									<option value="Others">Others</option>
									<option value="None">None</option>
								</select>
					
								</c:otherwise> 
							
							</c:choose>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
			</table>
		</div>  <!--  end of familyDiv -->
				
		<div id="personalDiv">
			<table>
				<tr><td>&nbsp;</td></tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Do you smoke? &nbsp;&nbsp;&nbsp;</td>
					<td>
						 <c:choose> 
							<c:when test="${smoke != null}"> 
								<c:if test="${smoke  == 'Yes'}">
								<input type="radio" id="smoke" name="smoke" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${smoke  == 'No'}">
								<input type="radio" id="smoke" name="smoke" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${smoke == null}"> 
								<input type="radio" id="smoke" name="smoke" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${smoke != null}"> 
								<c:if test="${smoke  == 'No'}">
								<input type="radio" id="smoke" name="smoke" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${smoke  == 'Yes'}">
								<input type="radio" id="smoke" name="smoke" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${smoke == null}"> 
								<input type="radio" id="smoke" name="smoke" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${alcohol != null}"> 
								<c:if test="${alcohol  == 'Yes'}">
								<input type="radio" id="alcohol" name="alcohol" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${alcohol  == 'No'}">
								<input type="radio" id="alcohol" name="alcohol" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${alcohol == null}"> 
								<input type="radio" id="alcohol" name="alcohol" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${alcohol != null}"> 
								<c:if test="${alcohol  == 'No'}">
								<input type="radio" id="alcohol" name="alcohol" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${alcohol  == 'Yes'}">
								<input type="radio" id="alcohol" name="alcohol" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${alcohol == null}"> 
								<input type="radio" id="alcohol" name="alcohol" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${drug != null}"> 
								<c:if test="${drug  == 'Yes'}">
								<input type="radio" id="drug" name="drug" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${drug  == 'No'}">
								<input type="radio" id="drug" name="drug" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${drug == null}"> 
								<input type="radio" id="drug" name="drug" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${drug != null}"> 
								<c:if test="${drug  == 'No'}">
								<input type="radio" id="drug" name="drug" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${drug  == 'Yes'}">
								<input type="radio" id="drug" name="drug" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${drug == null}"> 
								<input type="radio" id="drug" name="drug" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
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
						<c:choose> 
							<c:when test="${hivStatus != null}"> 
								<c:if test="${hivStatus  == 'Yes'}">
								<input type="radio" id="hivStatus" name="hivStatus" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${hivStatus  == 'No'}">
								<input type="radio" id="hivStatus" name="hivStatus" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${hivStatus == null}"> 
								<input type="radio" id="hivStatus" name="hivStatus" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${hivStatus != null}"> 
								<c:if test="${hivStatus  == 'No'}">
								<input type="radio" id="hivStatus" name="hivStatus" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${hivStatus  == 'Yes'}">
								<input type="radio" id="hivStatus" name="hivStatus" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${hivStatus == null}"> 
								<input type="radio" id="hivStatus" name="hivStatus" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>							
					</td>
				</tr>
				
				<tr>
					<td>&nbsp;&nbsp;&nbsp;Have you been exposed to any HIV/ AIDS factor in the past year, or since your last HIV Test?&nbsp;&nbsp;&nbsp;</td>
					<td>
						<c:choose> 
							<c:when test="${exposedHiv != null}"> 
								<c:if test="${exposedHiv  == 'Yes'}">
								<input type="radio" id="exposedHiv" name="exposedHiv" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${exposedHiv  == 'No'}">
								<input type="radio" id="exposedHiv" name="exposedHiv" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${exposedHiv == null}"> 
								<input type="radio" id="exposedHiv" name="exposedHiv" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${exposedHiv != null}"> 
								<c:if test="${exposedHiv  == 'No'}">
								<input type="radio" id="exposedHiv" name="exposedHiv" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${exposedHiv  == 'Yes'}">
								<input type="radio" id="exposedHiv" name="exposedHiv" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${exposedHiv == null}"> 
								<input type="radio" id="exposedHiv" name="exposedHiv" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>					
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
						<c:choose> 
							<c:when test="${familyHelp != null}"> 
								<c:if test="${familyHelp  == 'Yes'}">
								<input type="radio" id="familyHelp" name="familyHelp" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${familyHelp  == 'No'}">
								<input type="radio" id="familyHelp" name="familyHelp" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${familyHelp == null}"> 
								<input type="radio" id="familyHelp" name="familyHelp" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${familyHelp != null}"> 
								<c:if test="${familyHelp  == 'No'}">
								<input type="radio" id="familyHelp" name="familyHelp" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${familyHelp  == 'Yes'}">
								<input type="radio" id="familyHelp" name="familyHelp" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${familyHelp == null}"> 
								<input type="radio" id="familyHelp" name="familyHelp" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>							
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

						<c:choose> 
							<c:when test="${incomeSource != null}"> 
								<c:if test="${incomeSource  == 'Yes'}">
								<input type="radio" id="incomeSource" name="incomeSource" disabled checked="checked" value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${incomeSource  == 'No'}">
								<input type="radio" id="incomeSource" name="incomeSource" disabled value="Yes">Yes &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${incomeSource == null}"> 
								<input type="radio" id="incomeSource" name="incomeSource" value="Yes">Yes &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
																	
						 <c:choose> 
							<c:when test="${incomeSource != null}"> 
								<c:if test="${incomeSource  == 'No'}">
								<input type="radio" id="incomeSource" name="incomeSource" disabled checked="checked" value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${incomeSource  == 'Yes'}">
								<input type="radio" id="incomeSource" name="incomeSource" disabled value="No">No &nbsp;&nbsp;&nbsp;
								</c:if>
								
							</c:when> 
							<c:when test="${incomeSource == null}"> 
								<input type="radio" id="incomeSource" name="incomeSource" value="No">No &nbsp;&nbsp;&nbsp;
							</c:when> 	
						</c:choose>
					</td>
				</tr>
			</table>
		</div> <!--  end of personalDiv -->
				
			
	</form>
	</div>
		
</div>
<%@ include file="/WEB-INF/template/footer.jsp"%>
