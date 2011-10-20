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
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />
<%@ include file="/WEB-INF/template/headerMinimal.jsp" %>
<%@ include file="includes/js_css.jsp" %>
<style>
	.ui-button { margin-left: -1px; }
	.ui-button-icon-only .ui-button-text { padding: 0.35em; } 
	.ui-autocomplete-input { margin: 0; padding: 0.48em 0 0.47em 0.45em; }
</style>
<input type="hidden" id="pageId" value="finalResultPage"/>
<form method="post" id="finalResultForm">
<input type="hidden" name="admissionLogId" id="admissionLogId" value="${id }" />
<table class="box" width="100%">
	<tr><td colspan="3">
	<strong><spring:message code="patientdashboard.clinicalSummary.diagnosis"/>:</strong><em>*</em>
	<input class="ui-autocomplete-input ui-widget-content ui-corner-all" id="diagnosis" title="${opd.conceptId}" style="width:290px" name="diagnosis"/>
	</td>
	</tr>
	<tr>
        <td>
          <!-- List of all available DataElements -->
          <div id="divAvailableDiagnosisList">
          <select size="10" style="width:400px;" id="availableDiagnosisList" name="availableDiagnosisList" multiple="multiple" style="min-width:25em;height:10em" ondblclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');">
              <c:forEach items="${listDiagnosis}" var="diagnosis">
              	 <option value="${diagnosis.id}" >${diagnosis.name}</option>
              </c:forEach>
          </select>
          </div>
        </td>
        <td>
        	<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="&gt;"  style="width:50px" onclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');"/><br/>
            <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="&lt;"  style="width:50px" onclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList');"/><br/>
			<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="&gt;&gt;"  style="width:50px" onclick="moveAllById( 'availableDiagnosisList', 'selectedDiagnosisList' );"/><br/>
			<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="&lt;&lt;"  style="width:50px" onclick="moveAllById( 'selectedDiagnosisList', 'availableDiagnosisList' );"/>
		</td>			
        <td>
          <!-- List of all selected DataElements -->
          <select size="10" style="width:400px;" id="selectedDiagnosisList" name="selectedDiagnosisList" multiple="multiple" style="min-width:25em;height:10em" ondblclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList' );">
          	  <c:forEach items="${sDiagnosisList}" var="ss">
              	 <option value="${ss.id}" >${ss.name}</option>
              </c:forEach>
          </select>
        </td>
  </tr>
  <tr><td colspan="3">
	<div class="ui-widget">
		<strong><spring:message code="patientdashboard.procedures"/>:</strong>
		<input class="ui-autocomplete-input ui-widget-content ui-corner-all"  title="${opd.conceptId }"  id="procedure" style="width:300px" name="procedure"/>
	</div>
  
 	</td></tr>
	<tr>
        <td>
          <!-- List of all available DataElements -->
          <div id="divAvailableProcedureList">
          <select size="10" style="width:400px;" id="availableProcedureList" name="availableProcedureList" multiple="multiple" style="min-width:25em;height:5em" ondblclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');">
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
          <select size="10" style="width:400px;" id="selectedProcedureList" name="selectedProcedureList" multiple="multiple" style="min-width:25em;height:5em" ondblclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList' )">
         	 <c:forEach items="${sProcedureList}" var="xx">
              	 <option value="${xx.id}" >${xx.name}</option>
              </c:forEach>
          </select>
        </td>
  </tr>

</table>
<br/>
<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Submit" onclick="ADMITTED.submitIpdFinalResult();">
</form>