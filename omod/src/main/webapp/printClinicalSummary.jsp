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

<script type="text/javascript">
	jQuery(document).ready(function () {
		var otherInstructions = '${otherInstructions}';
		if (otherInstructions != "") {

		}
		else {
			jQuery("#othInstt").hide();
		}

		var internalReferral = '${internal}';
		if (internalReferral != "") {

		}
		else {
			jQuery("#intReff").hide();
		}

		var externalReferral = '${external}';
		if (externalReferral != "") {

		}
		else {
			jQuery("#extReff").hide();
		}


		var dateFollowUp = '${followUpDate}';
		if (dateFollowUp != "") {

		}
		else {
			jQuery("#followupdate").hide();
		}

		var ipdward = '${ipdAdmissionWard}';
		if (ipdward != "") {

		}
		else {
			jQuery("#ipdadmissionward").hide();
		}

	});
</script>

<table class="box">
	<tr>
		<center>
			<b>
				<font size="4">${hospitalName}</font>
			</b>
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
		<td>
			<c:choose>
				<c:when test="${patient.gender eq 'M'}">
					Male
				</c:when>
				<c:otherwise>
					Female
				</c:otherwise>
			</c:choose>
		</td>
		<td><strong>Age:</strong></td>
		<td>${age}</td>
	</tr>
	<tr>
		<td><strong>OPD Consulted:</strong></td>
		<td>${opdConceptName}</td>
		<td><strong>Encounter No:</strong></td>
		<td>${encounterId}</td>
	</tr>
</table>


<table class="box">
	<br />
	<tr>
		<center>
			<b>
				<font size="2">CLINICAL SUMMARY</font>
			</b>
		</center>
	</tr>
	<tr>
		<td><strong>History of Present Illness:</strong></td>
		<td>${illnessHistory}</td>
	</tr>
	<c:choose>
		<c:when test="${not empty pdiagnosiss}">
			<tr>
				<td><strong>Provisional Diagnosis:</strong></td>
				<c:forEach items="${pdiagnosiss}" var="pdiagnosis">
					</td>
					<td>${pdiagnosis.name}</td>
			</tr>
			<tr>
				<td>
					</c:forEach>
			</tr>
		</c:when>
		<c:otherwise>
			<tr>
				<td><strong>Final Diagnosis:</strong></td>
				<c:forEach items="${fdiagnosiss}" var="fdiagnosis">
					</td>
					<td>${fdiagnosis.name}</td>
			</tr>
			<tr>
				<td>
					</c:forEach>
			</tr>
		</c:otherwise>
	</c:choose>

	<tr>
		<td><strong>Procedure:</strong></td>
		<c:forEach items="${procedures}" var="procedure">
			</td>
			<td>${procedure.name}</td>
	</tr>
	<tr>
		<td>
			</c:forEach>
	</tr>

	<tr>
		<td><strong>Investigation Advised :</strong></td>
		<c:forEach items="${investigations}" var="investigation" varStatus="index">
			</td>
			<td>${index.count}.${investigation.name}</td>
	</tr>
	<tr>
		<td>
			</c:forEach>
	</tr>
</table>

<table class="box">
	<br />
	<tr>
		<center>
			<b>
				<font size="2">TREATMENT ADVISED</font>
			</b>
		</center>
	</tr>
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
	<tr id="othInstt">
		<td><strong>Other Instructions:</strong></td>
		<td>${otherInstructions}</td>
	</tr>
	<tr id="intReff">
		<td><strong>Internal Referral:</strong></td>
		<td>${internal}</td>
	</tr>
	<tr id="extReff">
		<td><strong>External Referral:</strong></td>
		<td>${external}</td>
	</tr>
	<tr>
		<td><strong>OPD Visit Outcome:</strong></td>
		<td>${visitOutCome} -</td>
		<td id="followupdate">${followUpDate}</td>
		<td id="ipdadmissionward">${ipdAdmissionWard}</td>
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
		<p style="text-align: right;">${treatingDoctor}</p>
	</tr>
	<br />
	<br />
	<br />
	<tr>
		<center>
			<b>
				<font size="2">Please Note - All follow-up appointments
					are scheduled between 3:00 -4:00 pm everyday</font>
			</b>
			<br>
			<p style="font-weight: bold;">${slipMessage}</p>
		</center>
	</tr>
</table>