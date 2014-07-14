/**
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
 **/

package org.openmrs.module.patientdashboard.web.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.ConceptClass;
import org.openmrs.ConceptDatatype;
import org.openmrs.ConceptName;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.GlobalProperty;
import org.openmrs.Location;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.User;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.EncounterService;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.IpdService;
import org.openmrs.module.hospitalcore.PatientQueueService;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.model.OpdPatientQueue;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.hospitalcore.model.TriagePatientData;
import org.openmrs.module.hospitalcore.model.TriagePatientQueue;
import org.openmrs.module.hospitalcore.model.PatientMedicalHistory;
import org.openmrs.module.hospitalcore.model.PatientDrugHistory;
import org.openmrs.module.hospitalcore.model.PatientFamilyHistory;
import org.openmrs.module.hospitalcore.model.PatientPersonalHistory;
import org.openmrs.module.hospitalcore.model.TriagePatientQueueLog;
import org.openmrs.module.hospitalcore.util.ConceptAnswerComparator;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.openmrs.module.patientdashboard.util.PatientDashboardUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("TriageFormController")
@RequestMapping("/module/patientdashboard/triageForm.htm")
public class TriageFormController {

	@SuppressWarnings("deprecation")
	@RequestMapping(method = RequestMethod.GET)
	public String firstView(
			@RequestParam("patientId") Integer patientId,
			@RequestParam("opdId") Integer opdId,
			@RequestParam(value = "queueId", required = false) Integer queueId,
			@RequestParam(value = "ipdAdmittedId", required = false) Integer ipdAdmittedId,
			@RequestParam("referralId") Integer referralId, Model model) {
		PatientService ps = Context.getPatientService();
		Patient patient = ps.getPatient(patientId);
		List<EncounterType> types = new ArrayList<EncounterType>();

		EncounterType reginit = Context.getEncounterService().getEncounterType(
				"REGINITIAL");
		types.add(reginit);
		EncounterType regrevisit = Context.getEncounterService()
				.getEncounterType("REGREVISIT");
		types.add(regrevisit);
		EncounterType labencounter = Context.getEncounterService()
				.getEncounterType("LABENCOUNTER");
		types.add(labencounter);
		EncounterType radiologyencounter = Context.getEncounterService()
				.getEncounterType("RADIOLOGYENCOUNTER");
		types.add(radiologyencounter);
		EncounterType opdencounter = Context.getEncounterService()
				.getEncounterType("OPDENCOUNTER");
		types.add(opdencounter);
		EncounterType ipdencounter = Context.getEncounterService()
				.getEncounterType("IPDENCOUNTER");
		types.add(ipdencounter);

		PatientQueueService pqs = Context.getService(PatientQueueService.class);
		IpdService ipdService = Context.getService(IpdService.class);
		TriagePatientQueue triagePatientQueue = pqs.getTriagePatientQueueById(queueId);
		Date createdOn = null;
		if (queueId != null) {
			createdOn = triagePatientQueue.getCreatedOn();
		}

		// get Encounter by date
		Encounter encounter = null;
		EncounterService es = Context.getEncounterService();
		List<Encounter> listEncounter = es.getEncounters(patient, createdOn,
				createdOn);
		if (1 == listEncounter.size())
			encounter = listEncounter.get(0);
		else {
			HospitalCoreService hcs = Context
					.getService(HospitalCoreService.class);
			encounter = hcs.getLastVisitEncounter(patient, types);
		}

		Concept referralConcept = Context.getConceptService().getConcept(
				"PATIENT REFERRED TO HOSPITAL?");
		Concept conceptYesAnswer = Context.getConceptService()
				.getConcept("YES");
		Concept referredTypeConcept = Context.getConceptService().getConcept(
				"REASON FOR REFERRAL");
		Concept temporaryCategoryConcept = Context.getConceptService()
				.getConcept("TEMPORARY CATEGORY");

		List<Obs> listObsTemporaryCategories = new ArrayList<Obs>();
		Obs referral = null;

		Set<Obs> setObs = Context.getObsService().getObservations(encounter);
		Iterator<Obs> obs = setObs.iterator();
		Obs o = new Obs();
		while (obs.hasNext()) {
			o = obs.next();
			if (temporaryCategoryConcept.getId().equals(o.getConcept().getId()))
				listObsTemporaryCategories.add(o); 
												
			if (referredTypeConcept.getId().equals(o.getConcept().getId()))
				referral = o; 
								
		}
		
		PatientQueueService queueService1 = Context.getService(PatientQueueService.class);
		TriagePatientQueue queue = queueService1.getTriagePatientQueueById(queueId);
		PatientMedicalHistory pmh = queueService1.getPatientHistoryByPatientId(queue.getPatient().getPatientId());
		
		if(pmh !=null)
		{
			model.addAttribute("existingIllness", pmh.getIllnessExisting());
			model.addAttribute("existingIllnessProblem", pmh.getIllnessProblem());
			model.addAttribute("existingIllnessProblem", pmh.getIllnessProblem());
			model.addAttribute("existingIllnessLong", pmh.getIllnessLong());
			model.addAttribute("existingIllnessProgress", pmh.getIllnessProgress());
			model.addAttribute("existingIllnessRecord", pmh.getIllnessRecord());
			model.addAttribute("chronicIllness", pmh.getChronicIllness());
			model.addAttribute("chronicIllnessProblem", pmh.getChronicIllnessProblem());
			model.addAttribute("chronicIllnessOccure", pmh.getChronicIllnessOccure());
			model.addAttribute("chronicIllnessOutcome", pmh.getChronicIllnessOutcome());
			model.addAttribute("chronicIllnessRecord", pmh.getChronicIllnessRecord());
			model.addAttribute("previousAdmission", pmh.getPreviousAdmission());
			model.addAttribute("previousAdmissionWhen", pmh.getPreviousAdmissionWhen());
			model.addAttribute("previousAdmissionProblem", pmh.getPreviousAdmissionProblem());
			model.addAttribute("previousAdmissionOutcome", pmh.getPreviousAdmissionOutcome());
			model.addAttribute("previousAdmissionRecord", pmh.getPreviousAdmissionRecord());
			model.addAttribute("previousInvestigation", pmh.getPreviousInvestigation());
			model.addAttribute("previousInvestigationWhen", pmh.getPreviousInvestigationWhen());
			model.addAttribute("previousInvestigationProblem", pmh.getPreviousInvestigationProblem());
			model.addAttribute("previousInvestigationOutcome", pmh.getPreviousInvestigationOutcome());
			model.addAttribute("previousInvestigationRecord", pmh.getPreviousInvestigationRecord());
			model.addAttribute("BCG", pmh.getBcg());
			model.addAttribute("polio", pmh.getPolio());
			model.addAttribute("DPT", pmh.getDpt());
			model.addAttribute("measles", pmh.getMeasles());
			model.addAttribute("pneumococcal", pmh.getPneumococcal());
			model.addAttribute("yellowFever", pmh.getYellowFever());
			model.addAttribute("tetanusMale", pmh.getTetanusMale());
			model.addAttribute("tetanusFemale", pmh.getTetanusFemale());
			model.addAttribute("otherVaccinations", pmh.getOtherVaccinations());
		}
		
		PatientDrugHistory pdh = queueService1.getPatientDrugHistoryByPatientId(queue.getPatient().getPatientId());
		if(pdh != null)
		{
			model.addAttribute("currentMedication", pdh.getCurrentMedication());
			model.addAttribute("medicationName", pdh.getMedicationName());
			model.addAttribute("medicationPeriod", pdh.getMedicationPeriod());
			model.addAttribute("medicationReason", pdh.getMedicationReason());
			model.addAttribute("medicationRecord", pdh.getMedicationRecord());
			model.addAttribute("sensitiveMedication", pdh.getSensitiveMedication());
			model.addAttribute("sensitiveMedicationName", pdh.getSensitiveMedicationName());
			model.addAttribute("sensitiveMedicationSymptom", pdh.getSensitiveMedicationSymptom());
			model.addAttribute("invasiveContraception", pdh.getInvasiveContraception());
			model.addAttribute("invasiveContraceptionName", pdh.getInvasiveContraceptionName());
		}
		
		PatientFamilyHistory patientFamilyHistory = queueService1.getPatientFamilyHistoryByPatientId(queue.getPatient().getPatientId());
		if(patientFamilyHistory != null)
		{
			model.addAttribute("parentStatus", patientFamilyHistory.getParentStatus());
			model.addAttribute("parentDeathCause", patientFamilyHistory.getParentDeathCause());
			model.addAttribute("parentDeathAge", patientFamilyHistory.getParentDeathCause());
			model.addAttribute("siblingStatus", patientFamilyHistory.getSiblingStatus());
			model.addAttribute("siblingDeathCause", patientFamilyHistory.getSiblingDeathCause());
			model.addAttribute("siblingDeathAge", patientFamilyHistory.getSiblingDeathAge());
			model.addAttribute("familyIllnessHistory", patientFamilyHistory.getFamilyIllnessHistory());
		}

		PatientPersonalHistory patientPersonalHistory = queueService1.getPatientPersonalHistoryByPatientId(queue.getPatient().getPatientId());
		if(patientPersonalHistory != null){
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
		}
		
		Date birthday = patient.getBirthdate();

		model.addAttribute("observation", listObsTemporaryCategories);
		model.addAttribute("patient", patient);
		model.addAttribute("patientCategory",
				PatientUtils.getPatientCategory(patient));

		model.addAttribute("queueId", queueId);
		model.addAttribute("age", PatientUtils.estimateAge(birthday));
		model.addAttribute("ageCategory",
				PatientDashboardUtil.calcAgeClass(patient.getAge()));
		model.addAttribute("opd", Context.getConceptService().getConcept(opdId));

		if (null != referral)
			model.addAttribute("referredType", referral.getValueCoded()
					.getName());

		model.addAttribute("referral",
				Context.getConceptService().getConcept(referralId));

		insertPropertiesUnlessExist();

		// get admitted status of patient

		IpdPatientAdmitted admitted = ipdService
				.getAdmittedByPatientId(patientId);

		if (admitted != null) {
			model.addAttribute("admittedStatus", "Admitted");
		}

		Concept opdWardConcept = Context.getConceptService().getConceptByName(
				"OPD WARD");
		List<ConceptAnswer> oList = (opdWardConcept != null ? new ArrayList<ConceptAnswer>(
				opdWardConcept.getAnswers()) : null);
		if (CollectionUtils.isNotEmpty(oList)) {
			Collections.sort(oList, new ConceptAnswerComparator());
		}
		model.addAttribute("listOPD", oList);
		
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
		Encounter enc=queueService.getLastOPDEncounter(patient);
		OpdPatientQueueLog opdPatientQueueLog=queueService.getOpdPatientQueueLogByEncounter(enc);
		model.addAttribute("opdPatientQueueLog", opdPatientQueueLog);
		Obs ob=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patientId),Context.getConceptService().getConcept("VISIT OUTCOME"),enc);
		model.addAttribute("ob", ob);

		return "module/patientdashboard/triageForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String formSummit(@RequestParam(value = "queueId", required = false) Integer queueId,
			@RequestParam(value = "weight", required = false) BigDecimal weight,
			@RequestParam(value = "height", required = false) BigDecimal height,
			
			@RequestParam(value = "mua", required = false) BigDecimal mua,
			@RequestParam(value = "chest", required = false) BigDecimal chest,
			@RequestParam(value = "abdominal", required = false) BigDecimal abdominal,
			
			@RequestParam(value = "temperature", required = false) BigDecimal temperature,
			@RequestParam(value = "sbp", required = false) Integer sbp,
			@RequestParam(value = "dbp", required = false) Integer dbp,
			@RequestParam(value = "resRate", required = false) Integer resRate,
			@RequestParam(value = "pulseRate", required = false) Integer pulseRate,
			@RequestParam(value = "bloodGroup", required = false) String bloodGroup,
			@RequestParam(value = "lastMenstrualPeriod", required = false) Date lastMenstrualPeriod,
			@RequestParam(value = "rhesusFactor", required = false) String rhesusFactor,
			@RequestParam(value = "pitct", required = false) String pitct,
			@RequestParam(value = "opd", required = false) Integer opd,
			
			@RequestParam(value = "existingIllness", required = false) String existingIllness,
			@RequestParam(value = "existingIllnessProblem", required = false) String existingIllnessProblem,
			@RequestParam(value = "existingIllnessLong", required = false) String existingIllnessLong,
			@RequestParam(value = "existingIllnessProgress", required = false) String existingIllnessProgress,
			@RequestParam(value = "existingIllnessRecord", required = false) String existingIllnessRecord,
			
			@RequestParam(value = "chronicIllness", required = false) String chronicIllness,
			@RequestParam(value = "chronicIllnessProblem", required = false) String chronicIllnessProblem,
			@RequestParam(value = "chronicIllnessOccure", required = false) String chronicIllnessOccure,
			@RequestParam(value = "chronicIllnessOutcome", required = false) String chronicIllnessOutcome,
			@RequestParam(value = "chronicIllnessRecord", required = false) String chronicIllnessRecord,
			@RequestParam(value = "previousAdmission", required = false) String previousAdmission,
			@RequestParam(value = "previousAdmissionWhen", required = false) String previousAdmissionWhen,
			@RequestParam(value = "previousAdmissionProblem", required = false) String previousAdmissionProblem,
			@RequestParam(value = "previousAdmissionOutcome", required = false) String previousAdmissionOutcome,
			@RequestParam(value = "previousAdmissionRecord", required = false) String previousAdmissionRecord,
			@RequestParam(value = "previousInvestigation", required = false) String previousInvestigation,
			@RequestParam(value = "previousInvestigationWhen", required = false) String previousInvestigationWhen,
			@RequestParam(value = "previousInvestigationProblem", required = false) String previousInvestigationProblem,
			@RequestParam(value = "previousInvestigationOutcome", required = false) String previousInvestigationOutcome,
			@RequestParam(value = "previousInvestigationRecord", required = false) String previousInvestigationRecord,
			@RequestParam(value = "BCG", required = false) String bcg,
			@RequestParam(value = "polio", required = false) String polio,
			@RequestParam(value = "DPT", required = false) String dpt,
			@RequestParam(value = "measles", required = false) String measles,
			@RequestParam(value = "pneumococcal", required = false) String pneumococcal,
			@RequestParam(value = "yellowFever", required = false) String yellowFever,
			@RequestParam(value = "tetanusMale", required = false) String tetanusMale,
			@RequestParam(value = "tetanusFemale", required = false) String tetanusFemale,
			@RequestParam(value = "otherVaccinations", required = false) String otherVaccinations,
			
			@RequestParam(value = "currentMedication", required = false) String currentMedication,
			@RequestParam(value = "medicationName", required = false) String medicationName,
			@RequestParam(value = "medicationPeriod", required = false) String medicationPeriod,
			@RequestParam(value = "medicationReason", required = false) String medicationReason,
			@RequestParam(value = "medicationRecord", required = false) String medicationRecord,
			@RequestParam(value = "sensitiveMedication", required = false) String sensitiveMedication,
			@RequestParam(value = "sensitiveMedicationName", required = false) String sensitiveMedicationName,
			@RequestParam(value = "sensitiveMedicationSymptom", required = false) String sensitiveMedicationSymptom,
			@RequestParam(value = "invasiveContraception", required = false) String invasiveContraception,
			@RequestParam(value = "invasiveContraceptionName", required = false) String invasiveContraceptionName,

			@RequestParam(value = "parentStatus", required = false) String parentStatus,
			@RequestParam(value = "parentDeathCause", required = false) String parentDeathCause,
			@RequestParam(value = "parentDeathAge", required = false) String parentDeathAge,
			@RequestParam(value = "siblingStatus", required = false) String siblingStatus,
			@RequestParam(value = "siblingDeathCause", required = false) String siblingDeathCause,
			@RequestParam(value = "siblingDeathAge", required = false) String siblingDeathAge,
			@RequestParam(value = "familyIllnessHistory", required = false) String familyIllnessHistory,
			@RequestParam(value = "smoke", required = false) String smoke,
			@RequestParam(value = "smokeItem", required = false) String smokeItem,
			@RequestParam(value = "smokeAverage", required = false) String smokeAverage,
			@RequestParam(value = "alcohol", required = false) String alcohol,
			@RequestParam(value = "alcoholItem", required = false) String alcoholItem,
			@RequestParam(value = "alcoholAverage", required = false) String alcoholAverage,
			@RequestParam(value = "drug", required = false) String drug,
			@RequestParam(value = "drugItem", required = false) String drugItem,
			@RequestParam(value = "drugAverage", required = false) String drugAverage,
			@RequestParam(value = "hivStatus", required = false) String hivStatus,
			@RequestParam(value = "exposedHiv", required = false) String exposedHiv,
			@RequestParam(value = "exposedHivFactor", required = false) String exposedHivFactor,
			@RequestParam(value = "familyHelp", required = false) String familyHelp,
			@RequestParam(value = "incomeSource", required = false) String incomeSource,
			@RequestParam(value = "otherHelp", required = false) String otherHelp,
		
			HttpServletRequest request) throws Exception {
		User user = Context.getAuthenticatedUser();
		//PatientService ps = Context.getPatientService();
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
		TriagePatientQueue queue = queueService.getTriagePatientQueueById(queueId);
		AdministrationService administrationService = Context.getAdministrationService();
		GlobalProperty gpTRIAGEEncounterType = administrationService.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_TRIAGE_ENCOUTNER_TYPE);
		EncounterType encounterType = Context.getEncounterService().getEncounterType(gpTRIAGEEncounterType.getPropertyValue());
		Encounter encounter = new Encounter();
		Location location = new Location( 1 );
		Date date = new Date();
		encounter.setPatient(queue.getPatient());
		encounter.setCreator( user);
		encounter.setProvider(user );
		encounter.setEncounterDatetime( date);
		encounter.setEncounterType(encounterType);
		encounter.setLocation( location );
		Context.getEncounterService().saveEncounter(encounter);
		
		TriagePatientQueueLog queueLog = new TriagePatientQueueLog();		
		queueLog.setTriageConcept(queue.getTriageConcept());
		queueLog.setTriageConceptName(queue.getTriageConceptName());
		queueLog.setPatient(queue.getPatient());
        queueLog.setCreatedOn(queue.getCreatedOn());
        queueLog.setPatientIdentifier(queue.getPatientIdentifier());
        queueLog.setPatientName(queue.getPatientName());
        queueLog.setReferralConcept(queue.getReferralConcept());
        queueLog.setReferralConceptName(queue.getReferralConceptName());
        queueLog.setSex(queue.getSex());
        queueLog.setUser(Context.getAuthenticatedUser());
        queueLog.setStatus("processed");
        queueLog.setBirthDate(queue.getBirthDate());
        queueLog.setEncounter(encounter);
		TriagePatientQueueLog triagePatientLog = queueService.saveTriagePatientQueueLog(queueLog);
		queueService.deleteTriagePatientQueue(queue);
		TriagePatientData tpd=new TriagePatientData();
		tpd.setTriageLogId(triagePatientLog);
		tpd.setWeight(weight);
		tpd.setHeight(height);
		
		tpd.setMua(mua);
		tpd.setChest(chest);
		tpd.setAbdominal(abdominal);
		
		tpd.setTemperature(temperature);
		tpd.setSystolic(sbp);
		tpd.setDaistolic(dbp);
		tpd.setRespiratoryRate(resRate);
		tpd.setPulsRate(pulseRate);
		if(bloodGroup.equals("")){
		tpd.setBloodGroup(null);
		}
		else{
		tpd.setBloodGroup(bloodGroup);
		}
		tpd.setLastMenstrualDate(lastMenstrualPeriod);
		if(rhesusFactor.equals("")){
		tpd.setRhesusFactor(null);
		}
		else{
		tpd.setRhesusFactor(rhesusFactor);
		}
		if(pitct.equals("")){
		tpd.setPitct(null);
		}
		else{
		tpd.setPitct(pitct);
		}
		tpd.setCreatedOn(date);

		PatientQueueService queueService1 = Context.getService(PatientQueueService.class);
		PatientMedicalHistory patientMedicalHistory1 = queueService1.getPatientHistoryByPatientId(queue.getPatient().getPatientId());	
		PatientDrugHistory patientDrugHistory1 = queueService1.getPatientDrugHistoryByPatientId(queue.getPatient().getPatientId());
		PatientFamilyHistory patientFamilyHistory1 = queueService1.getPatientFamilyHistoryByPatientId(queue.getPatient().getPatientId());
		PatientPersonalHistory patientPersonalHistory1 = queueService1.getPatientPersonalHistoryByPatientId(queue.getPatient().getPatientId());
		
		
		PatientMedicalHistory pmh = new PatientMedicalHistory(); 
		pmh.setPatientId(queue.getPatient().getPatientId());
		pmh.setTriageLogId(triagePatientLog);
		pmh.setIllnessExisting(existingIllness);
		pmh.setIllnessProblem(existingIllnessProblem);
		pmh.setIllnessLong(existingIllnessLong);
		pmh.setIllnessProgress(existingIllnessProgress);
		pmh.setIllnessRecord(existingIllnessRecord);
		pmh.setCreatedOn(date);
		pmh.setChronicIllness(chronicIllness);
		pmh.setChronicIllnessProblem(chronicIllnessProblem);
		pmh.setChronicIllnessOccure(chronicIllnessOccure);
		pmh.setChronicIllnessOutcome(chronicIllnessOutcome);
		pmh.setChronicIllnessRecord(chronicIllnessRecord);
		pmh.setPreviousAdmission(previousAdmission);
		pmh.setPreviousAdmissionWhen(previousAdmissionWhen);
		pmh.setPreviousAdmissionProblem(previousAdmissionProblem);
		pmh.setPreviousAdmissionOutcome(previousAdmissionOutcome);
		pmh.setPreviousAdmissionRecord(previousAdmissionRecord);
		pmh.setPreviousInvestigation(previousInvestigation);
		pmh.setPreviousInvestigationWhen(previousInvestigationWhen);
		pmh.setPreviousInvestigationProblem(previousInvestigationProblem);
		pmh.setPreviousInvestigationOutcome(previousInvestigationOutcome);
		pmh.setPreviousInvestigationRecord(previousInvestigationRecord);
		pmh.setBcg(bcg);
		pmh.setDpt(dpt);
		pmh.setYellowFever(yellowFever);
		pmh.setPneumococcal(pneumococcal);
		pmh.setPolio(polio);
		pmh.setTetanusFemale(tetanusFemale);
		pmh.setTetanusMale(tetanusMale);
		pmh.setMeasles(measles);
		pmh.setOtherVaccinations(otherVaccinations);

		
		PatientDrugHistory pdh = new PatientDrugHistory(); 
		pdh.setPatientId(queue.getPatient().getPatientId());
		pdh.setTriageLogId(triagePatientLog);
		pdh.setCurrentMedication(currentMedication);
		pdh.setMedicationName(medicationName);
		pdh.setMedicationPeriod(medicationPeriod);
		pdh.setMedicationReason(medicationReason);
		pdh.setMedicationRecord(medicationRecord);
		pdh.setSensitiveMedication(sensitiveMedication);
		pdh.setSensitiveMedicationName(sensitiveMedicationName);
		pdh.setSensitiveMedicationSymptom(sensitiveMedicationSymptom);
		pdh.setInvasiveContraception(invasiveContraception);
		pdh.setInvasiveContraceptionName(invasiveContraceptionName);
		pdh.setCreatedOn(date);
		
		
		PatientFamilyHistory pfh = new PatientFamilyHistory(); 
		pfh.setPatientId(queue.getPatient().getPatientId());
		pfh.setTriageLogId(triagePatientLog);
		pfh.setParentStatus(parentStatus);
		pfh.setParentDeathCause(parentDeathCause);
		pfh.setParentDeathAge(parentDeathAge);
		pfh.setSiblingStatus(siblingStatus);
		pfh.setSiblingDeathCause(siblingDeathCause);
		pfh.setSiblingDeathAge(siblingDeathAge);
		pfh.setFamilyIllnessHistory(familyIllnessHistory);
		pfh.setCreatedOn(date);

		PatientPersonalHistory pph = new PatientPersonalHistory(); 
		pph.setPatientId(queue.getPatient().getPatientId());
		pph.setTriageLogId(triagePatientLog);
		pph.setSmoke(smoke);
		pph.setSmokeItem(smokeItem);
		pph.setSmokeAverage(smokeAverage);
		pph.setAlcohol(alcohol);
		pph.setAlcoholItem(alcoholItem);
		pph.setAlcoholAverage(alcoholAverage);
		pph.setDrug(drug);
		pph.setDrugItem(drugItem);
		pph.setDrugAverage(drugAverage);
		pph.setExposedHiv(exposedHiv);
		pph.setExposedHivFactor(exposedHivFactor);
		pph.setHivStatus(hivStatus);
		pph.setFamilyHelp(familyHelp);
		pph.setOtherHelp(otherHelp);
		pph.setIncomeSource(incomeSource);
		pph.setCreatedOn(date);
		
		if(patientMedicalHistory1 ==null){
			PatientMedicalHistory patientMedicalHistory = queueService.savePatientMedicalHistory(pmh);
			PatientDrugHistory patientDrugHistory = queueService.savePatientDrugHistory(pdh);
			PatientFamilyHistory patientFamilyHistory = queueService.savePatientFamilyHistory(pfh);
			PatientPersonalHistory patientPersonalHistory = queueService.savePatientPersonalHistory(pph);
		}
		
		else {		
			
					if(patientMedicalHistory1.getIllnessExisting()==null || patientMedicalHistory1.getIllnessExisting().equals("")){
						patientMedicalHistory1.setIllnessExisting(existingIllness);
					}
					if(patientMedicalHistory1.getIllnessProblem()==null || patientMedicalHistory1.getIllnessProblem().equals("")){
						pmh.setIllnessProblem(existingIllnessProblem);	
					}
					if(patientMedicalHistory1.getIllnessLong()==null || patientMedicalHistory1.getIllnessLong().equals("")){
						patientMedicalHistory1.setIllnessLong(existingIllnessLong);						
					}
					if(patientMedicalHistory1.getIllnessProgress()==null || patientMedicalHistory1.getIllnessProgress().equals("")){
						patientMedicalHistory1.setIllnessProgress(existingIllnessProgress);
					}
					if(patientMedicalHistory1.getIllnessRecord()==null || patientMedicalHistory1.getIllnessRecord().equals("")){
						patientMedicalHistory1.setIllnessRecord(existingIllnessRecord);
					}
					System.out.println("&&&&&&"+patientMedicalHistory1.getChronicIllness()+"########");
					if(patientMedicalHistory1.getChronicIllness()==null || patientMedicalHistory1.getChronicIllness().equals("")){
						patientMedicalHistory1.setChronicIllness(chronicIllness);
					}
					if(patientMedicalHistory1.getChronicIllnessProblem()==null || patientMedicalHistory1.getChronicIllnessProblem().equals("")){
						patientMedicalHistory1.setChronicIllnessProblem(chronicIllnessProblem);
					}
					if(patientMedicalHistory1.getChronicIllnessOccure()==null || patientMedicalHistory1.getChronicIllnessOccure().equals("")){
						patientMedicalHistory1.setChronicIllnessOccure(chronicIllnessOccure);
					}
					if(patientMedicalHistory1.getChronicIllnessOutcome()==null || patientMedicalHistory1.getChronicIllnessOutcome().equals("")){
						patientMedicalHistory1.setChronicIllnessOutcome(chronicIllnessOutcome);
					}
					if(patientMedicalHistory1.getChronicIllnessRecord()==null || patientMedicalHistory1.getChronicIllnessRecord().equals("")){
						patientMedicalHistory1.setChronicIllnessRecord(chronicIllnessRecord);
					}
					if(patientMedicalHistory1.getPreviousAdmission()==null || patientMedicalHistory1.getPreviousAdmission().equals("")){
						patientMedicalHistory1.setPreviousAdmission(previousAdmission);
					}
					if(patientMedicalHistory1.getPreviousAdmissionWhen()==null || patientMedicalHistory1.getPreviousAdmissionWhen().equals("")){
						patientMedicalHistory1.setPreviousAdmissionWhen(previousAdmissionWhen);
					}
					if(patientMedicalHistory1.getPreviousAdmissionProblem()==null || patientMedicalHistory1.getPreviousAdmissionProblem().equals("")){
						patientMedicalHistory1.setPreviousAdmissionProblem(previousAdmissionProblem);
					}
					if(patientMedicalHistory1.getPreviousAdmissionOutcome()==null || patientMedicalHistory1.getPreviousAdmissionOutcome().equals("")){
						patientMedicalHistory1.setPreviousAdmissionOutcome(previousAdmissionOutcome);
					}
					if(patientMedicalHistory1.getPreviousAdmissionRecord()==null || patientMedicalHistory1.getPreviousAdmissionRecord().equals("")){
						patientMedicalHistory1.setPreviousAdmissionRecord(previousAdmissionRecord);
					}
					if(patientMedicalHistory1.getPreviousInvestigation()==null || patientMedicalHistory1.getPreviousInvestigation().equals("")){
						patientMedicalHistory1.setPreviousInvestigation(previousInvestigation);
					}
					if(patientMedicalHistory1.getPreviousInvestigationWhen()==null || patientMedicalHistory1.getPreviousInvestigationWhen().equals("")){
						patientMedicalHistory1.setPreviousInvestigationWhen(previousInvestigationWhen);
					}
					if(patientMedicalHistory1.getPreviousInvestigationProblem()==null || patientMedicalHistory1.getPreviousInvestigationProblem().equals("")){
						patientMedicalHistory1.setPreviousInvestigationProblem(previousInvestigationProblem);
					}
					if(patientMedicalHistory1.getPreviousInvestigationOutcome()==null || patientMedicalHistory1.getPreviousInvestigationOutcome().equals("")){
						patientMedicalHistory1.setPreviousInvestigationOutcome(previousInvestigationOutcome);						
					}
					if(patientMedicalHistory1.getPreviousInvestigationRecord()==null || patientMedicalHistory1.getPreviousInvestigationRecord().equals("")){
						patientMedicalHistory1.setPreviousInvestigationRecord(previousInvestigationRecord);
					}
					if(patientMedicalHistory1.getBcg()==null || patientMedicalHistory1.getBcg().equals("")){
						patientMedicalHistory1.setBcg(bcg);
					}
					if(patientMedicalHistory1.getDpt()==null || patientMedicalHistory1.getDpt().equals("")){
						patientMedicalHistory1.setDpt(dpt);
					}
					if(patientMedicalHistory1.getYellowFever()==null || patientMedicalHistory1.getYellowFever().equals("")){
						patientMedicalHistory1.setYellowFever(yellowFever);
					}
					if(patientMedicalHistory1.getPneumococcal()==null || patientMedicalHistory1.getPneumococcal().equals("")){
						patientMedicalHistory1.setPneumococcal(pneumococcal);
					}
					if(patientMedicalHistory1.getPolio()==null || patientMedicalHistory1.getPolio().equals("")){
						patientMedicalHistory1.setPolio(polio);
					}
					if(patientMedicalHistory1.getTetanusFemale()==null || patientMedicalHistory1.getTetanusFemale().equals("")){
						patientMedicalHistory1.setTetanusFemale(tetanusFemale);
					}
					if(patientMedicalHistory1.getTetanusMale()==null || patientMedicalHistory1.getTetanusMale().equals("")){
						patientMedicalHistory1.setTetanusMale(tetanusMale);
					}
					if(patientMedicalHistory1.getMeasles()==null || patientMedicalHistory1.getMeasles().equals("")){
						patientMedicalHistory1.setMeasles(measles);
					}
					if(patientMedicalHistory1.getOtherVaccinations()==null || patientMedicalHistory1.getOtherVaccinations().equals("")){
						patientMedicalHistory1.setOtherVaccinations(otherVaccinations);
					}
				queueService.savePatientMedicalHistory(patientMedicalHistory1);

				if(patientDrugHistory1.getCurrentMedication()==null || patientDrugHistory1.getCurrentMedication().equals("")){
					patientDrugHistory1.setCurrentMedication(currentMedication);
				}
				if(patientDrugHistory1.getMedicationName()==null || patientDrugHistory1.getMedicationName().equals("")){
					patientDrugHistory1.setMedicationName(medicationName);					
				}
				if(patientDrugHistory1.getMedicationPeriod()==null || patientDrugHistory1.getMedicationPeriod().equals("")){
					patientDrugHistory1.setMedicationPeriod(medicationPeriod);
				}
				if(patientDrugHistory1.getMedicationReason()==null || patientDrugHistory1.getMedicationReason().equals("")){
					patientDrugHistory1.setMedicationReason(medicationReason);
				}
				if(patientDrugHistory1.getMedicationRecord()==null || patientDrugHistory1.getMedicationRecord().equals("")){
					patientDrugHistory1.setMedicationRecord(medicationRecord);
				}
				if(patientDrugHistory1.getSensitiveMedication()==null || patientDrugHistory1.getSensitiveMedication().equals("")){
					patientDrugHistory1.setSensitiveMedication(sensitiveMedication);
				}
				if(patientDrugHistory1.getSensitiveMedicationName()==null || patientDrugHistory1.getSensitiveMedicationName().equals("")){
					patientDrugHistory1.setSensitiveMedicationName(sensitiveMedicationName);
				}
				if(patientDrugHistory1.getSensitiveMedicationSymptom()==null || patientDrugHistory1.getSensitiveMedicationSymptom().equals("")){
					patientDrugHistory1.setSensitiveMedicationSymptom(sensitiveMedicationSymptom);
				}
				if(patientDrugHistory1.getInvasiveContraception()==null || patientDrugHistory1.getInvasiveContraception().equals("")){
					patientDrugHistory1.setInvasiveContraception(invasiveContraception);
				}
				if(patientDrugHistory1.getInvasiveContraceptionName()==null || patientDrugHistory1.getInvasiveContraceptionName().equals("")){
					patientDrugHistory1.setInvasiveContraceptionName(invasiveContraceptionName);
				}
				
				queueService.savePatientDrugHistory(patientDrugHistory1);
				
				if(patientFamilyHistory1.getParentStatus()==null || patientFamilyHistory1.getParentStatus().equals("")){
					patientFamilyHistory1.setParentStatus(parentStatus);					
				}
				if(patientFamilyHistory1.getParentDeathCause()==null || patientFamilyHistory1.getParentDeathCause().equals("")){
					patientFamilyHistory1.setParentDeathCause(parentDeathCause);					
				}
				if(patientFamilyHistory1.getParentDeathAge()==null || patientFamilyHistory1.getParentDeathAge().equals("")){
					patientFamilyHistory1.setParentDeathAge(parentDeathAge);					
				}
				if(patientFamilyHistory1.getSiblingStatus()==null || patientFamilyHistory1.getSiblingStatus().equals("")){
					patientFamilyHistory1.setSiblingStatus(siblingStatus);
				}
				if(patientFamilyHistory1.getSiblingDeathCause()==null || patientFamilyHistory1.getSiblingDeathCause().equals("")){
					patientFamilyHistory1.setSiblingDeathCause(siblingDeathCause);
				}
				if(patientFamilyHistory1.getSiblingDeathAge()==null || patientFamilyHistory1.getSiblingDeathAge().equals("")){
					patientFamilyHistory1.setSiblingDeathAge(siblingDeathAge);
				}
				if(patientFamilyHistory1.getFamilyIllnessHistory()==null || patientFamilyHistory1.getFamilyIllnessHistory().equals("")){
					patientFamilyHistory1.setFamilyIllnessHistory(familyIllnessHistory);
				}
				
				queueService.savePatientFamilyHistory(patientFamilyHistory1);
				
				if(patientPersonalHistory1.getSmoke()==null || patientPersonalHistory1.getSmoke().equals("")){
					patientPersonalHistory1.setSmoke(smoke);
				}
				if(patientPersonalHistory1.getSmokeItem()==null || patientPersonalHistory1.getSmokeItem().equals("")){
					patientPersonalHistory1.setSmokeItem(smokeItem);
				}
				if(patientPersonalHistory1.getSmokeAverage()==null || patientPersonalHistory1.getSmokeAverage().equals("")){
					patientPersonalHistory1.setSmokeAverage(smokeAverage);
				}
				if(patientPersonalHistory1.getAlcohol()==null || patientPersonalHistory1.getAlcohol().equals("")){
					patientPersonalHistory1.setAlcohol(alcohol);
				}
				if(patientPersonalHistory1.getAlcoholItem()==null || patientPersonalHistory1.getAlcoholItem().equals("")){
					patientPersonalHistory1.setAlcoholItem(alcoholItem);
				}
				if(patientPersonalHistory1.getAlcoholAverage()==null || patientPersonalHistory1.getAlcoholAverage().equals("")){
					patientPersonalHistory1.setAlcoholAverage(alcoholAverage);
				}
				if(patientPersonalHistory1.getDrug()==null || patientPersonalHistory1.getDrug().equals("")){
					patientPersonalHistory1.setDrug(drug);
				}
				if(patientPersonalHistory1.getDrugItem()==null || patientPersonalHistory1.getDrugItem().equals("")){
					patientPersonalHistory1.setDrugItem(drugItem);
				}
				if(patientPersonalHistory1.getDrugAverage()==null || patientPersonalHistory1.getDrugAverage().equals("")){
					patientPersonalHistory1.setDrugAverage(drugAverage);
				}
				if(patientPersonalHistory1.getExposedHiv()==null || patientPersonalHistory1.getExposedHiv().equals("")){
					patientPersonalHistory1.setExposedHiv(exposedHiv);
				}
				if(patientPersonalHistory1.getExposedHivFactor()==null || patientPersonalHistory1.getExposedHivFactor().equals("")){
					patientPersonalHistory1.setExposedHivFactor(exposedHivFactor);
				}
				if(patientPersonalHistory1.getHivStatus()==null || patientPersonalHistory1.getHivStatus().equals("")){
					patientPersonalHistory1.setHivStatus(hivStatus);
				}
				if(patientPersonalHistory1.getFamilyHelp()==null || patientPersonalHistory1.getFamilyHelp().equals("")){
					patientPersonalHistory1.setFamilyHelp(familyHelp);
				}
				if(patientPersonalHistory1.getOtherHelp()==null || patientPersonalHistory1.getOtherHelp().equals("")){
					patientPersonalHistory1.setOtherHelp(otherHelp);
				}
				if(patientPersonalHistory1.getIncomeSource()==null || patientPersonalHistory1.getIncomeSource().equals("")){
					patientPersonalHistory1.setIncomeSource(incomeSource);
				}
				
				queueService.savePatientPersonalHistory(patientPersonalHistory1);
		}
		
		TriagePatientData triagePatientData=queueService.saveTriagePatientData(tpd);
		Concept opdConcept = Context.getConceptService().getConcept("OPD WARD");
		Concept selectedOPDConcept = Context.getConceptService().getConcept(opd);
		Obs opdObs = new Obs();
		opdObs.setConcept(opdConcept);
		opdObs.setValueCoded(selectedOPDConcept);
		encounter.addObs(opdObs);
		sendPatientToOPDQueue(queueLog.getPatient(), selectedOPDConcept, triagePatientData, false);
		return "redirect:/module/patientqueue/main.htm?opdId="+triagePatientLog.getTriageConcept().getId();
	}

	private void insertPropertiesUnlessExist() {

		GlobalProperty isInit = getGlobalProperty();

		if ("0".equals(isInit.getPropertyValue())) {

			try {
				isInit.setPropertyValue("1");
				Context.getAdministrationService().saveGlobalProperty(isInit);

				ConceptService conceptService = Context.getConceptService();

				// external hospital
				insertConcept(conceptService, "Coded", "Question",
						PatientDashboardConstants.PROPERTY_HOSPITAL);

				// Provisional diagnosis
				insertConcept(
						conceptService,
						"N/A",
						"Misc",
						PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);

				// Post for procedure
				insertConcept(conceptService, "N/A", "Misc",
						PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);

				// Internal referral
				insertConcept(conceptService, "Coded", "Question",
						PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL);

				// External referral
				insertConcept(conceptService, "Coded", "Question",
						PatientDashboardConstants.PROPERTY_EXTERNAL_REFERRAL);

				// Visit outcome
				insertConcept(conceptService, "Text", "Misc",
						PatientDashboardConstants.PROPERTY_VISIT_OUTCOME);

				// OPD WARD
				insertConcept(conceptService, "Coded", "Question",
						PatientDashboardConstants.PROPERTY_OPDWARD);

				// IPD WARD
				insertConcept(conceptService, "Coded", "Question",
						PatientDashboardConstants.PROPERTY_IPDWARD);

				// OPD encounter
				insertEncounter(PatientDashboardConstants.PROPERTY_OPD_ENCOUTNER_TYPE);

				// LAB encounter
				insertEncounter(PatientDashboardConstants.PROPERTY_LAB_ENCOUTNER_TYPE);

				/*
				 * Add external hospitals CHANGE LATER
				 */
				// insertExternalHospitalConcepts(conceptService);
				// insertIpdWardConcepts(conceptService);
				// Change the global property to 2
				isInit.setPropertyValue("2");
				Context.getAdministrationService().saveGlobalProperty(isInit);

			} catch (Exception e) {
				e.printStackTrace();
				isInit.setPropertyValue("0");
				Context.getAdministrationService().saveGlobalProperty(isInit);
			}

		}
	}

	// Return the globalProperty to tell necessary concepts are created.
	// If it does not exist, create the new one with value 0
	private GlobalProperty getGlobalProperty() {

		GlobalProperty gp = Context.getAdministrationService()
				.getGlobalPropertyObject(
						PatientDashboardConstants.PROPERTY_INIT_CONCEPT);

		if (gp == null) {
			gp = new GlobalProperty(
					PatientDashboardConstants.PROPERTY_INIT_CONCEPT, "0");
		}

		try {
			Integer.parseInt(gp.getPropertyValue());
		} catch (Exception e) {
			gp.setPropertyValue("0");
		}

		return gp;
	}

	private Concept insertConcept(ConceptService conceptService,
			String dataTypeName, String conceptClassName, String conceptNameKey) {
		try {
			ConceptDatatype datatype = Context.getConceptService()
					.getConceptDatatypeByName(dataTypeName);
			ConceptClass conceptClass = conceptService
					.getConceptClassByName(conceptClassName);
			GlobalProperty gp = Context.getAdministrationService()
					.getGlobalPropertyObject(conceptNameKey);
			Concept con = conceptService.getConcept(gp.getPropertyValue());
			
			if (con == null) {
				con = new Concept();
				ConceptName name = new ConceptName(gp.getPropertyValue(),
						Context.getLocale());
				con.addName(name);
				con.setDatatype(datatype);
				con.setConceptClass(conceptClass);
				return conceptService.saveConcept(con);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private Concept insertHospital(ConceptService conceptService,
			String hospitalName) {
		try {
			ConceptDatatype datatype = Context.getConceptService()
					.getConceptDatatypeByName("N/A");
			ConceptClass conceptClass = conceptService
					.getConceptClassByName("Misc");
			Concept con = conceptService.getConceptByName(hospitalName);
			
			if (con == null) {
				con = new Concept();
				ConceptName name = new ConceptName(hospitalName,
						Context.getLocale());
				con.addName(name);
				con.setDatatype(datatype);
				con.setConceptClass(conceptClass);
				return conceptService.saveConcept(con);
			}
			return con;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private void insertEncounter(String typeKey) {
		try {
			GlobalProperty gp = Context.getAdministrationService()
					.getGlobalPropertyObject(typeKey);
			if (Context.getEncounterService().getEncounterType(
					gp.getPropertyValue()) == null) {
				EncounterType et = new EncounterType(gp.getPropertyValue(), "");
				Context.getEncounterService().saveEncounterType(et);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void insertExternalHospitalConcepts(ConceptService conceptService) {
		
		Concept concept = conceptService
				.getConcept(PatientDashboardConstants.PROPERTY_HOSPITAL);
		if (concept != null) {
			String[] hospitalNames = { "INDIRA GANDHI MEDICAL COLLLEGE",
					"POST GRADUATE INSTITUTE, CHANDIGARH",
					"ALL INDIA INSTITUTE OF MEDICAL SCIENCE, NEW DELHI" };
			for (String hn : hospitalNames) {
				insertHospital(conceptService, hn);
			}
			addConceptAnswers(concept, hospitalNames,
					Context.getAuthenticatedUser());
		}
	}

	private void insertIpdWardConcepts(ConceptService conceptService) {
	
		Concept concept = conceptService
				.getConcept(PatientDashboardConstants.PROPERTY_IPDWARD);
		if (concept != null) {
			String[] wards = { "Ipd Ward 1", "Ipd Ward 2", "Ipd Ward 3" };
			for (String hn : wards) {
				insertHospital(conceptService, hn);
			}
			addConceptAnswers(concept, wards, Context.getAuthenticatedUser());
		}
	}

	private void addConceptAnswers(Concept concept, String[] answerNames,
			User creator) {
		Set<Integer> currentAnswerIds = new HashSet<Integer>();
		for (ConceptAnswer answer : concept.getAnswers()) {
			currentAnswerIds.add(answer.getAnswerConcept().getConceptId());
		}
		boolean changed = false;
		for (String answerName : answerNames) {
			Concept answer = Context.getConceptService().getConcept(answerName);
			if (!currentAnswerIds.contains(answer.getConceptId())) {
				changed = true;
				ConceptAnswer conceptAnswer = new ConceptAnswer(answer);
				conceptAnswer.setCreator(creator);
				concept.addAnswer(conceptAnswer);
			}
		}
		if (changed) {
			Context.getConceptService().saveConcept(concept);
		}
	}
	
	public static void sendPatientToOPDQueue(Patient patient, Concept selectedOPDConcept, TriagePatientData triagePatientData, boolean revisit) {
		Concept referralConcept = null;
		if (!revisit) {
			referralConcept = Context.getConceptService().getConcept("New Patient");
		} else {
			referralConcept = Context.getConceptService().getConcept("Revisit");
		}
		
		OpdPatientQueue queue = Context.getService(PatientQueueService.class).getOpdPatientQueue(
		    patient.getPatientIdentifier().getIdentifier(), selectedOPDConcept.getConceptId());
		if (queue == null) {
			queue = new OpdPatientQueue();
			queue.setUser(Context.getAuthenticatedUser());
			queue.setPatient(patient);
			queue.setCreatedOn(new Date());
			queue.setBirthDate(patient.getBirthdate());
			queue.setPatientIdentifier(patient.getPatientIdentifier().getIdentifier());
			queue.setOpdConcept(selectedOPDConcept);
			queue.setOpdConceptName(selectedOPDConcept.getName().getName());
			if( patient.getMiddleName() !=null){
			queue.setPatientName(patient.getGivenName() + " " + patient.getFamilyName() + " " + patient.getMiddleName());
			}
			else{
				queue.setPatientName(patient.getGivenName()+ " " + patient.getFamilyName());
			}
			queue.setReferralConcept(referralConcept);
			queue.setReferralConceptName(referralConcept.getName().getName());
			queue.setSex(patient.getGender());
			queue.setTriageDataId(triagePatientData);
			PatientQueueService queueService = Context.getService(PatientQueueService.class);
			queueService.saveOpdPatientQueue(queue);
			
		}
		
	}

}
