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
import org.openmrs.module.patientdashboard.model.PatientReferralDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("ReferralLetterController")
@RequestMapping("module/patientdashboard")
public class ReferralLetterController {
    @RequestMapping(value = "/referralLetter.htm", method = RequestMethod.GET)
    public String firstView(@RequestParam(value = "patientId", required = false) Integer patientId, Model model)
            throws Exception {
        String doctorName = Context.getAuthenticatedUser().getGivenName();

        List<Map<String, Object>> patientReferralDetailsList = Context.getService(OPDFormsService.class)
                .getPatientReferralDetails(patientId);

        System.out.println(new ObjectMapper().writeValueAsString(patientReferralDetailsList));

        model.addAttribute("patientId", patientId);
        model.addAttribute("patientReferralDetailsList",
                new ObjectMapper().writeValueAsString(patientReferralDetailsList));
        model.addAttribute("doctorName", doctorName);

        return "module/patientdashboard/opdForms/referralLetter";
    }

    @RequestMapping(value = "/referralLetter.htm", method = RequestMethod.POST)
    public void formSubmit(@RequestParam(value = "patientId", required = false) Integer patientId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

        PatientReferralDetail patientReferralDetail = new PatientReferralDetail();
                
        Patient patient = Context.getPatientService().getPatient(patientId);
        patientReferralDetail.setPatient(patient);

        patientReferralDetail.setReferTo(request.getParameter("referto"));
        System.out.println(request.getParameter("referto"));
        patientReferralDetail.setInvestigations(request.getParameter("investigation"));
        patientReferralDetail.setDiagnosis(request.getParameter("diagnosis"));
        patientReferralDetail.setTreatmentGiven(request.getParameter("treatment"));
        patientReferralDetail.setPastHistory(request.getParameter("pastHistory"));
        patientReferralDetail.setReasonForReferral(request.getParameter("referralReason"));
        patientReferralDetail.setCreatedDate(new Date());

        Context.getService(OPDFormsService.class).savePatientReferralDetail(patientReferralDetail);

        response.setContentType("application/json");
        ServletOutputStream outputStream = response.getOutputStream();

        new ObjectMapper().writeValue(outputStream, "Success");

    }
}
