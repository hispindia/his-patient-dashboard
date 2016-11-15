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
<%@page import="org.openmrs.ConceptName" %>
<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="View PatientDashboard" otherwise="/login.htm" redirect="index.htm" />
<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="includes/js_css.jsp" %>
<input type="hidden" id="pageId" value="patientDashboard"/>

<b class="boxHeader">Dashboard</b>
<div  class="box">
<table  cellspacing="10" width="100%">
	<tr>
		<td width="40%"><b>Patient ID:</b> ${patient.patientIdentifier.identifier}</td>
		<td width="30%">
			<c:if test="${not empty admittedStatus }">
				<span style="background-color:red; color:white">Admitted patient</span>				
			</c:if>
		</td>
		<td width="30%"><b>OPD Name:</b> ${opd.name } </td>
	</tr>
	<tr>
		<td width="40%"><b>Name:</b> ${patient.givenName}&nbsp;${patient.familyName}&nbsp;${fn:replace(patient.middleName,',',' ')}</td>
		<td width="30%"><b>Age:</b> ${age }</td>
		<td width="30%"><b>Gender:</b> ${patient.gender }</td>
	</tr>
	<!-- ghanshyam 16-06-2012 Bug #44 OPD Dashboard/ Patient category,PatientTemporary category is not being displayed-->
	<tr>
		
		
		
		<td width="30%"><b>Age category:</b> ${ageCategory }</td>
		<td width="30%"><b>Visit Status:</b>
		<!-- June 20th 2012 - Thai Chuong supported for issue #45 -->
		<c:choose> 
				<c:when test="${referredType.class.name == 'org.openmrs.ConceptName'}">
					${referredType}
				</c:when>
				<c:otherwise>
					${referral.name }	
				</c:otherwise>
			</c:choose>
		</td>
		
	</tr>
</table>
<div id="tabs">
<%--New Requirement "Editable Dashboard" --%>
     <ul>	<c:choose>
     <c:when test="${ empty admittedStatus }">
      <c:if test="${createNew==0}" >
       <li><a href="opdEntry.htm?patientId=${patient.patientId }&opdId=${opd.conceptId }&referralId=${referral.conceptId }&queueId=${queueId}"  title="OPD entry"><span > Clinical Notes</span></a></li>
      </c:if>
     </c:when>
     <c:otherwise>
      <li><a href="opdEntry.htm?patientId=${patient.patientId }&opdId=${opd.conceptId }&referralId=${referral.conceptId }&queueId=${queueId}"  title="OPD entry"><span > Clinical Notes</span></a></li>
     </c:otherwise>
          </c:choose>
 
         
         <li><a href="clinicalSummary.htm?patientId=${patient.patientId }"   title="Clinical summary"><span>Clinical Summary</span></a></li> 

         <%-- ghanshyam,date:22-april-2013 Support #1408 change in the Dashboard Tab 'Investigation report' to 'Laboratory record' for all hospital of india module
              renamed title and tab name from "Investigation report" to "Laboratory record"
         --%>
         <li><a href="investigationReport.htm?patientId=${patient.patientId }"  title="Laboratory record"><span >Laboratory Record</span></a></li>
         <%-- ghanshyam,date:10-april-2013 New Requirement #1302[PatientDashboard] Add Radiology record of patient in patientdashboard(india module) --%>
         <li><a href="radiologyRecord.htm?patientId=${patient.patientId }" title="Radiology record"><span>Radiology Record</span> </a></li>
         <li><a href="ipdRecord.htm?patientId=${patient.patientId }&opdLog=${opdLog}"  title="IPD record"><span >IPD Record</span></a></li>
         <%-- ghanshyam,date:18-april-2013 New Requirement #1391 [Patient Dashboard] Add Pharmacy record of patient in Dashboard(in all hospital of india module) --%>
		 <li><a href="pharmacyRecord.htm?patientId=${patient.patientId }" title="Pharmacy record"><span>Pharmacy Record</span> </a></li>
     </ul>
     
     <div id="OPD_entry"></div>
	 <div id="Clinical_summary"></div>
	 <%-- ghanshyam,date:22-april-2013 Support #1408 change in the Dashboard Tab 'Investigation report' to 'Laboratory record' for all hospital of india module
          renamed div id from "Investigation report" to "Laboratory record"
     --%>
	 <div id="Laboratory_record"></div>
	 <%-- ghanshyam,date:10-april-2013 New Requirement #1302[PatientDashboard] Add Radiology record of patient in patientdashboard(india module) --%>
	 <div id="Radiology_record"></div>
	 <div id="IPD_record"></div>
	 <%-- ghanshyam,date:18-april-2013 New Requirement #1391 [Patient Dashboard] Add Pharmacy record of patient in Dashboard(in all hospital of india module) --%>
	 <div id="Pharmacy_record"></div>
</div>

</div>


<%@ include file="/WEB-INF/template/footer.jsp" %> 