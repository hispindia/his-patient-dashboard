
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
<openmrs:require privilege="View PatientDashboard"
	otherwise="/login.htm" redirect="index.htm" />
<style type="text/css">
.drug-order {
	width: 100%;
}

.drugs {
	width: 16%;
	height: 10%;
	float: left;
}

.formulation {
	width: 23%;
	height: 10%;
	float: left;
}

.frequency {
	width: 23%;
	height: 10%;
	float: left;
}

.no-of-days {
	width: 13%;
	height: 10%;
	float: left;
}

.ui-button {
	margin-left: -1px;
}

.ui-button-icon-only .ui-button-text {
	padding: 0.35em;
}

.ui-autocomplete-input {
	margin: 0;
	padding: 0.48em 0 0.47em 0.45em;
}

.floatLeft {
	width: 70%;
	float: left;
}

.floatRight {
	width: 25%;
	float: right;
}

#historyOfPresentIlness {
	resize: none;
}
</style>
<style type="text/css">
td {
	padding: 0 5px 0 5px;
}
</style>
<%--New Requirement "Editable Dashboard" --%>
<script type="text/javascript">
function getContextPath(){		
		pn = location.pathname;
		len = pn.indexOf("/", 1);				
		cp = pn.substring(0, len);
		return cp;
	}
</script>
<script type="text/javascript">
jQuery(document).ready(  
		function() { 	jQuery('#lastMenstrualPeriod').datepicker({
			yearRange : 'c-100:c+100',
			dateFormat : 'dd/mm/yy',
			changeMonth : true,
			changeYear : true
		});
		jQuery("#calendarButton").click(function() {
			jQuery("#lastMenstrualPeriod").datepicker("show");
		});	
		
		if("${patient.gender }"=="M"){
	    jQuery("#lastMenstrualPeriod").attr("disabled", "disabled");
	   	jQuery("#calendarButton").hide();
	    }
		jQuery("#lastMenstrualPeriod").change(function()
		
		{ 
			var dd = new Date().getDate();
        var mm = new Date().getMonth()+1; //January is 0!
        var yyyy = new Date().getFullYear();
        if(dd < 10)
        {
            dd = '0'+ dd;
        }
        if(mm < 10)
        {
            mm = '0' + mm;
        }
        var fromdate1 = dd+'/'+mm+'/'+yyyy;
		var lmpValue=jQuery("#lastMenstrualPeriod").val();
		if(lmpValue > fromdate1)
		{
		alert("LMP can not be a future date");
		return false;
		}
		
		});
		//Show and hide for vital statstics
		jQuery("#current").hide();
		jQuery("#triageDiv").click(function()
			    		{
			    	jQuery("#current").toggle();
			    	
			    	
			    		});
function loadSelectedDiagnosisList()
{
	if(${diagnosisIdSet}.length > 0)
	{
	var diagIdToBeAdded = ('${diagnosisIdSet}');
	
	var diagNameToBeAdded = ('${diaNameSet}');

	diagIdToBeAdded = diagIdToBeAdded.substr(1);
	diagIdToBeAdded = diagIdToBeAdded.substring(0, diagIdToBeAdded.length - 1);	
	diagNameToBeAdded = diagNameToBeAdded.substr(1);
	diagNameToBeAdded = diagNameToBeAdded.substring(0, diagNameToBeAdded.length - 1);	
	var dIdArr = diagIdToBeAdded.split(",");
	var dNameArr = diagNameToBeAdded.split(",");
	
	var sdl = $("#selectedDiagnosisList");
	for (var i = 0; i < dIdArr.length; i++)
	{ 
		 dNameArr[i] = dNameArr[i].replaceAll("@", ",");
		
	     sdl.append("<option value='" + dIdArr[i]+ "'>" +  dNameArr[i] + "</option>");
   	}
   	}
}
loadSelectedDiagnosisList();
		});
</script>
<script type="text/javascript">
function radio_fSelected()
{
	$("#lblPrompt").show();
	
}

function removePrompt()
{
	$("#lblPrompt").hide();
	
}

function removeSelectedDia()
{
$("#selectedDiagnosisList").empty();
}

