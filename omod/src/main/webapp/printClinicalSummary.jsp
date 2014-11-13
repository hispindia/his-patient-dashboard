
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

<table class="box">
	<tr>
		<center>
			<b><font size="4">${hospitalName}</font></b>
		</center>
	</tr>
	<tr>
		<td><strong>Date/Time:</strong></td>
		<td>${currentDateTime}</td>
	</tr>
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
		<td><strong>Age Category:</strong></td>
		<td>${ageCategory}</td>
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
		<td><strong>Patient Category:</strong></td>
		<td>${selectedCategory}</td>
	</tr>
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
		<c:forEach items="${investigations}" var="investigation" varStatus="index">
			</td>
			<td>${index.count}.${investigation.name}</td>
	</tr>
	<tr>
		<td></c:forEach>
	</tr>
</table>

<table class="box">
    <tr><strong><font size="4">Rx</font></strong></tr>
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
		<td><strong>${visitOutCome}</strong></td>
		<td><strong><c:if test="${not empty otherValueOfVisit}">${otherValueOfVisit}</c:if>
		</strong></td>
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
		<p style="text-align: right;">Signature of the Treating Doctor</p>
	</tr>
</table>