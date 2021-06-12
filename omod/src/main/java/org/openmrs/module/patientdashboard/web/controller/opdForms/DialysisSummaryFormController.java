package org.openmrs.module.patientdashboard.web.controller.opdForms;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.openmrs.Patient;
import org.openmrs.PatientIdentifier;
import org.openmrs.api.context.Context;
import org.openmrs.module.patientdashboard.OPDFormsService;
import org.openmrs.module.patientdashboard.model.PatientDialysisSummaryForm;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("DialysisSummaryFormController")
@RequestMapping("module/patientdashboard")
public class DialysisSummaryFormController {
	@RequestMapping(value = "/dialysisSummaryForm.htm", method = RequestMethod.GET)
	public String firstView(@RequestParam(value = "patientId", required = false) Integer patientId, Model model)
			throws Exception {

		String doctorName = Context.getAuthenticatedUser().getGivenName();
		Patient patient = Context.getPatientService().getPatient(patientId);

		PatientIdentifier patientIdentifier = patient.getPatientIdentifier();
		String identifier = patientIdentifier.getIdentifier();

		String patientName = patient.getGivenName() + " " + patient.getFamilyName();
		patientName = patientName.replace(" .", "");
		int patientAge = patient.getAge(new Date());
		String patientGender = patient.getGender();

		model.addAttribute("patientId", patientId);
		model.addAttribute("identifier", identifier);
		model.addAttribute("patientName", patientName);
		model.addAttribute("patientAge", patientAge);
		model.addAttribute("patientGender", patientGender);
		model.addAttribute("doctorName", doctorName);

		return "module/patientdashboard/opdForms/dialysisSummaryForm";
	}

	@RequestMapping(value = "/dialysisSummaryForm.htm", method = RequestMethod.POST)
	public void formSubmit(@RequestParam(value = "patientId", required = false) Integer patientId,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		PatientDialysisSummaryForm patientDialysisSummaryForm = new PatientDialysisSummaryForm();

		Patient patient = Context.getPatientService().getPatient(patientId);
		patientDialysisSummaryForm.setPatient(patient);

		patientDialysisSummaryForm.setBloodFlowRate(request.getParameter("bloodFlowRate"));
		patientDialysisSummaryForm.setBloodGroup(request.getParameter("bloodGroup"));
		patientDialysisSummaryForm.setComplicationHd(request.getParameter("complicationHd"));
		patientDialysisSummaryForm.setDiagnosis(request.getParameter("diagnosis"));
		patientDialysisSummaryForm.setDryWeightHd(request.getParameter("dryWeightHd"));
		patientDialysisSummaryForm.setFrequencyHoursHd(request.getParameter("frequencyHoursHd"));
		patientDialysisSummaryForm.setHbvVaccination(request.getParameter("hbvVaccination"));
		patientDialysisSummaryForm.setHeparin(request.getParameter("heparin"));
		patientDialysisSummaryForm.setLatestInvestigation(request.getParameter("latestInvestigation"));
		patientDialysisSummaryForm.setMedications(request.getParameter("medications"));
		patientDialysisSummaryForm.setVascularAccess(request.getParameter("vascularAccess"));

		Date hdStartDate = new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("hdStartDate"));
		patientDialysisSummaryForm.setHdStartDate(hdStartDate);

		patientDialysisSummaryForm.setCreatedDate(new Date());

		PatientDialysisSummaryForm patientDialysisSummaryForm2 = Context.getService(OPDFormsService.class)
				.savePatientDialysisSummaryForm(patientDialysisSummaryForm);

		response.setContentType("application/json");
		ServletOutputStream outputStream = response.getOutputStream();

		new ObjectMapper().writeValue(outputStream, patientDialysisSummaryForm2);
	}

	@RequestMapping(value = "/getDialysisSummaryForms.htm", method = RequestMethod.GET)
	public void getDialysisSummaryForms(@RequestParam(value = "patientId", required = false) Integer patientId,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<Map<String, Object>> patientDialysisSummaryFormsList = Context.getService(OPDFormsService.class)
				.getPatientDialysisSummaryForms(patientId);

		response.setContentType("application/json");
		ServletOutputStream outputStream = response.getOutputStream();

		new ObjectMapper().writeValue(outputStream, patientDialysisSummaryFormsList);
	}
}