function loadSelectedDiagnosisList()
{
	if(${diagnosisIdSet}.length > 0)
	{
	var diagIdToBeAdded = ('${diagnosisIdSet}');
	
	var diagNameToBeAdded = ('${diaNameSet}');
	
	diagIdToBeAdded = diagIdToBeAdded.substr(1);
	diagIdToBeAdded = diagIdToBeAdded.substring(0, diagIdToBeAdded.length - 1);	
	diagNameToBeAdded = diagNameToBeAdded.substr(1);
	diagNameToBeAdded = diagNameToBeAdded.substring(0, diagNameToBeAdded.length - 1);	
	var dIdArr = diagIdToBeAdded.split(",");
	var dNameArr = diagNameToBeAdded.split(",");
	
	var sdl = $("#selectedDiagnosisList");
	for (var i = 0; i < dIdArr.length; i++)
	{ 
		 dNameArr[i] = dNameArr[i].replaceAll("@", ",");
		
	     sdl.append("<option value='" + dIdArr[i]+ "'>" +  dNameArr[i] + "</option>");
   	}
   	}
}

</script>

<script type="text/javascript">
function stopRKey(evt) {
  var evt = (evt) ? evt : ((event) ? event : null);
  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
  if ((evt.keyCode == 13) && (node.type=="text"))  {return false;}
}

document.onkeypress = stopRKey; 

    var _ipdConceptMap = new Array();
	<c:forEach var="entry" items="${ipdConceptMap}">
		_ipdConceptMap[${entry.key}] = "${entry.value}";
	</c:forEach>

	var drugIssuedList1 = new Array();
	function addDrugOrder() {
	   var drugName=document.getElementById('drugName').value.toString();
	   if(drugName==null || drugName==""){
	   alert("Please enter drug name");
	   return false;
	   }
	   else{
	   var formulation=document.getElementById('formulation').value;
	   drugIssuedList1.push(drugName.concat("+").concat(formulation));
	  var i;var value;
	   for(i=0;i<drugIssuedList1.length;i++)
		   {
		    value=drugIssuedList1[i];
		   }
	   var valueArr=value.split("+");  
	  
   if(formulation==null || formulation==""){
   alert("Please select formulation");
   return false;
   }
   var formulationArr=formulation.split("_"); 
   var frequency=document.getElementById('frequency').value;
   if(frequency==null || frequency==""){
   alert("Please select frequency");
   return false;
   }
   var frequencyArr=frequency.split("."); 
   var noOfDays=document.getElementById('noOfDays').value;
   if(noOfDays==null || noOfDays==""){
   alert("Please enter no of days");
   return false;
   }
   if (noOfDays!=null || noOfDays!=""){
    if(isNaN(noOfDays)){
    alert("Please enter no of days in correct format");
    return false;
    }
   }
   var comments=document.getElementById('comments').value;
   var deleteString = 'deleteInput(\"'+value+'\")';
   var htmlText =  "<div id='com_"+value+"_div'>"
 	 +"<input id='"+value+"_names'  name='drugOrder' value='"+value+"' type='hidden' />&nbsp;&nbsp;"
 	 +"<input id='"+value+"_name'  name='"+value+"drugOrder' type='text' size='14' value='"+valueArr[0]+"' type='hidden' readonly='readonly'/>&nbsp;&nbsp;"
 	 +"<input id='"+value+"_formulationName'  name='"+value+"_formulationName' type='text' size='14' value='"+formulationArr[0]+"'  readonly='readonly'/>&nbsp;&nbsp;"
 	 +"<input id='"+value+"_frequencyName'  name='"+value+"_frequencyName' type='text' size='6' value='"+frequencyArr[0]+"'  readonly='readonly'/>&nbsp;&nbsp;"
 	 +"<input id='"+value+"_noOfDays'  name='"+value+"_noOfDays' type='text' size='7' value='"+noOfDays+"'  readonly='readonly'/>&nbsp;&nbsp;"
 	 +"<input id='"+value+"_comments'  name='"+value+"_comments' type='text' size='17' value='"+comments+"'  readonly='readonly'/>&nbsp;&nbsp;"
 	 +"<input id='"+value+"_formulationId'  name='"+value+"_formulationId' type='hidden' value='"+formulationArr[1]+"'/>&nbsp;"
 	 +"<input id='"+value+"_frequencyId'  name='"+value+"_frequencyId' type='hidden' value='"+frequencyArr[1]+"'/>&nbsp;"
 	 +"<a style='color:red' href='#' onclick='"+deleteString+"' >[X]</a>"		
 	 +"</div>";
	       	
   var newElement = document.createElement('div');
   newElement.setAttribute("id", value);   
   newElement.innerHTML = htmlText;
   var fieldsArea = document.getElementById('headerValue');
   fieldsArea.appendChild(newElement);
   jQuery("#drugName").val("");
   jQuery("#formulation").val("");
   jQuery("#frequency").val("");
   jQuery("#noOfDays").val("");
   jQuery("#comments").val("");
   }
}

