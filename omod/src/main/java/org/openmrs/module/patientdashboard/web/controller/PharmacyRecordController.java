/**
 *  Copyright 2013 Society for Health Information Systems Programmes, India (HISP India)
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
 *  author:ghanshyam
 *  date: 18-april-2013
 *  issue: #1391 India module
 **/

package org.openmrs.module.patientdashboard.web.controller;

import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("PharmacyRecordController")
@RequestMapping("/module/patientdashboard/pharmacyRecord.htm")
public class PharmacyRecordController {

	@RequestMapping(method = RequestMethod.GET)
	public String firstView(@RequestParam(value = "patientId", required = false) Integer patientId, Model model) {
		PatientService patientService = (PatientService) Context.getService(PatientService.class);
		PatientDashboardService patientDashboardService = Context.getService(PatientDashboardService.class);
		Patient patient = patientService.getPatient(patientId);
		String patientIdentifier = patient.getPatientIdentifier().toString();
		List<String> issueDrugDates = patientDashboardService.getPatientDrugIssueDates(patientIdentifier);
		List<Map<String, Object>> patientDrugDetails = patientDashboardService.getPatientDrugDetails(patientIdentifier,
				"all");

		ObjectMapper mapper = new ObjectMapper();
		String patientDrugDetailsJson = "";
		String issueDrugDatesJson = "";

		try {
			patientDrugDetailsJson = mapper.writeValueAsString(patientDrugDetails);
			issueDrugDatesJson = mapper.writeValueAsString(issueDrugDates);

		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("patientIdentifier", patientIdentifier);
		model.addAttribute("issueDrugDatesJson", issueDrugDatesJson);
		model.addAttribute("patientDrugDetailsJson", patientDrugDetailsJson);

		return "module/patientdashboard/pharmacyRecord";
	}
}
