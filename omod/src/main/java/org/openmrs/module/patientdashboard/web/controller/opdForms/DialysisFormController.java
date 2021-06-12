package org.openmrs.module.patientdashboard.web.controller.opdForms;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.patientdashboard.OPDFormsService;
import org.openmrs.module.patientdashboard.model.PatientDialysisFormDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("DialysisFormController")
@RequestMapping("module/patientdashboard")
public class DialysisFormController {
	@RequestMapping(value = "/dialysisForm.htm", method = RequestMethod.GET)
	public String firstView(@RequestParam(value = "patientId", required = false) Integer patientId, Model model)
			throws Exception {
		String doctorName = Context.getAuthenticatedUser().getGivenName();
		Patient patient = Context.getPatientService().getPatient(patientId);

		String patientName = patient.getGivenName() + " " + patient.getFamilyName();
		patientName = patientName.replace(" .", "");
		int patientAge = patient.getAge(new Date());
		String patientGender = patient.getGender();

		List<Map<String, Object>> patientDialysisFormDetailsList = Context.getService(OPDFormsService.class)
				.getPatientDialysisFormDetails(patientId);

		ObjectMapper objectMapper = new ObjectMapper();
		String json = "";
		try {
			json = objectMapper.writeValueAsString(patientDialysisFormDetailsList);
		} catch (Exception e) {
			System.out.println(e);
		}

		model.addAttribute("patientId", patientId);
		model.addAttribute("patientName", patientName);
		model.addAttribute("patientAge", patientAge);
		model.addAttribute("patientGender", patientGender);
		model.addAttribute("doctorName", doctorName);
		model.addAttribute("patientDialysisFormDetails", json);

		return "module/patientdashboard/opdForms/dialysisForm";
	}

	@RequestMapping(value = "/getDialysisForm.list", method = RequestMethod.GET)
	public void getDetails(@RequestParam(value = "patientId", required = false) Integer patientId,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<Map<String, Object>> dialysisFormDetailsList = Context.getService(OPDFormsService.class)
				.getPatientDialysisFormDetails(patientId);

		response.setContentType("application/json");
		ServletOutputStream outputStream = response.getOutputStream();

		new ObjectMapper().writeValue(outputStream, dialysisFormDetailsList);
	}

	@RequestMapping(value = "/dialysisForm.htm", method = RequestMethod.POST)
	public void postDetails(@RequestParam(value = "patientId", required = false) Integer patientId,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		PatientDialysisFormDetail patientDialysisFormDetail = new PatientDialysisFormDetail();

		Patient patient = Context.getPatientService().getPatient(patientId);
		patientDialysisFormDetail.setPatient(patient);

		patientDialysisFormDetail.setBunPreDialysis(request.getParameter("bunPreText"));
		patientDialysisFormDetail.setBunPostDialysis(request.getParameter("bunPostText"));
		patientDialysisFormDetail.setUrr(request.getParameter("urrText"));
		patientDialysisFormDetail.setSerumCreatinine(request.getParameter("serumCreatinineText"));
		patientDialysisFormDetail.setHemoglobin(request.getParameter("hemoglobinText"));
		patientDialysisFormDetail.setPotassium(request.getParameter("potassiumText"));
		patientDialysisFormDetail.setCalcium(request.getParameter("calciumText"));
		patientDialysisFormDetail.setPhosphorus(request.getParameter("phosphorusText"));
		patientDialysisFormDetail.setAlbumin(request.getParameter("albuminText"));
		patientDialysisFormDetail.setFbs(request.getParameter("fbsText"));
		patientDialysisFormDetail.setRbs(request.getParameter("rbsText"));
		patientDialysisFormDetail.setIron(request.getParameter("ironText"));
		patientDialysisFormDetail.setTibc(request.getParameter("tibcText"));
		patientDialysisFormDetail.setSaturation(request.getParameter("saturationText"));
		patientDialysisFormDetail.setFerritin(request.getParameter("ferritinText"));
		patientDialysisFormDetail.setHbsAntibody(request.getParameter("hbsAntibodyText"));
		patientDialysisFormDetail.setHbsAg(request.getParameter("hbsAgText"));
		patientDialysisFormDetail.setHcv(request.getParameter("hcvText"));
		patientDialysisFormDetail.setHiv(request.getParameter("hivText"));
		patientDialysisFormDetail.setSodium(request.getParameter("sodiumText"));
		patientDialysisFormDetail.setsBilli(request.getParameter("sBilliText"));
		patientDialysisFormDetail.setSgpt(request.getParameter("sgptText"));
		patientDialysisFormDetail.setAlkPhos(request.getParameter("alkPhosText"));
		patientDialysisFormDetail.setUricAcid(request.getParameter("uricAcidText"));
		patientDialysisFormDetail.setCreatedDate(new Date());

		Context.getService(OPDFormsService.class).savePatientDialysisFormDetail(patientDialysisFormDetail);

		List<Map<String, Object>> dialysisFormDetailsList = Context.getService(OPDFormsService.class)
				.getPatientDialysisFormDetails(patientId);

		response.setContentType("application/json");
		ServletOutputStream outputStream = response.getOutputStream();

		new ObjectMapper().writeValue(outputStream, dialysisFormDetailsList);
	}
}