function deleteInput(drugName) {
   var parentDiv = 'headerValue';
   var child = document.getElementById(drugName);
   var parent = document.getElementById(parentDiv);
   parent.removeChild(child); 
   Array.prototype.remove = function(v) { this.splice(this.indexOf(v) == -1 ? this.length : this.indexOf(v), 1); }
   drugIssuedList.remove(drugName);
}



// Print the slip
function print(){
var submitStatus=0;
jQuery("#opdEntryForm").keypress(function(event){		
if(event.keyCode == 13){	
submitStatus=1;	
}
else{
submitStatus=0;
}
});

if('${ipdPatientAdmission}'=='true'){
alert("patient already sent in ipd admission queue");
return false;
}

var visitOutCome = $('input:radio[name=radio_f]:checked').val();

if(selectedDiagnosisList.length!=0 && visitOutCome!=undefined){

if(visitOutCome=="Follow-up"){
var datFollUp=jQuery("#dateFollowUp").val();
  if(datFollUp==""){
  alert("Please Enter Follow-up date");
  return false;
  }
 }
else if(visitOutCome=="Admit"){
var ipdward=jQuery("#ipdWard").val();
  if(ipdward==""){
  alert("Please select ipd ward");
  return false;
  }
 }
 
var historyOfPresentIlness = document.getElementById('historyOfPresentIlness').value;
jQuery("#printableHistoryOfPresentIllness").append("<span style='margin:5px;'>" + historyOfPresentIlness + "</span>");

//Diagnosis
var selDiagLen = selectedDiagnosisList.length;
var result =[];
for(i=selDiagLen-1; i>=0; i--){
var diag=selectedDiagnosisList[i].text;
var flag=0;
for(j=0; j<=result.length; j++)
{ if(result[j]== diag)
	   {
	   flag=1;
	   }
}
    if(flag==0)
    	{
    	result.push(diag);
    	}
}
jQuery("#printableProvisionalDiagnosis").append("<span style='margin:5px;'>" + result + "<br/>" + "</span>");

var selProLen = selectedProcedureList.length;
for(i=selProLen-1; i>=0; i--){
var pro=selectedProcedureList[i].text;
jQuery("#printablePostForProcedure").append("<span style='margin:5px;'>" + pro + "<br/>" + "</span>");
}

var selInvgLen = selectedInvestigationList.length;
var j=1;
for(i=selInvgLen-1; i>=0; i--){
var invg=selectedInvestigationList[i].text;
jQuery("#printableInvestigation").append("<span style='margin:5px;'>" + j + "." + invg + "<br/>" + "</span>");
j++;
}


var selDrugLen = drugIssuedList1.length;

var k=1;
for(i=0; i<=selDrugLen-1; i++){
var drug=drugIssuedList1[i];
var drugArr=drug.split("+"); 
var formulationName=document.getElementById(drug+"_formulationName").value;
var frequencyName=document.getElementById(drug+"_frequencyName").value;
var noOfDays=document.getElementById(drug+"_noOfDays").value;
var comments=document.getElementById(drug+"_comments").value;
jQuery("#printableSlNo").append("<span style='margin:5px;'>" + k + "<br/>" + "<br/>" + "</span>");
jQuery("#printableDrug").append("<span style='margin:5px;'>" + drugArr[0] + "<br/>"  + "<br/>"+ "</span>");
jQuery("#printableFormulation").append("<span style='margin:5px;'>" + formulationName + "<br/>" + "<br/>"  + "</span>");
jQuery("#printableFrequency").append("<span style='margin:5px;'>" + frequencyName + "<br/>" + "<br/>"  + "</span>");
jQuery("#printableNoOfDays").append("<span style='margin:5px;'>" + noOfDays + "<br/>" + "<br/>"  + "</span>");
jQuery("#printableComments").append("<span style='margin:5px;'>" + comments + "<br/>" + "<br/>"  + "</span>");
k++;
}


var otherInstructions = document.getElementById('otherInstructions').value;
if(otherInstructions!=""){
jQuery("#printableOtherInstructions").append("<span style='margin:5px;'>" + otherInstructions + "</span>");
}
else{
jQuery("#othInst").hide();
}

var internalReferral = document.getElementById('internalReferral').value;
if(internalReferral!=""){
jQuery("#printableInternalReferral").append("<span style='margin:5px;'>" + internalReferral + "</span>");
}
else{
jQuery("#intRef").hide();
}

var externalReferral = document.getElementById('externalReferral').value;
if(externalReferral!=""){
jQuery("#printableExternalReferral").append("<span style='margin:5px;'>" + externalReferral + "</span>");
}
else{
jQuery("#extRef").hide();
}

var admittedStatus='${admittedStatus}';
if(admittedStatus==""){
var dateFollowUp = document.getElementById('dateFollowUp').value;
if(dateFollowUp!=""){
jQuery("#printableOPDVisitOutCome").append("<span style='margin:5px;'>" + visitOutCome + "    " + "Visit Date:  " + dateFollowUp + "</span>");
}
else{
var ipdward=jQuery("#ipdWard").val();
  if(ipdward!=""){
  var selectedIpdName =_ipdConceptMap[ipdward];
  jQuery("#printableOPDVisitOutCome").append("<span style='margin:5px;'>" + visitOutCome + "  -  " + selectedIpdName + "</span>");
  }
  else{
  jQuery("#printableOPDVisitOutCome").append("<span style='margin:5px;'>" + visitOutCome + "</span>");
  }
 }
}
else{
jQuery("#printableOPDVisitOutCome").append("<span style='margin:5px;'>" + visitOutCome + "</span>");
}

jQuery("#printOPDSlip").printArea({
mode : "popup",
popClose : true
});

   }
}
</script>
<script type="text/JavaScript">
function calculateBmi(){
var weight = jQuery("#weight").val();
var height = jQuery("#height").val();	
var Bmi =  jQuery("#weight").val()/((jQuery("#height").val()/100)*(jQuery("#height").val()/100));

var b=Math.round(Bmi);
jQuery("#BMI").val(b);
}

