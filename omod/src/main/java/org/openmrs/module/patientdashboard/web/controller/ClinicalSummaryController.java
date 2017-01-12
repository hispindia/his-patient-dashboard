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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Concept;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.Location;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("ClinicalSummaryController")
@RequestMapping("/module/patientdashboard/clinicalSummary.htm")
public class ClinicalSummaryController {
	
	@RequestMapping(method=RequestMethod.GET)
	public String firstView(@RequestParam("patientId") Integer patientId,Model model){
		
		PatientDashboardService dashboardService =  Context.getService(PatientDashboardService.class);
        String orderLocationId = "1";
        Location location = Context.getLocationService().getLocation(Integer.parseInt(orderLocationId)) ;
		
        Patient patient = Context.getPatientService().getPatient(patientId);
        
        String gpOPDEncType = Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_OPD_ENCOUTNER_TYPE);
        EncounterType labOPDType = Context.getEncounterService().getEncounterType(gpOPDEncType);
        
        ConceptService conceptService = Context.getConceptService();
        AdministrationService administrationService = Context.getAdministrationService();
        String gpDiagnosis = administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
       Concept cFinalDiagnosis = conceptService.getConcept("FINAL DIAGNOSIS");
        String gpProcedure = administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
        
		//String gpInternalReferral = administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL);
        
		Concept conDiagnosis  = conceptService.getConcept(gpDiagnosis);
		
		Concept conProcedure  = conceptService.getConcept(gpProcedure);
		
		List<Encounter> encounters = dashboardService.getEncounter(patient, location, labOPDType, null);

		//  condiagnosis  
		// 
		// command
		String diagnosis = "";
		String procedure="";
		List<Clinical> clinicalSummaries = new ArrayList<Clinical>();
		for( Encounter enc: encounters ){
			diagnosis = "";
			String note ="";
			procedure="";
			Clinical clinical = new Clinical();
			for( Obs obs : enc.getAllObs()){
				//diagnosis
				if( obs.getConcept().getConceptId().equals(conDiagnosis.getConceptId()) ){
//					obs.getV
					if(obs.getValueCoded() != null){
						diagnosis +=obs.getValueCoded().getName()+", ";
					}
					if(StringUtils.isNotBlank(obs.getValueText())){
						note = "Note: "+obs.getValueText();
					}
					//System.out.println(obs.getva);
			
				}
				//final diagnosis
				if( obs.getConcept().getConceptId().equals(cFinalDiagnosis.getConceptId()) ){
//					obs.getV
					if(obs.getValueCoded() != null){
						diagnosis +=obs.getValueCoded().getName()+", ";
					}
					if(StringUtils.isNotBlank(obs.getValueText())){
						note = "Note: "+obs.getValueText();
					}
					//System.out.println(obs.getva);
			
				}
				//procedure
				if( obs.getConcept().getConceptId().equals(conProcedure.getConceptId()) ){
//					obs.getV
					if(obs.getValueCoded() != null){
						procedure +=obs.getValueCoded().getName()+", ";
					}
					if(StringUtils.isNotBlank(obs.getValueText())){
						procedure +=obs.getValueText()+", ";
					}
				}
			}
			diagnosis += note;
			if( StringUtils.endsWith(diagnosis, ", ")){
				diagnosis = StringUtils.removeEnd(diagnosis, ", ");
			}
			if( StringUtils.endsWith(procedure, ", ")){
				procedure = StringUtils.removeEnd(procedure, ", ");
			}
			
			//${patient.givenName}&nbsp;&nbsp;${patient.middleName}&nbsp;&nbsp; ${patient.familyName}

			clinical.setTreatingDoctor(enc.getCreator().getPerson().getGivenName()+" "+enc.getCreator().getPerson().getMiddleName()+" "+enc.getCreator().getPerson().getFamilyName());
			SimpleDateFormat sdf = new SimpleDateFormat("EEE dd/MM/yyyy hh:mm a");
			clinical.setDateOfVisit(sdf.format(enc.getDateCreated()));
			clinical.setId(enc.getId());
			clinical.setDiagnosis(diagnosis);
			clinical.setProcedures(procedure);
			clinicalSummaries.add(clinical);
			
			// set value to command object
			// add command to list
		};
		
		model.addAttribute("patient", patient);
		model.addAttribute("clinicalSummaries", clinicalSummaries);
		return "module/patientdashboard/clinicalSummary";
	}
	
	public static void main(String[] args) {
		String a = "asfsf, dsf, ";
		a = StringUtils.removeEnd(a, ", ");
		System.out.println(a);
	}
}
