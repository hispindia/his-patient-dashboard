package org.openmrs.module.patientdashboard.web.controller.opdForms;

import java.util.Date;

import org.openmrs.Patient;
import org.openmrs.PersonAddress;
import org.openmrs.api.context.Context;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("DeathCertificateController")
@RequestMapping("module/patientdashboard")
public class DeathCertificateController {
    @RequestMapping(value = "/deathCertificate.htm", method = RequestMethod.GET)
    public String firstView(@RequestParam(value = "patientId", required = false) Integer patientId, Model model) {
        Patient patient = Context.getPatientService().getPatient(patientId);
        String doctorName = Context.getAuthenticatedUser().getGivenName();

        String patientName = patient.getGivenName() + " " + patient.getFamilyName();
        patientName = patientName.replace(" .", "");
        int patientAge = patient.getAge(new Date());
        String patientGender = patient.getGender();
        PersonAddress personAddress = patient.getPersonAddress();
        String address = personAddress.getAddress1() + ", " + personAddress.getCityVillage() + ", "
                + personAddress.getCountyDistrict();

        model.addAttribute("patientId", patientId);
        model.addAttribute("patientName", patientName);
        model.addAttribute("patientAge", patientAge);
        model.addAttribute("patientGender", patientGender);
        model.addAttribute("address", address);
        model.addAttribute("doctorName", doctorName);
        return "module/patientdashboard/opdForms/deathCertificate";
    }
}
