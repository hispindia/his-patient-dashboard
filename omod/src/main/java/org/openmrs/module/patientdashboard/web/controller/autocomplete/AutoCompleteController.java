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


package org.openmrs.module.patientdashboard.web.controller.autocomplete;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Concept;
import org.openmrs.Drug;
import org.openmrs.Encounter;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.Person;
import org.openmrs.PersonAttribute;
import org.openmrs.PersonAttributeType;
import org.openmrs.User;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.EncounterService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.InventoryCommonService;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.PatientQueueService;
import org.openmrs.module.hospitalcore.model.InventoryDrug;
import org.openmrs.module.hospitalcore.model.InventoryDrugFormulation;
import org.openmrs.module.hospitalcore.model.OpdDrugOrder;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * <p> Class: AutoCompleteController </p>
 * <p> Package: org.openmrs.module.patientdashboard.web.controller.autocomplete </p> 
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Jan 26, 2011 5:15:41 PM </p>
 * <p> Update date: Jan 26, 2011 5:15:41 PM </p>
 **/
@Controller("AutoCompleteControllerPatientDashboard")
public class AutoCompleteController {
	
	@RequestMapping(value="/module/patientdashboard/autoCompleteDrugCoreList.htm", method=RequestMethod.GET)
	public String drugCoreGet(@RequestParam(value="term",required=false) String name, Model model) {
		List<Drug> drugs = new ArrayList<Drug>();
		if(!StringUtils.isBlank(name)){
			drugs = Context.getConceptService().getDrugs(name);
		}else{
			drugs = Context.getConceptService().getAllDrugs();
		}
			model.addAttribute("drugs",drugs);
		return "module/patientdashboard/autocomplete/autoCompleteDrugCoreList";
	}
	
