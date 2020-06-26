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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.openmrs.Concept;
import org.openmrs.Encounter;
import org.openmrs.GlobalProperty;
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
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.model.OpdDrugOrder;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("PrintClinicalSummaryController")
@RequestMapping("/module/patientdashboard/printDetails.form")
public class PrintClinicalSummaryController {

	@RequestMapping(method = RequestMethod.GET)
	public String firstView(@RequestParam("patientId") Integer patientId,
			@RequestParam("encounterId") Integer encounterId, Model model) {
		
		Patient patient = Context.getPatientService().getPatient(patientId);
		String hospitalName = Context.getAdministrationService()
				.getGlobalProperty("hospital.location_user");
		model.addAttribute("hospitalName", hospitalName);
		SimpleDateFormat sdf = new SimpleDateFormat("EEE dd/MM/yyyy hh:mm a");
		model.addAttribute("currentDateTime", sdf.format(new Date()));
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

		HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
		List<PersonAttribute> pas = hcs.getPersonAttributes(patientId);
		for (PersonAttribute pa : pas) {
			PersonAttributeType attributeType = pa.getAttributeType();
			if (attributeType.getPersonAttributeTypeId() == 14) {
				model.addAttribute("selectedCategory", pa.getValue());
			}
			User user = Context.getAuthenticatedUser();
			model.addAttribute("user", user);
		}

		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		ConceptService conceptService = Context.getConceptService();

		EncounterService encounterService = Context.getEncounterService();
		AdministrationService administrationService = Context
				.getAdministrationService();
		PatientDashboardService patientDashboardService = Context
				.getService(PatientDashboardService.class);
		String gpVisiteOutCome = administrationService
				.getGlobalProperty(PatientDashboardConstants.PROPERTY_VISIT_OUTCOME);
		Encounter encounter = encounterService.getEncounter(encounterId);
		String internal = "";
		String external = "";
		String visitOutCome = "";
		String followUpDate = "";
		String ipdAdmissionWard = "";
		String otherInstructions = "";
		String illnessHistory = "";

		Concept conInternal = Context.getConceptService().getConceptByName(
				Context.getAdministrationService().getGlobalProperty(
						PatientDashboardConstants.PROPERTY_INTERNAL_REFERRAL));
		Concept conExternal = Context.getConceptService().getConceptByName(
				Context.getAdministrationService().getGlobalProperty(
						PatientDashboardConstants.PROPERTY_EXTERNAL_REFERRAL));
		Concept conVisiteOutCome = conceptService.getConcept(gpVisiteOutCome);
		Concept conOtherInstructions = conceptService
				.getConceptByName("OTHER INSTRUCTIONS");
		Concept conIllnessHistory = conceptService
				.getConceptByName("HISTORY OF PRESENT ILLNESS");

		List<Concept> pdiagnosiss = new ArrayList<Concept>();
		List<Concept> fdiagnosiss = new ArrayList<Concept>();
		List<Concept> procedures = new ArrayList<Concept>();
		List<Concept> investigations = new ArrayList<Concept>();
		try {
			if (encounter != null) {
				for (Obs obs : encounter.getAllObs()) {
					if (obs.getConcept().getConceptId()
							.equals(conInternal.getConceptId())) {
						internal = obs.getValueCoded().getName() + "";
					}
					if (obs.getConcept().getConceptId()
							.equals(conExternal.getConceptId())) {
						external = obs.getValueCoded().getName() + "";
					}
					if (obs.getConcept().getConceptId()
							.equals(conVisiteOutCome.getConceptId())) {
						visitOutCome = obs.getValueText();
						if ("Follow-up".equalsIgnoreCase(visitOutCome)) {
							try {
								followUpDate = formatter.format(obs
										.getValueDatetime());
							} catch (Exception e) {
								e.printStackTrace();
							}

						} else if ("Admit".equalsIgnoreCase(visitOutCome)) {
							if (obs.getValueCoded() != null) {

								try {
									ipdAdmissionWard = obs.getValueCoded()
											.getName() + "";
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
						}
					}

					if (obs.getConcept().getConceptId()
							.equals(conOtherInstructions.getConceptId())) {
						otherInstructions = obs.getValueText();
					}

					if (obs.getConcept().getConceptId()
							.equals(conIllnessHistory.getConceptId())) {
						illnessHistory = obs.getValueText();
					}

					if (obs.getValueCoded() != null) {
						/*if (obs.getValueCoded().getConceptClass().getName()
								.equals("Diagnosis")) {
							diagnosiss.add(obs.getValueCoded());
						}*/
						if (obs.getValueCoded().getConceptClass().getName()
								.equals("Procedure")) {
							procedures.add(obs.getValueCoded());
						}
						if (obs.getValueCoded().getConceptClass().getName()
								.equals("Test")) {
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
			e.printStackTrace();
		}

		OpdPatientQueueLog opql=patientDashboardService.getOpdPatientQueueLog(encounter);
		User user=opql.getUser();
		Person person=user.getPerson();
		String givenName=person.getGivenName();
		String middleName=person.getMiddleName();
		String familyName=person.getFamilyName();

		if (givenName == null) {
			givenName = "";
		}
		if (middleName == null) {
			middleName = "";
		}
		if (familyName == null) {
			familyName = "";
		}

		String treatingDoctor = givenName + " " + middleName + " " + familyName;

		List<OpdDrugOrder> opdDrugOrders = patientDashboardService
				.getOpdDrugOrder(encounter);

		model.addAttribute("treatingDoctor", treatingDoctor);
		model.addAttribute("internal", internal);
		model.addAttribute("external", external);
		model.addAttribute("visitOutCome", visitOutCome);
		model.addAttribute("followUpDate", followUpDate);
		model.addAttribute("ipdAdmissionWard", ipdAdmissionWard);
		model.addAttribute("illnessHistory", illnessHistory);
		model.addAttribute("pdiagnosiss", pdiagnosiss);
		model.addAttribute("fdiagnosiss", fdiagnosiss);
		model.addAttribute("procedures", procedures);
		model.addAttribute("investigations", investigations);
		model.addAttribute("opdDrugOrders", opdDrugOrders);
		model.addAttribute("opdConceptName", opql.getOpdConceptName());
		model.addAttribute("encounterId", encounterId);

		GlobalProperty slipMessage = Context.getAdministrationService().getGlobalPropertyObject("hospitalcore.slipMessage");
		model.addAttribute("slipMessage", slipMessage.getPropertyValue());

		return "module/patientdashboard/printClinicalSummary";
	}
}
