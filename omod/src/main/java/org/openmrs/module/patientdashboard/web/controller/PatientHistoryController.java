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

import javax.servlet.http.HttpServletRequest;

import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.PatientQueueService;
import org.openmrs.module.hospitalcore.model.PatientDrugHistory;
import org.openmrs.module.hospitalcore.model.PatientFamilyHistory;
import org.openmrs.module.hospitalcore.model.PatientMedicalHistory;
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
			@RequestParam(value="visitStatus" ,required=false) String visitStatus ,
			@RequestParam(value="opdId" ,required=false) Integer opdId ,
			@RequestParam(value="hasEditPrivilige" ,required=false) String hasEditPrivilige ,
			Model model) {
		
		model.addAttribute("patientId", patientId);
		model.addAttribute("queueId", queueId);
		model.addAttribute("visitStatus", visitStatus);
		model.addAttribute("opdId", opdId);
		model.addAttribute("hasEditPrivilige", hasEditPrivilige);
		
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

	
	@RequestMapping(method = RequestMethod.POST)
	public String onUpdate(
			@RequestParam(value = "patientId", required = false) Integer patientId,
			@RequestParam(value="queueId" ,required=false) Integer queueId ,
			@RequestParam(value="visitStatus" ,required=false) String visitStatus ,
			@RequestParam(value="opdId" ,required=false) Integer opdId ,
			HttpServletRequest request,
			Model model)
	{
		
		String existingIllness =request.getParameter("existingIllness");
		String existingIllnessProblem =request.getParameter("existingIllnessProblem");
		String existingIllnessLong =request.getParameter("existingIllnessLong");
		String existingIllnessProgress =request.getParameter("existingIllnessProgress");
		String existingIllnessRecord =request.getParameter("existingIllnessRecord");
		String chronicIllness = request.getParameter("chronicIllness");
		String chronicIllnessProblem = request.getParameter("chronicIllnessProblem");
		String chronicIllnessOccure = request.getParameter("chronicIllnessOccure");
		String chronicIllnessOutcome = request.getParameter("chronicIllnessOutcome");
		String chronicIllnessRecord = request.getParameter("chronicIllnessRecord");
		String previousAdmission = request.getParameter("previousAdmission");
		String previousAdmissionWhen = request.getParameter("previousAdmissionWhen");
		String previousAdmissionProblem = request.getParameter("previousAdmissionProblem");
		String previousAdmissionOutcome = request.getParameter("previousAdmissionOutcome");
		String previousAdmissionRecord = request.getParameter("previousAdmissionRecord");
		String previousInvestigation = request.getParameter("previousInvestigation");
		String previousInvestigationWhen = request.getParameter("previousInvestigationWhen");
		String previousInvestigationProblem = request.getParameter("previousInvestigationProblem");
		String previousInvestigationOutcome = request.getParameter("previousInvestigationOutcome");
		String previousInvestigationRecord = request.getParameter("previousInvestigationRecord");
		String BCG = request.getParameter("BCG");
		String polio = request.getParameter("polio");
		String DPT = request.getParameter("DPT");
		String measles = request.getParameter("measles");
		String pneumococcal = request.getParameter("pneumococcal");
		String yellowFever = request.getParameter("yellowFever");
		String tetanusMale = request.getParameter("tetanusMale");
		String tetanusFemale = request.getParameter("tetanusFemale");
		String otherVaccinations = request.getParameter("otherVaccinations");
		
		
		
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
		
		PatientMedicalHistory patientMedicalHistory = queueService.getPatientHistoryByPatientId(patientId);	
		patientMedicalHistory.setIllnessExisting(existingIllness);
		patientMedicalHistory.setIllnessProblem(existingIllnessProblem);
		patientMedicalHistory.setIllnessLong(existingIllnessLong);
		patientMedicalHistory.setIllnessProgress(existingIllnessProgress);
		patientMedicalHistory.setIllnessRecord(existingIllnessRecord);
		patientMedicalHistory.setChronicIllness(chronicIllness);
		patientMedicalHistory.setChronicIllnessProblem(chronicIllnessProblem);
		patientMedicalHistory.setChronicIllnessOccure(chronicIllnessOccure);
		patientMedicalHistory.setChronicIllnessOutcome(chronicIllnessOutcome);
		patientMedicalHistory.setChronicIllnessRecord(chronicIllnessRecord);
		patientMedicalHistory.setPreviousAdmission(previousAdmission);
		patientMedicalHistory.setPreviousAdmissionWhen(previousAdmissionWhen);
		patientMedicalHistory.setPreviousAdmissionProblem(previousAdmissionProblem);
		patientMedicalHistory.setPreviousAdmissionOutcome(previousAdmissionOutcome);
		patientMedicalHistory.setPreviousAdmissionRecord(previousAdmissionRecord);
		patientMedicalHistory.setPreviousInvestigation(previousInvestigation);
		patientMedicalHistory.setPreviousInvestigationWhen(previousInvestigationWhen);
		patientMedicalHistory.setPreviousInvestigationProblem(previousInvestigationProblem);
		patientMedicalHistory.setPreviousInvestigationOutcome(previousInvestigationOutcome);
		patientMedicalHistory.setPreviousInvestigationRecord(previousInvestigationRecord);
		if(!(BCG.equals("Yes")||(BCG.equals("No"))))
			BCG="Not Sure";
		if(!(polio.equals("Yes")||(polio.equals("No"))))
			polio="Not Sure";
		if(!(DPT.equals("Yes")||(DPT.equals("No"))))
			DPT="Not Sure";
		if(!(measles.equals("Yes")||(measles.equals("No"))))
			measles="Not Sure";
		if(!(pneumococcal.equals("Yes")||(pneumococcal.equals("No"))))
			pneumococcal="Not Sure";
		if(!(yellowFever.equals("Yes")||(yellowFever.equals("No"))))
			yellowFever="Not Sure";
		if(!(tetanusFemale.equals("Yes")||(tetanusFemale.equals("No"))))
			tetanusFemale="Not Sure";
		if(!(tetanusMale.equals("Yes")||(tetanusMale.equals("No"))))
			tetanusMale="Not Sure";
		patientMedicalHistory.setBcg(BCG);
		patientMedicalHistory.setPolio(polio);
		patientMedicalHistory.setDpt(DPT);
		patientMedicalHistory.setMeasles(measles);
		patientMedicalHistory.setPneumococcal(pneumococcal);
		patientMedicalHistory.setYellowFever(yellowFever);
		patientMedicalHistory.setTetanusFemale(tetanusFemale);
		patientMedicalHistory.setTetanusMale(tetanusMale);
		patientMedicalHistory.setOtherVaccinations(otherVaccinations);
		
		
		
		queueService.updatePatientHistoryByPatientId(patientMedicalHistory);
		
		PatientDrugHistory patientDrugHistory = queueService.getPatientDrugHistoryByPatientId(patientId);
		String currentMedication = request.getParameter("currentMedication");
		String medicationName = request.getParameter("medicationName");
		String medicationPeriod = request.getParameter("medicationPeriod");
		String medicationReason = request.getParameter("medicationReason");
		String medicationRecord = request.getParameter("medicationRecord");
		String sensitiveMedication = request.getParameter("sensitiveMedication");
		String sensitiveMedicationName = request.getParameter("sensitiveMedicationName");
		String sensitiveMedicationSymptom = request.getParameter("sensitiveMedicationSymptom");
		String invasiveContraception = request.getParameter("invasiveContraception");
		String invasiveContraceptionName = request.getParameter("invasiveContraceptionName");
		
		patientDrugHistory.setCurrentMedication(currentMedication);
		patientDrugHistory.setMedicationRecord(medicationRecord);
		patientDrugHistory.setMedicationName(medicationName);
		patientDrugHistory.setMedicationPeriod(medicationPeriod);
		patientDrugHistory.setMedicationReason(medicationReason);
		patientDrugHistory.setSensitiveMedication(sensitiveMedication);
		patientDrugHistory.setSensitiveMedicationName(sensitiveMedicationName);
		patientDrugHistory.setSensitiveMedicationSymptom(sensitiveMedicationSymptom);
		patientDrugHistory.setInvasiveContraception(invasiveContraception);
		patientDrugHistory.setInvasiveContraceptionName(invasiveContraceptionName);
		
		queueService.updatePatientDrugHistoryByPatientId(patientDrugHistory);
			
		PatientFamilyHistory patientFamilyHistory = queueService.getPatientFamilyHistoryByPatientId(patientId);
			
		String parentStatus = request.getParameter("parentStatus");
		String parentDeathCause = request.getParameter("parentDeathCause");
		String parentDeathAge = request.getParameter("parentDeathAge");
		String siblingStatus = request.getParameter("siblingStatus");
		String siblingDeathCause = request.getParameter("siblingDeathCause");
		String siblingDeathAge = request.getParameter("siblingDeathAge");
		String familyIllnessHistory = request.getParameter("familyIllnessHistory");
		patientFamilyHistory.setParentStatus(parentStatus);
		patientFamilyHistory.setParentDeathCause(parentDeathCause);
		patientFamilyHistory.setParentDeathAge(parentDeathAge);
		patientFamilyHistory.setSiblingStatus(siblingStatus);
		patientFamilyHistory.setSiblingDeathCause(siblingDeathCause);
		patientFamilyHistory.setSiblingDeathAge(siblingDeathAge);
		patientFamilyHistory.setFamilyIllnessHistory(familyIllnessHistory);
		
		queueService.updatePatientFamilyHistoryByPatientId(patientFamilyHistory);
			
		PatientPersonalHistory patientPersonalHistory = queueService.getPatientPersonalHistoryByPatientId(patientId);
		String smoke = request.getParameter("smoke");
		String smokeItem = request.getParameter("smokeItem");
		String smokeAverage = request.getParameter("smokeAverage");
		String alcohol = request.getParameter("alcohol");
		String alcoholItem = request.getParameter("alcoholItem");
		String alcoholAverage = request.getParameter("alcoholAverage");
		String drug = request.getParameter("drug");
		String drugItem = request.getParameter("drugItem");
		String drugAverage = request.getParameter("drugAverage");
		String hivStatus = request.getParameter("hivStatus");
		String exposedHiv = request.getParameter("exposedHiv");
		String exposedHivFactor = request.getParameter("exposedHivFactor");
		String familyHelp = request.getParameter("familyHelp");
		String otherHelp = request.getParameter("otherHelp");
		String incomeSource = request.getParameter("incomeSource");
		
		patientPersonalHistory.setSmoke(smoke);
		patientPersonalHistory.setSmokeItem(smokeItem);
		patientPersonalHistory.setSmokeAverage(smokeAverage);
		patientPersonalHistory.setAlcohol(alcohol);
		patientPersonalHistory.setAlcoholItem(alcoholItem);
		patientPersonalHistory.setAlcoholAverage(alcoholAverage);
		patientPersonalHistory.setDrug(drug);
		patientPersonalHistory.setDrugItem(drugItem);
		patientPersonalHistory.setDrugAverage(drugAverage);
		patientPersonalHistory.setHivStatus(hivStatus);
		patientPersonalHistory.setExposedHiv(exposedHiv);
		patientPersonalHistory.setExposedHivFactor(exposedHivFactor);
		patientPersonalHistory.setFamilyHelp(familyHelp);
		patientPersonalHistory.setOtherHelp(otherHelp);
		patientPersonalHistory.setIncomeSource(incomeSource);
		
		queueService.updatePatientPersonalHistoryByPatientId(patientPersonalHistory);

		
		return "redirect:/module/patientdashboard/main.htm?patientId="+patientId
		+"&opdId="+opdId+"&visitStatus="+visitStatus+"&queueId="+queueId+"#Patient_history";
	}

}
