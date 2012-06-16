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

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.ConceptClass;
import org.openmrs.ConceptDatatype;
import org.openmrs.ConceptName;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.GlobalProperty;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.User;
import org.openmrs.api.ConceptService;
import org.openmrs.api.EncounterService;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.IpdService;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.openmrs.module.patientdashboard.util.PatientDashboardUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("patientDashboardMainController")
@RequestMapping("/module/patientdashboard/main.htm")
public class MainController {

	@SuppressWarnings("deprecation")
	@RequestMapping(method = RequestMethod.GET)
	public String firstView(@RequestParam("patientId") Integer patientId,
			@RequestParam("opdId") Integer opdId,
			@RequestParam(value="queueId", required=false) Integer queueId,
			@RequestParam("referralId") Integer referralId, Model model) {
		PatientService ps = Context.getPatientService();
		Patient patient = ps.getPatient(patientId);
		
		//ghanshyam 16-06-2012 Bug #44 OPD Dashboard/ Patient category,Temporary category is not being displayed
		List<EncounterType> types = new ArrayList<EncounterType>();
		EncounterType reginit = Context.getEncounterService().getEncounterType(1);
		types.add(reginit);
		EncounterType revisit = Context.getEncounterService().getEncounterType(2);
		types.add(revisit);
		
		EncounterType check = Context.getEncounterService().getEncounterType(3);
		EncounterType check1 = Context.getEncounterService().getEncounterType(4);
		EncounterType check2 = Context.getEncounterService().getEncounterType(5);
		EncounterType check3 = Context.getEncounterService().getEncounterType(6);
		EncounterType check4 = Context.getEncounterService().getEncounterType(7);
		EncounterType check5 = Context.getEncounterService().getEncounterType(8);
		EncounterType check6 = Context.getEncounterService().getEncounterType(9);
		EncounterType check7 = Context.getEncounterService().getEncounterType(10);
		
		types.add(check);
		types.add(check1);
		types.add(check2);
		types.add(check3);
		types.add(check4);
		types.add(check5);
		types.add(check6);
		types.add(check7);
		
		HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
		Encounter encounter = hcs.getLastVisitEncounter(patient, types);
		Set<Obs> setObs = Context.getObsService().getObservations(encounter);
		List<Obs> listObs = new ArrayList<Obs>();
		Iterator<Obs> obs = setObs.iterator();
		Obs o = new Obs();
		while(obs.hasNext()){
			o = obs.next();
			if(11 == o.getConcept().getId())
				listObs.add(o);
		}
		
		model.addAttribute("observation", listObs);
		model.addAttribute("patient", patient);
		model.addAttribute("patientCategory",PatientUtils.getPatientCategory(patient));
		
		model.addAttribute("queueId",queueId);
		model.addAttribute("age", PatientDashboardUtil.getAgeFromBirthDate(
				patient.getBirthdate(), patient.getBirthdateEstimated()));
		model.addAttribute("ageCategory",
				PatientDashboardUtil.calcAgeClass(patient.getAge()));
		model.addAttribute("opd", Context.getConceptService().getConcept(opdId));
		model.addAttribute("referral",
				Context.getConceptService().getConcept(referralId));
		

		

		/*
		 * String isInit = Context.getAdministrationService().getGlobalProperty(
		 * PatientDashboardConstants.PROPERTY_INIT_CONCEPT); if(
		 * "false".equals(isInit)){ ConceptService conceptService =
		 * Context.getConceptService();
		 * 
		 * ConceptDatatype datatype =
		 * Context.getConceptService().getConceptDatatypeByName("N/A");
		 * ConceptClass conceptClass =
		 * conceptService.getConceptClassByName("Misc"); String conceptName =
		 * Context
		 * .getAdministrationService().getGlobalProperty(PatientDashboardConstants
		 * .PROPERTY_PROVISIONAL_DIAGNOSIS); Concept con =
		 * conceptService.getConcept(conceptName); if( con == null ){ con = new
		 * Concept(); ConceptName name = new ConceptName(conceptName,
		 * Context.getLocale()); con.addName(name); con.setDatatype(datatype);
		 * con.setConceptClass(conceptClass); conceptService.saveConcept(con); }
		 * }
		 */


		// Init needed concepts
		
		insertPropertiesUnlessExist();
		
		// get admitted status of patient
		
		IpdService ipdService = Context.getService(IpdService.class);
		
		IpdPatientAdmitted admitted = ipdService.getAdmittedByPatientId(patientId);
		
		if( admitted != null ){
			model.addAttribute("admittedStatus", "Admitted");
		}
		
		return "module/patientdashboard/main";
	}

	private void insertPropertiesUnlessExist() {

		GlobalProperty isInit = getGlobalProperty();

		if ("0".equals(isInit.getPropertyValue())) {

			// System.out.println("run it");

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
	private GlobalProperty getGlobalProperty(){

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
			// System.out.println(con);
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
			// System.out.println(con);
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
		// System.out.println("========= insertExternalHospitalConcepts =========");
		Concept concept = conceptService
				.getConcept(PatientDashboardConstants.PROPERTY_HOSPITAL);
		if (concept != null) {
			String[] hospitalNames = { "INDIRA GANDHI MEDICAL COLLLEGE",
					"POST GRADUATE INSTITUTE, CHANDIGARH",
					"ALL INDIA INSTITUTE OF MEDICAL SCIENCE, NEW DELHI"
					};
			for (String hn : hospitalNames) {
				insertHospital(conceptService, hn);
			}
			addConceptAnswers(concept, hospitalNames,
					Context.getAuthenticatedUser());
		}
	}
	
	private void insertIpdWardConcepts(ConceptService conceptService) {
		// System.out.println("========= insertExternalHospitalConcepts =========");
		Concept concept = conceptService.getConcept(PatientDashboardConstants.PROPERTY_IPDWARD);
		if (concept != null) {
			String[] wards = { "Ipd Ward 1",
					"Ipd Ward 2",
					"Ipd Ward 3" };
			for (String hn : wards) {
				insertHospital(conceptService, hn);
			}
			addConceptAnswers(concept, wards,
					Context.getAuthenticatedUser());
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

}