	@RequestMapping(value="/module/patientdashboard/autoCompleteDrugCoreList.htm", method=RequestMethod.POST)
	public String drugCorePost(@RequestParam(value="term",required=false) String name, Model model) {
		List<Drug> drugs = new ArrayList<Drug>();
		if(!StringUtils.isBlank(name)){
			drugs = Context.getConceptService().getDrugs(name);
		}else{
			drugs = Context.getConceptService().getAllDrugs();
		}
			model.addAttribute("drugs",drugs);
		return "module/patientdashboard/autocomplete/autoCompleteDrugCoreList";
	}
	@RequestMapping("/module/patientdashboard/checkSession.htm")
	public String checkSession(HttpServletRequest request,Model model) {
		 if( Context.getAuthenticatedUser() != null &&  Context.getAuthenticatedUser().getId() != null){
			 model.addAttribute("session","1");
		 }else{
			 model.addAttribute("session","0");
		 }
		
		return "module/patientdashboard/session/checkSession";
	}
	@RequestMapping(value="/module/patientdashboard/vitalStatistic.htm", method=RequestMethod.GET)
	public String vitalStatistic(@RequestParam(value="id",required=false) Integer id, Model model) {
		if(id != null){
			PatientDashboardService dashboardService =  Context.getService(PatientDashboardService.class);
			EncounterService encounterService = Context.getEncounterService();
			Encounter encounter =encounterService.getEncounter(id);
			OpdPatientQueueLog opdPatientQueueLog=dashboardService.getOpdPatientQueueLog(encounter);
			Patient patient = opdPatientQueueLog.getPatient();
			PatientQueueService queueService = Context
					.getService(PatientQueueService.class);
			if (opdPatientQueueLog != null) {
				
				
				Obs weight=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patient.getPatientId()),Context.getConceptService().getConcept("WEIGHT"),encounter);
				if(weight!=null)
				{	model.addAttribute("weight", weight.getValueNumeric().intValue());
				
				}
				else
				{
					model.addAttribute("weight", "");
				}
				Obs height=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patient.getPatientId()),Context.getConceptService().getConcept("HEIGHT"),encounter);
				if(height!=null)
				{	
					model.addAttribute("height", height.getValueNumeric().intValue());
				
				}
				else
				{
					model.addAttribute("height", "");
				}
				
				if(weight!=null && height!=null)
				{	Obs bmi=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patient.getPatientId()),Context.getConceptService().getConcept("BMI"),encounter);
				  if(bmi!=null)	
				  {
					  model.addAttribute("bmi", Math.round(bmi.getValueNumeric()));
				  }
				  else
				  {
					  model.addAttribute("bmi", "");
				  }
				
				}
				else
				{
					model.addAttribute("bmi", "");
				}
				Obs temperature=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patient.getPatientId()),Context.getConceptService().getConcept("TEMPERATURE"),encounter);
				if(temperature!=null)
				{	
					model.addAttribute("temp", temperature.getValueNumeric());
				
				}
				else
				{
					model.addAttribute("temp", "");
				}
				Obs dbp=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patient.getPatientId()),Context.getConceptService().getConcept("DAISTOLIC BLOOD PRESSURE"),encounter);
				if(dbp!=null)
				{	model.addAttribute("dbp", dbp.getValueNumeric().intValue());
				
				}
				else
				{
					model.addAttribute("dbp", "");
				}
				Obs sbp=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patient.getPatientId()),Context.getConceptService().getConcept("SYSTOLIC BLOOD PRESSURE"),encounter);
				if(sbp!=null)
				{	model.addAttribute("sbp", sbp.getValueNumeric().intValue());
				
				}
				else
				{
					model.addAttribute("sbp", "");
				}
				Obs pulserate=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patient.getPatientId()),Context.getConceptService().getConcept("PULSE RATE"),encounter);
				if(pulserate!=null)
				{	model.addAttribute("pulserate", pulserate.getValueNumeric().intValue());
				
				}
				else
				{
					model.addAttribute("pulserate", "");
				}
				Obs lastmenstrualperiod=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patient.getPatientId()),Context.getConceptService().getConcept("LAST MENSTRUAL PERIOD"),encounter);
				if(lastmenstrualperiod!=null)
				{	SimpleDateFormat formatterExt = new SimpleDateFormat("dd/MM/yyyy");
				 String lmpdate = formatterExt.format(lastmenstrualperiod.getValueDatetime());
				
				
					model.addAttribute("lmp",lmpdate );
				
					
				
				}
				else
				{
					model.addAttribute("lmp", "");
				}
				}
			}
		
		return "module/patientdashboard/vitalStatistic";
	}
	@RequestMapping(value="/module/patientdashboard/autoCompleteProvisionalDianosis.htm", method=RequestMethod.GET)
	public String provisionalDianosis(@RequestParam(value="term",required=false) String name, Model model) {
		List<Concept> diagnosis = new ArrayList<Concept>();
		PatientDashboardService dashboardService = Context.getService(PatientDashboardService.class);
		diagnosis = dashboardService.searchDiagnosis(name);
		model.addAttribute("diagnosis", diagnosis);
		
		return "/module/patientdashboard/autocomplete/autoCompleteProvisionalDianosis";
	}
	
	@RequestMapping(value="/module/patientdashboard/comboboxProcedure.htm", method=RequestMethod.GET)
	public String comboboxProcedure(@RequestParam(value="text",required=false) String text, Model model) {
		List<Concept> procedures = new ArrayList<Concept>();
		PatientDashboardService dashboardService = Context.getService(PatientDashboardService.class);
		procedures = dashboardService.searchProcedure(text);
		model.addAttribute("procedures", procedures);
		return "module/patientdashboard/autocomplete/comboboxProcedure";
	}
	@RequestMapping(value="/module/patientdashboard/comboboxDianosis.htm", method=RequestMethod.GET)
	public String comboboxDianosis(@RequestParam(value="text",required=false) String text, Model model) {
		List<Concept> diagnosis = new ArrayList<Concept>();
		PatientDashboardService dashboardService = Context.getService(PatientDashboardService.class);
		diagnosis = dashboardService.searchDiagnosis(text);
		model.addAttribute("diagnosis", diagnosis);
		return "/module/patientdashboard/autocomplete/comboboxDianosis";
	}
	
	@RequestMapping(value="/module/patientdashboard/comboboxInvestigation.htm", method=RequestMethod.GET)
	public String comboboxInvestigation(@RequestParam(value="text",required=false) String text, Model model) {
		List<Concept> investigation = new ArrayList<Concept>();
		PatientDashboardService dashboardService = Context.getService(PatientDashboardService.class);
		investigation = dashboardService.searchInvestigation(text);
		model.addAttribute("investigation", investigation);
		return "/module/patientdashboard/autocomplete/comboboxInvestigation";
	}
	
	@RequestMapping(value="/module/patientdashboard/comboboxDrug.htm", method=RequestMethod.GET)
	public String comboboxDrug(@RequestParam(value="text",required=false) String text, Model model) {
		List<InventoryDrug> drugs = new ArrayList<InventoryDrug>();
		PatientDashboardService dashboardService = Context.getService(PatientDashboardService.class);
		drugs = dashboardService.findDrug(text);
		model.addAttribute("drugs", drugs);
		return "/module/patientdashboard/autocomplete/comboboxDrug";
	}
	
	@RequestMapping(value="/module/patientdashboard/detailClinical.htm", method=RequestMethod.GET)
	public String detailClinical(@RequestParam(value="id",required=false) Integer id, Model model) {
		if(id != null){
			
			 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			 ConceptService conceptService = Context.getConceptService();
			
			EncounterService encounterService = Context.getEncounterService();
			AdministrationService administrationService = Context.getAdministrationService();
			PatientDashboardService patientDashboardService = Context
				.getService(PatientDashboardService.class);
			String gpVisiteOutCome = administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_VISIT_OUTCOME);
			Encounter encounter =encounterService.getEncounter(id);
			String internal = "";
			String external = "";
			String visitOutCome = "";
			String followUpDate = "";
			String ipdAdmissionWard = "";
			String otherInstructions = "";
			String illnessHistory = "";
			
			Concept conInternal = Context.getConceptService().getConceptByName(Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL));
			Concept conExternal = Context.getConceptService().getConceptByName(Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_EXTERNAL_REFERRAL));
			Concept conVisiteOutCome  = conceptService.getConcept(gpVisiteOutCome);
			Concept conIllnessHistory = conceptService.getConceptByName("HISTORY OF PRESENT ILLNESS");
			Concept conOtherInstructions = conceptService.getConceptByName("OTHER INSTRUCTIONS");
			
			List<Concept> pdiagnosiss = new ArrayList<Concept>();
			List<Concept> fdiagnosiss = new ArrayList<Concept>();
			List<Concept> procedures = new ArrayList<Concept>();
			List<Concept> investigations = new ArrayList<Concept>();
			try {
				if(encounter != null){
					for( Obs obs : encounter.getAllObs()){
						if( obs.getConcept().getConceptId().equals(conInternal.getConceptId()) ){
							internal = obs.getValueCoded().getName()+"";
						}
						if( obs.getConcept().getConceptId().equals(conExternal.getConceptId()) ){
							external = obs.getValueCoded().getName()+"";
						}
						if( obs.getConcept().getConceptId().equals(conVisiteOutCome.getConceptId()) ){
							visitOutCome = obs.getValueText();
							if("Follow-up".equalsIgnoreCase(visitOutCome)){
								try {
									followUpDate = formatter.format(obs.getValueDatetime());
								} catch (Exception e) {
									// TODO: handle exception
									e.printStackTrace();
								}
								
							}else if("Admit".equalsIgnoreCase(visitOutCome)){
								if(obs.getValueCoded() != null){
									
									try {
										ipdAdmissionWard = obs.getValueCoded().getName() + "";
									} catch (Exception e) {
										// TODO: handle exception
										e.printStackTrace();
									}
								}
							}
						}
						
						if( obs.getConcept().getConceptId().equals(conOtherInstructions.getConceptId()) ){
							otherInstructions = obs.getValueText();
						}

						if( obs.getConcept().getConceptId().equals(conIllnessHistory.getConceptId()) ){
							illnessHistory = obs.getValueText();
						}
						
						if (obs.getValueCoded() != null) {
						/*	if (obs.getValueCoded().getConceptClass().getName().equals("Diagnosis")) {
								diagnosiss.add(obs.getValueCoded());
							}*/
							if (obs.getValueCoded().getConceptClass().getName().equals("Procedure")) {
								procedures.add(obs.getValueCoded());
							}
							if (obs.getValueCoded().getConceptClass().getName().equals("Test")) {
								investigations.add(obs.getValueCoded());
							}
							if (obs.getValueCoded().getConceptClass().getName()
									.equals("LabSet")) {
								investigations.add(obs.getValueCoded());
							}
							//New Requirement "Final & Provisional Diagnosis" //
							if (obs.getValueCoded().getConceptClass().getName().equals("Diagnosis")&&(obs.getConcept().isNamed("Provisional diagnosis"))) {
								pdiagnosiss.add(obs.getValueCoded());
								
							}
							if (obs.getValueCoded().getConceptClass().getName().equals("Diagnosis")&&(obs.getConcept().isNamed("FINAL DIAGNOSIS"))) {
								fdiagnosiss.add(obs.getValueCoded());
								
							}
						}

					}
					
					
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			OpdPatientQueueLog opql=patientDashboardService.getOpdPatientQueueLog(encounter);
			Patient patient = opql.getPatient();
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
			model.addAttribute("ageCategory", PatientUtils.estimateAgeCategory(birthday));
			
			User user=opql.getUser();
			Person person=user.getPerson();
			String givenName=person.getGivenName();
			String middleName=person.getMiddleName();
			String familyName=person.getFamilyName();
			
			if(givenName==null){
				givenName="";
			}
			if(middleName==null){
				middleName="";
			}
			if(familyName==null){
				familyName="";
			}
		
			String treatingDoctor=givenName+" "+middleName+" "+familyName;
			
			HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
			List<PersonAttribute> pas = hcs.getPersonAttributes(patient.getPatientId());
			for (PersonAttribute pa : pas) {
				PersonAttributeType attributeType = pa.getAttributeType();
				if (attributeType.getPersonAttributeTypeId() == 14) {
					model.addAttribute("selectedCategory", pa.getValue());
				}
			}
			
			List<OpdDrugOrder> opdDrugOrders=patientDashboardService.getOpdDrugOrder(encounter);
			
			model.addAttribute("treatingDoctor", treatingDoctor);
			model.addAttribute("internal", internal);
			model.addAttribute("external", external);
			model.addAttribute("visitOutCome", visitOutCome);
			model.addAttribute("followUpDate", followUpDate);
			model.addAttribute("ipdAdmissionWard", ipdAdmissionWard);
			model.addAttribute("otherInstructions", otherInstructions);
			model.addAttribute("illnessHistory", illnessHistory);
			model.addAttribute("pdiagnosiss", pdiagnosiss);
			model.addAttribute("fdiagnosiss", fdiagnosiss);
			model.addAttribute("procedures", procedures);
			model.addAttribute("investigations", investigations);
			model.addAttribute("opdDrugOrders", opdDrugOrders);
			model.addAttribute("opdConceptName", opql.getOpdConceptName());
			model.addAttribute("encounterId", id);
			
			SimpleDateFormat sdf = new SimpleDateFormat("EEE dd/MM/yyyy hh:mm a");
			model.addAttribute("dateOfVisit", sdf.format(opql.getCreatedOn()));
			
		}
		return "module/patientdashboard/detailClinical";
	}
	
	@RequestMapping(value="/module/patientdashboard/autoCompleteDiagnosis.htm", method=RequestMethod.GET)
	public String autoCompleteDiagnosis(@RequestParam(value="q",required=false) String name, Model model) {
		List<Concept> diagnosis = Context.getService(PatientDashboardService.class).searchDiagnosis(name);
		model.addAttribute("diagnosis",diagnosis);
		return "module/patientdashboard/autocomplete/autoCompleteDiagnosis";
	}
	
	@RequestMapping(value="/module/patientdashboard/autoCompleteProcedure.htm", method=RequestMethod.GET)
	public String autoCompleteProcedure(@RequestParam(value="q",required=false) String name, Model model) {
		List<Concept> procedures = Context.getService(PatientDashboardService.class).searchProcedure(name);
		
		model.addAttribute("procedures",procedures);
		return "module/patientdashboard/autocomplete/autoCompleteProcedure";
	}
	
	@RequestMapping(value="/module/patientdashboard/autoCompleteInvestigation.htm", method=RequestMethod.GET)
	public String autoCompleteInvestigation(@RequestParam(value="q",required=false) String name, Model model) {
		List<Concept> investigations = Context.getService(PatientDashboardService.class).searchInvestigation(name);
		model.addAttribute("investigations",investigations);
		return "module/patientdashboard/autocomplete/autoCompleteInvestigation";
	}
	
	@RequestMapping(value="/module/patientdashboard/autoCompleteDrug.htm", method=RequestMethod.GET)
	public String autoCompleteDrug(@RequestParam(value="q",required=false) String name, Model model) {
		List<InventoryDrug> drugs = Context.getService(PatientDashboardService.class).findDrug(name);
		model.addAttribute("drugs",drugs);
		return "module/patientdashboard/autocomplete/autoCompleteDrug";
	}
	
	@RequestMapping(value="/module/patientdashboard/formulationByDrugNameForIssue.form",method=RequestMethod.GET)
	public String formulationByDrugNameForIssueDrug(@RequestParam(value="drugName",required=false)String drugName, Model model) {
		InventoryCommonService inventoryCommonService = (InventoryCommonService) Context.getService(InventoryCommonService.class);
		InventoryDrug drug = inventoryCommonService.getDrugByName(drugName);
		if(drug != null){
			List<InventoryDrugFormulation> formulations = new ArrayList<InventoryDrugFormulation>(drug.getFormulations());
			model.addAttribute("formulations", formulations);
			model.addAttribute("drugId", drug.getId());
		}
		return "/module/patientdashboard/autocomplete/formulationByDrugForIssue";
	}
	
}
