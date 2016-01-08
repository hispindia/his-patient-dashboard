
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
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/moduleResources/patientdashboard/styles/common.css" />
<span class="boxHeader">Visit Details</span>
<table class="box">
	<tr>
		<td><strong>Name:</strong></td>
		<td>${patientName}</td>
	</tr>
	<tr>
		<td><strong>Patient ID:</strong></td>
		<td>${patient.patientIdentifier.identifier}</td>
	</tr>
	<tr>
		<td><strong>Age:</strong></td>
		<td>${age}</td>
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
	</tr>
	<tr>
		<td><strong>Payment Category:</strong></td>
		<td>${selectedCategory}</td>
	</tr>
	<%-- <tr>
		<td><strong>Waiver/ Exemption No:</strong></td>
		<td>${exemptionNumber}</td>
		<td>${nhifCardNumber}</td>
		<td>${waiverNumber}</td>
	</tr> --%>
	<tr>
		<td><strong>Treating Doctor:</strong></td>
		<td>${treatingDoctor}</td>
	</tr>
</table>


<table class="box">
	<tr>
		<td><strong>History of Present Illness:</strong></td>
		<td>${illnessHistory}</td>
	</tr>
	<tr>
		<td><strong>Symptom:</strong></td>
		<c:forEach items="${symptoms}" var="symptom">
			</td>
			<td>${symptom.name}</td>
	</tr>
	<tr>
		<td></c:forEach>
	</tr>
	<tr>
		<td><strong>Physical Examination:</strong></td>
		<c:forEach items="${examinations}" var="examinations">
			</td>
			<td>${examinations.name}</td>
	</tr>
	<tr>
		<td></c:forEach>
	</tr>
	<tr>
		<td><strong>Provisional Diagnosis:</strong></td>
		<c:forEach items="${diagnosiss}" var="diagnosis">
			</td>
			<td>${diagnosis.name}</td>
	</tr>
	<tr>
		<td></c:forEach>
	</tr>

	<tr>
		<td><strong>Procedure:</strong></td>
		<c:forEach items="${procedures}" var="procedure">
			</td>
			<td>${procedure.name}</td>
	</tr>
	<tr>
		<td></c:forEach>
	</tr>

	<tr>
		<td><strong>Investigation:</strong></td>
		<c:forEach items="${investigations}" var="investigation">
			</td>
			<td>${investigation.name}</td>
	</tr>
	<tr>
		<td></c:forEach>
	</tr>
</table>

<table class="box">
	<tr align="center">
		<th><strong>S.No</strong></th>
		<th><strong>Drug</strong></th>
		<th><strong>Formulation</strong></th>
		<th><strong>Frequency</strong></th>
		<th><strong>No of Days</strong></th>
		<th><strong>Comments</strong></th>
	</tr>
	<c:forEach items="${opdDrugOrders}" var="opdDrugOrder" varStatus="index">
		<tr align="center">
			<td>${index.count}</td>
			<td>${opdDrugOrder.inventoryDrug.name}</td>
			<td>${opdDrugOrder.inventoryDrugFormulation.name}-${opdDrugOrder.inventoryDrugFormulation.dozage}</td>
			<td>${opdDrugOrder.frequency.name}</td>
			<td>${opdDrugOrder.noOfDays}</td>
			<td>${opdDrugOrder.comments}</td>
		</tr>
	</c:forEach>
</table>

<table class="box">
	<tr>
		<td><strong>Other Instructions:</strong></td>
		<td>${otherInstructions}</td>
	</tr>
	<tr>
		<td><strong>Internal Referral:</strong></td>
		<td>${internal}</td>
	</tr>
	<tr>
		<td><strong>External Referral:</strong></td>
		<td>${external}</td>
	</tr>
	<tr>
		<td><strong>OPD Visit Outcome:</strong></td>
		<td>${visitOutCome}</td>
		<td><c:if test="${not empty otherValueOfVisit}">${otherValueOfVisit}</c:if>
		</td>
	</tr>
</table>