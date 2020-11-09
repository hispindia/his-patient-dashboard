package org.openmrs.module.patientdashboard.web.controller.opdForms;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.openmrs.Patient;
import org.openmrs.PersonAddress;
import org.openmrs.api.context.Context;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("MedicalSicknessController")
@RequestMapping("module/patientdashboard")
public class MedicalSicknessController {
    @RequestMapping(value = "/medicalSickness.htm", method = RequestMethod.GET)
    public String firstView(@RequestParam(value = "patientId", required = false) Integer patientId, Model model) {
        String doctorName = Context.getAuthenticatedUser().getGivenName();

        model.addAttribute("patientId", patientId);
        model.addAttribute("doctorName", doctorName);

        return "module/patientdashboard/opdForms/medicalSickness";
    }

    @RequestMapping(value = "/getmedicalsicknessdetail.list", method = RequestMethod.GET)
    public void getDetails(@RequestParam(value = "patientId", required = false) Integer patientId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

        Patient patient = Context.getPatientService().getPatient(patientId);

        String patientName = patient.getGivenName() + " " + patient.getFamilyName();
        patientName = patientName.replace(" .", "");
        int patientAge = patient.getAge(new Date());
        String patientGender = patient.getGender();
        
        PersonAddress personAddress = patient.getPersonAddress();
        String address = personAddress.getAddress1() + ", " + personAddress.getCityVillage() + ", " + personAddress.getCountyDistrict();

        Map<String, Object> patientDetails = new HashMap<String, Object>();
        patientDetails.put("patientName", patientName);
        patientDetails.put("patientAge", patientAge);
        patientDetails.put("patientGender", patientGender);
        patientDetails.put("patientAddress", address);

        response.setContentType("application/json");
        ServletOutputStream outputStream = response.getOutputStream();

        new ObjectMapper().writeValue(outputStream, patientDetails);
    }
}
