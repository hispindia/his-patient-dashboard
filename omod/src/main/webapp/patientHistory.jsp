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

<b class="boxHeader">Patient Surgical and Medical History</b>
<table>
	<tr align="left">
	<td>Any existing illness/ conditions  </td>
	<td>: ${existingIllness}</td>
	</tr>
	<tr align="left">
	<td>What is the problem?  </td>
	<td>: ${existingIllnessProblem}</td>
	</tr>
	<tr align="left">
	<td>How long have you had it?  </td>
	<td>: ${existingIllnessLong}</td>
	</tr>

	<tr align="left">
	<td>How is your progress?  </td>
	<td>: ${existingIllnessProgress}</td>
	</tr>
	<tr align="left">
	<td>Where are the Medical Records?  </td>
	<td>: ${existingIllnessRecord}</td>
	</tr>
	<tr align="left">
	<td>Suffered from any chronic illness?  </td>
	<td>: ${chronicIllness}</td>
	</tr>
	<tr align="left">
	<td>What is the problem?  </td>
	<td>: ${chronicIllnessProblem}</td>
	</tr>
	<tr align="left">
	<td>When did it occur?  </td>
	<td>: ${chronicIllnessOccure}</td>
	</tr>
	<tr align="left">
	<td>What was the outcome?  </td>
	<td>: ${chronicIllnessOutcome}</td>
	</tr>
	<tr align="left">
	<td>Where are the Medical Records?  </td>
	<td>: ${chronicIllnessRecord}</td>
	</tr>
	<tr align="left">
	<td>Any previous hospital admissions?  </td>
	<td>: ${previousAdmission}</td>
	</tr>
	<tr align="left">
	<td>When was this?  </td>
	<td>: ${previousAdmissionWhen}</td>
	</tr>
	<tr align="left">
	<td>What was the problem?  </td>
	<td>: ${previousAdmissionProblem}</td>
	</tr>
	<tr align="left">
	<td>What was the outcome?  </td>
	<td>: ${previousAdmissionOutcome}</td>
	</tr>
	<tr align="left">
	<td>Where are the Medical Records?  </td>
	<td>: ${previousAdmissionRecord}</td>
	</tr>
	<tr align="left">
	<td>Any previous operations/ investigations?  </td>
	<td>: ${previousInvestigation}</td>
	</tr>
	<tr align="left">
	<td>When was this?  </td>
	<td>: ${previousInvestigationWhen}</td>
	</tr>
	<tr align="left">
	<td>What was the problem?  </td>
	<td>: ${previousInvestigationProblem}</td>
	</tr>
	<tr align="left">
	<td>What was the outcome?  </td>
	<td>: ${previousInvestigationOutcome}</td>
	</tr>
	<tr align="left">
	<td>Where are the Medical Records?  </td>
	<td>: ${previousInvestigationRecord}</td>
	</tr>
	<tr align="left">
	<td>BCG  </td>
	<td>: ${BCG}</td>
	</tr>
	<tr align="left">
	<td>3 Polio Doses  </td>
	<td>: ${polio}</td>
	</tr>
	<tr align="left">
	<td>3DPT/ Pentavalent Doses  </td>
	<td>: ${DPT}</td>
	</tr>
	<tr align="left">
	<td>Measles  </td>
	<td>: ${measles}</td>
	</tr>
	<tr align="left">
	<td>Pneumococcal  </td>
	<td>: ${pneumococcal}</td>
	</tr>
	<tr align="left">
	<td>Yellow Fever  </td>
	<td>: ${yellowFever}</td>
	</tr>
	<tr align="left">
	<td>5 Tetanus Doses (If Female)  </td>
	<td>: ${tetanusFemale}</td>
	</tr>
	<tr align="left">
	<td>3 Tetanus Doses (If Male)  </td>
	<td>: ${tetanusMale}</td>
	</tr>
	<tr align="left">
	<td>Other </td>
	<td>: ${otherVaccinations}</td>
	</tr>
</table>


<br/>

