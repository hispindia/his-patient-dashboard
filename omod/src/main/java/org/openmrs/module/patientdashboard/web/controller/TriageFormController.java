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
import org.openmrs.module.hospitalcore.model.IpdPatientAdmissionLog;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.model.OpdPatientQueue;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.hospitalcore.model.TriagePatientData;
import org.openmrs.module.hospitalcore.model.TriagePatientQueue;
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

		return "module/patientdashboard/triageForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String formSummit(@RequestParam(value = "queueId", required = false) Integer queueId,
			@RequestParam(value = "weight", required = false) BigDecimal weight,
			@RequestParam(value = "height", required = false) BigDecimal height,
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
			queue.setPatientName(patient.getGivenName() + " " + patient.getMiddleName() + " " + patient.getFamilyName());
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
