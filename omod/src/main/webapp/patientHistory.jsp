
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

<b class="boxHeader">Patient Surgical and Medical History</b>
<table>
	<c:choose>
		<c:when test="${existingIllness != null}">
			<tr align="left">
				<td>Any existing illness/ conditions</td>
				<td>: ${existingIllness}</td>
			</tr>
		</c:when>
	</c:choose>

	<c:choose>
		<c:when
			test="${existingIllnessProblem != null && existingIllnessProblem != ''}">
			<tr align="left">
				<td>&nbsp;&nbsp;What is the problem?</td>
				<td>: ${existingIllnessProblem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${existingIllnessLong != null  && existingIllnessLong != ''}">
			<tr align="left">
				<td>&nbsp;&nbsp;How long have you had it?</td>
				<td>: ${existingIllnessLong}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${existingIllnessProgress != null  && existingIllnessProgress != ''}">
			<tr align="left">
				<td>&nbsp;&nbsp;How is your progress?</td>
				<td>: ${existingIllnessProgress}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${existingIllnessRecord != null  && existingIllnessRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${existingIllnessRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${chronicIllness != null  && chronicIllness != ''}">

			<tr align="left">
				<td>Suffered from any chronic illness?</td>
				<td>: ${chronicIllness}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${chronicIllnessProblem != null  && chronicIllnessProblem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is the problem?</td>
				<td>: ${chronicIllnessProblem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${chronicIllnessOccure != null  && chronicIllnessOccure != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;When did it occur?</td>
				<td>: ${chronicIllnessOccure}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${chronicIllnessOutcome != null  && chronicIllnessOutcome != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the outcome?</td>
				<td>: ${chronicIllnessOutcome}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${chronicIllnessRecord != null && chronicIllnessRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${chronicIllnessRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${previousAdmission != null && previousAdmission != ''}">

			<tr align="left">
				<td>Any previous hospital admissions?</td>
				<td>: ${previousAdmission}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousAdmissionWhen != null && previousAdmissionWhen != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;When was this?</td>
				<td>: ${previousAdmissionWhen}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousAdmissionProblem != null && previousAdmissionProblem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the problem?</td>
				<td>: ${previousAdmissionProblem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousAdmissionOutcome != null && previousAdmissionOutcome != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the outcome?</td>
				<td>: ${previousAdmissionOutcome}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousAdmissionRecord != null && previousAdmissionRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${previousAdmissionRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigation != null && previousInvestigation != ''}">

			<tr align="left">
				<td>Any previous operations/ investigations?</td>
				<td>: ${previousInvestigation}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigationWhen != null && previousInvestigationWhen != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;When was this?</td>
				<td>: ${previousInvestigationWhen}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigationProblem != null && previousInvestigationProblem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the problem?</td>
				<td>: ${previousInvestigationProblem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigationOutcome != null  && previousInvestigationOutcome != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the outcome?</td>
				<td>: ${previousInvestigationOutcome}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${previousInvestigationRecord != null && previousInvestigationRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${previousInvestigationRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${ BCG!= null ||  polio!=null || DPT!=null || measles!=null || pneumococcal!=null || yellowFever!=null || tetanusFemale!=null || tetanusMale!=null}">
			<tr>
				<td>Received the following vaccinations?&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${BCG != null}">
			<tr align="left">
				<td>&nbsp;&nbsp;BCG</td>
				<td>: ${BCG}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${polio != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;3 Polio Doses</td>
				<td>: ${polio}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${DPT != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;3DPT/ Pentavalent Doses</td>
				<td>: ${DPT}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${measles != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;Measles</td>
				<td>: ${measles}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${pneumococcal != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;Pneumococcal</td>
				<td>: ${pneumococcal}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${yellowFever != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;Yellow Fever</td>
				<td>: ${yellowFever}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${tetanusFemale != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;5 Tetanus Doses (If Female)</td>
				<td>: ${tetanusFemale}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${tetanusMale != null}">

			<tr align="left">
				<td>&nbsp;&nbsp;3 Tetanus Doses (If Male)</td>
				<td>: ${tetanusMale}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${otherVaccinations != null  && otherVaccinations != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Other</td>
				<td>: ${otherVaccinations}</td>
			</tr>
		</c:when>
	</c:choose>
</table>


<br />

<b class="boxHeader">Drug History</b>
<table>
	<c:choose>
		<c:when
			test="${currentMedication != null  && currentMedication != ''}">

			<tr align="left">
				<td>Current Medications</td>
				<td>: ${currentMedication}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${medicationName != null  && medicationName != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is the medication?</td>
				<td>: ${medicationName}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${medicationPeriod != null  && medicationPeriod != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;For how long it has been taken?</td>
				<td>: ${medicationPeriod}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${medicationReason != null  && medicationReason != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Why is it being taken?</td>
				<td>: ${medicationReason}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${medicationRecord != null  && medicationRecord != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Where are the Medical Records?</td>
				<td>: ${medicationRecord}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${sensitiveMedication != null  && sensitiveMedication != ''}">

			<tr align="left">
				<td>Any medication you are sensitive to?</td>
				<td>: ${sensitiveMedication}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${sensitiveMedicationName != null  && sensitiveMedicationName != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is the medication?</td>
				<td>: ${sensitiveMedicationName}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${sensitiveMedicationSymptom != null  && sensitiveMedicationSymptom != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What are the symptoms you experience?</td>
				<td>: ${sensitiveMedicationSymptom}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${invasiveContraception != null  && invasiveContraception != ''}">

			<tr align="left">
				<td>Are you using any invasive contraception?</td>
				<td>: ${invasiveContraception}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${invasiveContraceptionName != null  && invasiveContraceptionName != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Which one?</td>
				<td>: ${invasiveContraceptionName}</td>
			</tr>
		</c:when>
	</c:choose>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<tr>
	<td>&nbsp;</td>
</tr>

<br />

<b class="boxHeader">Family History</b>
<table>
	<c:choose>
		<c:when test="${parentStatus != null  && parentStatus != ''}">

			<tr align="left">

				<td>Status of parents</td>
				<td>: ${parentStatus}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${parentDeathCause != null  && parentDeathCause != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the cause of death?</td>
				<td>: ${parentDeathCause}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${parentDeathAge != null  && parentDeathAge != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;How old were they?</td>
				<td>: ${parentDeathAge}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${siblingStatus != null  && siblingStatus != ''}">

			<tr align="left">
				<td>Status of siblings</td>
				<td>: ${siblingStatus}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${siblingDeathCause != null  && siblingDeathCause != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What was the cause of death?</td>
				<td>: ${siblingDeathCause}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${siblingDeathAge != null  && siblingDeathAge != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;How old were they?</td>
				<td>: ${siblingDeathAge}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when
			test="${familyIllnessHistory != null  && familyIllnessHistory != ''}">

			<tr align="left">
				<td>Any family history of the following illness?</td>
				<td>: ${familyIllnessHistory}</td>
			</tr>
		</c:when>
	</c:choose>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<b class="boxHeader">Personal History</b>
<table>

	<c:choose>
		<c:when test="${smoke != null  && smoke != ''}">

			<tr align="left">
				<td>Do you smoke?</td>
				<td>: ${smoke}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${smokeItem != null  && smokeItem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What do you smoke?</td>
				<td>: ${smokeItem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${smokeAverage != null  && smokeAverage != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is your average in a day?</td>
				<td>: ${smokeAverage}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${alcohol != null  && alcohol != ''}">

			<tr align="left">
				<td>Do you drink alcohol?</td>
				<td>: ${alcohol}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${alcoholItem != null  && alcoholItem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What alcohol do you drink?</td>
				<td>: ${alcoholItem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${alcoholAverage != null  && alcoholAverage != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is your average in a day?</td>
				<td>: ${alcoholAverage}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${drug != null  && drug != ''}">

			<tr align="left">
				<td>Do you take any recreational drugs?</td>
				<td>: ${drug}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${drugItem != null  && drugItem != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What drugs do you take?</td>
				<td>: ${drugItem}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${drugAverage != null  && drugAverage != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;What is your average in a day?</td>
				<td>: ${drugAverage}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${hivStatus != null  && hivStatus != ''}">

			<tr align="left">
				<td>Are you aware of your current HIV Status</td>
				<td>: ${hivStatus}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${exposedHiv != null  && exposedHiv != ''}">

			<tr align="left">
				<td>Have you been exposed to any HIV/ AIDS factor in the past
					year, or since your last HIV Test?</td>
				<td>: ${exposedHiv}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${exposedHivFactor != null  && exposedHivFactor != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Which factors?</td>
				<td>: ${exposedHivFactor}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${familyHelp != null  && familyHelp != ''}">

			<tr align="left">
				<td>Any close member in the family who can support during
					illness?</td>
				<td>: ${familyHelp}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${otherHelp != null  && otherHelp != ''}">

			<tr align="left">
				<td>&nbsp;&nbsp;Who else can support you during illness?</td>
				<td>: ${otherHelp}</td>
			</tr>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${incomeSource != null  && incomeSource != ''}">

			<tr align="left">
				<td>Do you have a regular source of income?</td>
				<td>: ${incomeSource}</td>
			</tr>
		</c:when>
	</c:choose>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
