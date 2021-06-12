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
import org.openmrs.module.patientdashboard.model.PatientHaemodialysisForm;
import org.openmrs.module.patientdashboard.model.PatientHaemodialysisFormDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("HaemodialysisFormController")
@RequestMapping("module/patientdashboard")
public class HaemodialysisFormController {
	@RequestMapping(value = "/haemodialysisForm.htm", method = RequestMethod.GET)
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

		return "module/patientdashboard/opdForms/haemodialysisForm";
	}

	@RequestMapping(value = "/haemodialysisForm.htm", method = RequestMethod.POST)
	public void formSubmit(@RequestParam(value = "patientId", required = false) Integer patientId,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		Patient patient = Context.getPatientService().getPatient(patientId);
		PatientHaemodialysisForm patientHaemodialysisForm;

		if (request.getParameter("patientHaemodialysisFormId") != "") {
			Integer patientHaemodialysisFormId = Integer.parseInt(request.getParameter("patientHaemodialysisFormId"));
			patientHaemodialysisForm = Context.getService(OPDFormsService.class)
					.getPatientHaemodialysisFormById(patientHaemodialysisFormId);
		} else {
			patientHaemodialysisForm = new PatientHaemodialysisForm();
			patientHaemodialysisForm.setPatient(patient);
			patientHaemodialysisForm.setCreatedDate(new Date());
		}

		patientHaemodialysisForm.setBicarbonateAcetate(request.getParameter("bicarbonateAcetate"));
		patientHaemodialysisForm.setNewReuse(request.getParameter("newReuse"));
		patientHaemodialysisForm.setPerAceticAcidTest(request.getParameter("perAceticAcidTest"));
		patientHaemodialysisForm.setDryWeight(request.getParameter("dryWeight"));
		patientHaemodialysisForm.setPreDialysisWeight(request.getParameter("preDialysisWeight"));
		patientHaemodialysisForm.setDyspnoea(request.getParameter("dyspnoea"));
		patientHaemodialysisForm.setFever(request.getParameter("fever"));
		patientHaemodialysisForm.setPostDialysisWeight(request.getParameter("postDialysisWeight"));
		patientHaemodialysisForm.setBleeding(request.getParameter("bleeding"));
		patientHaemodialysisForm.setFlaps(request.getParameter("flaps"));
		patientHaemodialysisForm.setCrepitation(request.getParameter("crepitation"));
		patientHaemodialysisForm.setJvp(request.getParameter("jvp"));
		patientHaemodialysisForm.setPericarditis(request.getParameter("pericarditis"));
		patientHaemodialysisForm.setVomiting(request.getParameter("vomiting"));
		patientHaemodialysisForm.setHiv(request.getParameter("hiv"));
		patientHaemodialysisForm.setStartedAt(request.getParameter("startedAt"));
		patientHaemodialysisForm.setStoppedAt(request.getParameter("stopedAt"));
		patientHaemodialysisForm.setHbsag(request.getParameter("hbsag"));
		patientHaemodialysisForm.setStaffName(request.getParameter("staffName"));
		patientHaemodialysisForm.setStaffNameTwo(request.getParameter("staffNameTwo"));
		patientHaemodialysisForm.setHcv(request.getParameter("hcv"));
		patientHaemodialysisForm.setPreHdPulse(request.getParameter("preHdPulse"));
		patientHaemodialysisForm.setvascularAccess(request.getParameter("vascularAccess"));
		patientHaemodialysisForm.setAfv(request.getParameter("afv"));
		patientHaemodialysisForm.setAvShunt(request.getParameter("avShunt"));
		patientHaemodialysisForm.setIjv(request.getParameter("ijv"));
		patientHaemodialysisForm.setSubclavianFemoralGraft(request.getParameter("subclavianFemoralGraft"));
		patientHaemodialysisForm.setDialysisPlan(request.getParameter("dialysisPlan"));
		patientHaemodialysisForm.setNumberOfDialysisUsed(request.getParameter("numberOfDialysisUsed"));
		patientHaemodialysisForm.setDuration(request.getParameter("duration"));
		patientHaemodialysisForm.setNumberOfTubingsUsed(request.getParameter("numberOfTubingsUsed"));
		patientHaemodialysisForm.setBloodFlowRate(request.getParameter("bloodFlowRate"));
		patientHaemodialysisForm.setUf(request.getParameter("uf"));
		patientHaemodialysisForm.setInjections(request.getParameter("injections"));
		patientHaemodialysisForm.setHeparinDose(request.getParameter("heparinDose"));
		patientHaemodialysisForm.setBloodTransfusion(request.getParameter("bloodTransfusion"));
		patientHaemodialysisForm.setPostDialysisBp(request.getParameter("postDialysisBp"));
		patientHaemodialysisForm.setNote(request.getParameter("note"));

		Date nextDialysisDate = new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("nextDialysisDate"));
		patientHaemodialysisForm.setNextDialysisDate(nextDialysisDate);

		PatientHaemodialysisForm patientHaemodialysisForm2 = Context.getService(OPDFormsService.class)
				.savePatientHeamodialysisForm(patientHaemodialysisForm);

		String bpText = request.getParameter("bpText");
		String pulseText = request.getParameter("pulseText");
		String tmpText = request.getParameter("tmpText");
		String vpText = request.getParameter("vpText");

		if (bpText != "" || pulseText != "" || tmpText != "" || vpText != "") {
			PatientHaemodialysisFormDetail patientHaemodialysisFormDetail = new PatientHaemodialysisFormDetail();
			patientHaemodialysisFormDetail.setPatientHaemodialysisForm(patientHaemodialysisForm2);
			patientHaemodialysisFormDetail.setBp(bpText);
			patientHaemodialysisFormDetail.setPulse(pulseText);
			patientHaemodialysisFormDetail.setTmp(tmpText);
			patientHaemodialysisFormDetail.setVp(vpText);
			patientHaemodialysisFormDetail.setCreatedDate(new Date());

			Context.getService(OPDFormsService.class)
					.savePatientHaemodialysisFormDetail(patientHaemodialysisFormDetail);
		}

		response.setContentType("application/json");
		ServletOutputStream outputStream = response.getOutputStream();

		new ObjectMapper().writeValue(outputStream, patientHaemodialysisForm2);

	}

	@RequestMapping(value = "/getHaemodialysisForms.htm", method = RequestMethod.GET)
	public void getHaemodialysisForms(@RequestParam(value = "patientId", required = false) Integer patientId,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<Map<String, Object>> patientHaemodialysisFormsList = Context.getService(OPDFormsService.class)
				.getPatientHaemodialysisForms(patientId);

		response.setContentType("application/json");
		ServletOutputStream outputStream = response.getOutputStream();

		new ObjectMapper().writeValue(outputStream, patientHaemodialysisFormsList);
	}

	@RequestMapping(value = "/getHaemodialysisFormDetails.htm", method = RequestMethod.GET)
	public void getHaemodialysisFormDetails(@RequestParam(value = "formId", required = false) Integer formId,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<Map<String, Object>> patientHaemodialysisFormDetails = Context.getService(OPDFormsService.class)
				.getPatientHaemodialysisFormDetails(formId);

		response.setContentType("application/json");
		ServletOutputStream outputStream = response.getOutputStream();

		new ObjectMapper().writeValue(outputStream, patientHaemodialysisFormDetails);
	}

}
