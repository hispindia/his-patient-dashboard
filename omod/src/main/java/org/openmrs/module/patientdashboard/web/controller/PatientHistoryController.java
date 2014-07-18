/**
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
 *  author:Sagar
 **/

package org.openmrs.module.patientdashboard.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.InventoryCommonService;
import org.openmrs.module.hospitalcore.PatientQueueService;
import org.openmrs.module.hospitalcore.model.InventoryStoreDrugPatient;
import org.openmrs.module.hospitalcore.model.InventoryStoreDrugPatientDetail;
import org.openmrs.module.hospitalcore.model.OpdPatientQueue;
import org.openmrs.module.hospitalcore.model.TriagePatientData;
import org.openmrs.module.hospitalcore.model.PatientMedicalHistory;
import org.openmrs.module.hospitalcore.model.PatientDrugHistory;
import org.openmrs.module.hospitalcore.model.PatientFamilyHistory;
import org.openmrs.module.hospitalcore.model.PatientPersonalHistory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("PatientHistoryController")
@RequestMapping("/module/patientdashboard/patientHistory.htm")
public class PatientHistoryController {

	@RequestMapping(method = RequestMethod.GET)
	public String firstView(
			@RequestParam(value = "patientId", required = false) Integer patientId,
			@RequestParam(value="queueId" ,required=false) Integer queueId ,
			Model model) {
		model.addAttribute("patientId", patientId);
		PatientQueueService queueService = Context.getService(PatientQueueService.class);

		PatientMedicalHistory patientMedicalHistory = queueService.getPatientHistoryByPatientId(patientId);	
		model.addAttribute("dateOfCreation", patientMedicalHistory.getCreatedOn());
		model.addAttribute("existingIllness", patientMedicalHistory.getIllnessExisting());
		model.addAttribute("existingIllnessProblem", patientMedicalHistory.getIllnessProblem());
		model.addAttribute("existingIllnessLong", patientMedicalHistory.getIllnessLong());
		model.addAttribute("existingIllnessProgress", patientMedicalHistory.getIllnessProgress());
		model.addAttribute("existingIllnessRecord", patientMedicalHistory.getIllnessRecord());
		model.addAttribute("chronicIllness", patientMedicalHistory.getChronicIllness());
		model.addAttribute("chronicIllnessProblem", patientMedicalHistory.getChronicIllnessProblem());
		model.addAttribute("chronicIllnessOccure", patientMedicalHistory.getChronicIllnessOccure());
		model.addAttribute("chronicIllnessOutcome", patientMedicalHistory.getChronicIllnessOutcome());
		model.addAttribute("chronicIllnessRecord", patientMedicalHistory.getChronicIllnessRecord());
		model.addAttribute("previousAdmission", patientMedicalHistory.getPreviousAdmission());
		model.addAttribute("previousAdmissionWhen", patientMedicalHistory.getPreviousAdmissionWhen());
		model.addAttribute("previousAdmissionProblem", patientMedicalHistory.getPreviousAdmissionProblem());
		model.addAttribute("previousAdmissionOutcome", patientMedicalHistory.getPreviousAdmissionOutcome());
		model.addAttribute("previousAdmissionRecord", patientMedicalHistory.getPreviousAdmissionRecord());
		model.addAttribute("previousInvestigation", patientMedicalHistory.getPreviousInvestigation());
		model.addAttribute("previousInvestigationWhen", patientMedicalHistory.getPreviousInvestigationWhen());
		model.addAttribute("previousInvestigationProblem", patientMedicalHistory.getPreviousInvestigationProblem());
		model.addAttribute("previousInvestigationOutcome", patientMedicalHistory.getPreviousInvestigationOutcome());
		model.addAttribute("previousInvestigationRecord", patientMedicalHistory.getPreviousInvestigationRecord());
		model.addAttribute("BCG", patientMedicalHistory.getBcg());
		model.addAttribute("polio", patientMedicalHistory.getPolio());
		model.addAttribute("DPT", patientMedicalHistory.getDpt());
		model.addAttribute("measles", patientMedicalHistory.getMeasles());
		model.addAttribute("pneumococcal", patientMedicalHistory.getPneumococcal());
		model.addAttribute("yellowFever", patientMedicalHistory.getYellowFever());
		model.addAttribute("tetanusMale", patientMedicalHistory.getTetanusMale());
		model.addAttribute("tetanusFemale", patientMedicalHistory.getTetanusFemale());
		model.addAttribute("otherVaccinations", patientMedicalHistory.getOtherVaccinations());
	
		PatientDrugHistory patientDrugHistory = queueService.getPatientDrugHistoryByPatientId(patientId);
		model.addAttribute("currentMedication", patientDrugHistory.getCurrentMedication());
		model.addAttribute("medicationName", patientDrugHistory.getMedicationName());
		model.addAttribute("medicationPeriod", patientDrugHistory.getMedicationPeriod());
		model.addAttribute("medicationReason", patientDrugHistory.getMedicationReason());
		model.addAttribute("medicationRecord", patientDrugHistory.getMedicationRecord());
		model.addAttribute("sensitiveMedication", patientDrugHistory.getSensitiveMedication());
		model.addAttribute("sensitiveMedicationName", patientDrugHistory.getSensitiveMedicationName());
		model.addAttribute("sensitiveMedicationSymptom", patientDrugHistory.getSensitiveMedicationSymptom());
		model.addAttribute("invasiveContraception", patientDrugHistory.getInvasiveContraception());
		model.addAttribute("invasiveContraceptionName", patientDrugHistory.getInvasiveContraceptionName());
	
		PatientFamilyHistory patientFamilyHistory = queueService.getPatientFamilyHistoryByPatientId(patientId);
		model.addAttribute("parentStatus", patientFamilyHistory.getParentStatus());
		model.addAttribute("parentDeathCause", patientFamilyHistory.getParentDeathCause());
		model.addAttribute("parentDeathAge", patientFamilyHistory.getParentDeathAge());
		model.addAttribute("siblingStatus", patientFamilyHistory.getSiblingStatus());
		model.addAttribute("siblingDeathCause", patientFamilyHistory.getSiblingDeathCause());
		model.addAttribute("siblingDeathAge", patientFamilyHistory.getSiblingDeathAge());
		model.addAttribute("familyIllnessHistory", patientFamilyHistory.getFamilyIllnessHistory());
		
		PatientPersonalHistory patientPersonalHistory = queueService.getPatientPersonalHistoryByPatientId(patientId);
		model.addAttribute("smoke", patientPersonalHistory.getSmoke());
		model.addAttribute("smokeItem", patientPersonalHistory.getSmokeItem());
		model.addAttribute("smokeAverage", patientPersonalHistory.getSmokeAverage());
		model.addAttribute("alcohol", patientPersonalHistory.getAlcohol());
		model.addAttribute("alcoholItem", patientPersonalHistory.getAlcoholItem());
		model.addAttribute("alcoholAverage", patientPersonalHistory.getAlcoholAverage());
		model.addAttribute("drug", patientPersonalHistory.getDrug());
		model.addAttribute("drugItem", patientPersonalHistory.getDrugItem());
		model.addAttribute("drugAverage", patientPersonalHistory.getDrugAverage());
		model.addAttribute("hivStatus", patientPersonalHistory.getHivStatus());
		model.addAttribute("exposedHiv", patientPersonalHistory.getExposedHiv());
		model.addAttribute("exposedHivFactor", patientPersonalHistory.getExposedHivFactor());
		model.addAttribute("familyHelp", patientPersonalHistory.getFamilyHelp());
		model.addAttribute("otherHelp", patientPersonalHistory.getOtherHelp());
		model.addAttribute("incomeSource", patientPersonalHistory.getIncomeSource());
		
		return "module/patientdashboard/patientHistory";
	}


}
