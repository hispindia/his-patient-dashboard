<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form>
		<table class="box">
		
			<tr>
				<center>
					<b><font size="4">${hospitalName}</font></b>
				</center>
			</tr>
			<tr>
				<center>
					<b><font size="3">Discharge Slip</font></b>
				</center>
			</tr>
			<tr>
				<td colspan="4" align="left"><b><font size="3">Patient Details</font></b></td>
			</tr>
			<tr>
				<td><strong>Name:</strong></td>
				<td>${patientName}</td>
				<td><strong>Patient ID:</strong></td>
				<td>${patientIdentifier}</td>
			</tr>
			<tr>	
				<td><strong>Age:</strong></td>
				<td>${age}</td>
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
				<td><strong>${relationType}:</strong></td>
				<td>${relationName}</td>
			</tr>
			<tr>
				<td><strong>Address:</strong></td>
				<td>${admitted.patientAddress}</td>
			</tr>
		</table>
<table class="box">
			<tr>
				<td colspan="4" align="left"><b><font size="3">Admission Details</font></b></td>
			</tr>
			<tr>
				<td><strong>Department/OPD Consulted:</strong></td>
				<td>${referredFrom}</td>
			</tr>
			<tr>
				<td><strong>Admitted Ward / Bed No:</strong></td>
				<td>${admitted.admittedWard.name} / ${admitted.bed }</td>
			</tr>
			<tr>
				<td><strong>Treating Doctor:</strong></td>
				<td>${admitted.ipdAdmittedUser.givenName}</td>
			</tr>
			<tr>
				<td><strong>Date and Time of Admission:</strong></td>
				<td>${admissionDateTime}</td>
			</tr>
			<tr>
				<td><strong>Date and Time of Discharge:</strong></td>
				<td>${admitted.admissionDate}</td>
			</tr>
			<tr>
				<td><strong>Length of Stay:</strong></td>
				<td>${admittedDays}</td>
			</tr>
		</table>
	<table class="box">
	     
			<tr>
				<td colspan="4" align="left"><b><font size="3">Diagnosis Details</font></b></td>
			</tr>
			<c:choose>
	  <c:when test="${not empty records}">
		<c:forEach items="${records}" var="record" varStatus="varStatus">
			<tr>
				<td><strong>Final Diagnosis:</strong></td>
				<td>${record.diagnosis }</td>
			</tr>
			<tr>
				<td><strong>Procedure:</strong></td>
				<td>${record.procedures }</td>
			</tr>
			<tr>
				<td><strong>Discharge Outcome:</strong></td>
				<td>${record.admissionOutcome }</td>
			</tr>
			</c:forEach>
			</c:when>
			</c:choose>
		</table>
		<table class="box">
			<br />
			<tr>
				<td colspan="4" align="left"><b><font size="3">Treatment Advised</font></b></td>
			</tr>
			<tr align="center">
				<th>S.No</th>
				<th>Drug</th>
				<th>Formulation</th>
				<th>Frequency</th>
				<th>No of Days</th>
				<th>Comments</th>
			</tr>
			<c:choose>
	  <c:when test="${not empty records}">
		<c:forEach items="${records}" var="record" varStatus="varStatus">
			<c:forEach items="${record.subDetails}" var="opdDrugOrder" varStatus="index">
	
	<tr>
		
	 
			<td>${index.count}</td>
			<td>${opdDrugOrder.inventoryDrug.name}</td>
			<td>${opdDrugOrder.inventoryDrugFormulation.name}-${opdDrugOrder.inventoryDrugFormulation.dozage}</td>
			<td>${opdDrugOrder.frequency.name}</td>
			<td>${opdDrugOrder.noOfDays}</td>
			<td>${opdDrugOrder.comments}</td>
		
	</tr>	

	</c:forEach>
	</c:forEach>
	</c:when>
	</c:choose>
		</table>
		<table class="box">
			<tr>
				<td colspan="4" align="left"><b><font size="3">Other Instructions</font></b></td>
			</tr>
			<tr id="othInst">
				<td>${otherinstructions}</td>
			</tr>
		</table>
	
</form>