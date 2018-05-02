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

package org.openmrs.module.patientdashboard.web.controller.ajax;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.openmrs.Concept;
import org.openmrs.Encounter;
import org.openmrs.GlobalProperty;
import org.openmrs.Location;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.PersonAddress;
import org.openmrs.PersonAttribute;
import org.openmrs.User;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.IpdService;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.PatientQueueService;
import org.openmrs.module.hospitalcore.model.Department;
import org.openmrs.module.hospitalcore.model.DepartmentConcept;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmissionLog;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.model.OpdPatientQueue;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.hospitalcore.util.ConceptComparator;
import org.openmrs.module.hospitalcore.util.HospitalCoreConstants;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * <p>
 * Class: AjaxController
 * </p>
 * <p>
 * Package: org.openmrs.module.patientdashboard.web.controller.ajax
 * </p>
 * <p>
 * Author: Nguyen manh chuyen
 * </p>
 * <p>
 * Update by: Nguyen manh chuyen
 * </p>
 * <p>
 * Version: $1.0
 * </p>
 * <p>
 * Create date: Mar 24, 2011 4:16:48 PM
 * </p>
 * <p>
 * Update date: Mar 24, 2011 4:16:48 PM
 * </p>
 **/
@Controller("PatientDashboardAjaxController")
public class AjaxController {
	
