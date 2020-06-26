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

//New Requirement "Editable Dashboard" //
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
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
import org.openmrs.Person;
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
import org.openmrs.module.hospitalcore.model.BillableService;
import org.openmrs.module.hospitalcore.model.DepartmentConcept;
import org.openmrs.module.hospitalcore.model.IndoorPatientServiceBill;
import org.openmrs.module.hospitalcore.model.IndoorPatientServiceBillItem;
import org.openmrs.module.hospitalcore.model.InventoryDrug;
import org.openmrs.module.hospitalcore.model.InventoryDrugFormulation;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmission;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.model.LabTest;
import org.openmrs.module.hospitalcore.model.OpdDrugOrder;
import org.openmrs.module.hospitalcore.model.OpdPatientQueue;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.hospitalcore.model.OpdTestOrder;
import org.openmrs.module.hospitalcore.model.PatientSearch;
import org.openmrs.module.hospitalcore.util.ConceptComparator;
import org.openmrs.module.hospitalcore.util.HospitalCoreConstants;
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
			//@RequestParam(value = "opdLogId", required = false) Integer opdLogId,
			@RequestParam("referralId") Integer referralId, Model model) {

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

		List<Concept> investigations = patientDashboardService
				.listByDepartmentByWard(opdId, DepartmentConcept.TYPES[2]);
		if (CollectionUtils.isNotEmpty(investigations)) {
			Collections.sort(investigations, new ConceptComparator());
		}
		model.addAttribute("listInvestigations", investigations);

		List<Concept> drugFrequencyConcept = inventoryCommonService
				.getDrugFrequency();
		model.addAttribute("drugFrequencyList", drugFrequencyConcept);

		model.addAttribute("opd", opdConcept);
		model.addAttribute("referral",
				Context.getConceptService().getConcept(referralId));

		String hospitalName = Context.getAdministrationService()
				.getGlobalProperty("hospital.location_user");
		model.addAttribute("hospitalName", hospitalName);

		SimpleDateFormat sdf = new SimpleDateFormat("EEE dd/MM/yyyy hh:mm a");
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
       Person person=Context.getPersonService().getPerson(patientId);
		Date birthday = patient.getBirthdate();
		model.addAttribute("age", PatientUtils.estimateAge(birthday));
		model.addAttribute("ageCategory", PatientUtils.estimateAgeCategory(birthday));

		HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
		List<PersonAttribute> pas = hcs.getPersonAttributes(patientId);
		for (PersonAttribute pa : pas) {
			PersonAttributeType attributeType = pa.getAttributeType();
			if (attributeType.getPersonAttributeTypeId() == 14) {
				model.addAttribute("selectedCategory", pa.getValue());
			}
			/*
			 * if (attributeType.getPersonAttributeTypeId() == 36) {
			 * model.addAttribute("exemptionNumber", pa.getValue()); }
			 */

		}
        
		User user = Context.getAuthenticatedUser();
		model.addAttribute("user", user);
		
		//New Requirement "Editable Dashboard" //
		PatientQueueService queueService = Context
				.getService(PatientQueueService.class);
		
		Patient p = new Patient(patientId);
		Integer personId = p.getPersonId();
		Encounter enc= queueService.getLastOPDEncounter(patient);
		List<Obs> diagnosis= queueService.getAllDiagnosis(personId);
		Set<Concept> diagnosisIdSet = new LinkedHashSet<Concept>();
		Set<ConceptName> diagnosisNameSet = new LinkedHashSet<ConceptName>();
		 
		for(Obs diagnos:diagnosis){
			if(diagnos.getEncounter().getId().equals(enc.getEncounterId()))
			{
				
				diagnosisIdSet.add(diagnos.getValueCoded());
				diagnosisNameSet.add(diagnos.getValueCoded().getName());
				
			}
			
		 }
		Set<String> diaNameSet = new LinkedHashSet<String>();
		Iterator itr = diagnosisNameSet.iterator();
		while(itr.hasNext())
		{
			diaNameSet.add((itr.next().toString()).replaceAll(",", "@"));
			
		}
		model.addAttribute("diagnosisIdSet", diagnosisIdSet);
		model.addAttribute("diaNameSet", diaNameSet);
		
		Map<Integer, String> ipdConceptMap = new LinkedHashMap<Integer, String>();
		for(ConceptAnswer ipdcon:ipdConcept.getAnswers()){
			ipdConceptMap.put(ipdcon.getAnswerConcept().getId(), ipdcon.getAnswerConcept().getName().toString());
		}
		model.addAttribute("ipdConceptMap", ipdConceptMap);
		
		IpdService ipdService=Context.getService(IpdService.class);
		IpdPatientAdmitted admitted = ipdService.getAdmittedByPatientId(patientId);
		
		if (admitted != null) {
			model.addAttribute("admittedStatus", "Admitted");
		}
		
		IpdPatientAdmission ipdPatientAdmission=ipds.getIpdPatientAdmissionByPatient(patient);
		if (ipdPatientAdmission != null) {
			model.addAttribute("ipdPatientAdmission",true);
		}
		else{
			model.addAttribute("ipdPatientAdmission",false);	
		}

		GlobalProperty slipMessage = Context.getAdministrationService().getGlobalPropertyObject("hospitalcore.slipMessage");
		model.addAttribute("slipMessage", slipMessage.getPropertyValue());

        return "module/patientdashboard/opdEntry";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String formSummit(
			OPDEntryCommand command,
			HttpServletRequest request,
			@RequestParam(value = "drugOrder", required = false) String[] drugOrder)
			throws Exception {
		

		User user = Context.getAuthenticatedUser();
		PatientService ps = Context.getPatientService();
		// ghanshyam,23-oct-2013,New Requirement #2937 Dealing with Dead Patient
		HospitalCoreService hcs = (HospitalCoreService) Context
				.getService(HospitalCoreService.class);
		PatientDashboardService patientDashboardService = Context
				.getService(PatientDashboardService.class);
		IpdService ipdService = Context.getService(IpdService.class);
		Patient patient = ps.getPatient(command.getPatientId());
		PatientSearch patientSearch = hcs.getPatient(command.getPatientId());

		// harsh 14/6/2012 setting death date to today's date and dead variable
		// to true when "died" is selected
		if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "Died")) {
			patient.setDead(true);
			patient.setDeathDate(new Date());

			ps.savePatient(patient);

			// ghanshyam,23-oct-2013,New Requirement #2937 Dealing with Dead
			// Patient
			patientSearch.setDead(true);
			hcs.savePatientSearch(patientSearch);
		}

		Date date = new Date();
		// create obs group only for internal referral and admit
		Obs obsGroup = null;
		obsGroup = hcs.getObsGroupCurrentDate(patient.getPersonId());
		if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "Admit")
				|| (command.getInternalReferral() != null)) {
			if (obsGroup == null) {
				obsGroup = hcs.createObsGroup(patient,
						HospitalCoreConstants.PROPERTY_OBSGROUP);
			}
		}

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
		
		IpdPatientAdmitted admitted = ipdService.getAdmittedByPatientId(command.getPatientId());
		
		/*
		if (admitted != null) {
			encounter = admitted.getPatientAdmissionLog().getIpdEncounter();
		}
		else{
		encounter.setPatient(patient);
		encounter.setCreator(user);
		encounter.setProvider(user);
		encounter.setEncounterDatetime(date);
		encounter.setEncounterType(encounterType);
		encounter.setLocation(location);
		}
		*/
		encounter.setPatient(patient);
		encounter.setCreator(user);
		encounter.setProvider(user);
		encounter.setEncounterDatetime(date);
		encounter.setEncounterType(encounterType);
		encounter.setLocation(location);

		ConceptService conceptService = Context.getConceptService();
		GlobalProperty gpDiagnosis = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
		GlobalProperty procedure = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		GlobalProperty investigationn = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_FOR_INVESTIGATION);
		GlobalProperty internalReferral = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL);
		GlobalProperty externalReferral = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_EXTERNAL_REFERRAL);
		
		Concept cDiagnosis = conceptService.getConceptByName(gpDiagnosis.getPropertyValue());
		
		//New Requirement "Final & Provisional Diagnosis" //
		Concept cFinalDiagnosis = conceptService.getConcept("FINAL DIAGNOSIS");
		
		Concept chopi=Context.getConceptService().getConcept("HISTORY OF PRESENT ILLNESS");
		Concept cOtherIntructions=Context.getConceptService().getConcept("OTHER INSTRUCTIONS");

		if (cDiagnosis == null) {
			throw new Exception("Diagnosis concept null");
		}
		// diagnosis
		//New Requirement "Final & Provisional Diagnosis" //
		String selectedDia = request.getParameter("radio_dia");
		 ArrayList<Integer> arrlist = new ArrayList<Integer>();
		
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
			if(!(arrlist.contains(cId)))
			{
				arrlist.add(cId);
				
				 
				 encounter.addObs(obsDiagnosis);
			}
			
			
			
		}
		// historyOfPresentIllness
		if (StringUtils.isNotBlank(command.getHistoryOfPresentIlness())) {

			Obs obsDiagnosis = new Obs();
			obsDiagnosis.setObsGroup(obsGroup);
			obsDiagnosis.setConcept(chopi);
			obsDiagnosis.setValueText(command.getHistoryOfPresentIlness());
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
		
		//otherInstructions
		if (StringUtils.isNotBlank(command.getOtherInstructions())) {

			Obs obsDiagnosis = new Obs();
			obsDiagnosis.setObsGroup(obsGroup);
			obsDiagnosis.setConcept(cOtherIntructions);
			obsDiagnosis.setValueText(command.getOtherInstructions());
			obsDiagnosis.setCreator(user);
			obsDiagnosis.setDateCreated(date);
			obsDiagnosis.setEncounter(encounter);
			obsDiagnosis.setPatient(patient);
			encounter.addObs(obsDiagnosis);
		}

		// internal referral
		// System.out.println("command.getInternalReferral(): "+command.getInternalReferral());
		if (command.getInternalReferral() != null && !command.getInternalReferral().equals("")) {
			Concept cInternalReferral = conceptService
					.getConceptByName(internalReferral.getPropertyValue());
			if (cInternalReferral == null) {
				throw new Exception("InternalReferral concept null");
			}

			Concept internalReferralConcept = conceptService.getConceptByName(command
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

			// add this patient to the queue of the referral OPD
			OpdPatientQueue queue = new OpdPatientQueue();
			queue.setPatient(patient);
			queue.setCreatedOn(date);
			queue.setBirthDate(patient.getBirthdate());
			queue.setPatientIdentifier(patient.getPatientIdentifier()
					.getIdentifier());
			queue.setOpdConcept(internalReferralConcept);
			queue.setOpdConceptName(internalReferralConcept.getName().getName());
			queue.setPatientName(patient.getGivenName() + " "
					+ patient.getMiddleName() + " " + patient.getFamilyName());
			queue.setReferralConcept(currentOpd);
			queue.setReferralConceptName(currentOpd.getName().getName());
			queue.setSex(patient.getGender());
			PatientQueueService queueService = Context
					.getService(PatientQueueService.class);
			queueService.saveOpdPatientQueue(queue);

		}

		// external referral
		// System.out.println("command.getExternalReferral(): "+command.getExternalReferral());
		if (command.getExternalReferral() != null && !command.getExternalReferral().equals("")) {
			Concept cExternalReferral = conceptService
					.getConceptByName(externalReferral.getPropertyValue());
			if (cExternalReferral == null) {
				throw new Exception("ExternalReferral concept null");
			}
			Obs obsExternalReferral = new Obs();
			obsExternalReferral.setObsGroup(obsGroup);
			obsExternalReferral.setConcept(cExternalReferral);
			obsExternalReferral.setValueCoded(conceptService.getConceptByName(command
					.getExternalReferral()));
			obsExternalReferral.setCreator(user);
			obsExternalReferral.setDateCreated(date);
			obsExternalReferral.setEncounter(encounter);
			obsExternalReferral.setPatient(patient);
			encounter.addObs(obsExternalReferral);
		}
//Vital Static
		
		
		
		if(request.getParameter("weight")!=null && request.getParameter("weight")!="")
			{ String weight=request.getParameter("weight");
			  Double weights=Double.parseDouble(weight);
			Obs vitalstaticweight=new Obs();
			vitalstaticweight.setPatient(patient);
			vitalstaticweight.setEncounter(encounter);
			vitalstaticweight.setConcept(Context.getConceptService().getConcept("WEIGHT"));
			vitalstaticweight.setDateCreated(date);
			vitalstaticweight.setObsGroup(obsGroup);
			
			vitalstaticweight.setValueNumeric(weights);
			vitalstaticweight.setCreator(user);
			encounter.addObs(vitalstaticweight);
			
			
			}
		if(request.getParameter("height")!=null && request.getParameter("height")!="")
		{String height=request.getParameter("height");
		  Double heights=Double.parseDouble(height);
			
			Obs vitalstaticweight=new Obs();
		vitalstaticweight.setPatient(patient);
		vitalstaticweight.setEncounter(encounter);
		vitalstaticweight.setConcept(Context.getConceptService().getConcept("HEIGHT"));
		vitalstaticweight.setDateCreated(date);
		vitalstaticweight.setObsGroup(obsGroup);
		
		vitalstaticweight.setValueNumeric(heights);
		vitalstaticweight.setCreator(user);
		encounter.addObs(vitalstaticweight);
		
		
		}
		if(request.getParameter("systolic")!=null && request.getParameter("systolic")!="")
		{ String sys=request.getParameter("systolic");
		  Double systolic=Double.parseDouble(sys);
		Obs vitalstaticweight=new Obs();
		vitalstaticweight.setPatient(patient);
		vitalstaticweight.setEncounter(encounter);
		vitalstaticweight.setConcept(Context.getConceptService().getConcept("SYSTOLIC BLOOD PRESSURE"));
		vitalstaticweight.setDateCreated(date);
		vitalstaticweight.setObsGroup(obsGroup);
		
		vitalstaticweight.setValueNumeric(systolic);
		vitalstaticweight.setCreator(user);
		encounter.addObs(vitalstaticweight);
		
		
		}
	if(request.getParameter("diastolic")!=null && request.getParameter("diastolic")!="")
	{String dai=request.getParameter("diastolic");
	  Double daistolic=Double.parseDouble(dai);
		
		Obs vitalstaticweight=new Obs();
	vitalstaticweight.setPatient(patient);
	vitalstaticweight.setEncounter(encounter);
	vitalstaticweight.setConcept(Context.getConceptService().getConcept("DAISTOLIC BLOOD PRESSURE"));
	vitalstaticweight.setDateCreated(date);
	vitalstaticweight.setObsGroup(obsGroup);
	
	vitalstaticweight.setValueNumeric(daistolic);
	vitalstaticweight.setCreator(user);
	encounter.addObs(vitalstaticweight);
	
	}
	if(request.getParameter("pulsRate")!=null && request.getParameter("pulsRate")!="")
	{String pulse=request.getParameter("pulsRate");
	  Double pulses=Double.parseDouble(pulse);
		
		Obs vitalstaticweight=new Obs();
	vitalstaticweight.setPatient(patient);
	vitalstaticweight.setEncounter(encounter);
	vitalstaticweight.setConcept(Context.getConceptService().getConcept("PULSE RATE"));
	vitalstaticweight.setDateCreated(date);
	vitalstaticweight.setObsGroup(obsGroup);
	
	vitalstaticweight.setValueNumeric(pulses);
	vitalstaticweight.setCreator(user);
	encounter.addObs(vitalstaticweight);
	
	}
	if(request.getParameter("weight")!=null && request.getParameter("weight")!=""&& request.getParameter("height")!=null && request.getParameter("height")!="" )
	{String height=request.getParameter("height");
	
	  Double heights=Double.parseDouble(height);
	  String weight=request.getParameter("weight");
	  Double weights=Double.parseDouble(weight);
	  Double BMI=((weights)/((heights/100)*(heights/100)));
	  
		Obs vitalstaticweight=new Obs();
	vitalstaticweight.setPatient(patient);
	vitalstaticweight.setEncounter(encounter);
	vitalstaticweight.setConcept(Context.getConceptService().getConcept("BMI"));
	vitalstaticweight.setDateCreated(date);
	vitalstaticweight.setObsGroup(obsGroup);
	
	vitalstaticweight.setValueNumeric(BMI);
	vitalstaticweight.setCreator(user);
	encounter.addObs(vitalstaticweight);
	
	}
	
	
	if(request.getParameter("temp")!=null && request.getParameter("temp")!="")
	{String temperature=request.getParameter("temp");
	
	
	
	  Double temperatures=Double.parseDouble(temperature);
		
		Obs temperatureValue=new Obs();
		temperatureValue.setPatient(patient);
		temperatureValue.setEncounter(encounter);
		temperatureValue.setConcept(Context.getConceptService().getConcept("TEMPERATURE"));
		temperatureValue.setDateCreated(date);
		temperatureValue.setObsGroup(obsGroup);
	
		temperatureValue.setValueNumeric(temperatures);
		temperatureValue.setCreator(user);
	encounter.addObs(temperatureValue);
	
	}
	if(request.getParameter("lastMenstrualPeriod")!=null && request.getParameter("lastMenstrualPeriod")!="")
	{ String lmp=request.getParameter("lastMenstrualPeriod");
	SimpleDateFormat formatterExt = new SimpleDateFormat("dd/MM/yyyy");
	Date lmpdate = (Date)formatterExt.parse(lmp);
	Obs vitalstaticweight=new Obs();
	vitalstaticweight.setPatient(patient);
	vitalstaticweight.setEncounter(encounter);
	vitalstaticweight.setConcept(Context.getConceptService().getConcept("LAST MENSTRUAL PERIOD"));
	vitalstaticweight.setDateCreated(date);
	vitalstaticweight.setObsGroup(obsGroup);
	
	vitalstaticweight.setValueDatetime(lmpdate);
	vitalstaticweight.setCreator(user);
	encounter.addObs(vitalstaticweight);
	
	
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
			// TODO if
			if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "Follow-up")) {
				obsOutcome.setValueDatetime(Context.getDateFormat().parse(
						command.getDateFollowUp()));
			}

			if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "Admit")) {
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
		PatientQueueService queueService = Context
				.getService(PatientQueueService.class);
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
		 opdPatientLog = queueService
				.saveOpdPatientQueueLog(queueLog);
		queueService.deleteOpdPatientQueue(queue);
		// done queue

		if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "Admit")) {

			IpdPatientAdmission patientAdmission = new IpdPatientAdmission();
			patientAdmission.setAdmissionDate(date);
			patientAdmission.setAdmissionWard(conceptService.getConcept(command
					.getIpdWard()));
			patientAdmission.setBirthDate(patient.getBirthdate());
			patientAdmission.setGender(patient.getGender());
			patientAdmission.setOpdAmittedUser(user);
			patientAdmission.setOpdLog(opdPatientLog);
			patientAdmission.setPatient(patient);
			patientAdmission.setPatientIdentifier(patient
					.getPatientIdentifier().getIdentifier());
			patientAdmission.setPatientName(patient.getGivenName() + " "
					+ patient.getMiddleName() + " " + patient.getFamilyName());
			patientAdmission = ipdService
					.saveIpdPatientAdmission(patientAdmission);
		}	} else {
			opdPatientLog = queueService.getOpdPatientQueueLogById(command.getOpdId());
		}

		BillingService billingService = Context
				.getService(BillingService.class);

		//IpdPatientAdmitted admitted = ipdService.getAdmittedByPatientId(command.getPatientId());
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
					if (service != null) {
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
						bill.addBillItem(item);
					}
				}
				bill.setAmount(amount);
				bill.setActualAmount(amount);
				bill.setEncounter(admitted.getPatientAdmissionLog()
						.getIpdEncounter());
				if (serviceAvailable == true) {
					bill = billingService.saveIndoorPatientServiceBill(bill);
				}

				IndoorPatientServiceBill indoorPatientServiceBill = billingService
						.getIndoorPatientServiceBillById(bill
								.getIndoorPatientServiceBillId());
				if (indoorPatientServiceBill != null) {
					// billingService.saveBillEncounterAndOrderForIndoorPatient(indoorPatientServiceBill);
				}
			}

			if (!ArrayUtils.isEmpty(command.getSelectedProcedureList())) {
				Concept conpro = conceptService.getConceptByName(procedure
						.getPropertyValue());
				if (conpro == null) {
					throw new Exception("Post for procedure concept null");
				}
				/*
				 * Concept concept = Context.getConceptService().getConcept(
				 * "MINOR OPERATION"); Collection<ConceptAnswer>
				 * allMinorOTProcedures = null; List<Integer> id = new
				 * ArrayList<Integer>(); if (concept != null) {
				 * allMinorOTProcedures = concept.getAnswers(); for
				 * (ConceptAnswer c : allMinorOTProcedures) {
				 * id.add(c.getAnswerConcept().getId()); } }
				 * 
				 * Concept concept2 = Context.getConceptService().getConcept(
				 * "MAJOR OPERATION"); Collection<ConceptAnswer>
				 * allMajorOTProcedures = null; List<Integer> id2 = new
				 * ArrayList<Integer>(); if (concept2 != null) {
				 * allMajorOTProcedures = concept2.getAnswers(); for
				 * (ConceptAnswer c : allMajorOTProcedures) {
				 * id2.add(c.getAnswerConcept().getId()); } }
				 */

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
					/*
					 * if (id.contains(conId)) { SimpleDateFormat sdf = new
					 * SimpleDateFormat( "dd/MM/yyyy"); Date scheduleDate =
					 * sdf.parse(OTscheduleDate);
					 * opdTestOrder.setScheduleDate(scheduleDate); }
					 * 
					 * if (id2.contains(conId)) { SimpleDateFormat sdf = new
					 * SimpleDateFormat( "dd/MM/yyyy"); Date scheduleDate =
					 * sdf.parse(OTscheduleDate);
					 * opdTestOrder.setScheduleDate(scheduleDate); }
					 */
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
				/*
				 * Concept concept = Context.getConceptService().getConcept(
				 * "MINOR OPERATION"); Collection<ConceptAnswer>
				 * allMinorOTProcedures = null; List<Integer> id = new
				 * ArrayList<Integer>(); if (concept != null) {
				 * allMinorOTProcedures = concept.getAnswers(); for
				 * (ConceptAnswer c : allMinorOTProcedures) {
				 * id.add(c.getAnswerConcept().getId()); } }
				 * 
				 * Concept concept2 = Context.getConceptService().getConcept(
				 * "MAJOR OPERATION"); Collection<ConceptAnswer>
				 * allMajorOTProcedures = null; List<Integer> id2 = new
				 * ArrayList<Integer>(); if (concept2 != null) {
				 * allMajorOTProcedures = concept2.getAnswers(); for
				 * (ConceptAnswer c : allMajorOTProcedures) {
				 * id2.add(c.getAnswerConcept().getId()); } }
				 */

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

					/*
					 * conId = conceptService.getConcept(pId).getId(); if
					 * (id.contains(conId)) { SimpleDateFormat sdf = new
					 * SimpleDateFormat( "dd/MM/yyyy"); Date scheduleDate =
					 * sdf.parse(OTscheduleDate);
					 * opdTestOrder.setScheduleDate(scheduleDate); }
					 * 
					 * if (id2.contains(conId)) { SimpleDateFormat sdf = new
					 * SimpleDateFormat( "dd/MM/yyyy"); Date scheduleDate =
					 * sdf.parse(OTscheduleDate);
					 * opdTestOrder.setScheduleDate(scheduleDate); }
					 */
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
					//opdTestOrder.setScheduleDate(date);
					patientDashboardService.saveOrUpdateOpdOrder(opdTestOrder);
				}
			}

		}

		// send pharmacy orders to issue drugs to a patient from dashboard
		Integer formulationId;
		Integer frequencyId;
		Integer noOfDays;
		String comments;
		if (drugOrder != null) {
			for (String drugName : drugOrder) {String arr[]=drugName.split("\\+");
				InventoryCommonService inventoryCommonService = Context
						.getService(InventoryCommonService.class);
				InventoryDrug inventoryDrug = inventoryCommonService
						.getDrugByName(arr[0]);
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
					patientDashboardService
							.saveOrUpdateOpdDrugOrder(opdDrugOrder);
				}
			}
		}

		return "redirect:/module/patientqueue/main.htm?opdId="
				+ opdPatientLog.getOpdConcept().getId();

	}

}
