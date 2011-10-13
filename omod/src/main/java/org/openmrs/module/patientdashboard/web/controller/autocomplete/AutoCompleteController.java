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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Concept;
import org.openmrs.Drug;
import org.openmrs.Encounter;
import org.openmrs.Obs;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.EncounterService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
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
	
	@RequestMapping(value="/module/patientdashboard/autoCompleteProvisionalDianosis.htm", method=RequestMethod.GET)
	public String provisionalDianosis(@RequestParam(value="term",required=false) String name, Model model) {
		List<Concept> diagnosis = new ArrayList<Concept>();
		PatientDashboardService dashboardService = Context.getService(PatientDashboardService.class);
		diagnosis = dashboardService.searchDiagnosis(name);
		System.out.println("come here: "+name);
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
	
	@RequestMapping(value="/module/patientdashboard/detailClinical.htm", method=RequestMethod.GET)
	public String detailClinical(@RequestParam(value="id",required=false) Integer id, Model model) {
		if(id != null){
			
			 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			 ConceptService conceptService = Context.getConceptService();
			
			EncounterService encounterService = Context.getEncounterService();
			 AdministrationService administrationService = Context.getAdministrationService();
			String gpVisiteOutCome = administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_VISIT_OUTCOME);
			Encounter encounter =encounterService.getEncounter(id);
			String internal = "";
			String external = "";
			String visitOutCome = "";
			String otherValueOfVisit = "";
			
			Concept conInternal = Context.getConceptService().getConceptByName(Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL));
			Concept conExternal = Context.getConceptService().getConceptByName(Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_EXTERNAL_REFERRAL));
			Concept conVisiteOutCome  = conceptService.getConcept(gpVisiteOutCome);
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
							if("follow".equalsIgnoreCase(visitOutCome)){
								try {
									otherValueOfVisit = formatter.format(obs.getValueDatetime());
								} catch (Exception e) {
									// TODO: handle exception
									e.printStackTrace();
								}
								
							}else if("admit".equalsIgnoreCase(visitOutCome)){
								if(obs.getValueCoded() != null){
									
									try {
										otherValueOfVisit = obs.getValueCoded().getName()+"";
									} catch (Exception e) {
										// TODO: handle exception
										e.printStackTrace();
									}
								}
							}
						}
					}
					
					
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			
			model.addAttribute("internal", internal);
			model.addAttribute("external", external);
			model.addAttribute("visitOutCome", visitOutCome);
			model.addAttribute("otherValueOfVisit", otherValueOfVisit);
			
			
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
	
}
