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
<openmrs:require privilege="View PatientDashboard" otherwise="/login.htm" redirect="index.htm" />
<style>
	.ui-button { margin-left: -1px; }
	.ui-button-icon-only .ui-button-text { padding: 0.35em; } 
	.ui-autocomplete-input { margin: 0; padding: 0.48em 0 0.47em 0.45em; }
</style>
<b class="boxHeader">Opd Form</b>
<form class="box" method="post" action="opdEntry.htm" id="opdEntryForm">

<input type="hidden" name="patientId" value="${patientId }"/>
<input type="hidden" name="opdId" value="${opd.conceptId }"/>
<input type="hidden" name="queueId" id="queueId" value="${queueId }"/>
<input type="hidden" name="referralId" value="${referral.conceptId }"/>


<table cellspacing="5">
	<tr align="right"><td colspan="3">
	  <c:if test ="${not empty queueId }">
	  	<input type="submit" value="Conclude visit" class="ui-button ui-widget ui-state-default ui-corner-all" onclick="DASHBOARD.submitOpdEntry();"/><input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Back" onclick="DASHBOARD.backToQueue('${queueId}');"/>
	  </c:if>
   </td> </tr>
	<tr><td colspan="3">
	<strong>Provisional Diagnosis:</strong><em>*</em>
	<input class="ui-autocomplete-input ui-widget-content ui-corner-all" id="diagnosis" title="${opd.conceptId}" style="width:380px" name="diagnosis"/>
	</td>
	</tr>
   <tr>
        <td>
          <!-- List of all available DataElements -->
          <div id="divAvailableDiagnosisList">
          <select size="8" style="width:550px" id="availableDiagnosisList" name="availableDiagnosisList" multiple="multiple" style="min-width:25em;height:10em" ondblclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');">
              <c:forEach items="${diagnosisList}" var="diagnosis">
              	 <option value="${diagnosis.id}" >${diagnosis.name}</option>
              </c:forEach>
          </select>
          </div>
        </td>
        <td>
        	<input type="button" value="&gt;" class="ui-button ui-widget ui-state-default ui-corner-all"  style="width:50px" onclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');"/><br/>
            <input type="button" value="&lt;" class="ui-button ui-widget ui-state-default ui-corner-all" style="width:50px" onclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList');"/><br/>
			<input type="button" value="&gt;&gt;" class="ui-button ui-widget ui-state-default ui-corner-all" style="width:50px" onclick="moveAllById( 'availableDiagnosisList', 'selectedDiagnosisList' );"/><br/>
			<input type="button" value="&lt;&lt;" class="ui-button ui-widget ui-state-default ui-corner-all" style="width:50px" onclick="moveAllById( 'selectedDiagnosisList', 'availableDiagnosisList' );"/>
		</td>			
        <td>
          <!-- List of all selected DataElements -->
          <select id="selectedDiagnosisList" size="8" style="width:550px" name="selectedDiagnosisList" multiple="multiple" style="min-width:25em;height:10em" ondblclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList' );">
          </select>
        </td>
  </tr>
  <tr><td colspan="3">Add note: <input type="text" id="note" name="note" size="50" style="width:480px"/></td></tr>
  <tr><td colspan="3"><strong>Management plan: </strong></td></tr>
  <tr><td colspan="3">
	<div class="ui-widget">
		<strong>Post for procedure:</strong>
		<input class="ui-autocomplete-input ui-widget-content ui-corner-all"  title="${opd.conceptId }"  id="procedure" style="width:420px" name="procedure"/>
	</div>
  
 </td></tr>
  <tr>
        <td>
        	
          <!-- List of all available DataElements -->
          <div id="divAvailableProcedureList">
          <select size="7" style="width:550px" id="availableProcedureList" name="availableProcedureList" multiple="multiple" style="min-width:25em;height:5em" ondblclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');">
             <c:forEach items="${listProcedures}" var="procedure">
              	 <option value="${procedure.conceptId}" >${procedure.name}</option>
              </c:forEach>
          </select>
          </div>
        </td>
        <td>
        	<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="&gt;"  style="width:50px" onclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');"/><br/>
            <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="&lt;"  style="width:50px" onclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList');"/><br/>
			<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="&gt;&gt;"  style="width:50px" onclick="moveAllById( 'availableProcedureList', 'selectedProcedureList' );"/><br/>
			<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="&lt;&lt;"  style="width:50px" onclick="moveAllById( 'selectedProcedureList', 'availableProcedureList' );"/>
		</td>			
        <td>
          <!-- List of all selected DataElements -->
          <select size="7" style="width:550px" id="selectedProcedureList" name="selectedProcedureList" multiple="multiple" style="min-width:25em;height:5em" ondblclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList' )">
          </select>
        </td>
  </tr>
  <tr><td colspan="3">
  		Internal referral:
  		<select id="internalReferral" name="internalReferral">
				<option value="-1">--Select--</option>
  				<c:forEach items="${listInternalReferral}" var="internalReferral">
          			<option value="${internalReferral.answerConcept.id}"  >${internalReferral.answerConcept.name}</option>
       			</c:forEach>
  		</select> 
  		External referral:
  		<select id="externalReferral" name="externalReferral">
			<option value="-1">--Select--</option>
  			<c:forEach items="${listExternalReferral}" var="externalReferral">
          			<option value="${externalReferral.answerConcept.id}"  >${externalReferral.answerConcept.name}</option>
       		</c:forEach>
  		</select> 
  	  </td>
  </tr>
  <tr><td colspan="3">
  		<strong>OPD Visit Outcome:</strong><em>*</em>
  	  </td>
  </tr>
  <tr><td colspan="2">
        <!-- ghanshyam,23-oct-2013,New Requirement #2937 Dealing with Dead Patient -->
        <c:if test ="${empty admitted}">
  		<input type="radio" name="radio_f" id="input_follow" value="follow" onclick="DASHBOARD.onChangeRadio(this);">Follow up <input type="text" class="date-pick left" readonly="readonly"  ondblclick="this.value='';" name="dateFollowUp" id="dateFollowUp" onclick="DASHBOARD.onClickFollowDate(this);">
  		<input type="radio" name="radio_f" value="cured" onclick="DASHBOARD.onChangeRadio(this);">Cured
  		<input type="radio" name="radio_f" value="died"  onclick="DASHBOARD.onChangeRadio(this);">Died
  		</c:if>
  		<input type="radio" name="radio_f" value="reviewed"  onclick="DASHBOARD.onChangeRadio(this);">Reviewed
  		<c:if test ="${empty admitted}">
  			<input type="radio" name="radio_f" value="admit" onclick="DASHBOARD.onChangeRadio(this);">Admit
  		</c:if>
  	  </td>
  	  <td align="left" class="tdIpdWard" style='display: none;'>
  	  		<select id="ipdWard" name="ipdWard" >
			<option value="">--Select--</option>
			<c:if test="${not empty listIpd }">
	  			<c:forEach items="${listIpd}" var="ipd">
	          			<option value="${ipd.answerConcept.id}"  >${ipd.answerConcept.name}</option>
	       		</c:forEach>
       		</c:if>
  			</select> 
  	  </td>
  </tr>
  <tr><td colspan="3">
  <c:if test ="${not empty queueId }">
  	<input type="submit" value="Conclude visit" class="ui-button ui-widget ui-state-default ui-corner-all" onclick="DASHBOARD.submitOpdEntry();"/><input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Back" onclick="DASHBOARD.backToQueue('${queueId}');"/>
  </c:if>
   </td> </tr>
</table>      
</form>
