
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
	width: 80%;
	float: left;
}

.floatRight {
	width: 20%;
	float: right;
}

.container {
	overflow: hidden;
}
</style>
<script type="text/javascript">
function addDrugOrder() {
   var drugName=document.getElementById('drugName').value;
   if(drugName==null || drugName==""){
   alert("Please enter drug name");
   return false;
   }else{
   var formulation=document.getElementById('formulation').value;
   if(formulation==null || formulation==""){
   alert("Please select formulation");
   return false;
   }
   var formulationArr=formulation.split("."); 
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
   var deleteString = 'deleteInput(\"'+drugName+'\")';
   var htmlText =  "<div id='com_"+drugName+"_div'>"
	       	 +"<input id='"+drugName+"_name'  name='drugOrder' type='text' size='14' value='"+drugName+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_formulationName'  name='"+drugName+"_formulatioNname' type='text' size='14' value='"+formulationArr[0]+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_frequencyName'  name='"+drugName+"_frequencyName' type='text' size='6' value='"+frequencyArr[0]+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_noOfDays'  name='"+drugName+"_noOfDays' type='text' size='7' value='"+noOfDays+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_comments'  name='"+drugName+"_comments' type='text' size='17' value='"+comments+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_formulationId'  name='"+drugName+"_formulationId' type='hidden' value='"+formulationArr[1]+"'/>&nbsp;"
	       	 +"<input id='"+drugName+"_frequencyId'  name='"+drugName+"_frequencyId' type='hidden' value='"+frequencyArr[1]+"'/>&nbsp;"
	       	 +"<a style='color:red' href='#' onclick='"+deleteString+"' >[X]</a>"		
	       	 +"</div>";
	       	
   var newElement = document.createElement('div');
   newElement.setAttribute("id", drugName);   
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
}

function showSchedule(){
var url = "#TB_inline?height=300&width=300&inlineId=scheduleDiv";
tb_show("Schedule the procedues",url,false);
}
</script>
<b class="boxHeader">Opd Form</b>
<form class="box" method="post" action="opdEntry.htm" id="opdEntryForm">

	<input type="hidden" name="patientId" value="${patientId }" /> <input
		type="hidden" name="opdId" value="${opd.conceptId }" /> <input
		type="hidden" name="queueId" id="queueId" value="${queueId }" /> <input
		type="hidden" name="referralId" value="${referral.conceptId }" />
		<input
		type="hidden" name="opdLogId" id="opdLogId" value="${opdLogId }" />


	<div class="container">
		<div class="floatLeft">
			<tr>
				<table cellspacing="5">
					<!--  
		<tr align="right">
			<td colspan="3"><c:if test="${not empty queueId }">
					<input type="submit" value="Conclude visit"
						class="ui-button ui-widget ui-state-default ui-corner-all"
						onclick="DASHBOARD.submitOpdEntry();" />
					<input type="submit"
						class="ui-button ui-widget ui-state-default ui-corner-all"
						value="Back" onclick="DASHBOARD.backToQueue('${queueId}');" />
				</c:if></td>
		</tr>
	 -->
					<tr>
						<td colspan="3"><strong>History of Present Illness:</strong>
							<input type="text" id="history" name="history" size="200"
							style="width: 1000px; height: 50px"
							class="ui-autocomplete-input ui-widget-content ui-corner-all ac_input" />
						</td>
					</tr>
					<tr>
						<td colspan="3"><strong>Provisional Diagnosis:</strong><em>*</em>
							<input
							class="ui-autocomplete-input ui-widget-content ui-corner-all"
							id="diagnosis" title="${opd.conceptId}" style="width: 390px"
							name="diagnosis" /></td>
					</tr>
					<tr>
						<td>
							<!-- List of all available DataElements -->
							<div id="divAvailableDiagnosisList">
								<select size="4" style="width: 550px"
									id="availableDiagnosisList" name="availableDiagnosisList"
									multiple="multiple" style="min-width:25em;height:10em"
									ondblclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');">
									<c:forEach items="${diagnosisList}" var="diagnosis">
										<option value="${diagnosis.id}">${diagnosis.name}</option>
									</c:forEach>
								</select>
							</div></td>
						<td><input type="button" value="&gt;"
							class="ui-button ui-widget ui-state-default ui-corner-all"
							style="width: 50px"
							onclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');" /><br />
							<input type="button" value="&lt;"
							class="ui-button ui-widget ui-state-default ui-corner-all"
							style="width: 50px"
							onclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList');" />
							<!-- 
				<input type="button" value="&gt;&gt;"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				style="width: 50px"
				onclick="moveAllById( 'availableDiagnosisList', 'selectedDiagnosisList' );" /><br />
				<input type="button" value="&lt;&lt;"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				style="width: 50px"
				onclick="moveAllById( 'selectedDiagnosisList', 'availableDiagnosisList' );" />
				 -->
						</td>
						<td>
							<!-- List of all selected DataElements --> <select
							id="selectedDiagnosisList" size="4" style="width: 550px"
							name="selectedDiagnosisList" multiple="multiple"
							style="min-width:25em;height:10em"
							ondblclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList' );">
						</select></td>
					</tr>
				</table>
				<table cellspacing="5">
					<tr>
						<td colspan="3">
							<div class="ui-widget">
								<strong>Post for procedure:</strong> <input
									class="ui-autocomplete-input ui-widget-content ui-corner-all"
									title="${opd.conceptId }" id="procedure" style="width: 420px"
									name="procedure" />
							</div></td>
					</tr>
					<tr>
						<td>
							<!-- List of all available DataElements -->
							<div id="divAvailableProcedureList">
								<select size="4" style="width: 550px"
									id="availableProcedureList" name="availableProcedureList"
									multiple="multiple" style="min-width:25em;height:5em"
									ondblclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');">
									<c:forEach items="${listProcedures}" var="procedure">
										<option value="${procedure.conceptId}">${procedure.name}</option>
									</c:forEach>
								</select>
							</div></td>
						<td><input type="button"
							class="ui-button ui-widget ui-state-default ui-corner-all"
							value="&gt;" style="width: 50px"
							onclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');" /><br />
							<input type="button"
							class="ui-button ui-widget ui-state-default ui-corner-all"
							value="&lt;" style="width: 50px"
							onclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList');" />
							<!--  
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&gt;&gt;" style="width: 50px"
				onclick="moveAllById( 'availableProcedureList', 'selectedProcedureList' );" /><br />
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&lt;&lt;" style="width: 50px"
				onclick="moveAllById( 'selectedProcedureList', 'availableProcedureList' );" />
				-->
						</td>
						<td>
							<!-- List of all selected DataElements --> <select size="4"
							style="width: 550px" id="selectedProcedureList"
							name="selectedProcedureList" multiple="multiple"
							style="min-width:25em;height:5em"
							ondblclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList' );">
						</select></td>
						<td>
						<input type="button"
									class="ui-button ui-widget ui-state-default ui-corner-all"
									value="Schedule" onclick="showSchedule();" />
							</td>
					</tr>
					<!-- ghanshyam 1-june-2013 New Requirement #1633 User must be able to send investigation orders from dashboard to billing -->
					<tr>
						<td colspan="3">
							<div class="ui-widget">
								<strong>Investigation:</strong> <input
									class="ui-autocomplete-input ui-widget-content ui-corner-all"
									title="${opd.conceptId}" id="investigation"
									style="width: 450px" name="investigation" />
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<!-- List of all available Tests -->
							<div id="divAvailableInvestigationList">
								<select size="4" style="width: 550px"
									id="availableInvestigationList"
									name="availableInvestigationList" multiple="multiple"
									style="min-width:25em;height:5em"
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
							<!--  
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&gt;&gt;" style="width: 50px"
				onclick="moveAllById( 'availableInvestigationList', 'selectedInvestigationList' );" /><br />
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&lt;&lt;" style="width: 50px"
				onclick="moveAllById( 'selectedInvestigationList', 'availableInvestigationList' );" />
				-->
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
					<!-- ghanshyam 12-june-2013 New Requirement #1635 User should be able to send pharmacy orders to issue drugs to a patient from dashboard -->
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
									readonly="readonly" />&nbsp; <input type='text'
									id="formulation" name='formulation' value="Formulation"
									size="14" readonly="readonly" />&nbsp; <input type='text'
									id='frequency' name='frequency' value='Frequency' size="6"
									readonly="readonly" />&nbsp; <input type='text' id='noOfDays'
									name='noOfDays' value='No Of Days' size="7" readonly="readonly" />&nbsp;
								<input type='text' id='comments' name='comments'
									value='Comments' size="17" readonly="readonly" />&nbsp;
							</div>
						</td>
					</tr>
					<!-- ghanshyam 8-july-2013 New Requirement #1963 Redesign patient dashboard -->
					<tr>
						<td colspan="3"><strong>Other Instructions:</strong> <input
							type="text" id="note" name="note" size="200"
							style="width: 1035px; height: 50px"
							class="ui-autocomplete-input ui-widget-content ui-corner-all ac_input" />
						</td>
					</tr>
					<tr>
						<td colspan="3">Internal referral: <select
							id="internalReferral" name="internalReferral">
								<option value="-1">--Select--</option>
								<c:forEach items="${listInternalReferral}"
									var="internalReferral">
									<option value="${internalReferral.answerConcept.id}">${internalReferral.answerConcept.name}</option>
								</c:forEach>
						</select> External referral: <select id="externalReferral"
							name="externalReferral">
								<option value="-1">--Select--</option>
								<c:forEach items="${listExternalReferral}"
									var="externalReferral">
									<option value="${externalReferral.answerConcept.id}">${externalReferral.answerConcept.name}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td colspan="3"><strong>OPD Visit Outcome:</strong><em>*</em>
						</td>
					</tr>
					<tr>
						<td colspan="2"><c:if test="${empty admitted}">
								<input type="radio" name="radio_f" id="input_follow"
									value="Follow-up" onclick="DASHBOARD.onChangeRadio(this);">Follow up <input
									type="text" class="date-pick left" readonly="readonly"
									ondblclick="this.value='';" name="dateFollowUp"
									id="dateFollowUp" onclick="DASHBOARD.onClickFollowDate(this);">
								<input type="radio" name="radio_f" value="cured" id="cured"
									onclick="DASHBOARD.onChangeRadio(this);">Cured
   <input type="radio" name="radio_f" value="died" id="died"
									onclick="DASHBOARD.onChangeRadio(this);">Died
   </c:if> <input type="radio" name="radio_f" value="reviewed" id="reviewed"
							onclick="DASHBOARD.onChangeRadio(this);">Reviewed <c:if
								test="${empty admitted}">
								<input type="radio" name="radio_f" value="admit" id="admit"
									onclick="DASHBOARD.onChangeRadio(this);">Admit
   </c:if></td>
						<td align="left" class="tdIpdWard" style='display: none;'><select
							id="ipdWard" name="ipdWard">
								<option value="">--Select--</option>
								<c:if test="${not empty listIpd }">
									<c:forEach items="${listIpd}" var="ipd">
										<option value="${ipd.answerConcept.id}">${ipd.answerConcept.name}</option>
									</c:forEach>
								</c:if>
						</select></td>
					</tr>
					<tr>
						<td colspan="3"><c:if test="${not empty queueId}">
								<input type="submit" value="Conclude visit"
									class="ui-button ui-widget ui-state-default ui-corner-all"
									onclick="DASHBOARD.submitOpdEntry();" />
								<input type="submit"
									class="ui-button ui-widget ui-state-default ui-corner-all"
									value="Back" onclick="DASHBOARD.backToQueue('${queueId}');" />
							</c:if>
							<c:if test="${not empty opdLogId}">
								<input type="submit" value="Conclude visit"
									class="ui-button ui-widget ui-state-default ui-corner-all"
									onclick="DASHBOARD.submitOpdEntry();" />
								<input type="submit"
									class="ui-button ui-widget ui-state-default ui-corner-all"
									value="Back" onclick="DASHBOARD.backToOpdQueue('${opdLogId}');" />
							</c:if></td>
					</tr>
				</table>
			</tr>
		</div>

		<div class="floatRight">
			<tr>
				<table>
					<tr>
						<td>Weight (Kg)</td>
						<td><input type="text" id="weight" name="weight" size="11"
							value="${opdPatientQueue.triageDataId.weight}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Height (cm)</td>
						<td><input type="text" id="height" name="height" size="11"
							value="${opdPatientQueue.triageDataId.height}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Temperature (degree C)</td>
						<td><input type="text" id="temperature" name="temperature"
							size="11" value="${opdPatientQueue.triageDataId.temperature}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Systolic B.P</td>
						<td><input type="text" id="sbp" name="sbp" size="11"
							value="${opdPatientQueue.triageDataId.systolic}"
							readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>Diastolic B.P</td>
						<td><input type="text" id="dbp" name="dbp" size="11"
							value="${opdPatientQueue.triageDataId.daistolic}"
							readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>Respiratory Rate</td>
						<td><input type="text" id="resRate" name="resRate" size="11"
							value="${opdPatientQueue.triageDataId.respiratoryRate}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Pulse Rate</td>
						<td><input type="text" id="pulseRate" name="pulseRate"
							size="11" value="${opdPatientQueue.triageDataId.pulsRate}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Blood Group</td>
						<td><input type="text" id="bloodGroup" name="bloodGroup"
							size="11" value="${opdPatientQueue.triageDataId.bloodGroup}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Rhesus Factor</td>
						<td><input type="text" id="rhesusFactor" name="rhesusFactor"
							size="11" value="${opdPatientQueue.triageDataId.rhesusFactor}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Last Menstrual Period</td>
						<td><input type="text" id="lastMenstrualPeriod"
							name="lastMenstrualPeriod" size="11" value="${da}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>PITCT</td>
						<td><input type="text" id="pitct" name="pitct" size="11"
							value="${opdPatientQueue.triageDataId.pitct}" readonly="readonly">
						</td>
					</tr>
				</table>
			</tr>
		</div>
	</div>
<div id="scheduleDiv" style="visibility:hidden;">
<table id="tableSchedule">
</table>
</div>
</form>
