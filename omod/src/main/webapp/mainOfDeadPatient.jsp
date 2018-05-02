 <%--
 *  Copyright 2013 Society for Health Information Systems Programmes, India (HISP India)
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
				<span style="background-color:red; color:white">Dead Patient</span>				
		</td>
		<td width="30%"><b>Location:</b> ${opd.name } </td>
	</tr>
	<tr>
		<td width="40%"><b>Name:</b> ${patient.givenName}&nbsp;&nbsp;${patient.middleName}&nbsp;&nbsp; ${patient.familyName}</td>
		<td width="30%"><b>Age:</b> ${age }</td>
		<td width="30%"><b>Gender:</b> ${patient.gender }</td>
	</tr>
	<tr>
		<td width="40%"><b>Patient category:</b> ${patientCategory} -
		<c:forEach items="${observation}" var="observation">
			${observation.valueText} 
		</c:forEach>
		</td>
		<td width="30%"><b>Age category:</b> ${ageCategory }</td>
		<td width="30%"><b>Referral:</b>
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
     <ul>
         <li><a href="clinicalSummary.htm?patientId=${patient.patientId }"   title="Clinical summary"><span>Clinical summary</span></a></li>
         <li><a href="investigationReport.htm?patientId=${patient.patientId }"  title="Laboratory record"><span >Laboratory record</span></a></li>
         <li><a href="radiologyRecord.htm?patientId=${patient.patientId }" title="Radiology record"><span>Radiology record</span> </a></li>
         <li><a href="ipdRecord.htm?patientId=${patient.patientId }&opdLog=${opdLog}"  title="IPD record"><span >IPD record</span></a></li>
		 <li><a href="pharmacyRecord.htm?patientId=${patient.patientId }" title="Pharmacy record"><span>Pharmacy record</span> </a></li>
     </ul>
     
	 <div id="Clinical_summary"></div>
	 <div id="Laboratory_record"></div>
	 <div id="Radiology_record"></div>
	 <div id="IPD_record"></div>
	 <div id="Pharmacy_record"></div>
</div>

</div>


<%@ include file="/WEB-INF/template/footer.jsp" %> 