	@RequestMapping(value = "/module/patientdashboard/backToOpdQueue.htm", method = RequestMethod.GET)
	public String backToOpdQueue(@RequestParam("queueId") Integer queueId, Map<String, Object> model,
	                             HttpServletRequest request) {
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
		OpdPatientQueue queue = queueService.getOpdPatientQueueById(queueId);
		Integer opdId = 0;
		if (queue != null) {
			try {
				queue.setStatus("");
				queueService.saveOpdPatientQueue(queue);
				opdId = queue.getOpdConcept().getId();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		return "redirect:/module/patientqueue/main.htm?opdId=" + opdId;
	}
	
	@RequestMapping(value = "/module/patientdashboard/showAllDiagnosis.htm", method = RequestMethod.GET)
	public String showAllDiagnosis(@RequestParam(value = "queueId", required = false) String queueId,
	                               @RequestParam(value = "opdId", required = false) String opdId,
	                               @RequestParam(value = "patientId", required = false) String patientId,
	                               @RequestParam(value = "referralId", required = false) String referralId,
	                               Map<String, Object> model) {
		PatientDashboardService patientDashboardService = Context.getService(PatientDashboardService.class);
		
		List<Concept> diagnosisList = patientDashboardService.searchDiagnosis(null);
		model.put("diagnosisList", diagnosisList);
		return "module/patientdashboard/showAllDiagnosis";
	}
	
	@RequestMapping(value = "/module/patientdashboard/discharge.htm", method = RequestMethod.GET)
	public String dischargeView(@RequestParam(value = "id", required = false) Integer admittedId, Model model) {
		
		IpdService ipdService = (IpdService) Context.getService(IpdService.class);
		IpdPatientAdmitted admitted = ipdService.getIpdPatientAdmitted(admittedId);
		
		Patient patient = admitted.getPatient();
		
		PersonAddress add = patient.getPersonAddress();
		String address = " " + add.getCountyDistrict() + " " + add.getCityVillage();
		model.addAttribute("address", address);
		
		PersonAttribute relationNameattr = patient.getAttribute("Father/Husband Name");
		model.addAttribute("relationName", relationNameattr.getValue());
		Concept outComeList = Context.getConceptService().getConcept(HospitalCoreConstants.CONCEPT_ADMISSION_OUTCOME);
		
		model.addAttribute("listOutCome", outComeList.getAnswers());
		model.addAttribute("admitted", admitted);
		return "module/patientdashboard/dischargeForm";
	}
	
	@RequestMapping(value = "/module/patientdashboard/addConceptToWard.htm", method = RequestMethod.POST)
	public String addConceptToWard(@RequestParam(value = "opdId", required = false) Integer opdId,
	                               @RequestParam(value = "conceptId", required = false) Integer conceptId,
	                               @RequestParam(value = "typeConcept", required = false) Integer typeConcept, Model model) {
		
		if (opdId != null && opdId > 0 && conceptId != null && conceptId > 0 && typeConcept != null && typeConcept > 0) {
			PatientDashboardService patientDashboardService = Context.getService(PatientDashboardService.class);
			Department department = patientDashboardService.getDepartmentByWard(opdId);
			Concept concept = Context.getConceptService().getConcept(conceptId);
			if (concept != null && department != null) {
				DepartmentConcept departmentConcept = new DepartmentConcept();
				departmentConcept.setConcept(concept);
				departmentConcept.setDepartment(department);
				departmentConcept.setCreatedOn(new Date());
				departmentConcept.setCreatedBy(Context.getAuthenticatedUser().getGivenName());
				departmentConcept.setTypeConcept(typeConcept);
				patientDashboardService.createDepartmentConcept(departmentConcept);
			}
		}
		
		return "/module/patientdashboard/ajax/addConceptToWard";
	}
	
	@RequestMapping(value = "/module/patientdashboard/discharge.htm", method = RequestMethod.POST)
	public String dischargePost(@RequestParam("admittedId") Integer id, @RequestParam("outCome") Integer outCome, Model model) {
		IpdService ipdService = (IpdService) Context.getService(IpdService.class);
		
		IpdPatientAdmitted pa = ipdService.getIpdPatientAdmitted(id);
		IpdPatientAdmissionLog pal = pa.getPatientAdmissionLog();
		OpdPatientQueueLog pql = pal.getOpdLog();
		Integer patientId = pql.getPatient().getPatientId();
		Integer opdId = pql.getOpdConcept().getConceptId();
		Integer referralId = pql.getReferralConcept().getConceptId();
		
		ipdService.discharge(id, outCome);
		
		String url = "main.htm?patientId=" + patientId + "&opdId=" + opdId + "&referralId=" + referralId;
		
		model.addAttribute("urlS", url);
		model.addAttribute("message", "Succesfully");
		return "/module/patientdashboard/thickbox/success";
	}
	
	@RequestMapping(value = "/module/patientdashboard/changeFinalResult.htm", method = RequestMethod.GET)
	public String finalResult(@ModelAttribute("ipdCommand") IpdFinalResultCommand command,
	                          @RequestParam(value = "id", required = false) Integer id, Model model) {
		
		IpdService ipdService = (IpdService) Context.getService(IpdService.class);
		IpdPatientAdmissionLog admissionLog = ipdService.getIpdPatientAdmissionLog(id);
		
		//
		ConceptService conceptService = Context.getConceptService();
		AdministrationService administrationService = Context.getAdministrationService();
		String gpDiagnosis = administrationService
		        .getGlobalProperty(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
		String gpProcedure = administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		List<Obs> obsList = new ArrayList<Obs>(admissionLog.getIpdEncounter().getAllObs());
		Concept conDiagnosis = conceptService.getConcept(gpDiagnosis);
		
		Concept conProcedure = conceptService.getConcept(gpProcedure);
		
		List<Concept> selectedDiagnosisList = new ArrayList<Concept>();
		List<Concept> selectedProcedureList = new ArrayList<Concept>();
		if (CollectionUtils.isNotEmpty(obsList)) {
			for (Obs obs : obsList) {
				if (obs.getConcept().getConceptId().equals(conDiagnosis.getConceptId())) {
					selectedDiagnosisList.add(obs.getValueCoded());
				}
				if (obs.getConcept().getConceptId().equals(conProcedure.getConceptId())) {
					selectedProcedureList.add(obs.getValueCoded());
				}
			}
		}
		IpdPatientAdmitted admitted = ipdService.getAdmittedByPatientId(admissionLog.getPatient().getId());
		PatientDashboardService dashboardService = Context.getService(PatientDashboardService.class);
		List<Concept> diagnosis = dashboardService.listByDepartmentByWard(admitted.getAdmittedWard().getId(),
		    DepartmentConcept.TYPES[0]);
		if (CollectionUtils.isNotEmpty(diagnosis) && CollectionUtils.isNotEmpty(selectedDiagnosisList)) {
			diagnosis.removeAll(selectedDiagnosisList);
		}
		if (CollectionUtils.isNotEmpty(diagnosis)) {
			Collections.sort(diagnosis, new ConceptComparator());
		}
		model.addAttribute("listDiagnosis", diagnosis);
		List<Concept> procedures = dashboardService.listByDepartmentByWard(admitted.getAdmittedWard().getId(),
		    DepartmentConcept.TYPES[1]);
		if (CollectionUtils.isNotEmpty(procedures) && CollectionUtils.isNotEmpty(selectedProcedureList)) {
			procedures.removeAll(selectedProcedureList);
		}
		if (CollectionUtils.isNotEmpty(procedures)) {
			Collections.sort(procedures, new ConceptComparator());
		}
		model.addAttribute("listProcedures", procedures);
		model.addAttribute("id", id);
		Collections.sort(selectedDiagnosisList, new ConceptComparator());
		Collections.sort(selectedProcedureList, new ConceptComparator());
		model.addAttribute("sDiagnosisList", selectedDiagnosisList);
		model.addAttribute("sProcedureList", selectedProcedureList);
		return "module/patientdashboard/ipdFinalResult";
	}
	
	@RequestMapping(value = "/module/patientdashboard/changeFinalResult.htm", method = RequestMethod.POST)
	public String submitFinalResult(IpdFinalResultCommand command, HttpServletRequest request, Model model) {
		IpdService ipdService = (IpdService) Context.getService(IpdService.class);
		IpdPatientAdmissionLog admissionLog = ipdService.getIpdPatientAdmissionLog(command.getAdmissionLogId());
		
		//
		AdministrationService administrationService = Context.getAdministrationService();
		GlobalProperty gpDiagnosis = administrationService
		        .getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
		GlobalProperty procedure = administrationService
		        .getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		ConceptService conceptService = Context.getConceptService();
		Concept cDiagnosis = conceptService.getConceptByName(gpDiagnosis.getPropertyValue());
		Concept cProcedure = conceptService.getConceptByName(procedure.getPropertyValue());
		Encounter ipdEncounter = admissionLog.getIpdEncounter();
		List<Obs> listObsOfIpdEncounter = new ArrayList<Obs>(ipdEncounter.getAllObs());
		Location location = new Location(1);
		
		User user = Context.getAuthenticatedUser();
		Date date = new Date();
		//diagnosis
		
		Set<Obs> obses = new HashSet(ipdEncounter.getAllObs());
		
		ipdEncounter.setObs(null);
		
		List<Concept> listConceptDianosisOfIpdEncounter = new ArrayList<Concept>();
		List<Concept> listConceptProcedureOfIpdEncounter = new ArrayList<Concept>();
		if (CollectionUtils.isNotEmpty(listObsOfIpdEncounter)) {
			for (Obs obx : obses) {
				if (obx.getConcept().getConceptId().equals(cDiagnosis.getConceptId())) {
					listConceptDianosisOfIpdEncounter.add(obx.getValueCoded());
				}
				
				if (obx.getConcept().getConceptId().equals(cProcedure.getConceptId())) {
					listConceptProcedureOfIpdEncounter.add(obx.getValueCoded());
				}
			}
		}
		
		List<Concept> listConceptDiagnosis = new ArrayList<Concept>();
		for (Integer cId : command.getSelectedDiagnosisList()) {
			Concept cons = conceptService.getConcept(cId);
			listConceptDiagnosis.add(cons);
			if (!listConceptDianosisOfIpdEncounter.contains(cons)) {
				Obs obsDiagnosis = new Obs();
				//obsDiagnosis.setObsGroup(obsGroup);
				obsDiagnosis.setConcept(cDiagnosis);
				obsDiagnosis.setValueCoded(cons);
				obsDiagnosis.setCreator(user);
				obsDiagnosis.setObsDatetime(date);
				obsDiagnosis.setLocation(location);
				obsDiagnosis.setDateCreated(date);
				obsDiagnosis.setPatient(ipdEncounter.getPatient());
				obsDiagnosis.setEncounter(ipdEncounter);
				obsDiagnosis = Context.getObsService().saveObs(obsDiagnosis, "update obs diagnosis if need");
				obses.add(obsDiagnosis);
			}
		}
		List<Concept> listConceptProcedure = new ArrayList<Concept>();
		if (!ArrayUtils.isEmpty(command.getSelectedProcedureList())) {
			
			if (cProcedure == null) {
				try {
					throw new Exception("Post for procedure concept null");
				}
				catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			for (Integer pId : command.getSelectedProcedureList()) {
				Concept cons = conceptService.getConcept(pId);
				listConceptProcedure.add(cons);
				if (!listConceptProcedureOfIpdEncounter.contains(cons)) {
					Obs obsProcedure = new Obs();
					//obsDiagnosis.setObsGroup(obsGroup);
					obsProcedure.setConcept(cProcedure);
					obsProcedure.setValueCoded(conceptService.getConcept(pId));
					obsProcedure.setCreator(user);
					obsProcedure.setObsDatetime(date);
					obsProcedure.setLocation(location);
					obsProcedure.setPatient(ipdEncounter.getPatient());
					obsProcedure.setDateCreated(date);
					obsProcedure.setEncounter(ipdEncounter);
					obsProcedure = Context.getObsService().saveObs(obsProcedure, "update obs diagnosis if need");
					//ipdEncounter.addObs(obsProcedure);
					obses.add(obsProcedure);
				}
			}
			
		}
		
		// Remove obs diagnosis and procedure 
		
		for (Concept con : listConceptDianosisOfIpdEncounter) {
			if (!listConceptDiagnosis.contains(con)) {
				for (Obs obx : listObsOfIpdEncounter) {
					if (obx.getValueCoded().getConceptId().intValue() == con.getConceptId().intValue()) {
						Context.getObsService().deleteObs(obx);
						obses.remove(obx);
					}
				}
			}
		}
		
		for (Concept con : listConceptProcedureOfIpdEncounter) {
			if (!listConceptProcedure.contains(con)) {
				for (Obs obx : listObsOfIpdEncounter) {
					if (obx.getValueCoded().getConceptId().intValue() == con.getConceptId().intValue()) {
						Context.getObsService().deleteObs(obx);
						obses.remove(obx);
					}
				}
			}
		}
		
		ipdEncounter.setObs(obses);
		
		Context.getEncounterService().saveEncounter(ipdEncounter);
		
		//save ipd encounter
		
		//redirect to main page
		OpdPatientQueueLog pql = admissionLog.getOpdLog();
		Integer patientId = pql.getPatient().getPatientId();
		Integer opdId = pql.getOpdConcept().getConceptId();
		Integer referralId = pql.getReferralConcept().getConceptId();
		
		String url = "main.htm?patientId=" + patientId + "&opdId=" + opdId + "&referralId=" + referralId;
		model.addAttribute("urlS", url);
		model.addAttribute("message", "Succesfully");
		return "/module/patientdashboard/thickbox/success";
		
	}
}
