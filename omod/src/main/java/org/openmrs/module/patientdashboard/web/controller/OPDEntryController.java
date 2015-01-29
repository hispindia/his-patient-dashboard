/**
 *  Copyright 2010 Society for Health Information Systems Programmes, India (HISP India)
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.ConceptName;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.GlobalProperty;
import org.openmrs.Location;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.PersonAttribute;
import org.openmrs.PersonAttributeType;
import org.openmrs.User;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.BillingService;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.InventoryCommonService;
import org.openmrs.module.hospitalcore.IpdService;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.PatientQueueService;
import org.openmrs.module.hospitalcore.model.Answer;
import org.openmrs.module.hospitalcore.model.BillableService;
import org.openmrs.module.hospitalcore.model.DepartmentConcept;
import org.openmrs.module.hospitalcore.model.IndoorPatientServiceBill;
import org.openmrs.module.hospitalcore.model.IndoorPatientServiceBillItem;
import org.openmrs.module.hospitalcore.model.InventoryDrug;
import org.openmrs.module.hospitalcore.model.InventoryDrugFormulation;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmission;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmissionLog;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.model.OpdDrugOrder;
import org.openmrs.module.hospitalcore.model.OpdPatientQueue;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.hospitalcore.model.OpdTestOrder;
import org.openmrs.module.hospitalcore.model.PatientSearch;
import org.openmrs.module.hospitalcore.model.Question;
import org.openmrs.module.hospitalcore.model.Symptom;
import org.openmrs.module.hospitalcore.model.TriagePatientData;
import org.openmrs.module.hospitalcore.model.TriagePatientQueueLog;
import org.openmrs.module.hospitalcore.util.ConceptComparator;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("OPDEntryController")
@RequestMapping("/module/patientdashboard/opdEntry.htm")
public class OPDEntryController {

	@RequestMapping(method = RequestMethod.GET)
	public String firstView(
			@ModelAttribute("opdCommand") OPDEntryCommand command,
			@RequestParam("patientId") Integer patientId,
			@RequestParam("opdId") Integer opdId,
			@RequestParam(value = "queueId", required = false) Integer queueId,
			@RequestParam(value = "opdLogId", required = false) Integer opdLogId,Model model) {

		Concept opdWardConcept = Context.getConceptService().getConceptByName(
				Context.getAdministrationService().getGlobalProperty(
						PatientDashboardConstants.PROPERTY_OPDWARD));
		model.addAttribute("listInternalReferral",
				opdWardConcept != null ? new ArrayList<ConceptAnswer>(
						opdWardConcept.getAnswers()) : null);
		Concept hospitalConcept = Context.getConceptService().getConceptByName(
				Context.getAdministrationService().getGlobalProperty(
						PatientDashboardConstants.PROPERTY_HOSPITAL));
		model.addAttribute("listExternalReferral",
				hospitalConcept != null ? new ArrayList<ConceptAnswer>(
						hospitalConcept.getAnswers()) : null);
		
		
		model.addAttribute("patientId", patientId);
		IpdService ipds = (IpdService) Context.getService(IpdService.class);
		model.addAttribute("queueId", queueId);
		model.addAttribute("opdLogId", opdLogId);
		model.addAttribute("admitted", ipds.getAdmittedByPatientId(patientId));
		Concept ipdConcept = Context.getConceptService().getConceptByName(
				Context.getAdministrationService().getGlobalProperty(
						PatientDashboardConstants.PROPERTY_IPDWARD));
		model.addAttribute(
				"listIpd",
				ipdConcept != null ? new ArrayList<ConceptAnswer>(ipdConcept
						.getAnswers()) : null);

		PatientDashboardService patientDashboardService = Context
				.getService(PatientDashboardService.class);
		InventoryCommonService inventoryCommonService = Context
				.getService(InventoryCommonService.class);
		Concept opdConcept = Context.getConceptService().getConcept(opdId);
		/*
		 * //list diagnosis need rewrtie CHUYEN List<Concept> diagnosis = new
		 * ArrayList
		 * <Concept>(patientDashboardService.listDiagnosisByOpd(opdId));
		 * if(!CollectionUtils.isEmpty(diagnosis)){ Collections.sort(diagnosis,
		 * new ConceptComparator()); }
		 */
		List<Concept> diagnosisList = patientDashboardService
				.listByDepartmentByWard(opdId, DepartmentConcept.TYPES[0]);
		if (CollectionUtils.isNotEmpty(diagnosisList)) {
			Collections.sort(diagnosisList, new ConceptComparator());
		}
		model.addAttribute("diagnosisList", diagnosisList);

		// model.addAttribute("listDiagnosis", diagnosis);
		List<Concept> procedures = patientDashboardService
				.listByDepartmentByWard(opdId, DepartmentConcept.TYPES[1]);
		if (CollectionUtils.isNotEmpty(procedures)) {
			Collections.sort(procedures, new ConceptComparator());
		}
		model.addAttribute("listProcedures", procedures);

		// ghanshyam 1-june-2013 New Requirement #1633 User must be able to send
		// investigation orders from dashboard to billing
		List<Concept> investigations = patientDashboardService
				.listByDepartmentByWard(opdId, DepartmentConcept.TYPES[2]);
		if (CollectionUtils.isNotEmpty(investigations)) {
			Collections.sort(investigations, new ConceptComparator());
		}
		model.addAttribute("listInvestigations", investigations);

		List<Concept> symptomList = patientDashboardService
				.listByDepartmentByWard(opdId, DepartmentConcept.TYPES[3]);
		if (CollectionUtils.isNotEmpty(symptomList)) {
			Collections.sort(symptomList, new ConceptComparator());
		}
		model.addAttribute("symptomList", symptomList);

		// ghanshyam 12-june-2013 New Requirement #1635 User should be able to
		// send pharmacy orders to issue drugs to a patient from dashboard
		List<Concept> drugFrequencyConcept = inventoryCommonService
				.getDrugFrequency();
		model.addAttribute("drugFrequencyList", drugFrequencyConcept);

		model.addAttribute("opd", opdConcept);
	
		PatientQueueService queueService = Context
				.getService(PatientQueueService.class);
		OpdPatientQueue opdPatientQueue = new OpdPatientQueue();
		if (queueId != null) {
			opdPatientQueue = queueService.getOpdPatientQueueById(queueId);
			SimpleDateFormat formatterExt = new SimpleDateFormat("dd/MM/yyyy");
			TriagePatientData triagePatientData = opdPatientQueue
					.getTriageDataId();
			if (triagePatientData != null) {
				Date dat = triagePatientData.getLastMenstrualDate();
				if (dat != null) {
					String da = formatterExt.format(dat);
					model.addAttribute("da", da);
				}
			}
		}
		if (opdLogId != null) {
			// OpdPatientQueueLog
			// opdPatientQueueLog=queueService.getOpdPatientQueueLogByEncounter(Context.getEncounterService().getEncounter(encounterId));
			OpdPatientQueueLog opdPatientQueueLog = queueService
					.getOpdPatientQueueLogById(opdLogId);
			model.addAttribute("opdPatientQueueLog", opdPatientQueueLog);
		} else {
			model.addAttribute("opdPatientQueue", opdPatientQueue);
		}

		Concept concept = Context.getConceptService().getConcept(
				"MINOR OPERATION");

		Collection<ConceptAnswer> allMinorOTProcedures = null;
		List<Integer> id = new ArrayList<Integer>();
		if (concept != null) {
			allMinorOTProcedures = concept.getAnswers();
			for (ConceptAnswer c : allMinorOTProcedures) {
				id.add(c.getAnswerConcept().getId());
			}
		}
		model.addAttribute("allMinorOTProcedures", id);

		Concept concept2 = Context.getConceptService().getConcept(
				"MAJOR OPERATION");

		Collection<ConceptAnswer> allMajorOTProcedures = null;
		List<Integer> id2 = new ArrayList<Integer>();
		if (concept2 != null) {
			allMajorOTProcedures = concept2.getAnswers();
			for (ConceptAnswer c : allMajorOTProcedures) {
				id2.add(c.getAnswerConcept().getId());
			}
		}
		model.addAttribute("allMajorOTProcedures", id2);

		String hospitalName = Context.getAdministrationService()
				.getGlobalProperty("hospital.location_user");
		model.addAttribute("hospitalName", hospitalName);

		SimpleDateFormat sdf = new SimpleDateFormat("EEE dd/MM/yyyy kk:mm");
		model.addAttribute("currentDateTime", sdf.format(new Date()));
		Patient patient = Context.getPatientService().getPatient(patientId);
		patient.getPatientIdentifier();
		String patientName;
		if (patient.getMiddleName() != null) {
			patientName = patient.getGivenName() + " "
					+ patient.getFamilyName() + " " + patient.getMiddleName();
		} else {
			patientName = patient.getGivenName() + " "
					+ patient.getFamilyName();
		}

		model.addAttribute("patient", patient);
		model.addAttribute("patientName", patientName);

		Date birthday = patient.getBirthdate();
		model.addAttribute("age", PatientUtils.estimateAge(birthday));

		HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
		List<PersonAttribute> pas = hcs.getPersonAttributes(patientId);
		for (PersonAttribute pa : pas) {
			PersonAttributeType attributeType = pa.getAttributeType();
			if (attributeType.getPersonAttributeTypeId() == 14) {
				model.addAttribute("selectedCategory", pa.getValue());
			}
			if (attributeType.getPersonAttributeTypeId() == 36) {
				model.addAttribute("exemptionNumber", pa.getValue());
			}
			if (attributeType.getPersonAttributeTypeId() == 33) {
				model.addAttribute("nhifCardNumber", pa.getValue());
			}
			if (attributeType.getPersonAttributeTypeId() == 32) {
				model.addAttribute("waiverNumber", pa.getValue());
			}
			User user = Context.getAuthenticatedUser();
			model.addAttribute("user", user);
		}
   		Patient p = new Patient(patientId);
		Integer personId = p.getPersonId();
		
		List<Obs> diagnosis= queueService.getAllDiagnosis(personId);
		Set<Concept> diagnosisIdSet = new LinkedHashSet<Concept>();
		Set<ConceptName> diagnosisNameSet = new LinkedHashSet<ConceptName>();
		 
		for(Obs diagnos:diagnosis){
			diagnosisIdSet.add(diagnos.getValueCoded());
			diagnosisNameSet.add(diagnos.getValueCoded().getName());
		 }
		Set<String> diaNameSet = new LinkedHashSet<String>();
		Iterator itr = diagnosisNameSet.iterator();
		while(itr.hasNext())
		{
			diaNameSet.add((itr.next().toString()).replaceAll(",", "@"));
		}
		
		List<Obs> symptom= queueService.getAllSymptom(personId);
		Set<Concept> symptomIdSet = new LinkedHashSet<Concept>();
		Set<ConceptName> symptomNameSet = new LinkedHashSet<ConceptName>();
		for(Obs symp:symptom){
			 symptomIdSet.add(symp.getValueCoded());
			 symptomNameSet.add(symp.getValueCoded().getName());
		}
		Set<String> symNameSet = new LinkedHashSet<String>();
		Iterator itr1 = symptomNameSet.iterator();
		while(itr1.hasNext())
		{
			symNameSet.add((itr1.next().toString()).replaceAll(",", "@"));
		}
		
		model.addAttribute("diagnosisIdSet", diagnosisIdSet);
		model.addAttribute("symptomIdSet", symptomIdSet);
		model.addAttribute("diaNameSet", diaNameSet);
		model.addAttribute("symNameSet", symNameSet);
		return "module/patientdashboard/opdEntry";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String formSummit(
			OPDEntryCommand command,
			HttpServletRequest request,
			@RequestParam(value = "syptomIdList", required = false) String[] syptomIdList,
			@RequestParam(value = "drugOrder", required = false) String[] drugOrder,
			@RequestParam(value = "opdLogId", required = false) Integer opdLogId,
			@RequestParam(value = "lastMenstrualPeriod", required = false) Date lastMenstrualPeriod)
			throws Exception {
		// @RequestParam(value="encounterId" ,required=false) Integer
		// encounterId) throws Exception{
		User user = Context.getAuthenticatedUser();
		PatientService ps = Context.getPatientService();
		HospitalCoreService hcs = (HospitalCoreService) Context
				.getService(HospitalCoreService.class);
		PatientQueueService queueService = Context
				.getService(PatientQueueService.class);
		PatientDashboardService patientDashboardService = Context
				.getService(PatientDashboardService.class);
		IpdService ipdService = Context.getService(IpdService.class);
		Patient patient = ps.getPatient(command.getPatientId());
		PatientSearch patientSearch = hcs.getPatient(command.getPatientId());
		// harsh 14/6/2012 setting death date to today's date and dead variable
		// to true when "died" is selected
		if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "died")) {

			ConceptService conceptService = Context.getConceptService();
			Concept causeOfDeath = conceptService.getConceptByName("NONE");

			patient.setDead(true);
			patient.setDeathDate(new Date());
			patient.setCauseOfDeath(causeOfDeath);
			ps.savePatient(patient);
			patientSearch.setDead(true);
			hcs.savePatientSearch(patientSearch);
		}

		Date date = new Date();
		// create obs group only for internal referral and admit
		Obs obsGroup = null;
		obsGroup = hcs.getObsGroupCurrentDate(patient.getPersonId());
		/*
		 * if(StringUtils.equalsIgnoreCase(command.getRadio_f(), "admit") ||
		 * (command.getInternalReferral() != null &&
		 * command.getInternalReferral() > 0)){ if(obsGroup == null){ obsGroup =
		 * hcs.createObsGroup(patient, HospitalCoreConstants.PROPERTY_OBSGROUP);
		 * } }
		 */

		// ===================Comment this if we want to
		// save===========================
		/*
		 * if(true){ return
		 * "redirect:/module/patientdashboard/main.htm?patientId="
		 * +command.getPatientId(); }
		 */
		// ===================End Comment this if we want to
		// save===========================
		AdministrationService administrationService = Context
				.getAdministrationService();

		/**
		 * Save opd info 1. Get OPD Encounter type 2. Create encounter 3. Create
		 * Obs for each of those concept : diagnosis, procedure, internal
		 * referral, external referral, outcome 4. Get value from the submmited
		 * from, set them to corresponding obs 5. Set all obs to encoutner 6.
		 * Save encounter
		 */

		GlobalProperty gpOPDEncounterType = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_OPD_ENCOUTNER_TYPE);
		EncounterType encounterType = Context.getEncounterService()
				.getEncounterType(gpOPDEncounterType.getPropertyValue());
		Encounter encounter = new Encounter();
		Location location = new Location(1);
		
		if (opdLogId != null) {
			OpdPatientQueueLog opdPatientQueueLog = queueService
					.getOpdPatientQueueLogById(opdLogId);
			IpdPatientAdmissionLog ipdPatientAdmissionLog=ipdService.getIpdPatientAdmissionLog(opdPatientQueueLog);
			encounter = ipdPatientAdmissionLog.getIpdEncounter();
		} else {
			encounter.setPatient(patient);
			encounter.setCreator(user);
			encounter.setProvider(user);
			encounter.setEncounterDatetime(date);
			encounter.setEncounterType(encounterType);
			encounter.setLocation(location);
		}

		ConceptService conceptService = Context.getConceptService();
		GlobalProperty gpSymptom = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_SYMPTOM);
		GlobalProperty gpDiagnosis = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
		GlobalProperty procedure = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		// ghanshyam 1-june-2013 New Requirement #1633 User must be able to send
		// investigation orders from dashboard to billing
		GlobalProperty investigationn = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_FOR_INVESTIGATION);
		GlobalProperty internalReferral = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL);
		GlobalProperty externalReferral = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_EXTERNAL_REFERRAL);

		Concept cSymptom = conceptService.getConceptByName(gpSymptom
				.getPropertyValue());
		Concept cDiagnosis = conceptService.getConceptByName(gpDiagnosis
				.getPropertyValue());
		Concept cFinalDiagnosis = conceptService.getConcept("FINAL DIAGNOSIS");
		// ghanshyam 8-july-2013 New Requirement #1963 Redesign patientdashboard
		Concept cOtherInstructions = conceptService
				.getConceptByName("OTHER INSTRUCTIONS");
		Concept illnessHistory = conceptService
				.getConceptByName("History of Present Illness");

		if (cSymptom == null) {
			throw new Exception("Symptom concept null");
		}
		// symptom
		for (Integer cId : command.getSelectedSymptomList()) {
			Obs obsSymptom = new Obs();
			obsSymptom.setObsGroup(obsGroup);
			obsSymptom.setConcept(cSymptom);
			obsSymptom.setValueCoded(conceptService.getConcept(cId));
			obsSymptom.setCreator(user);
			obsSymptom.setDateCreated(date);
			obsSymptom.setEncounter(encounter);
			obsSymptom.setPatient(patient);
			encounter.addObs(obsSymptom);
		}

		if (cDiagnosis == null) {
			throw new Exception("Diagnosis concept null");
		}
		// diagnosis
		String selectedDia = request.getParameter("radio_dia");
		for (Integer cId : command.getSelectedDiagnosisList()) {
			
			Obs obsDiagnosis = new Obs();
			obsDiagnosis.setObsGroup(obsGroup);
			if(selectedDia.equals("prov_dia")){
				obsDiagnosis.setConcept(cDiagnosis);
			}
			else{
				obsDiagnosis.setConcept(cFinalDiagnosis);
			}
			obsDiagnosis.setValueCoded(conceptService.getConcept(cId));
			obsDiagnosis.setCreator(user);
			obsDiagnosis.setDateCreated(date);
			obsDiagnosis.setEncounter(encounter);
			obsDiagnosis.setPatient(patient);
			encounter.addObs(obsDiagnosis);
		}
		
	
		// note
		if (StringUtils.isNotBlank(command.getNote())) {

			Obs obsDiagnosis = new Obs();
			obsDiagnosis.setObsGroup(obsGroup);
			// ghanshyam 8-july-2013 New Requirement #1963 Redesign
			// patientdashboard
			obsDiagnosis.setConcept(cOtherInstructions);
			obsDiagnosis.setValueText(command.getNote());
			obsDiagnosis.setCreator(user);
			obsDiagnosis.setDateCreated(date);
			obsDiagnosis.setEncounter(encounter);
			obsDiagnosis.setPatient(patient);
			encounter.addObs(obsDiagnosis);
		}

		// illness history
		if (StringUtils.isNotBlank(command.getHistory())) {

			Obs obsDiagnosis = new Obs();
			obsDiagnosis.setObsGroup(obsGroup);
			// ghanshyam 8-july-2013 New Requirement #1963 Redesign
			// patientdashboard
			obsDiagnosis.setConcept(illnessHistory);
			obsDiagnosis.setValueText(command.getHistory());
			obsDiagnosis.setCreator(user);
			obsDiagnosis.setDateCreated(date);
			obsDiagnosis.setEncounter(encounter);
			obsDiagnosis.setPatient(patient);
			encounter.addObs(obsDiagnosis);
		}

		// procedure
		if (!ArrayUtils.isEmpty(command.getSelectedProcedureList())) {
			Concept pDiagnosis = conceptService.getConceptByName(procedure
					.getPropertyValue());
			if (pDiagnosis == null) {
				throw new Exception("Post for procedure concept null");
			}
			for (Integer pId : command.getSelectedProcedureList()) {
				Obs obsDiagnosis = new Obs();
				obsDiagnosis.setObsGroup(obsGroup);
				obsDiagnosis.setConcept(pDiagnosis);
				obsDiagnosis.setValueCoded(conceptService.getConcept(pId));
				obsDiagnosis.setCreator(user);
				obsDiagnosis.setDateCreated(date);
				obsDiagnosis.setEncounter(encounter);
				obsDiagnosis.setPatient(patient);
				encounter.addObs(obsDiagnosis);
			}

		}

		// ghanshyam 1-june-2013 New Requirement #1633 User must be able to send
		// investigation orders from dashboard to billing
		// investigation
		if (!ArrayUtils.isEmpty(command.getSelectedInvestigationList())) {
			Concept coninvt = conceptService.getConceptByName(investigationn
					.getPropertyValue());
			if (coninvt == null) {
				throw new Exception("Investigation concept null");
			}
			for (Integer pId : command.getSelectedInvestigationList()) {
				Obs obsInvestigation = new Obs();
				obsInvestigation.setObsGroup(obsGroup);
				obsInvestigation.setConcept(coninvt);
				obsInvestigation.setValueCoded(conceptService.getConcept(pId));
				obsInvestigation.setCreator(user);
				obsInvestigation.setDateCreated(date);
				obsInvestigation.setEncounter(encounter);
				obsInvestigation.setPatient(patient);
				encounter.addObs(obsInvestigation);
			}

		}

		// internal referral
		// System.out.println("command.getInternalReferral(): "+command.getInternalReferral());
		if (command.getInternalReferral() != null
				&& command.getInternalReferral() != "") {
			Concept cInternalReferral = conceptService
					.getConceptByName(internalReferral.getPropertyValue());
			if (cInternalReferral == null) {
				throw new Exception("InternalReferral concept null");
			}

			Concept internalReferralConcept = conceptService.getConcept(command
					.getInternalReferral());
			Obs obsInternalReferral = new Obs();
			obsInternalReferral.setObsGroup(obsGroup);
			obsInternalReferral.setConcept(cInternalReferral);
			obsInternalReferral.setValueCoded(internalReferralConcept);
			obsInternalReferral.setCreator(user);
			obsInternalReferral.setDateCreated(date);
			obsInternalReferral.setEncounter(encounter);
			obsInternalReferral.setPatient(patient);
			encounter.addObs(obsInternalReferral);

			Concept currentOpd = conceptService.getConcept(command.getOpdId());

			List<PersonAttribute> pas = hcs.getPersonAttributes(patient
					.getPatientId());
			String selectedCategory = "";
			for (PersonAttribute pa : pas) {
				PersonAttributeType attributeType = pa.getAttributeType();
				if (attributeType.getPersonAttributeTypeId() == 14) {
					selectedCategory = pa.getValue();
				}
			}

			// add this patient to the queue of the referral OPD
			OpdPatientQueue queue = new OpdPatientQueue();
			queue.setPatient(patient);
			queue.setCreatedOn(date);
			queue.setBirthDate(patient.getBirthdate());
			queue.setPatientIdentifier(patient.getPatientIdentifier()
					.getIdentifier());
			queue.setOpdConcept(internalReferralConcept);
			queue.setOpdConceptName(internalReferralConcept.getName().getName());
			if (patient.getMiddleName() != null) {
				queue.setPatientName(patient.getGivenName() + " "
						+ patient.getFamilyName() + " "
						+ patient.getMiddleName().replace(",", " "));
			} else {
				queue.setPatientName(patient.getGivenName() + " "
						+ patient.getFamilyName());
			}
			queue.setReferralConcept(currentOpd);
			queue.setReferralConceptName(currentOpd.getName().getName());
			queue.setSex(patient.getGender());
			queue.setTriageDataId(null);
			queue.setCategory(selectedCategory);
			queueService.saveOpdPatientQueue(queue);

		}

		// external referral
		// System.out.println("command.getExternalReferral(): "+command.getExternalReferral());
		if (command.getExternalReferral() != null
				&& command.getExternalReferral() != "") {
			Concept cExternalReferral = conceptService
					.getConceptByName(externalReferral.getPropertyValue());
			if (cExternalReferral == null) {
				throw new Exception("ExternalReferral concept null");
			}
			Obs obsExternalReferral = new Obs();
			obsExternalReferral.setObsGroup(obsGroup);
			obsExternalReferral.setConcept(cExternalReferral);
			obsExternalReferral.setValueCoded(conceptService.getConcept(command
					.getExternalReferral()));
			obsExternalReferral.setCreator(user);
			obsExternalReferral.setDateCreated(date);
			obsExternalReferral.setEncounter(encounter);
			obsExternalReferral.setPatient(patient);
			encounter.addObs(obsExternalReferral);
		}

		// TODO : out come

		Concept cOutcome = conceptService
				.getConceptByName(administrationService
						.getGlobalProperty(PatientDashboardConstants.PROPERTY_VISIT_OUTCOME));
		if (cOutcome == null) {
			throw new Exception("Visit Outcome concept =  null");
		}
		Obs obsOutcome = new Obs();
		obsOutcome.setObsGroup(obsGroup);
		obsOutcome.setConcept(cOutcome);

		try {
			obsOutcome.setValueText(command.getRadio_f());
		
			if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "Follow-up")) {
				obsOutcome.setValueDatetime(Context.getDateFormat().parse(
						command.getDateFollowUp()));
			}

			if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "admit")) {
				// System.out.println("command.getIpdWard(): "+command.getIpdWard());
				obsOutcome.setValueCoded(conceptService.getConcept(command
						.getIpdWard()));
				// Get ipd ward that patient come .
				/*
				 * Concept ipdWard =
				 * conceptService.getConceptByName(administrationService
				 * .getGlobalProperty
				 * (PatientDashboardConstants.PROPERTY_IPDWARD));
				 * System.out.println("ipdWard: "+ipdWard); if( ipdWard == null
				 * ){ throw new Exception("Ipd ward concept =  null"); } Obs
				 * obsIpdWard = new Obs(); obsIpdWard.setConcept(ipdWard);
				 * obsIpdWard
				 * .setValueCoded(conceptService.getConcept(command.getIpdWard
				 * ())); obsIpdWard.setCreator(user );
				 * obsIpdWard.setDateCreated(new Date());
				 * obsIpdWard.setPatient(patient);
				 * obsIpdWard.setEncounter(encounter);
				 * encounter.addObs(obsIpdWard);
				 */
				// call service from ipd queue and add this patient to ipd queue
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}

		obsOutcome.setCreator(user);
		obsOutcome.setDateCreated(date);
		obsOutcome.setPatient(patient);
		obsOutcome.setEncounter(encounter);
		encounter.addObs(obsOutcome);
		Context.getEncounterService().saveEncounter(encounter);

		// delele opd queue , create opd log queue
		OpdPatientQueueLog opdPatientLog;
		if (command.getQueueId() != null) {
			OpdPatientQueue queue = queueService.getOpdPatientQueueById(command
					.getQueueId());
			OpdPatientQueueLog queueLog = new OpdPatientQueueLog();
			queueLog.setOpdConcept(queue.getOpdConcept());
			queueLog.setOpdConceptName(queue.getOpdConceptName());
			queueLog.setPatient(queue.getPatient());
			queueLog.setCreatedOn(queue.getCreatedOn());
			queueLog.setPatientIdentifier(queue.getPatientIdentifier());
			queueLog.setPatientName(queue.getPatientName());
			queueLog.setReferralConcept(queue.getReferralConcept());
			queueLog.setReferralConceptName(queue.getReferralConceptName());
			queueLog.setSex(queue.getSex());
			queueLog.setUser(Context.getAuthenticatedUser());
			queueLog.setStatus("processed");
			queueLog.setBirthDate(patient.getBirthdate());
			queueLog.setEncounter(encounter);
			queueLog.setCategory(queue.getCategory());
			queueLog.setVisitStatus(queue.getVisitStatus());
			if (queue.getTriageDataId() != null) {
				queueLog.setTriageDataId(queue.getTriageDataId());
			} else {
				queueLog.setTriageDataId(null);
			}
			
			
			PatientDashboardService dashboardService =  Context.getService(PatientDashboardService.class);
			if(null!=queue.getTriageDataId() && null!=queue.getTriageDataId().getId())
				{
				TriagePatientData triagePatientData = dashboardService.getTriagePatientData(queue.getTriageDataId().getId());
		
				if(null!=request.getParameter("weight") && ""!=request.getParameter("weight"))
				{
					BigDecimal weight = new BigDecimal(request.getParameter("weight"));
					triagePatientData.setWeight(weight);
				}
				if(null!=request.getParameter("height") && ""!=request.getParameter("height"))
				{
					BigDecimal height = new BigDecimal(request.getParameter("height"));
					triagePatientData.setHeight(height);
				}
				if(null!=request.getParameter("temperature") && ""!=request.getParameter("temperature"))
				{
					BigDecimal temperature = new BigDecimal(request.getParameter("temperature"));
					triagePatientData.setTemperature(temperature);
				}
				if(null!=request.getParameter("mua") && ""!=request.getParameter("mua"))
				{
					BigDecimal mua = new BigDecimal(request.getParameter("mua"));
					triagePatientData.setMua(mua);
				}
				if(null!=request.getParameter("chest") && ""!=request.getParameter("chest"))
				{
					BigDecimal chest = new BigDecimal(request.getParameter("chest"));
					triagePatientData.setChest(chest);
				}
				if(null!=request.getParameter("abdominal") && ""!=request.getParameter("abdominal"))
				{
					BigDecimal abdominal = new BigDecimal(request.getParameter("abdominal"));
					triagePatientData.setAbdominal(abdominal);
				}
				if(null!=request.getParameter("systolic") && ""!=request.getParameter("systolic"))
				{
					Integer systolic = getInt(request.getParameter("systolic"));
					triagePatientData.setSystolic(systolic);
				}
				if(null!=request.getParameter("daistolic") && ""!=request.getParameter("daistolic"))
				{
					Integer daistolic = getInt(request.getParameter("daistolic"));
					triagePatientData.setDaistolic(daistolic);
				}
				if(null!=request.getParameter("respiratoryRate") && ""!=request.getParameter("respiratoryRate"))
				{
					Integer respiratoryRate = getInt(request.getParameter("respiratoryRate"));
					triagePatientData.setRespiratoryRate(respiratoryRate);				
				}
				if(null!=request.getParameter("pulsRate") && ""!=request.getParameter("pulsRate"))
				{
					Integer pulsRate = getInt(request.getParameter("pulsRate"));
					triagePatientData.setPulsRate(pulsRate);
				}
				if(null!=request.getParameter("bloodGroup") && ""!=request.getParameter("bloodGroup"))
				{
					String bloodGroup = request.getParameter("bloodGroup");
					triagePatientData.setBloodGroup(bloodGroup);
				}
				if(null!=request.getParameter("rhesusFactor") && ""!=request.getParameter("rhesusFactor"))
				{
					String rhesusFactor = request.getParameter("rhesusFactor");
					triagePatientData.setRhesusFactor(rhesusFactor);
				}
				
				triagePatientData.setLastMenstrualDate(lastMenstrualPeriod);
				
				if(null!=request.getParameter("pitct") && ""!=request.getParameter("pitct"))
				{
					String pitct = request.getParameter("pitct");
					triagePatientData.setPitct(pitct);
				}
				queueService.updateTriagePatientData(triagePatientData);
				}
				
			opdPatientLog = queueService.saveOpdPatientQueueLog(queueLog);
			queueService.deleteOpdPatientQueue(queue);
			// done queue

			if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "admit")) {

				opdPatientLog.setVisitOutCome("admit");
				queueService.saveOpdPatientQueueLog(opdPatientLog);
				IpdPatientAdmission patientAdmission = new IpdPatientAdmission();
				patientAdmission.setAdmissionDate(date);
				patientAdmission.setAdmissionWard(conceptService
						.getConcept(command.getIpdWard()));
				patientAdmission.setBirthDate(patient.getBirthdate());
				patientAdmission.setGender(patient.getGender());
				patientAdmission.setOpdAmittedUser(user);
				patientAdmission.setOpdLog(opdPatientLog);
				patientAdmission.setPatient(patient);
				patientAdmission.setPatientIdentifier(patient
						.getPatientIdentifier().getIdentifier());
				if (patient.getMiddleName() != null) {
					patientAdmission.setPatientName(patient.getGivenName()
							+ " " + patient.getFamilyName() + " "
							+ patient.getMiddleName().replace(",", " "));
				} else {
					patientAdmission.setPatientName(patient.getGivenName()
							+ " " + patient.getFamilyName());
				}
				patientAdmission.setAcceptStatus(0);
				patientAdmission = ipdService
						.saveIpdPatientAdmission(patientAdmission);
			}
		} else {
			opdPatientLog = queueService.getOpdPatientQueueLogById(command
					.getOpdLogId());
		}

		BillingService billingService = Context
				.getService(BillingService.class);

		IpdPatientAdmitted admitted = ipdService.getAdmittedByPatientId(command
				.getPatientId());
		if (admitted != null) {
			IndoorPatientServiceBill bill = new IndoorPatientServiceBill();

			bill.setCreatedDate(new Date());
			bill.setPatient(patient);
			bill.setCreator(Context.getAuthenticatedUser());

			IndoorPatientServiceBillItem item;
			BillableService service;
			BigDecimal amount = new BigDecimal(0);

			Integer[] al1 = command.getSelectedProcedureList();
			Integer[] al2 = command.getSelectedInvestigationList();
			Integer[] merge = null;
			if (al1 != null && al2 != null) {
				merge = new Integer[al1.length + al2.length];
				int j = 0, k = 0, l = 0;
				int max = Math.max(al1.length, al2.length);
				for (int i = 0; i < max; i++) {
					if (j < al1.length)
						merge[l++] = al1[j++];
					if (k < al2.length)
						merge[l++] = al2[k++];
				}
			} else if (al1 != null) {
				merge = command.getSelectedProcedureList();
			} else if (al2 != null) {
				merge = command.getSelectedInvestigationList();
			}

			boolean serviceAvailable = false;
			if (merge != null) {
				for (Integer iId : merge) {
					Concept c = conceptService.getConcept(iId);
					service = billingService.getServiceByConceptId(c
							.getConceptId());
					if(service!=null){
					serviceAvailable = true;
					amount = service.getPrice();
					item = new IndoorPatientServiceBillItem();
					item.setCreatedDate(new Date());
					item.setName(service.getName());
					item.setIndoorPatientServiceBill(bill);
					item.setQuantity(1);
					item.setService(service);
					item.setUnitPrice(service.getPrice());
					item.setAmount(amount);
					item.setActualAmount(amount);
					item.setOrderType("SERVICE");
					bill.addBillItem(item);
					}
				}
				bill.setAmount(amount);
				bill.setActualAmount(amount);
				bill.setEncounter(admitted.getPatientAdmissionLog()
						.getIpdEncounter());
				if(serviceAvailable ==true){
				bill = billingService.saveIndoorPatientServiceBill(bill);
				}

				IndoorPatientServiceBill indoorPatientServiceBill = billingService
						.getIndoorPatientServiceBillById(bill
								.getIndoorPatientServiceBillId());
				if (indoorPatientServiceBill != null) {
					billingService
							.saveBillEncounterAndOrderForIndoorPatient(indoorPatientServiceBill);
				}
			}

			if (!ArrayUtils.isEmpty(command.getSelectedProcedureList())) {
				Concept conpro = conceptService.getConceptByName(procedure
						.getPropertyValue());
				if (conpro == null) {
					throw new Exception("Post for procedure concept null");
				}
				Concept concept = Context.getConceptService().getConcept(
						"MINOR OPERATION");
				Collection<ConceptAnswer> allMinorOTProcedures = null;
				List<Integer> id = new ArrayList<Integer>();
				if (concept != null) {
					allMinorOTProcedures = concept.getAnswers();
					for (ConceptAnswer c : allMinorOTProcedures) {
						id.add(c.getAnswerConcept().getId());
					}
				}

				Concept concept2 = Context.getConceptService().getConcept(
						"MAJOR OPERATION");
				Collection<ConceptAnswer> allMajorOTProcedures = null;
				List<Integer> id2 = new ArrayList<Integer>();
				if (concept2 != null) {
					allMajorOTProcedures = concept2.getAnswers();
					for (ConceptAnswer c : allMajorOTProcedures) {
						id2.add(c.getAnswerConcept().getId());
					}
				}

				int conId;
				for (Integer pId : command.getSelectedProcedureList()) {
					BillableService billableService = billingService
							.getServiceByConceptId(pId);
					String OTscheduleDate = request
							.getParameter(pId.toString());
					OpdTestOrder opdTestOrder = new OpdTestOrder();
					opdTestOrder.setPatient(patient);
					opdTestOrder.setEncounter(encounter);
					opdTestOrder.setConcept(conpro);
					opdTestOrder.setTypeConcept(DepartmentConcept.TYPES[1]);
					opdTestOrder.setValueCoded(conceptService.getConcept(pId));
					opdTestOrder.setCreator(user);
					opdTestOrder.setCreatedOn(date);
					opdTestOrder.setBillingStatus(1);
					opdTestOrder.setBillableService(billableService);

					conId = conceptService.getConcept(pId).getId();
					if (id.contains(conId)) {
						SimpleDateFormat sdf = new SimpleDateFormat(
								"dd/MM/yyyy");
						Date scheduleDate = sdf.parse(OTscheduleDate);
						opdTestOrder.setScheduleDate(scheduleDate);
					}

					if (id2.contains(conId)) {
						SimpleDateFormat sdf = new SimpleDateFormat(
								"dd/MM/yyyy");
						Date scheduleDate = sdf.parse(OTscheduleDate);
						opdTestOrder.setScheduleDate(scheduleDate);
					}
					opdTestOrder.setIndoorStatus(1);
					patientDashboardService.saveOrUpdateOpdOrder(opdTestOrder);
				}

			}

		} else {
			if (!ArrayUtils.isEmpty(command.getSelectedProcedureList())) {
				Concept conpro = conceptService.getConceptByName(procedure
						.getPropertyValue());
				if (conpro == null) {
					throw new Exception("Post for procedure concept null");
				}
				Concept concept = Context.getConceptService().getConcept(
						"MINOR OPERATION");
				Collection<ConceptAnswer> allMinorOTProcedures = null;
				List<Integer> id = new ArrayList<Integer>();
				if (concept != null) {
					allMinorOTProcedures = concept.getAnswers();
					for (ConceptAnswer c : allMinorOTProcedures) {
						id.add(c.getAnswerConcept().getId());
					}
				}

				Concept concept2 = Context.getConceptService().getConcept(
						"MAJOR OPERATION");
				Collection<ConceptAnswer> allMajorOTProcedures = null;
				List<Integer> id2 = new ArrayList<Integer>();
				if (concept2 != null) {
					allMajorOTProcedures = concept2.getAnswers();
					for (ConceptAnswer c : allMajorOTProcedures) {
						id2.add(c.getAnswerConcept().getId());
					}
				}

				int conId;
				for (Integer pId : command.getSelectedProcedureList()) {
					BillableService billableService = billingService
							.getServiceByConceptId(pId);
					String OTscheduleDate = request
							.getParameter(pId.toString());
					OpdTestOrder opdTestOrder = new OpdTestOrder();
					opdTestOrder.setPatient(patient);
					opdTestOrder.setEncounter(encounter);
					opdTestOrder.setConcept(conpro);
					opdTestOrder.setTypeConcept(DepartmentConcept.TYPES[1]);
					opdTestOrder.setValueCoded(conceptService.getConcept(pId));
					opdTestOrder.setCreator(user);
					opdTestOrder.setCreatedOn(date);
					opdTestOrder.setBillableService(billableService);

					conId = conceptService.getConcept(pId).getId();
					if (id.contains(conId)) {
						SimpleDateFormat sdf = new SimpleDateFormat(
								"dd/MM/yyyy");
						Date scheduleDate = sdf.parse(OTscheduleDate);
						opdTestOrder.setScheduleDate(scheduleDate);
					}

					if (id2.contains(conId)) {
						SimpleDateFormat sdf = new SimpleDateFormat(
								"dd/MM/yyyy");
						Date scheduleDate = sdf.parse(OTscheduleDate);
						opdTestOrder.setScheduleDate(scheduleDate);
					}
					patientDashboardService.saveOrUpdateOpdOrder(opdTestOrder);
				}

			}

			if (!ArrayUtils.isEmpty(command.getSelectedInvestigationList())) {
				Concept coninvt = conceptService
						.getConceptByName(investigationn.getPropertyValue());
				if (coninvt == null) {
					throw new Exception("Investigation concept null");
				}
				
				
				
				for (Integer iId : command.getSelectedInvestigationList()) {
					BillableService billableService = billingService
							.getServiceByConceptId(iId);
					OpdTestOrder opdTestOrder = new OpdTestOrder();
					opdTestOrder.setPatient(patient);
					opdTestOrder.setEncounter(encounter);
					opdTestOrder.setConcept(coninvt);
					opdTestOrder.setTypeConcept(DepartmentConcept.TYPES[2]);
					opdTestOrder.setValueCoded(conceptService.getConcept(iId));
					opdTestOrder.setCreator(user);
					opdTestOrder.setCreatedOn(date);
					opdTestOrder.setBillableService(billableService);
					opdTestOrder.setScheduleDate(date);
					opdTestOrder.setFromDept( opdPatientLog.getOpdConceptName());
					patientDashboardService.saveOrUpdateOpdOrder(opdTestOrder);
				}
			}

		}

		// ghanshyam 12-june-2013 New Requirement #1635 User should be able to
		// send pharmacy orders to issue drugs to a patient from dashboard
		Integer formulationId;
		Integer frequencyId;
		Integer noOfDays;
		String comments;
		if (drugOrder != null) {
			for (String drugName : drugOrder) {
				InventoryCommonService inventoryCommonService = Context
						.getService(InventoryCommonService.class);
				InventoryDrug inventoryDrug = inventoryCommonService
						.getDrugByName(drugName);
				if (inventoryDrug != null) {
					formulationId = Integer.parseInt(request
							.getParameter(drugName + "_formulationId"));
					frequencyId = Integer.parseInt(request
							.getParameter(drugName + "_frequencyId"));
					noOfDays = Integer.parseInt(request.getParameter(drugName
							+ "_noOfDays"));
					comments = request.getParameter(drugName + "_comments");
					InventoryDrugFormulation inventoryDrugFormulation = inventoryCommonService
							.getDrugFormulationById(formulationId);
					Concept freCon = conceptService.getConcept(frequencyId);

					OpdDrugOrder opdDrugOrder = new OpdDrugOrder();
					opdDrugOrder.setPatient(patient);
					opdDrugOrder.setEncounter(encounter);
					opdDrugOrder.setInventoryDrug(inventoryDrug);
					opdDrugOrder
							.setInventoryDrugFormulation(inventoryDrugFormulation);
					opdDrugOrder.setFrequency(freCon);
					opdDrugOrder.setNoOfDays(noOfDays);
					opdDrugOrder.setComments(comments);
					opdDrugOrder.setCreator(user);
					opdDrugOrder.setCreatedOn(date);
					opdDrugOrder.setReferralWardName(opdPatientLog.getOpdConceptName());
					patientDashboardService
							.saveOrUpdateOpdDrugOrder(opdDrugOrder);
				}
			}
		}

		// symptom
		Symptom symptom = new Symptom();
		Question question = new Question();
		Answer answer = new Answer();
		for (String syptomId : syptomIdList) {
			String sypId = request.getParameter(syptomId);
			if (sypId != null) {
				symptom.setEncounter(encounter);
				symptom.setSymptomConcept(Context.getConceptService()
						.getConcept(Integer.parseInt(syptomId)));
				symptom.setCreatedDate(new Date());
				symptom.setCreator(Context.getAuthenticatedUser());
				Symptom sym = patientDashboardService.saveSymptom(symptom);
				Collection<ConceptAnswer> conceptAnswers = Context
						.getConceptService()
						.getConcept(Integer.parseInt(syptomId)).getAnswers();

				for (ConceptAnswer conceptAnswer : conceptAnswers) {
					if (conceptAnswer.getAnswerConcept().getDatatype()
							.isCoded()) {
						String aa = request.getParameter(syptomId
								+ ":"
								+ conceptAnswer.getAnswerConcept()
										.getConceptId().toString() + ":"
								+ "radioOption");
						if (aa != null) {
							question.setSymptom(sym);
							question.setQuestionConcept(conceptAnswer
									.getAnswerConcept());
							Question que = patientDashboardService
									.saveQuestion(question);

							Integer ghi = Integer.parseInt(aa);
							answer.setQuestion(que);
							answer.setAnswerConcept(Context.getConceptService()
									.getConcept(ghi));
							answer.setFreeText(null);
							patientDashboardService.saveAnswer(answer);
						}
					} else {
						String jkl = request.getParameter(syptomId
								+ ":"
								+ conceptAnswer.getAnswerConcept()
										.getConceptId().toString() + ":"
								+ "textFieldQues");
						if (!jkl.equals("")) {
							question.setSymptom(sym);
							question.setQuestionConcept(conceptAnswer
									.getAnswerConcept());
							Question que = patientDashboardService
									.saveQuestion(question);

							answer.setQuestion(que);
							answer.setAnswerConcept(null);
							answer.setFreeText(jkl);
							patientDashboardService.saveAnswer(answer);
						}
					}
				}
			}
		}
		
		if(null!=encounter && encounter.getEncounterType().getName().equals("OPDENCOUNTER"))
		{
			
			TriagePatientData triagePatientData =  new TriagePatientData();
			
			if(null!=request.getParameter("weight") && ""!=request.getParameter("weight"))
			{
				BigDecimal weight = new BigDecimal(request.getParameter("weight"));
				triagePatientData.setWeight(weight);
			}
			if(null!=request.getParameter("height") && ""!=request.getParameter("height"))
			{
				BigDecimal height = new BigDecimal(request.getParameter("height"));
				triagePatientData.setHeight(height);
			}
			if(null!=request.getParameter("temperature") && ""!=request.getParameter("temperature"))
			{
				BigDecimal temperature = new BigDecimal(request.getParameter("temperature"));
				triagePatientData.setTemperature(temperature);
			}
			if(null!=request.getParameter("mua") && ""!=request.getParameter("mua"))
			{
				BigDecimal mua = new BigDecimal(request.getParameter("mua"));
				triagePatientData.setMua(mua);
			}
			if(null!=request.getParameter("chest") && ""!=request.getParameter("chest"))
			{
				BigDecimal chest = new BigDecimal(request.getParameter("chest"));
				triagePatientData.setChest(chest);
			}
			if(null!=request.getParameter("abdominal") && ""!=request.getParameter("abdominal"))
			{
				BigDecimal abdominal = new BigDecimal(request.getParameter("abdominal"));
				triagePatientData.setAbdominal(abdominal);
			}
			if(null!=request.getParameter("systolic") && ""!=request.getParameter("systolic"))
			{
				Integer systolic = getInt(request.getParameter("systolic"));
				triagePatientData.setSystolic(systolic);
			}
			if(null!=request.getParameter("daistolic") && ""!=request.getParameter("daistolic"))
			{
				Integer daistolic = getInt(request.getParameter("daistolic"));
				triagePatientData.setDaistolic(daistolic);
			}
			if(null!=request.getParameter("respiratoryRate") && ""!=request.getParameter("respiratoryRate"))
			{
				Integer respiratoryRate = getInt(request.getParameter("respiratoryRate"));
				triagePatientData.setRespiratoryRate(respiratoryRate);				
			}
			if(null!=request.getParameter("pulsRate") && ""!=request.getParameter("pulsRate"))
			{
				Integer pulsRate = getInt(request.getParameter("pulsRate"));
				triagePatientData.setPulsRate(pulsRate);
			}
			if(null!=request.getParameter("bloodGroup") && ""!=request.getParameter("bloodGroup"))
			{
				String bloodGroup = request.getParameter("bloodGroup");
				triagePatientData.setBloodGroup(bloodGroup);
			}
			if(null!=request.getParameter("rhesusFactor") && ""!=request.getParameter("rhesusFactor"))
			{
				String rhesusFactor = request.getParameter("rhesusFactor");
				triagePatientData.setRhesusFactor(rhesusFactor);
			}
			if(null!=request.getParameter("lastMenstrualPeriod") && ""!=request.getParameter("lastMenstrualPeriod"))
			{
				Date lastMenstrualDate = new Date(request.getParameter("lastMenstrualPeriod"));
				triagePatientData.setLastMenstrualDate(lastMenstrualDate);
			}
			if(null!=request.getParameter("pitct") && ""!=request.getParameter("pitct"))
			{
				String pitct = request.getParameter("pitct");
				triagePatientData.setPitct(pitct);
			}
			triagePatientData.setCreatedOn(date);
			triagePatientData.setEncounterOpd(encounter.getEncounterId());
		 queueService.updateTriagePatientData(triagePatientData);
		
		}
		return "redirect:/module/patientqueue/main.htm?opdId="
				+ opdPatientLog.getOpdConcept().getId();

	}
	
	
	private Integer getInt(String value) {
		try {
			Integer number = Integer.parseInt(value);
			return number;
		} catch (Exception e) {
			return 0;
		}
	}

}
