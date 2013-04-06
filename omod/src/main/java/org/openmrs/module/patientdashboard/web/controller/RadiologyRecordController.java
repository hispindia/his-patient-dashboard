/**
 *  Copyright 2012 Society for Health Information Systems Programmes, India (HISP India)
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
 *  date:6-april-2013
 *  issue:#554 Radiology record
 **/

package org.openmrs.module.patientdashboard.web.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.Patient;
import org.openmrs.api.ConceptService;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.RadiologyCommonService;
import org.openmrs.module.hospitalcore.model.RadiologyTest;
import org.openmrs.module.hospitalcore.util.RadiologyConstants;
import org.openmrs.module.hospitalcore.util.RadiologyUtil;
import org.openmrs.module.hospitalcore.util.TestModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("RadiologyRecordController")
@RequestMapping("/module/patientdashboard/radiologyRecord.htm")
public class RadiologyRecordController {

	@ModelAttribute("date")
	public Map<String, Set<ConceptAnswer>> referenceData(
			@RequestParam(value = "date", required = false) String date,
			@RequestParam(value = "test", required = false) String test,
			@RequestParam(value = "patientId", required = false) Integer patientId,
			Model model, HttpServletRequest request) {
		RadiologyCommonService radiologyCommonService = (RadiologyCommonService) Context
				.getService(RadiologyCommonService.class);
		PatientService patientService = (PatientService) Context
				.getService(PatientService.class);
		ConceptService conceptService = (ConceptService) Context
				.getService(ConceptService.class);
		Patient patient = patientService.getPatient(patientId);

		if (date != null) {
			List<RadiologyTest> radiologyTests = radiologyCommonService
					.getAllTest(patient, date);
			Set<String> conanss = new HashSet<String>();
			for (RadiologyTest radiologyTest : radiologyTests) {
				ConceptAnswer conans = radiologyCommonService
						.getConceptAnswer(radiologyTest.getConcept());
				conanss.add(conans.getConcept().getName().toString());
			}
			model.addAttribute("tests", conanss);
		}

		if (test != null) {
			Concept concept = conceptService.getConceptByName(test);
			List<RadiologyTest> radiologyTests = radiologyCommonService
					.getAllTest(patient, date, concept);
			Set<String> cons = new HashSet<String>();
			for (RadiologyTest radiologyTest : radiologyTests) {
				cons.add(radiologyTest.getConcept().getName().toString());
			}
			model.addAttribute("test", test);
			model.addAttribute("subtests", cons);
		}

		model.addAttribute("dat", date);

		List<RadiologyTest> radiologyTests = radiologyCommonService
				.getAllTest(patient);
		Set<String> dates = new HashSet<String>();
		for (RadiologyTest radiologyTest : radiologyTests) {
			dates.add(Context.getDateFormat().format(radiologyTest.getDate()));
			model.addAttribute("dates", dates);
		}

		return null;
	}

	@RequestMapping(method = RequestMethod.GET)
	public String showView(
			@RequestParam(value = "patientId", required = false) Integer patientId,
			Model model) {
		model.addAttribute("patientId", patientId);
		return "module/patientdashboard/radiologyRecord";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String formSubmit(
			@RequestParam(value = "date", required = false) String date,
			@RequestParam(value = "subtest", required = false) String subtest,
			@RequestParam(value = "patientId", required = false) Integer patientId,
			Model model,HttpServletRequest request) {
		RadiologyCommonService radiologyCommonService = (RadiologyCommonService) Context
				.getService(RadiologyCommonService.class);
		PatientService patientService = (PatientService) Context
				.getService(PatientService.class);
		ConceptService conceptService = (ConceptService) Context
				.getService(ConceptService.class);
		Patient patient = patientService.getPatient(patientId);
		if (subtest != null) {
			Concept concept = conceptService.getConceptByName(subtest);
			Map<Concept, Set<Concept>> testTreeMap = (Map<Concept, Set<Concept>>) request
			.getSession().getAttribute(
					RadiologyConstants.SESSION_TEST_TREE_MAP);
			List<RadiologyTest> radiologyTests = radiologyCommonService
					.getAllSubTest(patient, date, concept);
			List<TestModel> tests = RadiologyUtil.generateModelsFromTests(radiologyTests, testTreeMap);
			model.addAttribute("radiologytests", tests);
		}
		return "module/patientdashboard/radiologyRecordResult";
	}
}