<b class="boxHeader">Drug History</b>
<table>
	<tr align="left">
	<td>Current Medications </td>
	<td>: ${currentMedication}</td>
	</tr>
	<tr align="left">
	<td>What is the medication? </td>
	<td>: ${medicationName}</td>
	</tr>
	<tr align="left">
	<td>For how long it has been taken?</td>
	<td>: ${medicationPeriod}</td>
	</tr>
	<tr align="left">
	<td>Why is it being taken?</td>
	<td>: ${medicationReason}</td>
	</tr>
	<tr align="left">
	<td>Where are the Medical Records?</td>
	<td>: ${medicationRecord}</td>
	</tr>
	<tr align="left">
	<td>Any medication you are sensitive to?</td>
	<td>: ${sensitiveMedication}</td>
	</tr>
	<tr align="left">
	<td>What is the medication?</td>
	<td>: ${sensitiveMedicationName}</td>
	</tr>
	<tr align="left">
	<td>What are the symptoms you experience?</td>
	<td>: ${sensitiveMedicationSymptom}</td>
	</tr>
	<tr align="left">
	<td>Are you using any invasive contraception?</td>
	<td>: ${invasiveContraception}</td>
	</tr>
	<tr align="left">
	<td>Which one?</td>
	<td>: ${invasiveContraceptionName}</td>
	</tr>

</table>


<br/>

<b class="boxHeader">Family History</b>
<table >
	<tr align="left">
	<td>Status of parents </td>
	<td>: ${parentStatus}</td>
	</tr>
	<tr align="left">
	<td>What was the cause of death? </td>
	<td>: ${parentDeathCause}</td>
	</tr>
	<tr align="left">
	<td>How old were they? </td>
	<td>: ${parentDeathAge}</td>
	</tr>
	<tr align="left">
	<td>Status of siblings </td>
	<td>: ${siblingStatus}</td>
	</tr>
	<tr align="left">
	<td>What was the cause of death? </td>
	<td>: ${siblingDeathCause}</td>
	</tr>
	<tr align="left">
	<td>How old were they? </td>
	<td>: ${siblingDeathAge}</td>
	</tr>
	<tr align="left">
	<td>Any family history of the following illness? </td>
	<td>: ${familyIllnessHistory}</td>
	</tr>
</table>

<b class="boxHeader">Personal History</b>
<table >
	<tr align="left">
	<td>Do you smoke?</td>
	<td>: ${smoke}</td>
	</tr>
	<tr align="left">
	<td>What do you smoke?</td>
	<td>: ${smokeItem}</td>
	</tr>
	<tr align="left">
	<td>What is your average in a day?</td>
	<td>: ${smokeAverage}</td>
	</tr>
	<tr align="left">
	<td>Do you drink alcohol?</td>
	<td>: ${alcohol}</td>
	</tr>
	<tr align="left">
	<td>What alcohol do you drink?</td>
	<td>: ${alcoholItem}</td>
	</tr>
	<tr align="left">
	<td>What is your average in a day?</td>
	<td>: ${alcoholAverage}</td>
	</tr>
	<tr align="left">
	<td>Do you take any recreational drugs?</td>
	<td>: ${drug}</td>
	</tr>
	<tr align="left">
	<td>What drugs do you take?</td>
	<td>: ${drugItem}</td>
	</tr>
	<tr align="left">
	<td>What is your average in a day?</td>
	<td>: ${drugAverage}</td>
	</tr>
	<tr align="left">
	<td>Are you aware of your current HIV Status</td>
	<td>: ${hivStatus}</td>
	</tr>
	<tr align="left">
	<td>Have you been exposed to any HIV/ AIDS factor in the past year, or since your last HIV Test?</td>
	<td>: ${exposedHiv}</td>
	</tr>
	<tr align="left">
	<td>Which factors?</td>
	<td>: ${exposedHivFactor}</td>
	</tr>
	<tr align="left">
	<td>Any close member in the family who can support during illness?</td>
	<td>: ${familyHelp}</td>
	</tr>
	<tr align="left">
	<td>Who else can support you during illness?</td>
	<td>: ${otherHelp}</td>
	</tr>
	<tr align="left">
	<td>Do you have a regular source of income?</td>
	<td>: ${incomeSource}</td>
	</tr>
</table>