</script>
<b class="boxHeader">Opd Form</b>
<form class="box" method="post" action="opdEntry.htm" id="opdEntryForm"
	name="opdEntryForm" onsubmit="return print();">

	<input type="hidden" name="patientId" value="${patientId }" /> <input
		type="hidden" name="opdId" value="${opd.conceptId }" /> <input
		type="hidden" name="queueId" id="queueId" value="${queueId }" /> <input
		type="hidden" name="referralId" value="${referral.conceptId }" />

	<div class="container">



		<table cellspacing="5">

			<tr align="right">
				<td colspan="3"><c:choose>
						<c:when test="${not empty queueId }">
							<input type="submit" value="Conclude visit"
								class="ui-button ui-widget ui-state-default ui-corner-all"
								onclick="DASHBOARD.submitOpdEntry();" />
							<input type="submit"
								class="ui-button ui-widget ui-state-default ui-corner-all"
								value="Back" onclick="DASHBOARD.backToQueue('${queueId}');" />
						</c:when>
						<c:otherwise>
							<input type="submit" value="Conclude visit"
								class="ui-button ui-widget ui-state-default ui-corner-all"
								onclick="DASHBOARD.submitOpdEntry();" />
							<input type="submit"
								class="ui-button ui-widget ui-state-default ui-corner-all"
								value="Back"
								onclick="DASHBOARD.backToQueue('${referral.conceptId}');" />
						</c:otherwise>
					</c:choose></td>
			</tr>

			<tr>
				<td colspan="3">
					<div id="triageDiv">
						<label><b> <input type="button"
								value="VITAL STATISTIC DETAILS"
								class="ui-button ui-widget ui-state-default ui-corner-all" />
						</b></label>
					</div>

					<div id="current">
						<label><b class="boxHeader">Current Vitals Details</b></label>
						<table width="65%" height="50%" class=box>
							<tr>
								<th></th>
								<th></th>
								<th></th>
								<th>Range</th>
								<th>Unit</th>
							</tr>
							<tr>
								<td>Weight</td>
								<td><input type="text" id="weight" name="weight" size="11">
								</td>
								<td></td>
								<td></td>
								<td>Kg</td>
							</tr>
							<tr>
								<td>Height</td>
								<td><input type="text" id="height" name="height" size="11"
									oninput="calculateBmi()"></td>
								<td></td>
								<td></td>
								<td>cm</td>
							</tr>
							<tr>
								<td>BMI</td>
								<td><input type="text" id="BMI" size="11" maxlength="7"></td>
								<td></td>
								<td>18.5-24.9</td>

								<td></td>
							</tr>
							<tr>
								<td>Temperature</td>
								<td><input type="text" id="temp" name="temp" size="11"
									maxlength="7"></td>
								<td></td>
								<td>97.7-98.96</td>

								<td>F</td>
							</tr>
							<tr>
								<td>B.P</td>
								<td><input type="text" id="systolic" name="systolic"
									size="5">/<input type="text" id="diastolic"
									name="diastolic" size="5"></td>
								<td></td>
								<td>110/70-140/90</td>

								<td>mm/Hg</td>
							</tr>
							<tr>
								<td>Pulse Rate</td>
								<td><input type="text" id="pulsRate" name="pulsRate"
									size="11"></td>
								<td></td>
								<td>60-90</td>

								<td>/min</td>
							</tr>
							<tr>
								<td>LMP</td>
								<td><input type="text" id="lastMenstrualPeriod"
									name="lastMenstrualPeriod" size="11"><img
									id="calendarButton"
									src="${pageContext.request.contextPath}/moduleResources/patientdashboard/calendar.gif" />
								</td>


							</tr>

						</table>

					</div>
				</td>
			</tr>

			<tr>
				<td colspan="3"><strong>History of Present Illness:</strong> <input
					type="text" id="historyOfPresentIlness"
					name="historyOfPresentIlness" size="150"
					style="width: 1000px; height: 50px" rows=1 cols=20
					class="ui-autocomplete-input ui-widget-content ui-corner-all ac_input" /></td>
			</tr>
			<tr>
				<td colspan="3">
					<%--New Requirement "Final & Provisional Diagnosis" ~Wasib--%> <strong>
						Diagnosis</strong>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3"><div id="diag">
						<input type="radio" name="radio_dia" value="prov_dia"
							checked="checked" id="prov_dia"
							onclick="loadSelectedDiagnosisList();" /><strong>Provisional</strong>
						<input type="radio" name="radio_dia" value="final_dia"
							id="final_dia" onclick="removeSelectedDia();" /><strong>Final</strong>&nbsp;&nbsp;
						<strong>Diagnosis:</strong><em>*</em> <input
							class="ui-autocomplete-input ui-widget-content ui-corner-all"
							id="diagnosis" title="${opd.conceptId}" style="width: 390px"
							name="diagnosis" /></td>
			</tr>
			<tr>
				<td>
					<!-- List of all available DataElements -->
					<div id="divAvailableDiagnosisList">
						<select size="4" style="width: 550px" id="availableDiagnosisList"
							name="availableDiagnosisList" multiple="multiple"
							style="min-width:25em;height:10em"
							ondblclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');">
							<c:forEach items="${diagnosisList}" var="diagnosis">
								<option value="${diagnosis.id}">${diagnosis.name}</option>
							</c:forEach>
						</select>
					</div>
				</td>
				<td>
					<div id="dgn">
						<input type="button" value="&gt;"
							class="ui-button ui-widget ui-state-default ui-corner-all"
							style="width: 50px"
							onclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');" /><br />
						<input type="button" value="&lt;"
							class="ui-button ui-widget ui-state-default ui-corner-all"
							style="width: 50px"
							onclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList');" /><br />
					</div>
				</td>
				<td>
					<!-- List of all selected DataElements --> <select
					id="selectedDiagnosisList" size="4" style="width: 550px"
					name="selectedDiagnosisList" multiple="multiple"
					style="min-width:25em;height:10em"
					ondblclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList' );">

				</select>
				</td>
			</tr>


			<tr>
				<td colspan="3">
					<div class="ui-widget">
						<strong>Post for procedure:</strong> <input
							class="ui-autocomplete-input ui-widget-content ui-corner-all"
							title="${opd.conceptId }" id="procedure" style="width: 420px"
							name="procedure" />
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<!-- List of all available DataElements -->
					<div id="divAvailableProcedureList">
						<select size="4" style="width: 550px" id="availableProcedureList"
							name="availableProcedureList" multiple="multiple"
							style="min-width:25em;height:10em"
							ondblclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');">
							<c:forEach items="${listProcedures}" var="procedure">
								<option value="${procedure.conceptId}">${procedure.name}</option>
							</c:forEach>
						</select>
					</div>
				</td>
				<td><input type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all"
					value="&gt;" style="width: 50px"
					onclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');" /><br />
					<input type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all"
					value="&lt;" style="width: 50px"
					onclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList');" /><br />
				</td>
				<td>
					<!-- List of all selected DataElements --> <select size="4"
					style="width: 550px" id="selectedProcedureList"
					name="selectedProcedureList" multiple="multiple"
					style="min-width:25em;height:10em"
					ondblclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList' )">
				</select>
				</td>
			</tr>

			<tr>
				<td colspan="3">
					<div class="ui-widget">
						<strong>Investigation:</strong> <input
							class="ui-autocomplete-input ui-widget-content ui-corner-all"
							title="${opd.conceptId}" id="investigation" style="width: 450px"
							name="investigation" />
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<!-- List of all available Tests -->
					<div id="divAvailableInvestigationList">
						<select size="4" style="width: 550px"
							id="availableInvestigationList" name="availableInvestigationList"
							multiple="multiple" style="min-width:25em;height:5em"
							ondblclick="moveSelectedById( 'availableInvestigationList', 'selectedInvestigationList');">
							<c:forEach items="${listInvestigations}" var="investigation">
								<option value="${investigation.conceptId}">${investigation.name}</option>
							</c:forEach>
						</select>
					</div>
				</td>
				<td><input type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all"
					value="&gt;" style="width: 50px"
					onclick="moveSelectedById( 'availableInvestigationList', 'selectedInvestigationList');" /><br />
					<input type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all"
					value="&lt;" style="width: 50px"
					onclick="moveSelectedById( 'selectedInvestigationList', 'availableInvestigationList');" />
				</td>
				<td>
					<!-- List of all selected DataElements --> <select size="4"
					style="width: 550px" id="selectedInvestigationList"
					name="selectedInvestigationList" multiple="multiple"
					style="min-width:25em;height:5em"
					ondblclick="moveSelectedById( 'selectedInvestigationList', 'availableInvestigationList' )">
				</select>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="ui-widget">
						<strong>Drug:</strong>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="1">
					<div class="drug-order" id="drugOrder"
						style="background: #FFFFFF; border: 1px #808080 solid; padding: 0.3em; margin: 0.3em 0em; min-width: 25em; height: 5em;">
						<div class="drugs" class="ui-widget">
							<input title="${opd.conceptId}" id="drugName" name="drugName"
								placeholder="Search for drugs" onblur="ISSUE.onBlur(this);" />
						</div>
						<div class="formulation" id="divFormulation">
							<select id="formulation" name="formulation">
								<option value="">
									<spring:message code="patientdashboard.SelectFormulation" />
								</option>
							</select>
						</div>
						<div class="frequency">
							<select id="frequency" name="frequency">
								<option value="">Select Frequency</option>
								<c:forEach items="${drugFrequencyList}" var="dfl">
									<option value="${dfl.name}.${dfl.conceptId}">${dfl.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="no-of-days">
							<input type="text" id="noOfDays" name="noOfDays"
								placeholder="No Of Days" size="7">
						</div>
						<div class="comments">
							<TEXTAREA id="comments" name="comments" placeholder="Comments"
								rows=1 cols=15></TEXTAREA>
						</div>
					</div>
				</td>

				<td><div class="add">
						<input type="button"
							class="ui-button ui-widget ui-state-default ui-corner-all"
							value="Add" onClick="addDrugOrder();" />
					</div></td>

				<td>
					<div id="headerValue"
						style="background: #FFFFFF; border: 1px #808080 solid; padding: 0.3em; margin: 0.3em 0em; width: 100%;">
						<input type='text' id="drug" name="drug" value='Drugs' size="14"
							readonly="readonly" />&nbsp; <input type='text' id="formulation"
							name='formulation' value="Formulation" size="14"
							readonly="readonly" />&nbsp; <input type='text' id='frequency'
							name='frequency' value='Frequency' size="6" readonly="readonly" />&nbsp;
						<input type='text' id='noOfDays' name='noOfDays'
							value='No Of Days' size="7" readonly="readonly" />&nbsp; <input
							type='text' id='comments' name='comments' value='Comments'
							size="17" readonly="readonly" />&nbsp;
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3"><strong>Other Instructions:</strong> <input
					type="text" id="otherInstructions" name="otherInstructions"
					size="200" style="width: 1035px; height: 50px"
					class="ui-autocomplete-input ui-widget-content ui-corner-all ac_input" />
				</td>
			</tr>

			<tr>
				<td colspan="3">Internal referral: <select
					id="internalReferral" name="internalReferral">
						<option value="">--Select--</option>
						<c:forEach items="${listInternalReferral}" var="internalReferral">
							<option value="${internalReferral.answerConcept.name}">${internalReferral.answerConcept.name}</option>
						</c:forEach>
				</select> External referral: <select id="externalReferral"
					name="externalReferral">
						<option value="">--Select--</option>
						<c:forEach items="${listExternalReferral}" var="externalReferral">
							<option value="${externalReferral.answerConcept.name}">${externalReferral.answerConcept.name}</option>
						</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td colspan="3"><strong>OPD Visit Outcome:</strong><em>*</em></td>
			</tr>
			<tr>
				<td colspan="2">
					<!-- ghanshyam,23-oct-2013,New Requirement #2937 Dealing with Dead Patient -->
					<c:if test="${empty admitted}">
						<input type="radio" name="radio_f" id="input_follow"
							value="Follow-up" onclick="DASHBOARD.onChangeRadio(this);">Follow Up <input
							type="text" class="date-pick left" readonly="readonly"
							ondblclick="this.value='';" name="dateFollowUp" id="dateFollowUp"
							onclick="DASHBOARD.onClickFollowDate(this);">
						<input type="radio" name="radio_f" value="Cured"
							onclick="DASHBOARD.onChangeRadio(this);">Cured
  		           </c:if> 
  		           <input type="radio" name="radio_f" value="Reviewed"
					onclick="DASHBOARD.onChangeRadio(this);">Reviewed <c:if
						test="${empty admitted}">
						<input type="radio" name="radio_f" value="Admit"
							onclick="DASHBOARD.onChangeRadio(this);">Admit
  		</c:if>
				</td>
				<td align="left" class="tdIpdWard" style='display: none;'><select
					id="ipdWard" name="ipdWard">
						<option value="">--Select--</option>
						<c:if test="${not empty listIpd }">
							<c:forEach items="${listIpd}" var="ipd">
								<option value="${ipd.answerConcept.id}">${ipd.answerConcept.name}</option>
							</c:forEach>
						</c:if>
				</select></td>
				<td align="left" style="float:right">
				<c:if test="${empty admitted}">
				<input type="radio" name="radio_f" value="Died"
							onclick="DASHBOARD.onChangeRadio(this);">Died
				</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="3"><c:choose>
						<c:when test="${not empty queueId }">
							<input type="submit" value="Conclude visit"
								class="ui-button ui-widget ui-state-default ui-corner-all"
								onclick="DASHBOARD.submitOpdEntry();" />
							<input type="submit"
								class="ui-button ui-widget ui-state-default ui-corner-all"
								value="Back" onclick="DASHBOARD.backToQueue('${queueId}');" />
						</c:when>
						<c:otherwise>
							<input type="submit" value="Conclude visit"
								class="ui-button ui-widget ui-state-default ui-corner-all"
								onclick="DASHBOARD.submitOpdEntry();" />
							<input type="submit"
								class="ui-button ui-widget ui-state-default ui-corner-all"
								value="Back"
								onclick="DASHBOARD.backToQueue('${referral.conceptId}');" />
						</c:otherwise>
					</c:choose></td>
			</tr>
		</table>

	</div>




	</div>

	<div id="printOPDSlip" style="visibility: hidden;">
		<table class="box">
			<tr>
				<center>
					<b><font size="4">${hospitalName}</font></b>
				</center>
			</tr>
			<tr>
				<td><strong>Date & Time of the Visit:</strong></td>
				<td>${currentDateTime}</td>
				<td><strong>Patient Category:</strong></td>
				<td>${selectedCategory}</td>
			</tr>
			<tr>
				<td><strong>Patient ID:</strong></td>
				<td>${patient.patientIdentifier.identifier}</td>
				<td><strong>Name:</strong></td>
				<td>${patientName}</td>
			</tr>
			<tr>
				<td><strong>Gender:</strong></td>
				<td><c:choose>
						<c:when test="${patient.gender eq 'M'}">
					Male
				</c:when>
						<c:otherwise>
					Female
				</c:otherwise>
					</c:choose></td>
				<td><strong>Age:</strong></td>
				<td>${age}</td>
			</tr>
			<tr>
				<td><strong>OPD Consulted:</strong></td>
				<td>${opd.name}</td>
			</tr>
		</table>
		<table class="box">
			<tr>
				<center>
					<b><font size="2">CLINICAL SUMMARY</font></b>
				</center>
			</tr>
			<tr>
				<td><strong>History of Present Illness:</strong></td>
				<td><div id="printableHistoryOfPresentIllness"></div></td>
			</tr>
			<tr>
				<td><strong>Diagnosis:</strong></td>
				<td><div id="printableProvisionalDiagnosis"></div></td>
			</tr>
			<tr>
				<td><strong>Procedure:</strong></td>
				<td><div id="printablePostForProcedure"></div></td>
			</tr>
			<tr>
				<td><strong>Investigation Advised :</strong></td>
				<td><div id="printableInvestigation"></div></td>
			</tr>
		</table>
		<table class="box">
			<br />
			<tr>
				<center>
					<b><font size="2">TREATMENT ADVISED</font></b>
				</center>
			</tr>
			<!--
<tr align="center"><th>--</th><th>--</th><th>--</th><th>--</th><th>--</th><th>--</th></tr>
-->
			<tr align="center">
				<th>S.No</th>
				<th>Drug</th>
				<th>Formulation</th>
				<th>Frequency</th>
				<th>No of Days</th>
				<th>Comments</th>
			</tr>
			<tr align="center">
				<td><div id="printableSlNo"></div></td>
				<td><div id="printableDrug"></div></td>
				<td><div id="printableFormulation"></div></td>
				<td><div id="printableFrequency"></div></td>
				<td><div id="printableNoOfDays"></div></td>
				<td><div id="printableComments"></div></td>
			</tr>
		</table>
		<table class="box">
			<tr id="othInst">
				<td><strong>Other Instructions:</strong></td>
				<td><div id="printableOtherInstructions"></div></td>
			</tr>
			<tr id="intRef">
				<td><strong>Internal Referral:</strong></td>
				<td><div id="printableInternalReferral"></div></td>
			</tr>
			<tr id="extRef">
				<td><strong>External Referral:</strong></td>
				<td><div id="printableExternalReferral"></div></td>
			</tr>
			<tr>
				<td><strong>Visit Outcome:</strong></td>
				<td><div id="printableOPDVisitOutCome"></div></td>
			</tr>
		</table>
		<table>
			<br />
			<br />
			<br />
			<br />
			<br />
			<br />
			<tr>
				<p style="text-align: right;">${user.givenName}</p>
			</tr>
			<br />
			<br />
			<br />
			<tr>
				<center>
					<b><font size="2">Please Note - All follow-up
							appointments are scheduled between 3:00 -4:00 pm everyday</font></b>
					<br>
					<p style="font-weight: bold;">${slipMessage}</p>
				</center>
				
			</tr>
		</table>
	</div>
</form>
