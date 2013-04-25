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

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.InventoryCommonService;
import org.openmrs.module.hospitalcore.model.InventoryStoreDrugPatient;
import org.openmrs.module.hospitalcore.model.InventoryStoreDrugPatientDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("PharmacyRecordController")
@RequestMapping("/module/patientdashboard/pharmacyRecord.htm")
public class PharmacyRecordController {

	@RequestMapping(method = RequestMethod.GET)
	public String firstView(
			@RequestParam(value = "patientId", required = false) Integer patientId,
			Model model) {
		InventoryCommonService inventoryCommonService = (InventoryCommonService) Context
				.getService(InventoryCommonService.class);
		PatientService patientService = (PatientService) Context
				.getService(PatientService.class);
		Patient patient = patientService.getPatient(patientId);
		List<InventoryStoreDrugPatient> listDate = inventoryCommonService
				.getAllIssueDateByPatientId(patient);
		//ghanshyam,date:25-april-2013 Feedback #1391 Add Pharmacy record of patient in Dashboard(written below LinkedHashSet at the place of HashSet)
		Set<String> dates = new LinkedHashSet<String>();
		for (InventoryStoreDrugPatient date : listDate) {
			dates.add(Context.getDateFormat().format(date.getCreatedOn()));
		}
		model.addAttribute("patientId", patientId);
		model.addAttribute("dates", dates);
		return "module/patientdashboard/pharmacyRecord";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String formSubmit(
			@RequestParam(value = "patientId", required = false) Integer patientId,
			@RequestParam(value = "date", required = false) String date,Model model) {
		InventoryCommonService inventoryCommonService = (InventoryCommonService) Context
				.getService(InventoryCommonService.class);
		PatientService patientService = (PatientService) Context
				.getService(PatientService.class);
		if(!date.equals("null")){
		Patient patient = patientService.getPatient(patientId);
		List<InventoryStoreDrugPatient> listIssue = inventoryCommonService
				.getDeatilOfInventoryStoreDrugPatient(patient, date);
		List<InventoryStoreDrugPatientDetail> drugDetails = new ArrayList<InventoryStoreDrugPatientDetail>();
		for (InventoryStoreDrugPatient isdpd : listIssue) {
			List<InventoryStoreDrugPatientDetail> listDrugIssue = inventoryCommonService
					.getDrugDetailOfPatient(isdpd);
			drugDetails.addAll(listDrugIssue);
		}
		model.addAttribute("drugDetails", drugDetails);
		}
		return "module/patientdashboard/pharmacyRecordResult";
	}
}
