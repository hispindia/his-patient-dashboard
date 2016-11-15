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

//New Requirement "Editable Dashboard" ~//
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.openmrs.PersonAttribute;
import org.openmrs.PersonAttributeType;
import org.openmrs.Privilege;
import org.openmrs.Role;
import org.openmrs.User;
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
	
	/**
	 * June 20th 2012 - Thai Chuong updated for Bug #45 and optimized issue #44
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(method = RequestMethod.GET)
	public String firstView(@RequestParam("patientId") Integer patientId, @RequestParam("opdId") Integer opdId,
	                        @RequestParam(value = "queueId", required = false) Integer queueId,
	                        //ghanshyam 23-oct-2012 Bug #423 [IPD][0.9.7] Error Screen on clicking patiend ID in Admitted patient Index
	                        @RequestParam(value = "ipdAdmittedId", required = false) Integer ipdAdmittedId,
	                        @RequestParam("referralId") Integer referralId, Model model) {
		PatientService ps = Context.getPatientService();
		Patient patient = ps.getPatient(patientId);
		
		//ghanshyam 16-06-2012 Bug #44 OPD Dashboard/ Patient category,Temporary category is not being displayed
		List<EncounterType> types = new ArrayList<EncounterType>();
		
		EncounterType reginit = Context.getEncounterService().getEncounterType("REGINITIAL");
		types.add(reginit);
		EncounterType regrevisit = Context.getEncounterService().getEncounterType("REGREVISIT");
		types.add(regrevisit);
		EncounterType labencounter = Context.getEncounterService().getEncounterType("LABENCOUNTER");
		types.add(labencounter);
		EncounterType radiologyencounter = Context.getEncounterService().getEncounterType("RADIOLOGYENCOUNTER");
		types.add(radiologyencounter);
		EncounterType opdencounter = Context.getEncounterService().getEncounterType("OPDENCOUNTER");
		types.add(opdencounter);
		EncounterType ipdencounter = Context.getEncounterService().getEncounterType("IPDENCOUNTER");
		types.add(ipdencounter);
		
		// get Date of OPD Patient queue
		PatientQueueService pqs = Context.getService(PatientQueueService.class);
		//ghanshyam 23-oct-2012 Bug #423 [IPD][0.9.7] Error Screen on clicking patiend ID in Admitted patient Index(below two line commented and
		//line added upto else condition)
		/*
		OpdPatientQueue opdPatientQueue = pqs.getOpdPatientQueueById(queueId);
		Date createdOn = opdPatientQueue.getCreatedOn();
		*/
		//ghanshyam,11-nov-2013,Feedback #2937 Dealing with Dead Patient
		IpdService ipdService=Context.getService(IpdService.class);
		OpdPatientQueue opdPatientQueue = pqs.getOpdPatientQueueById(queueId);
		Date createdOn = null;
		if(queueId!=null){
			createdOn = opdPatientQueue.getCreatedOn();
		}
		else if(ipdAdmittedId!=null){
			IpdPatientAdmitted ipdPatientAdmitted=ipdService.getIpdPatientAdmitted(ipdAdmittedId);
			IpdPatientAdmissionLog pali=ipdPatientAdmitted.getPatientAdmissionLog();
			OpdPatientQueueLog opql=pali.getOpdLog();
			Integer id=opql.getId();
			OpdPatientQueueLog opdPatientQueueLog=pqs.getOpdPatientQueueLogById(id);
			createdOn=opdPatientQueueLog.getCreatedOn();
		}
		else{
			createdOn = new Date();
		}
		
		// get Encounter by date
		Encounter encounter = null;
		EncounterService es = Context.getEncounterService();
		List<Encounter> listEncounter = es.getEncounters(patient, createdOn, createdOn);
		if (1 == listEncounter.size())
			encounter = listEncounter.get(0);
		else {
			HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
			encounter = hcs.getLastVisitEncounter(patient, types);
		}
		
		/*
		 * INIT THE CONCEPT INFORMATION - issue #45, #44
		 */
		Concept referralConcept = Context.getConceptService().getConcept("PATIENT REFERRED TO HOSPITAL?");
		Concept conceptYesAnswer = Context.getConceptService().getConcept("YES");
		Concept referredTypeConcept = Context.getConceptService().getConcept("REASON FOR REFERRAL");
		Concept temporaryCategoryConcept = Context.getConceptService().getConcept("TEMPORARY CATEGORY");
		
		List<Obs> listObsTemporaryCategories = new ArrayList<Obs>();
		Obs referral = null;
		
		Set<Obs> setObs = Context.getObsService().getObservations(encounter);
		Iterator<Obs> obs = setObs.iterator();
		Obs o = new Obs();
		while (obs.hasNext()) {
			o = obs.next();
			if (temporaryCategoryConcept.getId().equals(o.getConcept().getId()))
				listObsTemporaryCategories.add(o); // get temporary category - issue #44
			if (referredTypeConcept.getId().equals(o.getConcept().getId()))
				referral = o; // get referredType if patient come from another health place - issue #45
		}
		
		/**
		 * June 21st 2012 - Thai Chuong supported for issue #108 - estimate patient's age
		 */
		Date birthday = patient.getBirthdate();
		
		model.addAttribute("observation", listObsTemporaryCategories);
		model.addAttribute("patient", patient);
		model.addAttribute("patientCategory", PatientUtils.getPatientCategory(patient));
		
		model.addAttribute("queueId", queueId);
		// issue #108
		//		model.addAttribute("age",
		//		    PatientDashboardUtil.getAgeFromBirthDate(patient.getBirthdate(), patient.getBirthdateEstimated()));
		model.addAttribute("age", PatientUtils.estimateAge(birthday));
		model.addAttribute("ageCategory", PatientDashboardUtil.calcAgeClass(patient.getAge()));
		model.addAttribute("opd", Context.getConceptService().getConcept(opdId));
		
		// If the patient from another health place come - issue #45
		if (null != referral)
			model.addAttribute("referredType", referral.getValueCoded().getName());
		
		model.addAttribute("referral", Context.getConceptService().getConcept(referralId));
		
		insertPropertiesUnlessExist();
		
		// get admitted status of patient
		
		IpdPatientAdmitted admitted = ipdService.getAdmittedByPatientId(patientId);
		
		if (admitted != null) {
			
			model.addAttribute("admittedStatus", "Admitted");
		}
		
		//New Requirement "Editable Dashboard"//
		
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
		Encounter enc=queueService.getLastOPDEncounter(patient);
	
		OpdPatientQueueLog opdPatientQueueLog=queueService.getOpdPatientQueueLogByEncounter(enc);
		model.addAttribute("opdPatientQueueLog", opdPatientQueueLog);
		if(encounter!=null)
		{
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	    String created = sdf.format(encounter.getEncounterDatetime());
			String sft= sdf.format(new Date())	;
		int value=sft.compareTo(created);
	
		  model.addAttribute("createNew", value);
		 
		}
		Obs ob=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patientId),Context.getConceptService().getConcept("VISIT OUTCOME"),enc);
				if(ob==null)
				{
					return "module/patientdashboard/main";
				}
				else
				{
					model.addAttribute("ob", ob);
				}
		
		
		 User loggedInUser = Context.getUserContext().getAuthenticatedUser();
			Set<Role> userRole = loggedInUser.getAllRoles();
			Set<Privilege> userPrivileges = (Set<Privilege>) loggedInUser.getPrivileges();
			 String hasEditPrivilige = "no";
			  
			  Iterator iteratorPrivileges = userPrivileges.iterator(); 
		      
		      String priv= "Edit Patient by Doctor";
		      while (iteratorPrivileges.hasNext()){
			         if(priv.equalsIgnoreCase(iteratorPrivileges.next().toString()))
				      {
			        	 hasEditPrivilige = "yes";
				     }
			        
			      }
			
		      model.addAttribute("hasEditPrivilige",hasEditPrivilige);
		     
		  if(ob.getConcept().getId()!=null)
		     {
		    	 model.addAttribute("revisit","revisit");
		     }
		
	
		
		//ghanshyam,23-oct-2013,New Requirement #2937 Dealing with Dead Patient
		Boolean dead = patient.getDead();
		if(dead.equals(false)){
			return "module/patientdashboard/main";
		}
		else{
			return "module/patientdashboard/mainOfDeadPatient";
		}
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
				insertConcept(conceptService, "Coded", "Question", PatientDashboardConstants.PROPERTY_HOSPITAL);
				
				// Provisional diagnosis
				insertConcept(conceptService, "N/A", "Misc", PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
				
				// Post for procedure
				insertConcept(conceptService, "N/A", "Misc", PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
				
				// Internal referral
				insertConcept(conceptService, "Coded", "Question", PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL);
				
				// External referral
				insertConcept(conceptService, "Coded", "Question", PatientDashboardConstants.PROPERTY_EXTERNAL_REFERRAL);
				
				// Visit outcome
				insertConcept(conceptService, "Text", "Misc", PatientDashboardConstants.PROPERTY_VISIT_OUTCOME);
				
				// OPD WARD
				insertConcept(conceptService, "Coded", "Question", PatientDashboardConstants.PROPERTY_OPDWARD);
				
				// IPD WARD
				insertConcept(conceptService, "Coded", "Question", PatientDashboardConstants.PROPERTY_IPDWARD);
				
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
				
			}
			catch (Exception e) {
				e.printStackTrace();
				isInit.setPropertyValue("0");
				Context.getAdministrationService().saveGlobalProperty(isInit);
			}
			
		}
	}
	
	// Return the globalProperty to tell necessary concepts are created.
	// If it does not exist, create the new one with value 0
	private GlobalProperty getGlobalProperty() {
		
		GlobalProperty gp = Context.getAdministrationService().getGlobalPropertyObject(
		    PatientDashboardConstants.PROPERTY_INIT_CONCEPT);
		
		if (gp == null) {
			gp = new GlobalProperty(PatientDashboardConstants.PROPERTY_INIT_CONCEPT, "0");
		}
		
		try {
			Integer.parseInt(gp.getPropertyValue());
		}
		catch (Exception e) {
			gp.setPropertyValue("0");
		}
		
		return gp;
	}
	
	private Concept insertConcept(ConceptService conceptService, String dataTypeName, String conceptClassName,
	                              String conceptNameKey) {
		try {
			ConceptDatatype datatype = Context.getConceptService().getConceptDatatypeByName(dataTypeName);
			ConceptClass conceptClass = conceptService.getConceptClassByName(conceptClassName);
			GlobalProperty gp = Context.getAdministrationService().getGlobalPropertyObject(conceptNameKey);
			Concept con = conceptService.getConcept(gp.getPropertyValue());
			// System.out.println(con);
			if (con == null) {
				con = new Concept();
				ConceptName name = new ConceptName(gp.getPropertyValue(), Context.getLocale());
				con.addName(name);
				con.setDatatype(datatype);
				con.setConceptClass(conceptClass);
				return conceptService.saveConcept(con);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private Concept insertHospital(ConceptService conceptService, String hospitalName) {
		try {
			ConceptDatatype datatype = Context.getConceptService().getConceptDatatypeByName("N/A");
			ConceptClass conceptClass = conceptService.getConceptClassByName("Misc");
			Concept con = conceptService.getConceptByName(hospitalName);
			// System.out.println(con);
			if (con == null) {
				con = new Concept();
				ConceptName name = new ConceptName(hospitalName, Context.getLocale());
				con.addName(name);
				con.setDatatype(datatype);
				con.setConceptClass(conceptClass);
				return conceptService.saveConcept(con);
			}
			return con;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private void insertEncounter(String typeKey) {
		try {
			GlobalProperty gp = Context.getAdministrationService().getGlobalPropertyObject(typeKey);
			if (Context.getEncounterService().getEncounterType(gp.getPropertyValue()) == null) {
				EncounterType et = new EncounterType(gp.getPropertyValue(), "");
				Context.getEncounterService().saveEncounterType(et);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void insertExternalHospitalConcepts(ConceptService conceptService) {
		// System.out.println("========= insertExternalHospitalConcepts =========");
		Concept concept = conceptService.getConcept(PatientDashboardConstants.PROPERTY_HOSPITAL);
		if (concept != null) {
			String[] hospitalNames = { "INDIRA GANDHI MEDICAL COLLLEGE", "POST GRADUATE INSTITUTE, CHANDIGARH",
			        "ALL INDIA INSTITUTE OF MEDICAL SCIENCE, NEW DELHI" };
			for (String hn : hospitalNames) {
				insertHospital(conceptService, hn);
			}
			addConceptAnswers(concept, hospitalNames, Context.getAuthenticatedUser());
		}
	}
	
	private void insertIpdWardConcepts(ConceptService conceptService) {
		// System.out.println("========= insertExternalHospitalConcepts =========");
		Concept concept = conceptService.getConcept(PatientDashboardConstants.PROPERTY_IPDWARD);
		if (concept != null) {
			String[] wards = { "Ipd Ward 1", "Ipd Ward 2", "Ipd Ward 3" };
			for (String hn : wards) {
				insertHospital(conceptService, hn);
			}
			addConceptAnswers(concept, wards, Context.getAuthenticatedUser());
		}
	}
	
	private void addConceptAnswers(Concept concept, String[] answerNames, User creator) {
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
