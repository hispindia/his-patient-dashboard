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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.GlobalProperty;
import org.openmrs.Location;
import org.openmrs.Obs;
import org.openmrs.Patient;
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
import org.openmrs.module.hospitalcore.model.InventoryDrug;
import org.openmrs.module.hospitalcore.model.InventoryDrugFormulation;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmission;
import org.openmrs.module.hospitalcore.model.OpdDrugOrder;
import org.openmrs.module.hospitalcore.model.OpdTestOrder;
import org.openmrs.module.hospitalcore.model.OpdPatientQueue;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.hospitalcore.model.PatientSearch;
import org.openmrs.module.hospitalcore.model.TriagePatientData;
import org.openmrs.module.hospitalcore.util.ConceptComparator;
import org.openmrs.module.hospitalcore.util.HospitalCoreConstants;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
@Controller("OPDEntryController")
@RequestMapping("/module/patientdashboard/opdEntry.htm")
public class OPDEntryController {

	@RequestMapping(method=RequestMethod.GET)
	public String firstView(@ModelAttribute("opdCommand") OPDEntryCommand command,
			@RequestParam("patientId") Integer patientId, 
			@RequestParam("opdId") Integer opdId ,
			@RequestParam(value="queueId" ,required=false) Integer queueId ,
			@RequestParam("referralId") Integer referralId, Model model){
		
		Concept opdWardConcept = Context.getConceptService().getConceptByName(Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_OPDWARD));
		model.addAttribute("listInternalReferral", opdWardConcept!= null ?  new ArrayList<ConceptAnswer>(opdWardConcept.getAnswers()) : null);
		Concept hospitalConcept = Context.getConceptService().getConceptByName(Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_HOSPITAL));
		model.addAttribute("listExternalReferral", hospitalConcept!= null ?  new ArrayList<ConceptAnswer>(hospitalConcept.getAnswers()) : null);
		model.addAttribute("patientId", patientId );
		IpdService ipds = (IpdService) Context.getService(IpdService.class);
		model.addAttribute("queueId", queueId);
		model.addAttribute("admitted", ipds.getAdmittedByPatientId(patientId));
		Concept ipdConcept = Context.getConceptService().getConceptByName(Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_IPDWARD));
		model.addAttribute("listIpd", ipdConcept!= null ?  new ArrayList<ConceptAnswer>(ipdConcept.getAnswers()) : null);
		
		PatientDashboardService patientDashboardService = Context.getService(PatientDashboardService.class);
		InventoryCommonService inventoryCommonService = Context.getService(InventoryCommonService.class);
		Concept opdConcept =  Context.getConceptService().getConcept(opdId);
		/*
		//list diagnosis need rewrtie CHUYEN
		List<Concept> diagnosis = new ArrayList<Concept>(patientDashboardService.listDiagnosisByOpd(opdId));
		if(!CollectionUtils.isEmpty(diagnosis)){
			Collections.sort(diagnosis, new ConceptComparator());
		}*/
		List<Concept> diagnosisList = patientDashboardService.listByDepartmentByWard(opdId, DepartmentConcept.TYPES[0]);
		if(CollectionUtils.isNotEmpty(diagnosisList)){
			Collections.sort(diagnosisList, new ConceptComparator());
		}
		model.addAttribute("diagnosisList", diagnosisList);
		
		//model.addAttribute("listDiagnosis", diagnosis);
		List<Concept> procedures = patientDashboardService.listByDepartmentByWard(opdId, DepartmentConcept.TYPES[1]);
		if(CollectionUtils.isNotEmpty(procedures)){
			Collections.sort(procedures, new ConceptComparator());
		}
		model.addAttribute("listProcedures", procedures);
		
		//ghanshyam 1-june-2013 New Requirement #1633 User must be able to send investigation orders from dashboard to billing
		List<Concept> investigations = patientDashboardService.listByDepartmentByWard(opdId, DepartmentConcept.TYPES[2]);
		if(CollectionUtils.isNotEmpty(investigations)){
			Collections.sort(investigations, new ConceptComparator());
		}
		model.addAttribute("listInvestigations", investigations);
		
		//ghanshyam 12-june-2013 New Requirement #1635 User should be able to send pharmacy orders to issue drugs to a patient from dashboard
		List<Concept> drugFrequencyConcept= inventoryCommonService.getDrugFrequency();
		model.addAttribute("drugFrequencyList", drugFrequencyConcept);
		
		model.addAttribute("opd", opdConcept);
		model.addAttribute("referral", Context.getConceptService().getConcept(referralId));
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
		OpdPatientQueue opdPatientQueue=queueService.getOpdPatientQueueById(queueId);
		SimpleDateFormat formatterExt = new SimpleDateFormat("dd-MM-yyyy");
		TriagePatientData triagePatientData=opdPatientQueue.getTriageDataId();
		if(triagePatientData!=null){
		Date dat=triagePatientData.getLastMenstrualDate();
		if(dat!=null){
		String da = formatterExt.format(dat);
		model.addAttribute("da", da);
		 }
		}
		model.addAttribute("opdPatientQueue", opdPatientQueue);
		
		return "module/patientdashboard/opdEntry";
	}
	@RequestMapping(method=RequestMethod.POST)
	public String formSummit(OPDEntryCommand command,
			HttpServletRequest request,
			@RequestParam(value="drugOrder",required=false) String[] drugOrder) throws Exception{
		User user =Context.getAuthenticatedUser();
		PatientService ps = Context.getPatientService();
		HospitalCoreService hcs = (HospitalCoreService) Context.getService(HospitalCoreService.class);
		Patient patient = ps.getPatient(command.getPatientId());
		PatientSearch patientSearch = hcs.getPatient(command.getPatientId());
		
		// harsh 14/6/2012 setting death date to today's date and dead variable to true when "died" is selected
		if (StringUtils.equalsIgnoreCase(command.getRadio_f(), "died")){
			
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
		//create obs group only for internal referral and admit
		Obs obsGroup = null;
		obsGroup = hcs.getObsGroupCurrentDate(patient.getPersonId());
		/*
		if(StringUtils.equalsIgnoreCase(command.getRadio_f(), "admit") || (command.getInternalReferral() != null && command.getInternalReferral() > 0)){
			if(obsGroup == null){
				obsGroup = hcs.createObsGroup(patient, HospitalCoreConstants.PROPERTY_OBSGROUP);
			}
		}
		*/
		
		
		//===================Comment this if we want to save===========================
		/*if(true){
			return "redirect:/module/patientdashboard/main.htm?patientId="+command.getPatientId();
		}*/
		//===================End Comment this if we want to save===========================
		AdministrationService administrationService = Context.getAdministrationService();
		
		/**
		 * Save opd info
		 * 1. Get OPD Encounter type
		 * 2. Create encounter
		 * 3. Create Obs for each of those concept : diagnosis, procedure, internal referral, external referral, outcome 
		 * 4. Get value from the submmited from, set them to corresponding obs
		 * 5. Set all obs to encoutner
		 * 6. Save encounter
		 */
		
		GlobalProperty gpOPDEncounterType = administrationService.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_OPD_ENCOUTNER_TYPE);
		EncounterType encounterType = Context.getEncounterService().getEncounterType(gpOPDEncounterType.getPropertyValue());
		Encounter encounter = new Encounter();
		Location location = new Location( 1 );
		encounter.setPatient(patient);
		encounter.setCreator( user);
		encounter.setProvider(user );
		encounter.setEncounterDatetime( date);
		encounter.setEncounterType(encounterType);
		encounter.setLocation( location );
		
		ConceptService conceptService = Context.getConceptService();
		GlobalProperty gpDiagnosis = administrationService.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
		GlobalProperty procedure = administrationService.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		//ghanshyam 1-june-2013 New Requirement #1633 User must be able to send investigation orders from dashboard to billing
		GlobalProperty investigationn = administrationService.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_FOR_INVESTIGATION);
		GlobalProperty internalReferral = administrationService.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL);
		GlobalProperty externalReferral = administrationService.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_EXTERNAL_REFERRAL);
		
		Concept cDiagnosis = conceptService.getConceptByName(gpDiagnosis.getPropertyValue());
		//ghanshyam 8-july-2013 New Requirement #1963 Redesign patient dashboard
		Concept cOtherInstructions = conceptService.getConceptByName("OTHER INSTRUCTIONS");
		Concept illnessHistory = conceptService.getConceptByName("History of Present Illness");
		
		if( cDiagnosis == null ){
			throw new Exception("Diagnosis concept null");
		}
		//diagnosis
		for( Integer cId : command.getSelectedDiagnosisList()){
			Obs obsDiagnosis = new Obs();
			obsDiagnosis.setObsGroup(obsGroup);
			obsDiagnosis.setConcept(cDiagnosis);
			obsDiagnosis.setValueCoded(conceptService.getConcept(cId));
			obsDiagnosis.setCreator(user );
			obsDiagnosis.setDateCreated(date);
			obsDiagnosis.setEncounter(encounter);
			obsDiagnosis.setPatient(patient);
			encounter.addObs(obsDiagnosis);
		}
		//note
		if(StringUtils.isNotBlank(command.getNote())){
			
			Obs obsDiagnosis = new Obs();
			obsDiagnosis.setObsGroup(obsGroup);
			//ghanshyam 8-july-2013 New Requirement #1963 Redesign patient dashboard
			obsDiagnosis.setConcept(cOtherInstructions);
			obsDiagnosis.setValueText(command.getNote());
			obsDiagnosis.setCreator(user );
			obsDiagnosis.setDateCreated(date);
			obsDiagnosis.setEncounter(encounter);
			obsDiagnosis.setPatient(patient);
			encounter.addObs(obsDiagnosis);
		}
		
		//illness history
		if(StringUtils.isNotBlank(command.getHistory())){
			
			Obs obsDiagnosis = new Obs();
			obsDiagnosis.setObsGroup(obsGroup);
			//ghanshyam 8-july-2013 New Requirement #1963 Redesign patient dashboard
			obsDiagnosis.setConcept(illnessHistory);
			obsDiagnosis.setValueText(command.getHistory());
			obsDiagnosis.setCreator(user );
			obsDiagnosis.setDateCreated(date);
			obsDiagnosis.setEncounter(encounter);
			obsDiagnosis.setPatient(patient);
			encounter.addObs(obsDiagnosis);
		}
		
		
		//procedure
		if(!ArrayUtils.isEmpty(command.getSelectedProcedureList())){
			Concept pDiagnosis = conceptService.getConceptByName(procedure.getPropertyValue());
			if( pDiagnosis == null ){
				throw new Exception("Post for procedure concept null");
			}
			for( Integer pId : command.getSelectedProcedureList()){
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
		
		//ghanshyam 1-june-2013 New Requirement #1633 User must be able to send investigation orders from dashboard to billing
		//investigation
		if(!ArrayUtils.isEmpty(command.getSelectedInvestigationList())){
			Concept coninvt= conceptService.getConceptByName(investigationn.getPropertyValue());
			if( coninvt == null ){
				throw new Exception("Investigation concept null");
			}
			for( Integer pId : command.getSelectedInvestigationList()){
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
		
		//internal referral
//		System.out.println("command.getInternalReferral(): "+command.getInternalReferral());
		if(command.getInternalReferral() != null && command.getInternalReferral() > 0){
			Concept cInternalReferral = conceptService.getConceptByName(internalReferral.getPropertyValue());
			if( cInternalReferral == null ){
				throw new Exception("InternalReferral concept null");
			}
			
			Concept internalReferralConcept = conceptService.getConcept(command.getInternalReferral());
			Obs obsInternalReferral = new Obs();
			obsInternalReferral.setObsGroup(obsGroup);
			obsInternalReferral.setConcept(cInternalReferral);
			obsInternalReferral.setValueCoded(internalReferralConcept);
			obsInternalReferral.setCreator(user );
			obsInternalReferral.setDateCreated(date);
			obsInternalReferral.setEncounter(encounter);
			obsInternalReferral.setPatient(patient);
			encounter.addObs(obsInternalReferral);
			
			
			Concept currentOpd =conceptService.getConcept(command.getOpdId());
			
			// add this patient to the queue of the referral OPD
			OpdPatientQueue queue = new OpdPatientQueue();
	        queue.setPatient(patient);
	        queue.setCreatedOn(date);
	        queue.setBirthDate(patient.getBirthdate());
	        queue.setPatientIdentifier(patient.getPatientIdentifier().getIdentifier());
	        queue.setOpdConcept(internalReferralConcept);
	        queue.setOpdConceptName(internalReferralConcept.getName().getName());
	        if(patient.getMiddleName()!=null){
	        queue.setPatientName(patient.getGivenName()+" "+patient.getMiddleName() + " "+ patient.getFamilyName());
	        }
	        else{
	        	queue.setPatientName(patient.getGivenName()+" "+ patient.getFamilyName());	        	
	        }
	        queue.setReferralConcept(currentOpd);
	        queue.setReferralConceptName(currentOpd.getName().getName());
	        queue.setSex(patient.getGender());
	        queue.setTriageDataId(null);
	        PatientQueueService queueService = Context.getService(PatientQueueService.class);
	        queueService.saveOpdPatientQueue(queue);
			
		}
		
		//external referral
//		System.out.println("command.getExternalReferral(): "+command.getExternalReferral());
		if(command.getExternalReferral()!= null && command.getExternalReferral() > 0 ){
		Concept cExternalReferral = conceptService.getConceptByName(externalReferral.getPropertyValue());
		if( cExternalReferral == null ){
			throw new Exception("ExternalReferral concept null");
		}
		Obs obsExternalReferral = new Obs();
		obsExternalReferral.setObsGroup(obsGroup);
		obsExternalReferral.setConcept(cExternalReferral);
		obsExternalReferral.setValueCoded(conceptService.getConcept(command.getExternalReferral()));
		obsExternalReferral.setCreator(user );
		obsExternalReferral.setDateCreated(date);
		obsExternalReferral.setEncounter(encounter);
		obsExternalReferral.setPatient(patient);
		encounter.addObs(obsExternalReferral);
		}
		
		
		// TODO : out come 
		
		Concept cOutcome = conceptService.getConceptByName(administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_VISIT_OUTCOME));
		if( cOutcome == null ){
			throw new Exception("Visit Outcome concept =  null");
		}
		Obs obsOutcome = new Obs();
		obsOutcome.setObsGroup(obsGroup);
		obsOutcome.setConcept(cOutcome);
		
		try {
			obsOutcome.setValueText(command.getRadio_f());
			//TODO if
			if(StringUtils.equalsIgnoreCase(command.getRadio_f(), "Follow-up")){
				obsOutcome.setValueDatetime(Context.getDateFormat().parse(command.getDateFollowUp()));
			}
			
			if(StringUtils.equalsIgnoreCase(command.getRadio_f(), "admit")){
				//System.out.println("command.getIpdWard(): "+command.getIpdWard());
				obsOutcome.setValueCoded(conceptService.getConcept(command.getIpdWard()));
				//Get ipd ward that patient come .
				/*
				Concept ipdWard = conceptService.getConceptByName(administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_IPDWARD));
				System.out.println("ipdWard: "+ipdWard);
				if( ipdWard == null ){
					throw new Exception("Ipd ward concept =  null");
				}
				Obs obsIpdWard = new Obs();
				obsIpdWard.setConcept(ipdWard);
				obsIpdWard.setValueCoded(conceptService.getConcept(command.getIpdWard()));
				obsIpdWard.setCreator(user );
				obsIpdWard.setDateCreated(new Date());
				obsIpdWard.setPatient(patient);
				obsIpdWard.setEncounter(encounter);
				encounter.addObs(obsIpdWard);*/
				//call service from ipd queue and add this patient to ipd queue
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}

		obsOutcome.setCreator(user );
		obsOutcome.setDateCreated(date);
		obsOutcome.setPatient(patient);
		obsOutcome.setEncounter(encounter);
		encounter.addObs(obsOutcome);
		Context.getEncounterService().saveEncounter(encounter);
		
		
		//delele opd queue , create opd log queue
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
		OpdPatientQueue queue = queueService.getOpdPatientQueueById(command.getQueueId());
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
        if(queue.getTriageDataId()!=null){
        queueLog.setTriageDataId(queue.getTriageDataId());
        }
        else{
        queueLog.setTriageDataId(null);	
        }
        OpdPatientQueueLog opdPatientLog = queueService.saveOpdPatientQueueLog(queueLog);
        queueService.deleteOpdPatientQueue(queue);
        //done queue
		
		if(StringUtils.equalsIgnoreCase(command.getRadio_f(), "admit")){
			
			IpdService  ipdService = (IpdService)Context.getService(IpdService.class);
			IpdPatientAdmission patientAdmission = new IpdPatientAdmission();
			patientAdmission.setAdmissionDate(date);
			patientAdmission.setAdmissionWard(conceptService.getConcept(command.getIpdWard()));
			patientAdmission.setBirthDate(patient.getBirthdate());
			patientAdmission.setGender(patient.getGender());
			patientAdmission.setOpdAmittedUser(user);
			patientAdmission.setOpdLog(opdPatientLog);
			patientAdmission.setPatient(patient);
			patientAdmission.setPatientIdentifier(patient.getPatientIdentifier().getIdentifier());
			if(patient.getMiddleName()!=null){
			patientAdmission.setPatientName(patient.getGivenName()+" "+patient.getMiddleName() + " "+ patient.getFamilyName());
			}
			else{
				patientAdmission.setPatientName(patient.getGivenName()+" "+ patient.getFamilyName());
			}
			patientAdmission = ipdService.saveIpdPatientAdmission(patientAdmission);
		}
		
		//ghanshyam 1-june-2013 New Requirement #1633 User must be able to send investigation orders from dashboard to billing
		//procedure
		PatientDashboardService patientDashboardService = Context.getService(PatientDashboardService.class);
		if(!ArrayUtils.isEmpty(command.getSelectedProcedureList())){
			Concept conpro = conceptService.getConceptByName(procedure.getPropertyValue());
			if( conpro == null ){
				throw new Exception("Post for procedure concept null");
			}
			for( Integer pId : command.getSelectedProcedureList()){
				BillingService billingService = Context.getService(BillingService.class);
				BillableService billableService = billingService.getServiceByConceptId(pId);
				OpdTestOrder opdTestOrder = new OpdTestOrder();
				opdTestOrder.setPatient(patient);
				opdTestOrder.setEncounter(encounter);
				opdTestOrder.setConcept(conpro);
				opdTestOrder.setTypeConcept(DepartmentConcept.TYPES[1]);
				opdTestOrder.setValueCoded(conceptService.getConcept(pId));
				opdTestOrder.setCreator(user);
				opdTestOrder.setCreatedOn(date);
				opdTestOrder.setBillableService(billableService);
				patientDashboardService.saveOrUpdateOpdOrder(opdTestOrder);
			}
		
		}
		//investigation
		if(!ArrayUtils.isEmpty(command.getSelectedInvestigationList())){
			Concept coninvt= conceptService.getConceptByName(investigationn.getPropertyValue());
			if( coninvt == null ){
				throw new Exception("Investigation concept null");
			}
			for( Integer iId : command.getSelectedInvestigationList()){
				BillingService billingService = Context.getService(BillingService.class);
				BillableService billableService = billingService.getServiceByConceptId(iId);
				OpdTestOrder opdTestOrder = new OpdTestOrder();
				opdTestOrder.setPatient(patient);
				opdTestOrder.setEncounter(encounter);
				opdTestOrder.setConcept(coninvt);
				opdTestOrder.setTypeConcept(DepartmentConcept.TYPES[2]);
				opdTestOrder.setValueCoded(conceptService.getConcept(iId));
				opdTestOrder.setCreator(user);
				opdTestOrder.setCreatedOn(date);
				opdTestOrder.setBillableService(billableService);
				patientDashboardService.saveOrUpdateOpdOrder(opdTestOrder);
			}
		
		}
		
		// ghanshyam 12-june-2013 New Requirement #1635 User should be able to send pharmacy orders to issue drugs to a patient from dashboard
		Integer formulationId;
		Integer frequencyId;
		Integer noOfDays;
		String comments;
		if(drugOrder!=null){
		for (String drugName : drugOrder) {
			InventoryCommonService inventoryCommonService = Context.getService(InventoryCommonService.class);
			InventoryDrug inventoryDrug = inventoryCommonService.getDrugByName(drugName);
			if(inventoryDrug!=null){
			formulationId = Integer.parseInt(request.getParameter(drugName
					+ "_formulationId"));
			frequencyId = Integer.parseInt(request.getParameter(drugName
					+ "_frequencyId"));
			noOfDays = Integer.parseInt(request.getParameter(drugName
					+ "_noOfDays"));
			comments = request.getParameter(drugName + "_comments");
			InventoryDrugFormulation inventoryDrugFormulation = inventoryCommonService.getDrugFormulationById(formulationId);
			Concept freCon = conceptService.getConcept(frequencyId);
			
			OpdDrugOrder opdDrugOrder = new OpdDrugOrder();
			opdDrugOrder.setPatient(patient);
			opdDrugOrder.setEncounter(encounter);
			opdDrugOrder.setInventoryDrug(inventoryDrug);
			opdDrugOrder.setInventoryDrugFormulation(inventoryDrugFormulation);
			opdDrugOrder.setFrequency(freCon);
			opdDrugOrder.setNoOfDays(noOfDays);
			opdDrugOrder.setComments(comments);
			opdDrugOrder.setCreator(user);
			opdDrugOrder.setCreatedOn(date);
			patientDashboardService.saveOrUpdateOpdDrugOrder(opdDrugOrder);
			}
		  }
		}
		
		return "redirect:/module/patientqueue/main.htm?opdId="+opdPatientLog.getOpdConcept().getId();
		
	}
	
	
	
	
}
